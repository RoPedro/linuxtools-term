#!/bin/bash

retrieve_projects()
{
    echo "Retrieving projects..."
    DEFAULT_PROJECTS_DIR="mnt/d/backup_wsl/" # Default directory

    # Set backup directory
    BACKUP_DIR="${1:-$DEFAULT_PROJECTS_DIR}" # Default directory if none is specified
    TARGET_DIR="$HOME/projects"

    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Backup directory not found: $BACKUP_DIR"
        return 1
    fi

    mkdir -p "$TARGET_DIR"

    cp -r "$BACKUP_DIR/projects" "$TARGET_DIR"

    echo "Projects retrieved."
}

main()
{
    retrieve_projects
}

main