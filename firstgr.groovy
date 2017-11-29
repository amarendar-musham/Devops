pipeline {
    agent any
    stages {
        stage("Building stage") {
            stages {
                echo "Building stage data"
            }
        }
        stage("tESTING stage") {
            stages {
                echo "TESTING stage data"
            }
        }
        stage("QA stage") {
            stages {
                echo "QA stage data"
            }
        }
    }
}
