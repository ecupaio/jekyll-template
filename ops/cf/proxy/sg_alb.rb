## security group for http from internet to ALB
resource :SgAlb, 'AWS::EC2::SecurityGroup' do
  group_description 'HTTP access to ALB from internet'
  vpc_id Fn::import_value(Fn::sub('${vpc}-VpcId'))
  security_group_ingress [
    { CidrIp: '0.0.0.0/0', IpProtocol: :tcp, FromPort: 80,  ToPort: 80 },
    { CidrIp: '0.0.0.0/0', IpProtocol: :tcp, FromPort: 443, ToPort: 443 },
  ]
  security_group_egress [
    { CidrIp: '0.0.0.0/0', IpProtocol: '-1', FromPort: 0, ToPort: 0 }
  ]
  tag :Name, Fn::ref('AWS::StackName')
end
