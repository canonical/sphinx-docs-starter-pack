# shellcheck shell=bash
# _lib/helpers.sh — shared utility functions for sp

_venv_ready=0

_err() {
  echo "$*" >&2
  exit 1
}

_run() {
  if (( VERBOSE )); then
    echo "+" "$@" >&2
  fi
  "$@"
}

_ensure_venv() {
  (( _venv_ready )) && return
  if [[ ! -d "${DOCS_VENVDIR}" ]]; then
    echo "... setting up virtualenv"
    python3 -m venv "${DOCS_VENVDIR}" \
      || _err "You must install python3-venv before you can build the documentation."
    # shellcheck disable=SC2086
    "${DOCS_VENVDIR}/bin/pip" install ${PIPOPTS} --require-virtualenv \
      --upgrade -r requirements.txt \
      --log "${DOCS_VENVDIR}/pip_install.log"
    [[ -f "${DOCS_VENVDIR}/pip_list.txt" ]] \
      && mv "${DOCS_VENVDIR}/pip_list.txt" "${DOCS_VENVDIR}/pip_list.txt.bak"
    "${DOCS_VENVDIR}/bin/pip" list --local --format=freeze \
      > "${DOCS_VENVDIR}/pip_list.txt"
  fi
  _venv_ready=1
}

_warn_alias() {
  echo "Warning: '$1' is a Makefile alias; use './sp $2' instead." >&2
}
