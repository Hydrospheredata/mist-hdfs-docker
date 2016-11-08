node {
  currentBuild.result = "SUCCESS"
  
  try {
    stage('clone project') {
      checkout scm
    }
    stage('build hdfs container') {
      docker.withRegistry('https://hub.docker.com/', '2276974e-852b-45ab-bf14-9136e1b31217') {
        def pcImg 
        pcImg = docker.build("hydrosphere/hdfs:latest")
        pcImg.push();
      }
    }
  }
  catch (err) {
    currentBuild.result = "FAILURE"
    echo "${err}"
    mail body: "project build error is here: ${env.BUILD_URL}" ,
        from: 'hydro-support@provectus.com',
        replyTo: 'noreply@provectus.com',
        subject: 'project build failed',
        to: "peanig@gmail.com"
    throw err
  }
}
