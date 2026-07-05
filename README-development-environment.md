# Docker development environment for Chisimba Revival

Copy the `docker/` folder into the root of the `chisimba-revival` repository, next to `framework/`.

Expected layout:

```text
chisimba-revival/
├── framework/
├── docker/
└── docs/
```

Start the environment:

```bash
cd /run/media/derek/main/Projects/chisimba-revival/chisimba-revival-repo/docker
docker compose up --build
```

Open:

```text
http://localhost:8080/ch/
```

phpMyAdmin is available at:

```text
http://localhost:8081/
```

Default database settings for the Chisimba installer:

```text
Host: db
Database: chisimba
Username: chisimba
Password: chisimba
```

PEAR path to try first:

```text
/usr/local/lib/php
```

If testing the bundled PEAR path later:

```text
/workspace/framework/app/lib/pear
```

Useful commands:

```bash
# Stop containers
cd docker
docker compose down

# Rebuild after Dockerfile changes
cd docker
docker compose up --build

# View PHP errors
cd docker
docker compose exec web tail -100 /tmp/chisimba-php-error.log

# Enter web container
cd docker
docker compose exec web bash

# Enter database using client inside web container
cd docker
docker compose exec web mysql -h db -u chisimba -pchisimba chisimba
```

Notes:

- The `framework/` folder is mounted into the web container. PHP source edits in Git are reflected immediately; rebuilds are only needed for Docker/PHP/Apache changes.
- This container is for restoration/development only, not production.
- Current known unresolved restoration issue: installer PEAR/MDB2 driver detection and/or MDB2 runtime compatibility.
