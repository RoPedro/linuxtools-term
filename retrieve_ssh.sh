retrieve_ssh_directory()
{
    echo "Retrieving SSH keys..."
    DEFAULT_SSH_DIR="mnt/d/backup_wsl/" # Default directory

    # Set backup directory
    BACKUP_DIR="${1:-$DEFAULT_SSH_DIR}" # Default directory if none is specified
    TARGET_DIR="$HOME/.ssh"

    # Check if backup directory exists
    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Backup directory not found: $BACKUP_DIR"
        return 1
    fi

    # Create target directory if it doesn't exist
    mkdir -p "$TARGET_DIR"

    # Copy files from .ssh directory 
    cp -r "$BACKUP_DIR/.ssh" "$TARGET_DIR"

    # Assign permissions
    chmod 700 "$TARGET_DIR"
    chmod 600 "$TARGET_DIR/*"

    echo "SSH keys retrieved."
}