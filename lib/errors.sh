source ./lib/log.sh

# Exit on error, undefined vars, pipe failures
set -euo pipefail

# Error handling
handle_error() {
    log_error "An error occurred on line $1"
    exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR
