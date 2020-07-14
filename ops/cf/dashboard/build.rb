Cfer::Core::Resource.extend_resource 'AWS::CloudWatch::Dashboard' do
  def build_metrics
    [
      {
        type: :metric,
        properties: {
          title: 'Code Builds',
          view: :timeSeries,
          stacked: true,
          region: '${AWS::Region}',
          period: 60,
          metrics: [
            [ 'AWS/CodeBuild', :SucceededBuilds, :ProjectName, '${codebuild}', { stat: :Sum } ],
            [ '.',             :FailedBuilds,    '.',          '.',            { stat: :Sum } ],
          ],
        }
      },
      {
        type: :metric,
        properties: {
          title: 'Code Build Duration',
          view: :timeSeries,
          stacked: true,
          region: '${AWS::Region}',
          metrics: [
            [ 'AWS/CodeBuild', :Duration, :ProjectName, '${codebuild}' ],
          ],
        }
      },
    ]
  end
end
