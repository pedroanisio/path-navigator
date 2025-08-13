#!/bin/bash

# Path Navigator - Automated Installation Script

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Path Navigator Installation Script${NC}\n"

# Detect shell
if [ -n "$ZSH_VERSION" ]; then
    SHELL_TYPE="zsh"
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_TYPE="bash"
    SHELL_RC="$HOME/.bashrc"
else
    echo -e "${RED}Unsupported shell. Only Bash and Zsh are supported.${NC}"
    exit 1
fi

echo -e "Detected shell: ${YELLOW}$SHELL_TYPE${NC}"

# Create bin directory
echo -e "\n1. Creating ~/bin directory..."
mkdir -p ~/bin

# Copy Python script
echo -e "2. Installing Python script..."
cp src/path_navigator.py ~/bin/
chmod +x ~/bin/path_navigator.py

# Check if already installed
if grep -q "Path Navigator Function" "$SHELL_RC" 2>/dev/null; then
    echo -e "${YELLOW}Path Navigator already installed in $SHELL_RC${NC}"
    echo -e "Skipping shell integration..."
else
    # Add shell integration
    echo -e "3. Adding shell integration to $SHELL_RC..."
    echo "" >> "$SHELL_RC"
    
    if [ "$SHELL_TYPE" = "bash" ]; then
        cat shell/bash_integration.sh >> "$SHELL_RC"
    else
        cat shell/zsh_integration.sh >> "$SHELL_RC"
    fi
fi

# Create default config
echo -e "4. Setting up default configuration..."
mkdir -p ~/.config/path_navigator
if [ ! -f ~/.config/path_navigator/paths.json ]; then
    cp config/paths.example.json ~/.config/path_navigator/paths.json
    echo -e "   Created default configuration"
else
    echo -e "   Configuration already exists, skipping..."
fi

echo -e "\n${GREEN}✓ Installation complete!${NC}"
echo -e "\nTo start using Path Navigator:"
echo -e "  1. Reload your shell: ${YELLOW}source $SHELL_RC${NC}"
echo -e "  2. Run: ${YELLOW}n${NC} to open the navigator"
echo -e "  3. Run: ${YELLOW}nedit${NC} to customize your paths"
echo -e "\nFor more information, see the README.md"