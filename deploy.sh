docker build -t testep02/multi-client:latest -t testep02/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t testep02/multi-server:latest -t testep02/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t testep02/multi-worker:latest -t testep02/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push testep02/multi-client:latest
docker push testep02/multi-server:latest
docker push testep02/multi-worker:latest

docker push testep02/multi-client:$SHA
docker push testep02/multi-server:$SHA
docker push testep02/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=testep02/multi-server:$SHA
kubectl set image deployments/client-deployment client=testep02/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=testep02/multi-worker:$SHA
