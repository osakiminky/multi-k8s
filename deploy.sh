docker build -t osakiminky/multi-client:latest -t osakiminky/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t osakiminky/multi-server:latest -t osakiminky/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t osakiminky/multi-worker:latest -t osakiminky/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push osakiminky/multi-client:latest
docker push osakiminky/multi-server:latest
docker push osakiminky/multi-worker:latest

docker push osakiminky/multi-client:$SHA
docker push osakiminky/multi-server:$SHA
docker push osakiminky/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=osakiminky/multi-client:$SHA
kubectl set image deployments/server-deployment server=osakiminky/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=osakiminky/multi-worker:$SHA