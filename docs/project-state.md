# Chisimba Revival Project State

## Repository

- GitHub: https://github.com/dkeats/chisimba-revival
- Local path: `/run/media/derek/main/Projects/chisimba-revival/chisimba-revival-repo`
- Chisimba core source is in `framework/`.

## Current development environment

- Target environment name: Chisimba Revival Development Environment v4.0.
- Earlier Docker containers up to v3.1 were experimental and should not be treated as the baseline.
- v4.0 is the reset baseline.

## Design decision

- `framework/` is Git source.
- `/var/www/html/ch` is a writable runtime installation inside Docker.
- Docker must not silently patch Chisimba.
- Chisimba source changes should be committed in Git.

## Current restoration blocker

- Installer PEAR/MDB2 compatibility.
- Known focus: `MDB2_Driver_mysql` detection and PEAR database layer behaviour.
