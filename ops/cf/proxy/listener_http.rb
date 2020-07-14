## redirect http to https
resource :ListenerHttp, 'AWS::ElasticLoadBalancingV2::Listener', DependsOn: [:Alb, :TargetGroup] do
  load_balancer_arn Fn::ref(:Alb)
  port 80
  protocol :HTTP
  default_actions [
    { Type: :redirect, RedirectConfig: { Port: 443, Protocol: :HTTPS, StatusCode: :HTTP_301 } } ## redirect to https
  ]
end
