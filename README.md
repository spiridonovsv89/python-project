# python-project
___

Main purpose o this project is create full CI/CD pipeline, learn and use such
technologies as:
- Google Kubernetes Engine 
- Jenkins as CI/CD tool
- Helm
- Python + Flask + MariaDB as frontend application

## Project scheme:

![Scheme](https://github.com/spiridonovsv89/python-project/blob/main/docs/Scheme.png?raw=true)

## Preparation

Initially we have GCP account with GKE activated and this repo, lets create GKE cluster from shell:

```
gcloud container clusters create cluster-1 --num-nodes 2 --machine-type c3-highcpu-4 --region us-central1-c
```

Clone repo and deploy backend and frontend:

```
git clone https://github.com/spiridonovsv89/python-project.git \
 
kubectl apply -f python-project/k8s/backend
```
```
kubectl apply -f python-project/k8s/frontend
```

In this case we deploy pods to kubernetes manually, but also we can do it
by `Helm`, lets deploy Jenkins by this way:
```
helm repo add jenkinsci https://charts.jenkins.io \

helm repo update \

helm install jenkins jenkinsci/jenkins
```
and add some extra options, such as plugins and ingress for webhook:
```
helm upgrade jenkins jenkinsci/jenkins -f python-project/helm/values.yaml
```

Also, we have to install ingress controller for gitHub webhook access app from outside:

````
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx 
````

To see that everything is fine:
```
kubectl get all
```
## CI/CD description
After pushing to the main branch, `Jenkins` automatically starts executing
pipeline according to Jenkinsfile. There are three main stages in the Jenkinsfile:

Unit test (CI) with python agent

Build and push to the registry (CI) with dind agent

Deploy to production environment (CD) with kubectl agent

Each next one is executed if the previous one is successful.

---
[Author](https://www.linkedin.com/in/spiridonovsv89/)