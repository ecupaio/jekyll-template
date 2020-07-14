## security group for http from ALB to containers
resource :SgWeb, 'AWS::EC2::SecurityGroup' do
  group_description 'HTTP access from ALB to containers'
  vpc_id Fn::import_value(Fn::sub('${vpc}-VpcId'))
  security_group_egress [
    { CidrIp: '0.0.0.0/0', IpProtocol: '-1', FromPort: 0, ToPort: 0 }
  ]
  tag :Name, Fn::ref('AWS::StackName')
end

## separate resource so we can point sg to itself
resource :SgWebIngress, 'AWS::EC2::SecurityGroupIngress', DependsOn: :SgWeb do
  group_id Fn::ref(:SgWeb)
  ip_protocol :tcp
  from_port 0
  to_port 65535
  source_security_group_id Fn::ref(:SgWeb)
end
