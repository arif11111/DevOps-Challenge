    //function to retrieve ip of the application deployed
def getnodehost (namespace, servicename) {

	script {
		sh """
            export NODE_PORT="\$(kubectl get --namespace ${namespace} -o jsonpath="{.spec.ports[0].nodePort}" services ${servicename})"
        """
        sh """ 
            export NODE_IP="\$(kubectl get nodes --namespace ${namespace} -o jsonpath="{.items[0].status.addresses[0].address}")"
        """
        host_ip = "http://$NODE_IP:$NODE_PORT/"		    
	    }
	return "$host_ip"
    }


// function to create the namespace
  def createNamespace (namespace) {
        
        echo "Creating namespace ${namespace} if needed"

        sh "[ ! -z \"\$(kubectl get ns ${namespace} -o name 2>/dev/null)\" ] || kubectl create ns ${namespace}"
   }
        
pipeline {
    
    parameters {
        string (name: 'GIT_BRANCH', defaultValue: 'master',  description: 'Git branch to build')

    }
    
    environment {
	DOCKER_REG = 'a5edevopstuts' 
        IMAGE_NAME = 'python-test-app'  
        TEST_LOCAL_PORT = '8080' //local port to test docker image locally 
        ID = "${IMAGE_NAME}:${BUILD_NUMBER}"  // container ID for running the docker image locally    
    }
    
    agent { node { label 'master' } }
    
        
        
        stage('Git checkout'){
            steps{
                echo "checkout code"
                git branch: 'master', credentialsId: 'GitHubID', url: 'https://github.com/arif11111/DevOps-Challenge.git'
                }
               
            }

        stage('Application Test'){
            steps{
                sh 'pip install -r requirements.txt'
                sh 'python tests/test.py'
            }
            post{
                success{
                    echo "Application Testing completed"
                }
                failure{
                    echo "Application Testing failed"
                    currentBuild.result = 'ABORTED'
                }
            }
        }         
              
        
        stage('Publish Docker Image')
        {
            steps {            
            echo "Pushing ${DOCKER_REG}/${IMAGE_NAME} image to registry"
             withCredentials([usernameColonPassword(credentialsId: 'dockerID', variable: 'docker_credn')]) {
                    sh "docker login"
                    sh "docker push ${DOCKER_REG}/${IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
        }
        
        

        stage('Deploy to Dev Env') {
            steps {  
                FileCredentials([credentialsId: 'arn:aws:eks:us-west-2:226945010623:cluster/my-cluster', serverUrl: 'https://9FF1107DA999F3D2A69D1598F94D2F0A.gr7.us-west-2.eks.amazonaws.com']) {

                    script{
                        sed -i -r "s#docker_image#\1 ${DOCKER_REG}/${IMAGE_NAME}:${BUILD_NUMBER}/" .Dev-Manifests/python-test-app-deploy.yml                    
                        namespace = 'dev'
                        createNamespace (namespace)
                        sh 'kubectl apply -f .Dev-Manifests/'

                    }			  
                }
            }    
       }

         
        
    	stage('Development Env Test') {
            steps {
               FileCredentials([credentialsId: 'arn:aws:eks:us-west-2:226945010623:cluster/my-cluster', serverUrl: 'https://9FF1107DA999F3D2A69D1598F94D2F0A.gr7.us-west-2.eks.amazonaws.com']) {
                script {
                    namespace = 'dev'
                    echo "Accessing the status of application in ${namespace} namespace" 
                    servicename = "${IMAGE_NAME}-svc" 
                    host_ip = getnodehost(namespace, servicename)
                    runcurl(host_ip) 
                    } 		        		                                                                       
                }
            }    
        }

        stage('Deploy to Prod Env') {
            steps {  
                FileCredentials([credentialsId: 'arn:aws:eks:us-west-2:226945010623:cluster/my-cluster', serverUrl: 'https://9FF1107DA999F3D2A69D1598F94D2F0A.gr7.us-west-2.eks.amazonaws.com']) {
                    script{
                        sed -i -r "s#docker_image#\1 ${DOCKER_REG}/${IMAGE_NAME}:${BUILD_NUMBER}/" .Prod-Manifests/python-test-app-deploy.yml
                        namespace = 'prod'
                        createNamespace (namespace)
                        sh 'kubectl apply -f .Prod-Manifests/'
                    }			  
                }
            }    
       }
         
        
    	stage('Prod Env Test') {
            steps {
               FileCredentials([credentialsId: 'arn:aws:eks:us-west-2:226945010623:cluster/my-cluster', serverUrl: 'https://9FF1107DA999F3D2A69D1598F94D2F0A.gr7.us-west-2.eks.amazonaws.com']) {
                script {
                    namespace = 'prod'
                    echo "Accessing the status of application in ${namespace} namespace" 
                    servicename = "${IMAGE_NAME}-svc" 
                    host_ip = getnodehost(namespace, servicename)
                    runcurl(host_ip) 
                    } 		        		                                                                       
                }
            }    
        }
}        
