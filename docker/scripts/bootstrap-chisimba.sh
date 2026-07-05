#!/bin/bash
set -e

CHROOT=/var/www/html/ch
FRAMEWORK=/workspace/framework

if [ ! -d "$FRAMEWORK/app" ]; then
  echo "ERROR: Expected Chisimba framework at $FRAMEWORK/app" >&2
  echo "Make sure docker/ is inside the repo and ../framework exists." >&2
  exit 1
fi

mkdir -p "$CHROOT"

# Recreate symlinks on every container start so repo edits are reflected.
ln -sfn "$FRAMEWORK/app/index.php" "$CHROOT/index.php"
ln -sfn "$FRAMEWORK/app/gateway.php" "$CHROOT/gateway.php"
ln -sfn "$FRAMEWORK/app/classes" "$CHROOT/classes"
ln -sfn "$FRAMEWORK/app/core_modules" "$CHROOT/core_modules"
ln -sfn "$FRAMEWORK/app/cron" "$CHROOT/cron"
ln -sfn "$FRAMEWORK/app/installer" "$CHROOT/installer"
ln -sfn "$FRAMEWORK/app/lib" "$CHROOT/lib"
ln -sfn "$FRAMEWORK/app/config" "$CHROOT/config"

mkdir -p "$CHROOT/skins" "$CHROOT/user_images" "$CHROOT/usrfiles" "$CHROOT/error_logs"

# Link bundled skins/user_images contents if present.
if [ -d "$FRAMEWORK/app/skins" ]; then
  find "$FRAMEWORK/app/skins" -mindepth 1 -maxdepth 1 -exec ln -sfn {} "$CHROOT/skins/" \;
fi
if [ -d "$FRAMEWORK/app/user_images" ]; then
  find "$FRAMEWORK/app/user_images" -mindepth 1 -maxdepth 1 -exec ln -sfn {} "$CHROOT/user_images/" \;
fi

# Keep Chisimba runtime-writable locations writable in the container.
chown -R www-data:www-data "$CHROOT/usrfiles" "$CHROOT/error_logs" || true
chmod -R 777 "$CHROOT/usrfiles" "$CHROOT/error_logs" || true

# If external modules are later added at ../modules, expose them as packages.
if [ -d "/workspace/modules" ]; then
  ln -sfn /workspace/modules "$CHROOT/packages"
fi

exec apache2-foreground
