# Chisimba Revival Development Environment v4.0

## Purpose

This environment is the reset point after the earlier experimental Docker containers.

It is designed around one clear rule:

- `framework/` is source code in Git.
- `/var/www/html/ch` is a writable Chisimba runtime installation inside Docker.

The installer may write files, create directories, and generate configuration inside the runtime without modifying the Git source tree.

## Repository layout

```text
chisimba-revival-repo/
├── framework/          # Chisimba core source
├── docker/             # Docker development environment
├── docs/               # Project documentation
└── runtime/            # Optional host runtime data, ignored by Git if used later
```

## Container layout

```text
/opt/chisimba-app       # copy of framework/app baked into the image
/var/www/html/ch        # writable runtime webroot, Docker named volume
```

On first start, the bootstrap script copies `/opt/chisimba-app` into `/var/www/html/ch` only if the runtime webroot is empty.

## Running

From the repository root:

```bash
cd docker
docker compose up --build
```

Open:

```text
http://localhost:8080/ch/
```

## Resetting the runtime installation

If the installer leaves the runtime in a bad state:

```bash
cd docker
docker compose down -v
docker compose up --build
```

This removes the Docker named volumes, including the generated Chisimba webroot and database data.

## Installer values

Use:

```text
Chisimba home directory: /var/www/html/ch/
PEAR path: /var/www/html/ch/lib/pear
Database host: db
Database name: chisimba
Database user: chisimba
Database password: chisimba
```

## Design notes

This setup deliberately does not patch Chisimba source during Docker build. Any Chisimba code change should be made in `framework/`, reviewed with `git diff`, committed, and then tested by rebuilding the Docker image.
