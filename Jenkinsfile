#!groovy​
properties([[$class: 'jenkins.model.BuildDiscarderProperty', strategy: [$class: 'LogRotator',
                                                                        numToKeepStr: '10',
                                                                        artifactNumToKeepStr: '10']]])
node {
    step([$class: 'WsCleanup'])
    
    stage('Check Out') {
        checkout scm
    }
        
        def mvnHome = tool 'MAVEN3'
        build_version = env.BUILD_NUMBER
      
        stage('Build & Test') {
            sh "${mvnHome}/bin/mvn clean verify -DBUILD_NUMBER=$build_version"
            
            junit(testResults: "admin-service/target/surefire-reports/*.xml")
            
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'admin-service-it/target/jacoco-report', reportFiles: 'index.html', reportName: 'Jacoco Report'])
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'admin-service-it/target/cucumber-html-report', reportFiles: 'index.html', reportName: 'Cucumber Report'])
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'admin-service-it/target/site/serenity/', reportFiles: 'index.html', reportName: 'Serenity Report'])
        }
        
        
        def sonarqubeScannerHome = tool name: 'sonarqubescanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        stage('Code Analysis') {
            //sh "${sonarqubeScannerHome}/bin/sonar-scanner -e -Dsonar.host.url=http://sonar.ms-accelerator.com -Dsonar.projectName=admin-service -Dsonar.projectKey=com.dell.tsp.admin.tsp-admin-service:tsp-admin-service -Dsonar.sources=. -Dsonar.java.binaries=."
            sh "${mvnHome}/bin/mvn sonar:sonar"
        }

        stage('Deploy to Nexus') {
            sh "${mvnHome}/bin/mvn deploy -DBUILD_NUMBER=$build_version -Dmaven.test.skip=true"
         }
        stage('Int Tests') {
              //sh 'docker rmi $(docker images --filter "dangling=true" -q --no-trunc) '
              sh "docker ps"
           }
        stage ('Deploy') { steps{ sshagent(credentials : ['1cbeac72-4505-4a87-9bbe-de92a95b9217']) { sh 'ssh -o StrictHostKeyChecking=no root@10.118.169.49 uptime' sh 'ssh -v root@10.118.169.49' sh 'docker ps' } } } 
        }
      
            
}
