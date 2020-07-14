## reap task sends stack names to hamerkop cfnreap SQS queue
require 'stax/aws/ssm'
require 'stax/aws/sqs'

module Stax
  class Cli < Base
    no_commands do
      ## get queue from hamerkop SSM param
      def reap_queue_url
        @_reap_queue_url ||= Aws::Ssm.get(names: ['/hamerkop/master/cfnreap/Sqs']).first&.value
      end

      ## send list of stack name to queue
      def reap_queue_send(stacks)
        stacks.each_slice(10) do |batch|
          Aws::Sqs.client.send_message_batch(
            queue_url: reap_queue_url,
            entries: batch.map { |s| { id: s, message_body: s } }
          )
        end
      end
    end

    desc 'reap', 'meta reap task'
    def reap
      debug("Finding stacks to reap for #{branch_name}")
      stacks = stack_objects.map do |s|
        s.exists? ? s.stack_name.tap(&method(:puts)) : nil
      end.compact

      fail_task('No stacks to reap') if stacks.empty?

      if yes?('Really reap the above stacks?', :yellow)
        reap_queue_send(stacks)
      end
    end

  end
end
