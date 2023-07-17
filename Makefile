.PHONY setup-mac:
setup-mac:
	echo "Downloading necessary tools..."; \
	brew install minikube && \
	echo "Done!"


.PHONY start:
start:
	echo "Starting minikube..."; \
	minikube start && \
	echo "Applying Kubernetes configs..."; \
	kubectl apply -f K8s/krakend && \
	kubectl apply -f K8s/lists-microservice && \
	kubectl apply -f K8s/notifications-microservice && \
	kubectl apply -f K8s/users-microservice && \
	kubectl apply -f K8s/web-client && \
	echo "Waiting for Kubernetes to create pods..."; \
	sleep 60; \
	echo "Waiting for pods to be ready..."; \
	for app in lists-microservice-app users-microservice-app lists-microservice-db users-microservice-db; do \
		kubectl wait --for=condition=Ready pod -l app=$$app --timeout=600s; \
	done; \
	echo "Running alembic upgrade..."; \
	for app in lists-microservice-app users-microservice-app; do \
		pod=$$(kubectl get pods -l app=$$app -o jsonpath="{.items[0].metadata.name}"); \
		if [ ! -z "$$pod" ]; then \
			echo "Running alembic upgrade on $$pod"; \
			kubectl exec $$pod -- alembic upgrade head; \
		fi; \
	done; \
	echo "Starting to run backend. Keep this tab open. Execute make run-frontend in another tab";
	kubectl port-forward service/krakend-api-gateway-service 8080:8080 ;


.PHONY run-frontend:
run-frontend:
	echo "Starting to run frontend..."; \
	minikube service web-client-service ;

.PHONY stop:
stop:
	echo "Stopping minikube..."; \
	minikube stop && \
	echo "Done!"


.PHONY clean:
clean:
	echo "Deleting minikube..."; \
	minikube delete && \
	echo "Done!;"

