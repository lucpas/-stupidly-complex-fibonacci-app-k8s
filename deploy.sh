docker build -t lucpas/fibo-client:latest -t lucpas/fibo-client:$SHA -f ./client/Dockerfile ./client
docker build -t lucpas/fibo-server:latest -t lucpas/fibo-server:$SHA -f ./server/Dockerfile ./server
docker build -t lucpas/fibo-worker:latest -t lucpas/fibo-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lucpas/fibo-client:latest
docker push lucpas/fibo-server:latest
docker push lucpas/fibo-worker:latest
docker push lucpas/fibo-client:$SHA
docker push lucpas/fibo-server:$SHA
docker push lucpas/fibo-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=lucpas/fibo-server:$SHA
kubectl set image deployments/client-deployment client=lucpas/fibo-client:$SHA
kubectl set image deployments/worker-deployment worker=lucpas/fibo-worker:$SHA