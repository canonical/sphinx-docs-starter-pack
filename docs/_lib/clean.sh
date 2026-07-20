# shellcheck shell=bash
# _lib/clean.sh — clean functions and cmd_clean for sp

_clean_doc() {
  git clean -fx "${DOCS_BUILDDIR}"
  rm -rf "${DEV_DIR}/.doctrees"
}

#######################################
# Entry point for './sp clean'. Removes build output and optionally
# purges the virtualenv and downloaded Vale style files.
# Globals:
#   DOCS_VENVDIR, DEV_DIR, VALE_CONFIG
# Arguments:
#   --purge - Also remove .venv and DEV_DIR/styles.
#   --help  - Print usage and return.
#######################################
cmd_clean() {
  local -i purge=0
  for arg in "$@"; do
    case "${arg}" in
      --help)
        echo "Usage:"
        echo "    ./sp clean [<option>...]"
        echo
        echo "Remove all built docs and temporary files. Sometimes, stale files can cause"
        echo "build failures, and the only solution is to clear the previous builds."
        echo
        echo "Options:"
        echo "            --purge  Also remove the docs environment (.venv) and downloaded"
        echo "                     style files. Use this to fully reset the environment,"
        echo "                     for example when switching branches or updating"
        echo "                     dependencies."
        echo
        echo "Global options:"
        echo "            --verbose  Show more commands in the terminal"
        echo "            --help  Show this help"
        return 0 ;;
      --purge) purge=1 ;;
      *) _err "Unknown clean option: ${arg}" ;;
    esac
  done
  _clean_doc
  if (( purge )); then
    if [[ -e "${DOCS_VENVDIR}" ]]; then
      if [[ ! -d "${DOCS_VENVDIR}" || "${DOCS_VENVDIR}" == /* || "${DOCS_VENVDIR}" == *..* ]]; then
        _err "Refusing to remove '${DOCS_VENVDIR}': not a safe relative directory path."
      fi
      echo "Removing ${DOCS_VENVDIR}"
      rm -rf "${DOCS_VENVDIR}"
    fi
    if [[ -e "${DEV_DIR}/styles" ]]; then
      echo "Removing ${DEV_DIR}/styles"
      rm -rf "${DEV_DIR}/styles"
    fi
    if [[ -e "${VALE_CONFIG}" ]]; then
      echo "Removing ${VALE_CONFIG}"
      rm -rf "${VALE_CONFIG}"
    fi
  fi
}
