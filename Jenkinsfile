pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    
    stages {
       // stage('Git Checkout terraform') {
          //  agent { 
           //     label 'master' 
           // }
          // steps {
          //      git branch: 'main', credentialsId: 'jenkins-token', url: 'https://github.com/6rey/tf.git'
          //  }
        //}
        stage('Delete workspace before build starts') {
            steps {
                echo 'Deleting workspace'
                deleteDir()
            }
        }        
        stage('Terraform Init') {
            agent { 
                label 'master'
               // customWorkspace '/var/lib/jenkins/workspace/pipeline-scm@2'
            }
            steps {
                dir('tf'){
                 sh 'terraform init'
                }
            }
            
        }
        stage('Terraform Plan') {
            agent { 
                label 'master'
            }
            steps {
                dir('tf'){
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-ec2', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
                    {
                        sh 'terraform plan'
                    }
                }
            }
        }
        stage('Terraform Apply') {
            agent { 
                label 'master'
            }
            steps {
                dir('tf'){
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-ec2', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
                    {
                        sh 'terraform apply --auto-approve'
                    }
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
        stage('Build docker image') {
            steps{
                sh 'docker build  --no-cache --tag java:version .' 
            }
        }
        stage('Run Docker App') {
            steps{
               sh 'docker run -p 80:8080 -t java:version'
            }
        }
    }    
}