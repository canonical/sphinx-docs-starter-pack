# shellcheck shell=bash
# _lib/build.sh — build functions and cmd_build for sp

_pdf_prep() {
  _ensure_venv
  local missing=()
  for package_name in "${DOCS_PDFPACKAGES[@]}"; do
    dpkg-query -W -f='${Status}' "${package_name}" 2>/dev/null \
      | grep -q "ok installed" || missing+=("${package_name}")
  done
  if (( ${#missing[@]} == 0 )); then
    return
  fi
  echo
  echo "PDF generation requires the installation of the following packages:"
  echo "  ${DOCS_PDFPACKAGES[*]}"
  echo ""
  echo "Install them with:"
  printf "  sudo apt-get install --no-install-recommends -y"
  printf " \\\\\n    %s" "${DOCS_PDFPACKAGES[@]}"
  printf "\n"
  echo ""
  echo "Please be aware these packages will be installed to your system."
  exit 1
}

_build_watch() {
  _ensure_venv
  # shellcheck disable=SC2086
  _run "${DOCS_VENVDIR}/bin/sphinx-autobuild" \
    -b dirhtml \
    --host "${SPHINX_HOST}" \
    --port "${SPHINX_PORT}" \
    "${DOCS_SOURCEDIR}" "${DOCS_BUILDDIR}" \
    ${SPHINX_OPTS} ${SPHINX_AUTOBUILD_OPTS}
}

_build_html() {
  _ensure_venv
  # shellcheck disable=SC2086
  _run "${SPHINX_BUILD}" \
    --fail-on-warning --keep-going \
    -b dirhtml \
    "${DOCS_SOURCEDIR}" "${DOCS_BUILDDIR}" \
    -w "${DEV_DIR}/warnings.txt" \
    ${SPHINX_OPTS}
}

_build_pdf() {
  local dest="${1:-${DOCS_BUILDDIR}}"
  _pdf_prep
  # shellcheck disable=SC2086
  _run "${SPHINX_BUILD}" -M latexpdf "${DOCS_SOURCEDIR}" "${DOCS_BUILDDIR}" ${SPHINX_OPTS}
  rm -f "${DOCS_BUILDDIR}/latex/front-page-light.pdf"
  rm -f "${DOCS_BUILDDIR}/latex/normal-page-footer.pdf"
  mkdir -p "${dest}"
  find "${DOCS_BUILDDIR}/latex" -name '*.pdf' -exec mv -t "${dest}" {} +
  rm -r "${DOCS_BUILDDIR}/latex"
  echo
  echo "Output can be found in ./${dest}"
  echo
}

#######################################
# Entry point for './sp build'. Parses arguments and dispatches to
# _build_watch, _build_html, or _build_pdf.
# Globals:
#   None
# Arguments:
#   mode    - run (default), html, or pdf.
#   --clean - Clean build output before building.
#   --path  - Destination path for PDF output.
#   --help  - Print usage and return.
#######################################
cmd_build() {
  local subcmd="" pdf_path=""
  local -i clean=0 expect_path=0
  for arg in "$@"; do
    if (( expect_path )); then
      pdf_path="${arg}"
      expect_path=0
      continue
    fi
    case "${arg}" in
      --help)
        echo "Usage:"
        echo "    ./sp build <mode> [<option>...]"
        echo
        echo "Render the docs. Three output types are available:"
        echo
        echo "- 'run' (default) hosts the docs in a local server you can view in the web browser."
        echo "  When you save a change to a source file, the server updates the doc in real time."
        echo "- 'html' renders the docs as a static set of HTML pages"
        echo "- 'pdf' renders the docs as a PDF file"
        echo
        echo "Positional arguments:"
        echo "            mode  Output type, either 'run' (default), 'html', or 'pdf'"
        echo
        echo "Options:"
        echo "            --clean  Clean the built docs and temporary files before building"
        echo "            --path  Destination path for PDF builds"
        echo
        echo "Global options:"
        echo "            --verbose  Show more commands in the terminal"
        echo "            --help  Show this help"
        return 0 ;;
      --clean)       clean=1 ;;
      --path)        expect_path=1 ;;
      run|html|pdf)  subcmd="${arg}" ;;
      "")            ;;
      *) _err "Unknown build option: ${arg}" ;;
    esac
  done
  if (( expect_path )); then
    _err "--path requires a value"
  fi
  if [[ -n "${pdf_path}" && "${subcmd}" != "pdf" ]]; then
    _err "--path can only be used with 'pdf' mode"
  fi
  (( clean )) && _clean_doc
  case "${subcmd}" in
    html)    _build_html ;;
    pdf)     _build_pdf "${pdf_path}" ;;
    run|"")  _build_watch ;;
  esac
}
