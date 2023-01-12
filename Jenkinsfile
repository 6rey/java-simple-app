pipeline {
    agent any
    tools {
        terraform 'terraform'
    }

    stages {
        stage('Git Checkout terraform') {
            agent { 
                label 'master' 
            }
            steps {
                git branch: 'main', credentialsId: 'jenkins-token', url: 'https://github.com/6rey/tf.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
            
        }
        stage('Terraform Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-ec2', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
                {
                sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-ec2', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
                {
                sh 'terraform apply --auto-approve'
                }
            }
        }
        
        stage('Git Checkout java project') {
            agent { 
                label 'agent-jar' 
            }
            steps {
                git branch: 'master', credentialsId: 'jenkins-token', url: 'https://github.com/6rey/java-simple-app.git'
            }
        }
    }    
}