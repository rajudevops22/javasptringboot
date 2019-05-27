  node{
   def ansibleip = '192.168.1.111'
   def ansibleuser = 'raju'
   //def stopTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/tomcat8/bin/shutdown.sh"
   //def startTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/tomcat8/bin/startup.sh"
   def copyWar = "scp -o StrictHostKeyChecking=no myweb.war ${ansibleuser}@${ansibleip}:/home/raju/deployartifacts"
  
   stage('SCM Checkout'){
     git 'https://github.com/rajudevops22/javasptringboot.git'
   }
   stage('Compile-Package'){
    
      def mvnHome =  tool name: 'Maven-3', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
   }

   stage('Test'){
     def mvnHome =  tool name: 'Maven-3', type: 'maven'   
      sh "${mvnHome}/bin/mvn test"
   } 
	  
   stage('SonarQube Analysis') {
      def mvnHome =  tool name: 'Maven-3', type: 'maven'
		
      /*  def sonarhome = tool name: 'sonar', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        env.PATH = "${sonarhome}/bin:${env.PATH}"
	   sh "${sonarhome}/bin/sonar-scanner" 
		     sh 'printenv' 
	  }*/		 
       withSonarQubeEnv('sonarserver') { 
          sh "${mvnHome}/bin/mvn  sonar:sonar"   
       }
	     }
	
    stage('deploy to nexus'){
	   def mvnHome =  tool name: 'Maven-3', type: 'maven'
       sh "${mvnHome}/bin/mvn deploy"
   } 


/*sshagent(['ansible-ckey']) {
	sh 'mv target/myweb*.war target/myweb.war' 
	sh 'cd target'
	sh 'pwd'
	sh 'ls -lart'
  sh "${copyWar}"
}*/
   
   stage('Build Docker Image'){
	def dockerhome =  tool name: 'docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
        env.PATH = "${dockerhome}/bin:${env.PATH}"
	   sh 'sudo docker build -t rajuseeram22/demoapp:0.0.1 .'
   }

   stage('Upload Image to DockerHub'){
	 def dockerhome =  tool name: 'docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
	 env.PATH = "${dockerhome}/bin:${env.PATH}"
	   withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerhubpwd')]) {
   sh "sudo docker login -u rajuseeram22 -p ${dockerhubpwd}"
   }
    sh 'sudo docker push rajuseeram22/demoapp:0.0.1'
   }
		
   stage('Email Notification'){
      mail bcc: '', body: '''Hi Welcome to jenkins email alerts
      Thanks
      Raju''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job', to: 'raju.seeram22@gmail.com'
   }
}


