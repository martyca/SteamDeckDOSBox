#!/bin/bash

APP_ID="io.github.dosbox-staging"

# Check if app is installed
if ! flatpak list --app | grep -q "$APP_ID"; then
    echo "$APP_ID is not installed. Installing..."
    flatpak install -y flathub "$APP_ID"
else
    echo "$APP_ID is already installed."
fi

# Check permissions
echo "Checking permissions for $APP_ID..."
PERMISSIONS=$(flatpak info --show-permissions "$APP_ID")

# Extract the 'filesystems=' line from [Context]
FILESYSTEMS_LINE=$(echo "$PERMISSIONS" | grep '^filesystems=')

if echo "$FILESYSTEMS_LINE" | grep -q '\<home\>'; then
    echo "✅ $APP_ID has access to 'home'."
else
    echo "⚠️ WARNING: $APP_ID does NOT have 'home' access!"
    echo "⚠️ Consider installing FLATSEAL and explicitly allowing access to 'all user files'"
fi
