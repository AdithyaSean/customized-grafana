FROM grafana/grafana-oss:11.5.2-ubuntu

USER root

# Create directory for dashboards
RUN mkdir -p /var/lib/grafana/dashboards

# Copy provisioning configurations
COPY provisioning/datasources /etc/grafana/provisioning/datasources
COPY provisioning/dashboards /etc/grafana/provisioning/dashboards
COPY dashboards/system-metrics.json /var/lib/grafana/dashboards/

# Return to grafana user
USER grafana

# Environment variables
ENV GF_PATHS_PROVISIONING="/etc/grafana/provisioning"
ENV GF_INSTALL_PLUGINS="grafana-piechart-panel"
ENV GF_DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH="/var/lib/grafana/dashboards/system-metrics.json"
ENV GF_AUTH_LOGIN_TITLE="Test Monitoring"
ENV GF_AUTH_LOGIN_SUBTITLE="System Metrics Dashboard"