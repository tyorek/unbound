#!/bin/bash
# =============================================================================
# Unbound Manager - CLI utility for managing Unbound DNS
# Version: 1.0.0
# Author: Tegan Yorek
# Repo: https://github.com/yourusername/unbound-config (update this)
# =============================================================================

set -euo pipefail  # Safer bash scripting

SCRIPT_VERSION="1.0.0"
SCRIPT_NAME="$(basename "$0")"

# Use sudo only when needed
use_sudo() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "sudo"
    fi
}

SUDO="$(use_sudo)"

# === Functions ===
edit_forward() {
    $SUDO nano /etc/unbound/unbound.conf.d/forward.conf
}

edit_server() {
    $SUDO nano /etc/unbound/unbound.conf.d/server.conf
}

reload_unbound() {
    $SUDO systemctl reload unbound
    echo "✅ Unbound service reloaded."
}

check_conf() {
    $SUDO unbound-checkconf
}

cat_server() {
    $SUDO cat /etc/unbound/unbound.conf.d/server.conf
}

cat_forward() {
    $SUDO cat /etc/unbound/unbound.conf.d/forward.conf
}

restart_unbound() {
    $SUDO systemctl restart unbound
    echo "✅ Unbound service restarted."
}

view_logs() {
    $SUDO journalctl -xeu unbound -f
}

clear_caches() {
    $SUDO unbound-control flush_bogus
    $SUDO unbound-control flush_negative
    $SUDO unbound-control flush_infra all
    $SUDO unbound-control flush_stats
    $SUDO unbound-control flush_requestlist
    echo "✅ All Unbound caches flushed."
}

show_version() {
    echo "${SCRIPT_NAME} version ${SCRIPT_VERSION}"
}

show_help() {
    cat << EOF
Usage: ${SCRIPT_NAME} [COMMAND]

Unbound DNS management utility.

Commands:
  forward | for      Edit forward.conf
  server  | edit     Edit server.conf
  reload             Reload Unbound (graceful)
  restart            Full restart of Unbound
  check              Validate configuration
  cat | catserver    Show server.conf
  forcat             Show forward.conf
  status | stat      Follow live journal logs
  clear | unclear    Flush all caches
  version            Show version
  help               Show this help

Examples:
  ${SCRIPT_NAME} reload
  ${SCRIPT_NAME} forward
  ${SCRIPT_NAME} status
EOF
}

# === Main ===
case "${1:-help}" in
    forward|for)        edit_forward ;;
    server|edit)        edit_server ;;
    reload)             reload_unbound ;;
    restart)            restart_unbound ;;
    check)              check_conf ;;
    cat|catserver)      cat_server ;;
    forcat)             cat_forward ;;
    status|stat)        view_logs ;;
    clear|unclear)      clear_caches ;;
    version|--version)  show_version ;;
    help|--help|-h)     show_help ;;
    *)
        echo "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
