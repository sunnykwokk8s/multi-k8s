docker build -t sunnykwokk8s/multi-client:latest -t sunnykwokk8s/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sunnykwokk8s/multi-server:latest -t sunnykwokk8s/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sunnykwokk8s/multi-worker:latest -t sunnykwokk8s/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sunnykwokk8s/multi-client:latest
docker push sunnykwokk8s/multi-server:latest
docker push sunnykwokk8s/multi-worker:latest
docker push sunnykwokk8s/multi-client:$SHA
docker push sunnykwokk8s/multi-server:$SHA
docker push sunnykwokk8s/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sunnykwokk8s/multi-server:$SHA
kubectl set image deployments/client-deployment client=sunnykwokk8s/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sunnykwokk8s/multi-worker:$SHA
