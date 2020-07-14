resource :IamRolePipeline, 'AWS::IAM::Role', DependsOn: :S3Bucket do
  path '/'
  assume_role_policy_document(
    Version: '2012-10-17',
    Statement: [
      {
        Effect: :Allow,
        Principal: {
          Service: 'codepipeline.amazonaws.com'
        },
        Action: 'sts:AssumeRole'
      }
    ]
  )
  policies [
    {
      PolicyName: :CodePipeline,
      PolicyDocument: {
        Version: '2012-10-17',
        Statement: [
          {
            Effect: :Allow,
            Action: [
              's3:PutObject',
              's3:GetObject',
              's3:GetObjectVersion',
              's3:GetBucketVersioning',
            ],
            Resource: Fn::join('/', Fn::get_att(:S3Bucket, :Arn), '*'),
          },
          {
            Effect: :Allow,
            Action: [
              'codebuild:StartBuild',
              'codebuild:BatchGetBuilds',
            ],
            Resource: '*',
          },
        ]
      }
    }
  ]
end
