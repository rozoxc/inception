 User Documentation
 
Welcome to the **Inception** project. This document is designed for end users and administrators to understand how to interact with the deployed web infrastructure.
 
---
 
## Services Provided
 
This stack provides a fully functional, secure web platform consisting of:
 
1. **NGINX** — A web server that handles incoming traffic, secures it with SSL/TLS encryption (HTTPS), and serves the website to your browser.
2. **WordPress** — A popular Content Management System (CMS) where you can write articles, manage users, and design your website.
3. **MariaDB** — A secure database backend that invisibly stores all WordPress data, user accounts, and settings.
---
 
## How to Start and Stop the Project
 
The project is managed via Docker Compose. Open your terminal in the directory containing the `docker-compose.yml` file (usually the `srcs` folder).
 
**Start the project:**
```bash
make all
```
> The `-d` flag runs it in the background so you can continue using your terminal.
 
**Stop the project:**
```bash
make down
```
 
---
 
## Accessing the Website and Administration Panel
 
Once the project is running, you can access the website securely via your web browser.
 
> ⚠️ **Note:** Because we use a self-signed certificate for local testing, your browser may warn you that the connection is not private. Click **Advanced** → **Proceed** to view the site.
 
| | URL |
|---|---|
| Main website | `https://ababdoul.42.fr` |
| Administration panel | `https://ababdoul.42.fr/wp-admin` |
 
---
 
## Locating and Managing Credentials
 
For security reasons, passwords are not hardcoded into the project files. All credentials (database passwords, admin logins, standard user logins) are managed via a single hidden file named `.env` located at the root of the `srcs` folder.
 
To look up credentials:
```bash
cat srcs/.env
```
 
Use the `WP_ADMIN_USER` and `WP_ADMIN_PASSWORD` values found in this file to log into the `/wp-admin` panel.
 
---
 
## Checking if Services Are Running Correctly
 
If the website is not loading, you can check the health of the services using Docker.
 
**1. Check container status:**
```bash
docker ps
```
This lists all running containers. You should see `my_nginx`, `my_wordpress`, and `my_mariadb` with a status of `Up`.
 
**2. Check logs for errors:**
 
If a container is crashing or restarting, read its internal logs to find out why:
```bash
docker logs my_nginx
docker logs my_wordpress
docker logs my_mariadb
```