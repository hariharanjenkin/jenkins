properties([

	parameters ([
		string (defaultValue: '', description: 'Enter the AWS account ID', name: 'AWS_Account_ID', trim: false),
	])
])


def awsassumecredential(def acc){
    println acc
    def AWS_ROLE_ARN = "arn:aws:iam::"+ acc +":role/ROLE-JENKINS"
  
   sh"""     
    rm -rf /home/ec2-user/.aws/config
aws sts get-caller-identity
aws sts assume-role --role-session-name Jenkins01 --role-arn  ${AWS_ROLE_ARN} > awscre
"""
sh'''
cat > aws_credentials <<EOF
[default]
output = json
region = us-west-2
aws_access_key_id = $(jq -r .Credentials.AccessKeyId awscre)
aws_secret_access_key = $(jq -r .Credentials.SecretAccessKey awscre)
aws_session_token = $(jq -r .Credentials.SessionToken awscre)
EOF
'''
}

pipeline {
	agent {label 'master'}
	
	stages {
		stage('CLEAN WORKSPACE IN JENKINS SERVER'){
			steps {
				cleanWs()
			} // Steps Completed	
		}  // Stage Completed
	

		stage('CLONE THE SOURCE CODE FROM GIT-HUB'){
			steps {
				echo 'In SCM Stage'
				
				git credentialsId: 'c8300171-d7b3-452e-a384-893f10299ad5', url: 'https://github.com/hariharanjenkin/jenkins-cft.git',branch: 'master'
			} // Steps Completed
		}  // Stage Completed



		stage('Terraform Execution for CFT'){
			steps {
				
				script {
					awsassumecredential(AWS_Account_ID)
				}
				
				sh '''

				aws s3 ls

				pwd
				ls


				'''
				
			}  // Steps Completed
		}  // Stage Completed
		
		
	}
}