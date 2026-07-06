#!/usr/bin/env bash
set -euo pipefail

SOURCE="${CHISIMBA_SOURCE:-/opt/chisimba-source}"
WEBROOT="${CHISIMBA_WEBROOT:-/var/www/html/ch}"

mkdir -p "$WEBROOT"

# Build a writable runtime webroot from the Git-managed source.
# The installer can write into WEBROOT without modifying framework/.
rsync -a --delete \
  --exclude='.git' \
  "$SOURCE/app/" "$WEBROOT/"

mkdir -p \
  "$WEBROOT/packages" \
  "$WEBROOT/usrfiles" \
  "$WEBROOT/usrfiles/users" \
  "$WEBROOT/error_logs" \
  "$WEBROOT/config"

# Make the Chisimba runtime writable for the installer.
chown -R www-data:www-data "$WEBROOT"
chmod -R u+rwX,g+rwX "$WEBROOT"

exec apache2-foreground
