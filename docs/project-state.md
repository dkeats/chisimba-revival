# Chisimba Revival Project State

## Repository
- GitHub: https://github.com/dkeats/chisimba-revival
- Local path: `/run/media/derek/main/Projects/chisimba-revival/chisimba-revival-repo`
- Core source is in `framework/`.

## Development environment
- Current target: Chisimba Revival Development Environment v4.0.
- `framework/` is source.
- `runtime/` is generated/writable and ignored by Git.
- Docker should not silently patch Chisimba source.

## Current blocker
- Installer/PEAR/MDB2 compatibility.
- Known issue: `MDB2_Driver_mysql` detection and PEAR database layer compatibility.
