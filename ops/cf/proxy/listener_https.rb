resource :ListenerHttps, 'AWS::ElasticLoadBalancingV2::Listener', DependsOn: [:Alb, :TargetGroup] do
  load_balancer_arn Fn::ref(:Alb)
  port 443
  protocol :HTTPS
  certificates [
    { CertificateArn: Fn::ref(:certificate) }
  ]
  ssl_policy 'ELBSecurityPolicy-TLS-1-2-2017-01'
  default_actions [
    { Type: :forward, TargetGroupArn: Fn::ref(:TargetGroup) } # forward to app
  ]
end
