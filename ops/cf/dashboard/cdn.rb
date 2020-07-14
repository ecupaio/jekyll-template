Cfer::Core::Resource.extend_resource 'AWS::CloudWatch::Dashboard' do
  def cdn_metrics
    [
      {
        type: :metric,
        properties: {
          title: 'Cloudfront Requests',
          view: :timeSeries,
          stacked: false,
          region: '${AWS::Region}',
          metrics: [
            [ 'AWS/CloudFront', 'Requests', 'Region', 'Global', 'DistributionId', '${distribution}', { stat: 'Sum', period: 60 } ],
          ],
        }
      },
      {
        type: :metric,
        properties: {
          title: 'Cloudfront CacheHitRate',
          view: :timeSeries,
          stacked: false,
          region: '${AWS::Region}',
          metrics: [
            [ 'AWS/CloudFront', :CacheHitRate, :Region, :Global, :DistributionId, '${distribution}', { stat: :Average, period: 60 } ],
          ],
        }
      },
      {
        type: :metric,
        properties: {
          title: 'Cloudfront OriginLatency',
          view: :timeSeries,
          stacked: false,
          region: '${AWS::Region}',
          metrics: [
            [ 'AWS/CloudFront', :OriginLatency, :Region, :Global, :DistributionId, '${distribution}', { stat: :Average, period: 60 } ],
          ],
        }
      },
      {
        type: :metric,
        properties: {
          title: 'Cloudfront Errors',
          view: :timeSeries,
          stacked: false,
          region: '${AWS::Region}',
          metrics: [
            [ 'AWS/CloudFront', '4xxErrorRate',   :Region, :Global, :DistributionId, '${distribution}',    { stat: :Average, period: 60 } ],
            [ '.',              '401ErrorRate',   '.',     '.',     '.',             '.',                  { stat: :Average, period: 60 } ],
            [ '.',              '403ErrorRate',   '.',     '.',     '.',             '.',                  { stat: :Average, period: 60 } ],
            [ '.',              '404ErrorRate',   '.',     '.',     '.',             '.',                  { stat: :Average, period: 60 } ],
            [ '.',              '5xxErrorRate',   '.',     '.',     '.',             '.',                  { stat: :Average, period: 60 } ],
            [ '.',              '502ErrorRate',   '.',     '.',     '.',             '.',                  { stat: :Average, period: 60 } ],
            [ '.',              '503ErrorRate',   '.',     '.',     '.',             '.',                  { stat: :Average, period: 60 } ],
            [ '.',              '504ErrorRate',   '.',     '.',     '.',             '.',                  { stat: :Average, period: 60 } ],
          ],
        }
      },
    ]
  end
end
