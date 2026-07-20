# shellcheck shell=bash
# _lib/check.sh — check functions and cmd_check for sp

_get_vale_dir() {
  # Finds the vale package directory inside the venv.
  find "${DOCS_VENVDIR}/lib" -maxdepth 3 -name "vale" -type d 2>/dev/null \
    | head -1
}

_get_check_path() {
  # Builds the Vale scan path: all top-level entries except venv, build, dev, and lib dirs.
  local result=() venvdir_base builddir_base devdir_base
  venvdir_base="$(basename "${DOCS_VENVDIR}")"
  builddir_base="$(basename "${DOCS_BUILDDIR}")"
  devdir_base="$(basename "${DEV_DIR}")"
  for item in *; do
    [[ "${item}" == "${venvdir_base}" ]] && continue
    [[ "${item}" == "${builddir_base}" ]] && continue
    [[ "${item}" == "${devdir_base}" ]]  && continue
    [[ "${item}" == "_lib" ]]            && continue
    result+=("${item}")
  done
  echo "${result[*]}"
}

_vale_setup() {
  _ensure_venv
  if [[ ! -f "${VALE_CONFIG}" ]]; then
    "${DOCS_VENVDIR}/bin/python3" "${DEV_DIR}/get_vale_conf.py"
  fi
  echo '.Level=="error" and .Name!="Canonical.500-Repeated-words" and .Name!="Canonical.000-US-spellcheck"' \
    > "${DEV_DIR}/styles/error.filter"
  echo '.Name=="Canonical.000-US-spellcheck"' \
    > "${DEV_DIR}/styles/spelling.filter"
  local vale_dir
  vale_dir="$(_get_vale_dir)"
  if [[ -n "${vale_dir}" ]]; then
    find "${vale_dir}/vale_bin" -size 195c \
      -exec "${DOCS_VENVDIR}/bin/vale" --version \;
  fi
}

_pymarkdownlnt_setup() {
  _ensure_venv
  local pymarkdown_dir
  pymarkdown_dir="$(find "${DOCS_VENVDIR}/lib" -maxdepth 3 \
    -name "pymarkdown" -type d 2>/dev/null | head -1)"
  if [[ -z "${pymarkdown_dir}" ]]; then
    "${DOCS_VENVDIR}/bin/pip" install pymarkdownlnt==0.9.35
  fi
}

_restore_vocab() {
  if [[ -f "${DOCS_VOCAB}/accept_backup.txt" ]]; then
    cat "${DOCS_VOCAB}/accept_backup.txt" > "${DOCS_VOCAB}/accept.txt"
    rm "${DOCS_VOCAB}/accept_backup.txt"
  fi
}

_vale_run() {
  local filter="$1"
  local check_path="$2"
  # Prepend venv bin (absolute) so vale can find rst2html (from docutils)
  local PATH="${SCRIPT_DIR}/${DOCS_VENVDIR}/bin:${PATH}"
  cp "${DOCS_VOCAB}/accept.txt" "${DOCS_VOCAB}/accept_backup.txt"
  trap '_restore_vocab' EXIT
  cat "${DOCS_SOURCEDIR}/.custom_wordlist.txt" >> "${DOCS_VOCAB}/accept.txt"
  # Word-split check_path intentionally: may contain multiple space-separated paths
  # shellcheck disable=SC2086
  _run "${DOCS_VENVDIR}/bin/vale" \
    --config="${VALE_CONFIG}" \
    --filter="${filter}" \
    --glob='*.{md,rst}' \
    ${check_path}
  _restore_vocab
  trap - EXIT
}

_check_style() {
  _vale_setup
  local check_path
  check_path="${CHECK_PATH:-$(_get_check_path)}"
  echo "Running Vale style check against ${check_path}. To change target set CHECK_PATH= with sp command"
  _vale_run "${DEV_DIR}/styles/error.filter" "${check_path}"
  echo "Running Vale spelling check against ${check_path}."
  _vale_run "${DEV_DIR}/styles/spelling.filter" "${check_path}"
}

_check_markdown() {
  _pymarkdownlnt_setup
  local -i status=0
  # shellcheck disable=SC2086
  _run "${DOCS_VENVDIR}/bin/pymarkdownlnt" \
    --config "${DEV_DIR}/.pymarkdown.json" \
    --return-code-scheme explicit \
    scan \
    --recurse \
    --exclude="${DEV_DIR}/**" \
    --exclude="${DOCS_VENVDIR}/**" \
    "${DOCS_SOURCEDIR}" \
    || status=$?
  if (( status == 1 )); then
    echo "No Markdown files selected for linting"
    return 0
  fi
  echo "pymarkdownlnt exited with code ${status}"
  return "${status}"
}

_check_links() {
  _ensure_venv
  # shellcheck disable=SC2086
  _run "${SPHINX_BUILD}" -b linkcheck -q \
    "${DOCS_SOURCEDIR}" "${DOCS_BUILDDIR}" \
    ${SPHINX_OPTS} \
    || {
      grep --color -F "[broken]" "${DOCS_BUILDDIR}/output.txt" || true
      exit 1
    }
}

#######################################
# Entry point for './sp check'. Parses arguments and dispatches to
# _check_style, _check_markdown, _check_links, or all three.
# Globals:
#   None
# Arguments:
#   type   - style, markdown, links, or all (default).
#   --help - Print usage and return.
#######################################
cmd_check() {
  local subcmd=""
  for arg in "$@"; do
    case "${arg}" in
      --help)
        echo "Usage:"
        echo "    ./sp check <type> [<option>...]"
        echo
        echo "Check for problems in the documentation. Several checks are available:"
        echo
        echo "- 'style' checks for spelling and style concerns"
        echo "- 'markdown' looks for Markdown formatting issues"
        echo "- 'links' checks for valid external hyperlinks"
        echo
        echo "Positional arguments:"
        echo "            type  The check to run, either 'all' (default), 'style',"
        echo "                  'markdown', or 'links'"
        echo
        echo "Environment variables:"
        echo "            CHECK_PATH  Limit style checks to a specific path instead of"
        echo "                  the entire source tree (e.g. CHECK_PATH=tutorials ./sp check style)"
        echo
        echo "Global options:"
        echo "            --verbose  Show more commands in the terminal"
        echo "            --help  Show this help"
        return 0 ;;
      style|markdown|links)  subcmd="${arg}" ;;
      "")                    ;;
      *) _err "Unknown check option: ${arg}" ;;
    esac
  done
  case "${subcmd}" in
    style)         _check_style ;;
    markdown)      _check_markdown ;;
    links)         _check_links ;;
    "")
      _check_style
      _check_markdown
      _check_links
      ;;
  esac
}
