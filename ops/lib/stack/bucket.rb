module Stax
  class Bucket < Stack
    include S3

    no_commands do
      def dev_account_check!
        if aws_account_id == ''
          unless yes?("\nReview applications created in the dev account must create a CDN stack, which may take up to 45 minutes.\nAre you sure you don't want to use the fedev account for direct bucket access instead?", :green)
            fail_task("Exiting without creating stack")
          end
        end
      end
    end

    def create
      dev_account_check!
      super
    end
  end
end
