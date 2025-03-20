pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "html-container"
        CONTAINER_NAME = "html_server"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/RanjithDev-SRE/Git-Devops-POC.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker stop ${CONTAINER_NAME} || true && docker rm ${CONTAINER_NAME} || true'
                sh 'docker run -d --name ${CONTAINER_NAME} -p 8080:80 ${DOCKER_IMAGE}'
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Apply Terraform') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Cleanup Unused Images') {
            steps {
                sh 'docker system prune -f'
            }
        }
    }
    
    post {
        success {
            echo "Deployment Successful! Visit http://4.236.163.168:8080/"
        }
        failure {
            echo "Deployment Failed!"
        }
    }
}
