description ''

parameter :vpc,    type: :String
parameter :bucket, type: :String

## needed to add cdn to s3 policy if it exists
parameter :CanonicalUser, type: :String
condition :HasCanonicalUser, Fn::not(Fn::equals(Fn::ref(:CanonicalUser), ''))

## desired count for tasks, leave empty to maintain current value
parameter :desired, type: :String, default: ''

## returns true if :desired param is not empty
condition :DesiredCount, Fn::not(Fn::equals(Fn::ref(:desired), ''))

parameter :certificate, type: 'AWS::SSM::Parameter::Value<String>', default: '/certs/master/peacock/Cert'

mappings(
  Account: {
    '': { domain: '' }
    
  },
  AlbHostedZone: {
    'us-east-1': { id: '' },
    'us-west-2': { id: '' },
  },
)

include_template(
  'proxy/s3_policy.rb',
  'proxy/sg_alb.rb',
  'proxy/sg_web.rb',
  'proxy/iam_role_exec.rb',
  'proxy/iam_role_task.rb',
  'proxy/log_group.rb',
  'proxy/ecs_cluster.rb',
  'proxy/ecs_task.rb',
  'proxy/ecs_service.rb',
  'proxy/alb.rb',
  'proxy/target_group.rb',
  'proxy/listener_http.rb',
  'proxy/listener_https.rb',
  'proxy/route53.rb',
)
