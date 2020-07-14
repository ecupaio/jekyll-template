resource :IamRoleBuild, 'AWS::IAM::Role', DependsOn: :S3Bucket do
  path '/'
  assume_role_policy_document(
    Version: '2012-10-17',
    Statement: [
      {
        Effect: :Allow,
        Principal: {
          Service: 'codebuild.amazonaws.com'
        },
        Action: 'sts:AssumeRole'
      }
    ]
  )
  policies [
    {
      PolicyName: :CodeBuild,
      PolicyDocument: {
        Version: '2012-10-17',
        Statement: [
          {
            Effect: :Allow,
            Action: [
              'logs:CreateLogGroup',
              'logs:CreateLogStream',
              'logs:PutLogEvents',
            ],
            Resource: '*',
          },
          ## get token for github from SSM
          {
            Effect: :Allow,
            Action: 'ssm:GetParameter',
            Resource: Fn::sub('arn:aws:ssm:${AWS::Region}:${AWS::AccountId}:parameter/gemfury/token'),
          },
          ## access to codepipeline artifact bucket
          {
            Effect: :Allow,
            Action: [
              's3:GetObject',
              's3:GetObjectVersion',
              's3:PutObject',
            ],
            Resource: Fn::join('/', Fn::get_att(:S3Bucket, :Arn), '*'),
          },
          ## access to website deployment bucket
          {
            Effect: :Allow,
            Action: [
              's3:ListBucket',
              's3:GetBucketLocation',
              's3:GetObject',
              's3:PutObject',
              's3:PutObjectAcl',
              's3:DeleteObject',
            ],
            Resource: [
              Fn::import_value(Fn::sub('${bucket}-S3BucketArn')),
              Fn::join('/', Fn::import_value(Fn::sub('${bucket}-S3BucketArn')), '*'),
            ]
          },
          ## invalidate cloudfront distribution after deploy
          {
            Effect: :Allow,
            Action: 'cloudfront:CreateInvalidation',
            Resource: '*',
          },
        ]
      }
    }
  ]
end
