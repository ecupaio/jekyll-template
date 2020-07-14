resource :Alb, 'AWS::ElasticLoadBalancingV2::LoadBalancer', DependsOn: [:SgAlb, :SgWeb] do
  subnets Fn::split(',', Fn::import_value(Fn::sub('${vpc}-SubnetIds')))
  security_groups [
    Fn::ref(:SgAlb),
    Fn::ref(:SgWeb),
  ]
  tag :Name, Fn::ref('AWS::StackName')
end

output :AlbArn,      Fn::ref(:Alb)
output :AlbFullName, Fn::get_att(:Alb, :LoadBalancerFullName)
output :AlbDnsName,  Fn::get_att(:Alb, :DNSName)
