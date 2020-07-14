description ''

parameter :branch, type: :String

## stacks to import
parameter :build, type: :String
parameter :cdn,   type: :String

include_template(
  'dashboard/dashboard.rb'
)
