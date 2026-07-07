# Chisimba Revival Docker v4.0

This is the clean reset Docker environment.

Run:

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
Chisimba home directory: /var/www/html/ch/
PEAR path: /var/www/html/ch/lib/pear
Database host: db
Database: chisimba
Username: chisimba
Password: chisimba
```

Reset completely:

```bash
cd docker
docker compose down -v
docker compose up --build
```
