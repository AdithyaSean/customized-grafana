# Customized Grafana for System Monitoring

This project provides a customized Grafana Docker setup with real-time system metrics monitoring including CPU usage, RAM usage, and CPU clock speed. It uses Prometheus for metric collection, Node Exporter for system metrics, and a pre-configured Grafana instance with auto-provisioned dashboards.

## Table of Contents

- [Customized Grafana for System Monitoring](#customized-grafana-for-system-monitoring)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Prerequisites](#prerequisites)
  - [Project Structure](#project-structure)
  - [Installation and Setup](#installation-and-setup)
  - [Accessing Grafana](#accessing-grafana)
  - [Understanding the Components](#understanding-the-components)
    - [1. Grafana](#1-grafana)
    - [2. Prometheus](#2-prometheus)
    - [3. Node Exporter](#3-node-exporter)
  - [Dashboard Customization](#dashboard-customization)
  - [Persistence](#persistence)
  - [Troubleshooting](#troubleshooting)
    - [Common Issues](#common-issues)
    - [Restarting Services](#restarting-services)

## Features

- Real-time monitoring of system metrics (CPU, RAM, CPU clock speed)
- Persistent storage for Grafana and Prometheus data
- Pre-configured Grafana dashboards for system monitoring
- Docker Compose setup for easy deployment
- Based on official Grafana OSS 11.5.2 Ubuntu image

## Prerequisites

- Docker and Docker Compose installed
- Basic understanding of Docker and containerization
- Port 3000 (Grafana), 9090 (Prometheus), and 9100 (Node Exporter) available on your host

## Project Structure

```
customized-grafana/
├── docker-compose.yml       # Docker Compose configuration
├── Dockerfile               # Custom Grafana image definition
├── README.md                # Project documentation
├── dashboards/              # Grafana dashboard JSON files
│   └── system-metrics.json  # System metrics dashboard
├── prometheus/              # Prometheus configuration files
│   └── prometheus.yml       # Prometheus scraping configuration
└── provisioning/            # Grafana auto-provisioning
    ├── dashboards/          # Dashboard provisioning
    │   └── dashboard.yml    # Dashboard provider config
    └── datasources/         # Data source provisioning
        └── prometheus.yml   # Prometheus data source config
```

## Installation and Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/AdithyaSean/customized-grafana.git
   cd customized-grafana
   ```

2. Build and start the containers:
   ```bash
   docker compose up -d
   ```

3. Wait for all containers to initialize (this may take a few moments).

## Accessing Grafana

- Grafana is accessible at http://localhost:3000
- Default login credentials:
  - Username: `admin`
  - Password: `admin`

After logging in, you'll find a pre-configured "System Metrics Dashboard" in the "System Monitoring" folder.

## Understanding the Components

### 1. Grafana
Grafana is the visualization platform used for displaying the system metrics in an intuitive dashboard. Our custom Grafana image extends the official `grafana-oss:11.5.2-ubuntu` image with:
- Pre-configured data sources (Prometheus)
- Pre-loaded system metrics dashboard
- Persistent storage for configurations and dashboards

### 2. Prometheus
Prometheus is a time-series database that collects and stores metrics. It scrapes metrics from configured targets at regular intervals and makes them available for querying by Grafana.

### 3. Node Exporter
Node Exporter collects hardware and OS metrics from the host system and exposes them for Prometheus to scrape. It provides metrics about:
- CPU usage and frequency
- Memory usage
- Disk I/O
- Network statistics
- And many more system-level metrics

## Dashboard Customization

The default system metrics dashboard provides:
- CPU usage percentage
- Memory usage in bytes
- CPU clock speed in hertz

To customize or create new dashboards:
1. Login to Grafana
2. Navigate to Dashboards > New Dashboard
3. Use the Prometheus data source to query system metrics
4. Save your customized dashboard

For permanent modifications, export the dashboard JSON and add it to the `dashboards/` directory, then update the Dockerfile accordingly.

## Persistence

The setup uses Docker volumes to ensure data persistence:
- `grafana-storage`: Stores Grafana configurations, dashboards, and plugins
- `prometheus-data`: Stores Prometheus time-series data

This ensures your data and configurations are preserved across container restarts.

## Troubleshooting

### Common Issues

1. **Can't access Grafana**
   - Ensure ports aren't blocked by firewall
   - Check if all containers are running: `docker compose ps`
   - Check Grafana logs: `docker compose logs grafana`

2. **No metrics showing in dashboard**
   - Ensure Node Exporter is running: `docker compose ps`
   - Check Prometheus configuration: `docker compose logs prometheus`
   - Verify Prometheus can scrape Node Exporter: http://localhost:9090/targets

3. **Docker Compose errors**
   - Ensure Docker and Docker Compose are up to date
   - Check for port conflicts with existing services

### Restarting Services

To restart a specific service:
```bash
docker compose restart <service-name>
```

To restart the entire stack:
```bash
docker compose down
docker compose up -d
```