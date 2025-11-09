#!/bin/bash

# =============================================================================
# Repositories Cloner
# Clones all my repositories from GitHub to a specified workspace directory.
# =============================================================================


# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURRENT_DIR="$(pwd)"

set -e  # Exit on error
source "$SCRIPT_DIR/common-functions.sh"


# -----------------------------------------------------------------------------
# Default Values
# -----------------------------------------------------------------------------

source "$SCRIPT_DIR/repositories.sh"

DRY_RUN="false"
VERBOSE="false"
LIST_NAME=""

# check it REMOTE_PROVIDER_URI is set, otherwise set to default
if [ -z "$REMOTE_PROVIDER_URI" ]; then
    REMOTE_PROVIDER_URI="git@github.com:"
fi

REMOTE_PROVIDER_TRAILING=".git"

WORKSPACE_DIR="${HOME}/github"



# -----------------------------------------------------------------------------
# Help Function
# -----------------------------------------------------------------------------

show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Clones all my repositories from ${REMOTE_PROVIDER_URI} to: ${WORKSPACE_DIR}

Options:
    --list LIST_NAME                         Use RECENT, ACTIVE, ARCHIVE, or ALL (default: RECENT)
    --dry-run                                Show what would be done without doing it
    --verbose                                Show detailed output
    -h, --help                               Show this help message

Note: Flags accept both hyphens and underscores (e.g., --use-claude-code-subagents or --use_claude_code_subagents)

Examples:
    $0
    $0 --list ALL
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
            --list)
                LIST_NAME="$2"
                shift 2
                ;;
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
                echo -e "Unknown option: $1"
                show_help
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


    local REPOSITORIES=()
    # check if LIST_NAME is on of the valid options
    case "$LIST_NAME" in
        RECENT|"")
            REPOSITORIES=("${REPOSITORIES_RECENT[@]}")
            ;;
        ACTIVE)
            REPOSITORIES=("${REPOSITORIES_ACTIVE[@]}")
            ;;
        ARCHIVE)
            REPOSITORIES=("${REPOSITORIES_ARCHIVE[@]}")
            ;;
        ALL)
            REPOSITORIES=("${REPOSITORIES_ALL[@]}")
            ;;
        *)
            echo "Invalid list name: $LIST_NAME"
            show_help
            ;;
    esac

    # Clone each repository in the array
    for REPO in "${REPOSITORIES[@]}"; do
        if [[ "$VERBOSE" == "true" ]]; then
            echo git clone "${REMOTE_PROVIDER_URI}${REPO}${REMOTE_PROVIDER_TRAILING}" "${WORKSPACE_DIR}/${REPO}"
        fi
        if [ -d "${WORKSPACE_DIR}/${REPO}" ]; then
            echo "Directory ${WORKSPACE_DIR}/${REPO} already exists. Skipping clone."
            continue
        fi
        if [[ "$DRY_RUN" != "true" ]]; then
            git clone "${REMOTE_PROVIDER_URI}${REPO}${REMOTE_PROVIDER_TRAILING}" "${WORKSPACE_DIR}/${REPO}"
        fi
    done
}

# Run main function
main "$@"

