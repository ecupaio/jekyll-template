subnets = 2.times.map do |i|
  "Subnet#{i}".tap do |subnet|

    resource subnet, 'AWS::EC2::Subnet', DependsOn: :Vpc do
      vpc_id Fn::ref(:Vpc)
      availability_zone Fn::select(i, Fn::get_azs)
      cidr_block Fn::select(i, Fn::cidr(Fn::get_att(:Vpc, :CidrBlock), 256, 8))
      map_public_ip_on_launch true
      tag :Name, Fn::ref('AWS::StackName')
    end

    resource "rt#{subnet}", 'AWS::EC2::SubnetRouteTableAssociation', DependsOn: subnet do
      subnet_id Fn::ref(subnet)
      route_table_id Fn::ref(:RouteTable)
    end

  end
end

output :SubnetIds,   Fn::join(',', subnets.map(&Fn.method(:ref))), export: Fn::sub('${AWS::StackName}-SubnetIds')
output :SubnetZones, Fn::join(',', subnets.map{ |s| Fn::get_att(s, :AvailabilityZone) }), export: Fn::sub('${AWS::StackName}-SubnetZones')
