require_relative 'build'
require_relative 'cdn'

resource :CloudwatchDashboard, 'AWS::CloudWatch::Dashboard' do
  dashboard_name Fn::sub('website-${branch}')
  dashboard_body(
    Fn::sub(
      {
        widgets: [
          build_metrics,
          cdn_metrics,
        ].flatten
      }.to_json,
      codebuild: Fn::import_value(Fn::sub('${build}-CodeBuild')),
      distribution: Fn::import_value(Fn::sub('${cdn}-Distribution')),
    )
  )
end
