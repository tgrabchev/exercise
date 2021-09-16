                                   Installing and configuring Nginx Ingress Controller in AWS EKS Cluster.
                                 

***1. Creating your EKS cluster using Terraform script.***

   * Once your cluster is up and running run - ***aws eks --region (your region) update-kubeconfig --name (the name of your cluster)***
   
   * Test if you are now connected to your cluster with some simple commands - ***kubectl get all***
   
***2. Install the Nginx Ingress Controller using Helm - https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/***

   * We first clone the git repo as follows - ***git clone https://github.com/nginxinc/kubernetes-ingress/***
   
   * Change directory to ***kubernetes-ingress/deployments/helm-chart*** and run ***git checkout v1.12.1***
   
   * Add the Helm repo - ***helm repo add nginx-stable https://helm.nginx.com/stable*** and then run - ***helm repo update***
   
   * Create namespace called test by running the command - ***kubectl create namespace test***
   
   * Once all steps above are ran then run the finall installation of the chart in the test namespace - ***helm install my-release nginx-stable/nginx-ingress --namespace=test***
   
   * ***Confirm if everything is deployed and make sure its in running state!***
   
3. Deploying our Deployments and Configuring Ingress for them.

   * Creating the yaml file for our Deployment and Service by following this link - https://aws.amazon.com/premiumsupport/knowledge-center/eks-access-kubernetes-services/#:~:text=Example%20of%20a%20hostname-app-svc.yaml%20file%20for%20hostname-app%3A
    
    * The example above can be reused depending on the application and we are using the same pattern in the next 2 application which will be deployed as well.
    
    * Creating the Ingress for our applications as following this link - https://aws.amazon.com/premiumsupport/knowledge-center/eks-access-kubernetes-services/#:~:text=Implement%20Ingress%20so%20that%20it%20interfaces%20with%20your%20services%20using%20a%20single%20load%20balancer%20provided%20by%20Ingress%20Controller.%20See%20the%20following%20micro-ingress.yaml%20example%3A
    
     * Once all 3 Ingresses are deployed test the if they are working by running the command - ***curl -I http://aaa71bxxxxx-11xxxxx10.us-east-1.elb.amazonaws.com/*** ***(you should replace the ELB example with your current AWS ELB)***
     
        * ***Once you run this command you should get the following respose:***
        
                           HTTP/1.1 404 Not Found
                           Server: nginx/1.17.5
                           Date: Mon, 25 Nov 2019 20:50:58 GMT
                           Content-Type: text/html
                           Content-Length: 153
                           Connection: keep-alive
                          
         * Then run the command - ***curl -I -H "Host: hostname.mydomain.com" http://aaa71bxxxxx-11xxxxx10.us-east-1.elb.amazonaws.com/*** ***(Again replace the EBL with your current one)*** you should get 200 OK responce if everything is working as expected.
         
         
                           HTTP/1.1 200 OK
                           Server: nginx/1.19.8
                           Date: Fri, 26 Mar 2021 15:49:43 GMT
                           Content-Type: text/plain; charset=utf-8
                           Content-Length: 29
                           Connection: keep-alive
                                                        
                                                        
***4. Installing the Elasticsearch and Kibana using operators - https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html***

   * Install custom resource definitions and the operator with its RBAC rules:

   ***kubectl create -f https://download.elastic.co/downloads/eck/1.7.1/crds.yaml***
   
   ***kubectl apply -f https://download.elastic.co/downloads/eck/1.7.1/operator.yaml***
   
   * ***Monitor the operator logs:***

   ***kubectl -n elastic-system logs -f statefulset.apps/elastic-operator***
   
   * Once you install the operator above you should now install the Elasticsearch cluster by following the exact steps from the following link - ***https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html***
   
   * Once Elasticsearch is installed then we need to move forward to Kibana following the exact steps from the following link - ***https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-kibana.html***
   
      * Once Kibana is installed as well you should be able to open it on localhost using the following command - ***kubectl port-forward service/quickstart-kb-http 5601*** and you should be able to connect using localhost in your browser.
   
   
   
   
   
   
