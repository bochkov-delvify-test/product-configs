# product-configs

## Description

A repo containing configuration files for the ToDo list product

## Requirements

- [ ] Make
- [ ] Docker with BuildKit support (24+ version)
- [ ] Minikube
- [ ] Kubectl

## Installation

### For Mac users

* Install [Homebrew](https://brew.sh/)
* `make setup-mac`

### For other users

Please, refer to the [Makefile](Makefile) for the list of commands to run (check `setup-mac` target).  
Please, adjust them accordingly for your OS of choice.

## Development

### Lifecycle commands

Run the product in Kubernetes and start the backend

```bash
make start 
```

Run the frontend after the backend is up and running

```bash
make run-frontend
```

Stop the service

```bash
make stop
```

Delete the cluster and Docker containers

```bash
make clean
```

To see the dashboard with logs:

```bash
minikube dashboard
```


## Project structure

```
├── Makefile - Makefile with project commands
├── K8s - Kubernetes configuration files
```

## How to run

To run the product locally you need:
1. Download this repo
2. Install the requirements
3. Open Docker Desktop
4. Navigate to the root folder of this repo
5. Run the `make start` command. 

After all migrations ran and backend is running you will se in terminal:

```
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

Don't close this tab! 

6. Open a new tab
7. Navigate to the root folder of this repo
8. Run `make run-frintend`. 

This will open the product in your browser.

## Architecture

All parts of the project are containerized and run in Kubernetes.

1. Web client - React application [GitHub](https://github.com/bochkov-delvify-test/web-client)
2. API Gateway - KrakenD
3. Users microservice - Python FastAPI application to manage users [GitHub](https://github.com/bochkov-delvify-test/users-microservice)
    3.1. Users DB - PostgreSQL database
4. Lists microservice - Python FastAPI application to manage lists and tasks [GitHub](https://github.com/bochkov-delvify-test/lists-microservice)
    4.1. Lists DB - PostgreSQL database
    4.2. Lists Scheduler - Python FastAPI application to manage scheduled notifications
5. Notifications microservice - Python FastAPI application to send notifications [GitHub](https://github.com/bochkov-delvify-test/notifications-microservice)

* All microservices are created from template [GitHub](https://github.com/bochkov-delvify-test/microservice-template)

![ToDoList architecture.jpeg](ToDoList%20architecture.jpeg?raw=true "ToDoList architecture.jpeg")