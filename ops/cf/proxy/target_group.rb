resource :TargetGroup, 'AWS::ElasticLoadBalancingV2::TargetGroup', DependsOn: :Alb do
  port 80
  protocol :HTTP
  health_check_path '/health'
  health_check_port 'traffic-port'
  health_check_protocol :HTTP
  target_type :ip
  vpc_id Fn::import_value(Fn::sub('${vpc}-VpcId'))
end
