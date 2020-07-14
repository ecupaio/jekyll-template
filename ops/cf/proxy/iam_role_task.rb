## permissions needed for running container
resource :IamRoleTask, 'AWS::IAM::Role' do
  path '/'
  assume_role_policy_document(
    Version: '2012-10-17',
    Statement: [
      {
        Effect: :Allow,
        Principal: {
          Service: 'ecs-tasks.amazonaws.com'
        },
        Action: 'sts:AssumeRole'
      }
    ]
  )
end
