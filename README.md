# Timestamp Hostname App

This is a Python Flask application that exposes an API endpoint to retrieve the current timestamp and hostname of the server.

#### Prerequisites

Before building and running the application, ensure that you have the following prerequisites installed on your system:

- Python 3.9 or higher
- pip package manager
- Docker (if you plan to build a Docker image)

### Building the application

Follow these steps to build and run the application:

**1.** Clone the repository:

`git clone https://github.com/terrymafura/timestamp-hostname.git`
`cd timestamp-hostname`

**2.** Build the Docker image:

`docker build -t timestamp-hostname-app .`

**3.** Run the Docker container:

`docker run -p 5000:5000 timestamp-hostname-app`

The application will be accessible on `http://localhost:5000`

##### API Endpoint
This app exposes the API endpoint `GET /timestamphostname` which returns the current timestamp and the hostname of the server in JSON format

### Deploying the application
To deploy the application in a Kubernetes cluster, follow these steps:

**1.** Build a Docker image as described in the previous section. 

**2.** Push the Docker image to a container registry of your choice: 

`docker push your-container-registry/timestamp-hostname-app:latest`

**3.** Update the image name in `deployment.yaml` file:

```
containers:
    - name: timestamp-hostname-app-container
      image: your-container-registry/timestamp-hostname-app:latest
```

**4.** Apply the Kubernetes manifests:

```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
``` 
This will create a Deployment, Service and Ingress resources in your Kubernetes cluster.

**5.** Access the application:

Determine the external IP address or hostname of the Ingress controller service. Run the following command:
`kubectl get ingress`
Look for the `timehostapp.example.com` Ingress rule and note the external IP address or hostname
Access the application by visiting `http://<external-ip-or-hostname>/` in your web browser.

### Monitoring and/or Metrics
To enable monitoring and metrics for the application, you can use Prometheus and Grafana. Here's how to deploy and configure them:

**1.** Deploy Prometheus

- Apply the Prometheus configuration:
`kubectl apply -f prometheus-config.yaml`
- Apply the Prometheus deployment and service:
`kubectl apply -f prometheus.yaml`
- Prometheus will be deployed in your Kubernetes cluster and will start scraping metrics from the timestamphostname application.

**2.** Deploy Grafana

- Apply the Grafana deployment:
`kubectl apply -f grafana.yaml`
- Access the Grafana UI:
Determine the external IP address or hostname of the Grafana service. Run the following command:
`kubectl get service grafana`
Note the external IP address or hostname.
Access the Grafana UI by visiting `http://<external-ip-or-hostname>:3000` in your web browser.
- Log in to Grafana:
    - Username: `admin`
    - Password: `admin` (default password, change it for production use)

**3.** Configure Grafana

- Once logged in, configure Prometheus as a data source in Grafana:
    - Go to `"Administration" > "Data Sources"`.
    - Click on `"Add data source"`.
    - Select `"Prometheus"` as the data source type.
    - Set the URL to `http://prometheus:9090` (internal service DNS).
    - Click on `"Save & Test"` to verify the connection.
- Import monitoring dashboards:
    - Go to `"Create" > "Import"`.
    - Import the provided monitoring dashboards (e.g., `timestamp-hostname-app-dashboard.json`).
    - Follow the instructions to import the dashboard.
    - Explore the metrics and visualizations in Grafana.

**4.** Monitor the application:

- Visit the Grafana UI (http://<external-ip-or-hostname>:3000) to monitor the application's metrics and visualizations.
- Grafana will fetch metrics from Prometheus and provide a rich monitoring and visualization experience for your application.

### Bootstrap the testing environment

Install and run Minikube inorder to test the application
- The configuration will detect your operating system and install your required minikube setup. Run:
`make install start`

This will install Minikube and start the local Kubernetes cluster.
