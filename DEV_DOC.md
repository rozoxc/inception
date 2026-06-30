# Developer Documentation

This guide provides technical instructions for developers on how to set up, build, and maintain the Inception Docker infrastructure.

---

## 1. Setting Up the Environment from Scratch

### Prerequisites

- A Linux host (Debian/Ubuntu recommended) or VM.
- `docker` and `docker-compose` (or `docker compose` plugin) installed.
- `make` installed (if using the Makefile wrapper).

### Configuration Files & Directories

Before launching the project, the persistent data directories must exist on the host machine. The Docker daemon requires these to bind mount the volumes properly.

```bash
mkdir -p /home/ababdoul/Desktop/data/mariadb
mkdir -p /home/ababdoul/Desktop/data/wordpress
```

> **Note:** Replace `ababdoul` with the actual user profile running the host machine if deployed elsewhere.

### Secrets (`.env`)

Create a `.env` file inside the `srcs/` directory. It must contain the following variables with **no quotation marks or spaces** around the `=` sign:

```env
DOMAIN_NAME=ababdoul.42.fr

SQL_DATABASE=your_db_name
SQL_USER=your_db_user
SQL_PASSWORD=your_db_pass
SQL_ROOT_PASSWORD=your_root_pass

WP_ADMIN_USER=your_admin
WP_ADMIN_PASSWORD=your_admin_pass
WP_ADMIN_EMAIL=admin@example.com

WP_USER=your_author
WP_USER_PASSWORD=your_author_pass
WP_USER_EMAIL=author@example.com
```

> ⚠️ **Crucial:** `WP_ADMIN_EMAIL` and `WP_USER_EMAIL` must be strictly unique values.

---

## 2. Building and Launching the Project

Navigate to the `srcs` folder (or project root if a top-level Makefile is used).

**Build and launch:**
```bash
docker compose up --build -d
```

> The `--build` flag ensures that the `Dockerfile`s are re-evaluated and any changes to local scripts (`wp.sh`, `mariadb.sh`, etc.) are injected into the new images.

---

## 3. Relevant Management Commands

**View live logs for all containers:**
```bash
docker compose logs -f
```

**Execute a shell inside a running container (debugging):**
```bash
docker exec -it my_wordpress bash
```

**Complete teardown (clean slate):**

If the WordPress installation crashes halfway, ghost files will prevent a re-installation. Run this to wipe the containers, volumes, and data:
```bash
docker compose down -v
sudo rm -rf /home/ababdoul/Desktop/data/mariadb/*
sudo rm -rf /home/ababdoul/Desktop/data/wordpress/*
```

**System prune (clear build cache):**
```bash
docker system prune -a --volumes
```

---

## 4. Project Data and Persistence

Data persistence is achieved strictly through **Bind Mounts**, bypassing Docker's internal volume manager to meet project constraints.

### Where is data stored?

| Data | Host path |
|---|---|
| Database files | `/home/ababdoul/Desktop/data/mariadb` |
| WordPress web files | `/home/ababdoul/Desktop/data/wordpress` |

### How does it persist?

In `docker-compose.yml`, the `volumes` block maps internal container paths (e.g. `/var/lib/mysql`) directly to the host paths listed above. Because the host kernel manages the filesystem at these paths:

- Deleting the `my_mariadb` container does **not** delete the files.
- When a new container is instantiated, it mounts the host directory and immediately regains access to all previous data.

This ensures **100% persistence** across container lifecycles.