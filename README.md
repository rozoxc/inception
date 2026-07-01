*This project has been created as part of the 42 curriculum by ababdoul.*

# Inception

## Description

The **Inception** project is a System Administration and Networking assignment designed to broaden knowledge of system administration by using Docker. The primary goal is to virtualize a complete web infrastructure within a personal virtual machine using custom-built Docker containers.

This project deploys a LEMP-like stack (Linux, NGINX, MariaDB, PHP-FPM/WordPress) where every service runs in its own dedicated, isolated container, strictly adhering to the **one-service-per-container** rule.

---

## Project Description

### Docker Usage & Design

All services in this project are built from scratch using custom `Dockerfiles` based on `debian:bullseye`. No pre-made Docker Hub images (like the official `wordpress` or `mariadb` images) were used. The infrastructure is orchestrated using `docker-compose.yml`.

#### Main Design Choices

- **PID 1 Enforcement:** All main services (NGINX, PHP-FPM, MariaDB) run in the foreground to occupy PID 1, preventing the containers from exiting.
- **Automation:** Bash scripts (`wp.sh`, `mariadb.sh`) are used as entrypoints to dynamically configure the database and WordPress core on startup.
- **Isolation:** The infrastructure is isolated within a custom Docker bridge network (`inception_net`), and port `443` is the only port exposed to the host machine.

---

### Technical Comparisons

#### Virtual Machines vs Docker
A Virtual Machine virtualizes an entire computer system, including the complete OS and kernel, making it heavy and resource-intensive. Docker virtualizes at the OS level — all containers share the host machine's Linux kernel. This makes Docker containers lightweight, fast to boot, and highly portable.

#### Secrets vs Environment Variables
Docker Secrets are encrypted and securely mounted into containers in memory, making them the safest choice for production. Environment Variables (used via `.env` in this project) are injected into the container's environment. While easier to set up for local development, they are less secure as they can be exposed via shell access or `docker inspect`.

#### Docker Network vs Host Network
A Docker Network (like our bridge network) creates an isolated, private LAN for the containers. They communicate using Docker DNS without exposing i00nternal ports (like `3306` or `90`) to the outside world. Using the Host Network removes this isolation, binding the container's network directly to the VM's network — a security risk that can also cause port conflicts.

#### Docker Volumes vs Bind Mounts
Docker Volumes are managed entirely by the Docker Engine and stored in `/var/lib/docker/volumes/`. Bind Mounts (required by this project) map a specific host path (e.g. `/home/ababdoul/data/...`) directly to a folder inside the container, giving the host direct access to the files.

---

## Instructions

### Prerequisites

1. Ensure **Docker** and **Docker Compose** are installed on your virtual machine.
2. Create the local data directories:
   ```bash
   mkdir -p /home/ababdoul/Desktop/data/mariadb
   mkdir -p /home/ababdoul/Desktop/data/wordpress
   ```
3. Update `/etc/hosts` to map `ababdoul.42.fr` to `127.0.0.1`:
   ```bash
   echo "127.0.0.1 ababdoul.42.fr" | sudo tee -a /etc/hosts
   ```
4. Create a `.env` file at the root of the project with the required credentials.

### Execution

Build and start the infrastructure:
```bash
docker compose up -d --build
```

Stop the infrastructure:
```bash
docker compose down
```

---

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [WP-CLI Documentation](https://make.wordpress.org/cli/commands/)
- [NGINX SSL Configuration](https://nginx.org/en/docs/http/configuring_https_servers.html)

### AI Usage

AI (Google Gemini) was used during development primarily as a debugging and educational tool, specifically for:

- Diagnosing Bash script syntax errors (e.g., missing `#!/bin/bash` shebangs and spacing in `if` statements).
- Explaining Docker layer caching and the PID 1 daemon rule.
- Troubleshooting volume path mapping issues and Docker Compose syntax.
- Visualizing the SSL/TLS handshake process.