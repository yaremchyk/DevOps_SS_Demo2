pipeline {

    environment {
            AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
            AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        }

    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
    
        stage ("terraform init") {
            steps {
                
                sh ("terraform init -reconfigure") 
            }
        }

        stage ("ECR plan") {
            steps {
                sh ('terraform plan -target="module.ecr"') 
            }
        
        stage ("ECS&Task Definition plan") {
            steps {
                sh ('terraform plan -target="module.ecs"') 
                sh ('terraform plan -target="module.ecs_task_definition"') 
            }
        }
        stage ("Apply or Destroy") {
            steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve')         
           }
        } 
        stage ("Trigger app build") {
            steps {
                
                build 'Demo_2'         
           }
        }
}
}
