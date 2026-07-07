#!/usr/bin/env bash
set -euo pipefail

WEBROOT="${CHISIMBA_WEBROOT:-/var/www/html/ch}"
SOURCE="/opt/chisimba-app"

mkdir -p "$WEBROOT"

# First-run bootstrap only. Do not delete or overwrite an installed runtime.
if [ ! -f "$WEBROOT/index.php" ]; then
  echo "Bootstrapping Chisimba runtime webroot at $WEBROOT"
  cp -a "$SOURCE/." "$WEBROOT/"
fi

mkdir -p \
  "$WEBROOT/usrfiles" \
  "$WEBROOT/usrfiles/users" \
  "$WEBROOT/packages" \
  "$WEBROOT/error_logs" \
  "$WEBROOT/config"

chown -R www-data:www-data "$WEBROOT"
chmod -R u+rwX,g+rwX "$WEBROOT"

exec "$@"
