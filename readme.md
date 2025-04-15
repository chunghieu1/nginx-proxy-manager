# Auto Installer for Nginx Proxy Manager (via Docker)

This is a Bash script to automatically install and configure Nginx Proxy Manager on a Linux server (Ubuntu/Debian/CentOS). Easily deploy it with a single command!

---

## Features

- Automatically installs Docker and Docker Compose (if not already installed)
- Creates a configuration directory for Nginx Proxy Manager
- Generates a ready-to-use `docker-compose.yml` file
- Starts the Nginx Proxy Manager container

---

## Requirements

- Operating System: Ubuntu, Debian, CentOS, or equivalent
- `root` or `sudo` privileges
- Ports 80, 81, and 443 must be available

---

## Usage

### 1. Clone or download the script
```bash
git clone https://github.com/chunghieu1/nginx-proxy-manager.git
cd nginx-proxy-manager
```

### 2. Run the script
```bash
chmod +x install-npm.sh
./install-npm.sh
```

### 3. Access Nginx Proxy Manager
Open your browser and navigate to your server's IP address with port 81:
```
http://your-server-ip:81
```

### 4. Login
Use the default credentials:

- Email: admin@example.com
- Password: changeme

---

## Notes

- **Firewall Configuration**: Ensure that ports 80, 81, and 443 are open in your server's firewall.
- **Default Credentials**: Change the default credentials immediately after logging in for the first time.
- **Data Persistence**: The configuration and SSL certificates are stored in the `data` and `letsencrypt` directories. Make sure to back them up if needed.
- **Docker Installation**: The script installs Docker and Docker Compose if they are not already installed. Ensure your system has internet access during the installation process.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.