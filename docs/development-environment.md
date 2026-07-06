# Chisimba Revival Development Environment

## Design

The Git repository is the source of truth. The Chisimba installer runs against a writable runtime copy.

```text
framework/                 Git-managed source
runtime/webroot/            generated writable installation, ignored by Git
runtime/packages/           writable packages directory
runtime/usrfiles/           writable user files directory
runtime/error_logs/         writable logs directory
runtime/config/             writable generated config directory
docker/                     Docker development environment
```

At container startup, `framework/app/` is copied into `runtime/webroot/`, then Apache serves `/var/www/html/ch` from that writable runtime directory.

## Run

```bash
cd docker
docker compose up --build
```

Open:

```text
http://localhost:8080/ch/
```

Installer values:

```text
PEAR path: /var/www/html/ch/lib/pear
Database host: db
Database: chisimba
Username: chisimba
Password: chisimba
```

## Stop

```bash
cd docker
docker compose down
```

## Reset runtime installation

```bash
rm -rf runtime
cd docker
docker compose up --build
```

## Notes

Do not commit `runtime/`. It is generated and writable by design.
