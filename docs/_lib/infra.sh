# shellcheck shell=bash
# _lib/infra.sh — update command for sp

#######################################
# Entry point for './sp update'. Syncs with the Canonical Starter Pack
# by running update_sp.py inside the venv.
# Globals:
#   DOCS_VENVDIR, DEV_DIR
# Arguments:
#   --help - Print usage and return.
#######################################
cmd_update() {
  for arg in "$@"; do
    case "${arg}" in
      --help)
        echo "Usage:"
        echo "    ./sp update [<option>...]"
        echo
        echo "Update the docs base. The foundation of the docs come from Canonical's"
        echo "Starter Pack. This command syncs with that project, pulling in new file"
        echo "structure, requirements, and templates."
        echo
        echo "Global options:"
        echo "            --verbose  Show more commands in the terminal"
        echo "            --help  Show this help"
        return 0 ;;
    esac
  done
  _ensure_venv
  _run "${DOCS_VENVDIR}/bin/python3" "${DEV_DIR}/update_sp.py"
}
