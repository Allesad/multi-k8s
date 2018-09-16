docker build -t allesad/multi-client:latest -t allesad/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t allesad/multi-server:latest -t allesad/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t allesad/multi-worker:latest -t allesad/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push allesad/multi-client:latest
docker push allesad/multi-server:latest
docker push allesad/multi-worker:latest

docker push allesad/multi-client:$SHA
docker push allesad/multi-server:$SHA
docker push allesad/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=allesad/multi-client:$SHA
kubectl set image deployments/server-deployment server=allesad/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=allesad/multi-worker:$SHA