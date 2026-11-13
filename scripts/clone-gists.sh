#!/bin/bash

# =============================================================================
# Gists Cloner
# Clones all my gists from GitHub to a specified workspace directory.
# =============================================================================


# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -e  # Exit on error


# -----------------------------------------------------------------------------
# Default Values
# -----------------------------------------------------------------------------

source "$SCRIPT_DIR/gists.sh"

DRY_RUN="false"
VERBOSE="false"
# Set the default remote unless an override was supplied.
if [ -z "${REMOTE_PROVIDER_GIST_URI:-}" ]; then
    REMOTE_PROVIDER_GIST_URI="git@gist.github.com:"
fi

REMOTE_PROVIDER_TRAILING=".git"

WORKSPACE_DIR="${HOME}/workspace/personal"
if [ ! -d "$WORKSPACE_DIR" ]; then
    WORKSPACE_DIR="${HOME}/workspace"
fi


# -----------------------------------------------------------------------------
# Help Function
# -----------------------------------------------------------------------------

show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Clones all gists listed in gists.sh from ${REMOTE_PROVIDER_GIST_URI}.
Each owner/gist-id entry is cloned to: ${WORKSPACE_DIR}/owner/gists/gist-id

Options:
    --dry-run                                Show what would be done without doing it
    --verbose                                Show detailed output
    -h, --help                               Show this help message

Note: Flags accept both hyphens and underscores (e.g., --dry-run or --dry_run)

Examples:
    $0
    $0 --dry-run

EOF
    exit 0
}


# -----------------------------------------------------------------------------
# Parse Command Line Arguments
# -----------------------------------------------------------------------------

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        # Normalize flag by replacing underscores with hyphens
        local flag="${1//_/-}"

        case $flag in
            --dry-run)
                DRY_RUN="true"
                shift
                ;;
            --verbose)
                set -x
                VERBOSE="true"
                shift
                ;;
            -h|--help)
                show_help
                ;;
            *)
                echo "Unknown option: $1" >&2
                return 1
                ;;
        esac
    done
}


# -----------------------------------------------------------------------------
# Main Execution
# -----------------------------------------------------------------------------

main() {
    # Parse command line arguments
    parse_arguments "$@"

    local gist owner gist_id destination remote
    for gist in "${GISTS[@]}"; do
        if [[ ! "$gist" =~ ^[a-zA-Z0-9][a-zA-Z0-9_-]*/[a-zA-Z0-9][a-zA-Z0-9_-]*$ ]]; then
            echo "Invalid gist entry (expected owner/gist-id): $gist" >&2
            return 1
        fi

        owner="${gist%%/*}"
        gist_id="${gist#*/}"
        destination="${WORKSPACE_DIR}/${owner}/gists/${gist_id}"
        remote="${REMOTE_PROVIDER_GIST_URI}${gist_id}${REMOTE_PROVIDER_TRAILING}"

        if [ -d "$destination" ]; then
            echo "Directory $destination already exists. Skipping clone."
            continue
        fi
        if [[ "$VERBOSE" == "true" || "$DRY_RUN" == "true" ]]; then
            printf '%q ' git clone -- "$remote" "$destination"
            printf '\n'
        fi
        if [[ "$DRY_RUN" != "true" ]]; then
            mkdir -p "${WORKSPACE_DIR}/${owner}/gists"
            git clone -- "$remote" "$destination"
        fi
    done
}

# Run main function
main "$@"
