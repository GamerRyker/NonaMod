#!/bin/bash
PLUGIN_NAME="URL Plugin Installer"
PLUGIN_FUNCTION="Install Plugin From URL"
PLUGIN_DESCRIPTION="Use to install a plugin from a URL"
PLUGIN_AUTHOR="StarkMist111960"
PLUGIN_VERSION=1

read -p "Welcome, type the URL of the plugin you want to install (you will probably only use this for testing purposes): " URL
cd /mnt/stateful_partition/murkmod/plugins
curl -O $URL

