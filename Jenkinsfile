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
    
        stage ("Terraform init") {
            steps {
                
                sh ("terraform init ") 
            }
        }

        stage ("S3 and Dynamo DB plan") {
            steps {
                sh ('terraform plan -target="module.backend"') 
            }
        }
        stage ("ECR plan") {
            steps {
                sh ('terraform plan -target="module.ecr"') 
            }
        }
        stage ("ECS&Task Definition plan") {
            steps {
                sh ('terraform plan -target="module.ecs"') 
                sh ('terraform plan -target="module.ecs_task_definition"') 
            }
        }
        stage ("Apply or Destroy") {
            steps {
        script {
            try {
                echo "Terraform action is --> ${action}"
                sh ('terraform apply --auto-approve')
            } catch (err) {
                echo err.getMessage()
            }
        }
        echo currentBuild.result
    }
        } 
        stage ("Trigger app build") {
            steps {
                
                build 'Demo_2'         
           }
        }
}
}
