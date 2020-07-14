description 'Peacock website vpc for proxy'

include_template(
  'vpc/vpc.rb',
  'vpc/subnets.rb',
  'vpc/endpoint.rb',
)
