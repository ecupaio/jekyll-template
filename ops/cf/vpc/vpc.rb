resource :Vpc, 'AWS::EC2::VPC' do
  cidr_block '10.0.0.0/16'
  tag :Name, Fn::ref('AWS::StackName')
end

## allow internet access for instances in vpc
resource :Igw, 'AWS::EC2::InternetGateway' do
  tag :Name, Fn::ref('AWS::StackName')
end

## attach gateway to vpc
resource :IgwAttach, 'AWS::EC2::VPCGatewayAttachment', DependsOn: [:Vpc, :Igw] do
  vpc_id Fn::ref(:Vpc)
  internet_gateway_id Fn::ref(:Igw)
end

## routing table for vpc
resource :RouteTable, 'AWS::EC2::RouteTable', DependsOn: :Vpc do
  vpc_id Fn::ref(:Vpc)
  tag :Name, Fn::ref('AWS::StackName')
end

## default route for outgoing packets
resource :Route, 'AWS::EC2::Route', DependsOn: [:RouteTable, :Igw] do
  route_table_id Fn::ref(:RouteTable)
  gateway_id Fn::ref(:Igw)
  destination_cidr_block '0.0.0.0/0'
end

output :VpcId, Fn::ref(:Vpc), export: Fn::sub('${AWS::StackName}-VpcId')
