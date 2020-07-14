module Stax
  class Cdn < Stack
    include Cloudfront

    no_commands do
      def cfn_parameters
        super.merge(
          branch: branch_name,
          VpceS3: vpc_endpoint_s3 || '',
        )
      end

      ## for s3 policy: get from vpc if that stack exists
      def vpc_endpoint_s3
        stack(:vpc).exists? && stack(:vpc).stack_output(:VpceS3)
      end
    end

    desc 'url', 'show friendly url for cdn'
    def url
      puts('https://' + stack_output(:Route53))
    end

    desc 'create', 'create stack'
    def create
      super
      invoke :url
    end
  end
end
