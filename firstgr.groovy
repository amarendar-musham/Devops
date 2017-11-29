pipeline {
    agent any
   parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('QA') {
            steps {
                input "Does the env look ok"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying.... \n ${params.PERSON}'
            }
        }
    }
}
