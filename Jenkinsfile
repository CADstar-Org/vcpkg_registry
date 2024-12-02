pipeline {
	agent { label 'x64 && windows && msvc-v143 && cuda-12.6' }

	options {
		// skipDefaultCheckout(true)// This is required if you want to clean before build
		buildDiscarder(logRotator(numToKeepStr: '5'))
		timeout(time: 48, unit: 'HOURS')
		timestamps() // add timestamps to console output
	}
	environment	{
		TIME_STAMP = "00-00-00-0000"
        EXPORT_NAME = "export-${env.BUILD_TIME}"
	}

	stages {
		stage('build') {
			steps {
				  script {
      				  	TIME_STAMP = new Date().format("yy-MM-dd-HHmm", TimeZone.getTimeZone('UTC'))
						println "Time is ${TIME_STAMP}"
   					 }

					bat 'ps-script-wrapper.cmd ./start_build.ps1'
			}
		}
	
		stage('Archive') {
			steps {
				println "export timestamp is ${TIME_STAMP}"

				bat "ps-script-wrapper.cmd ./export.ps1 ${TIME_STAMP}"
				archiveArtifacts artifacts: "export-${TIME_STAMP}.7z"
			}
		}
	}
}
