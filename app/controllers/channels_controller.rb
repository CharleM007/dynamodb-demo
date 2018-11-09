class ChannelsController < ApplicationController
  include Jets::AwsServices
  class_iam_policy("dynamodb", "sns")
  def index
    channels = Channel.scan
    topic_arn = Alert.lookup(:delivery_completed)
    Jets.logger.debug("About to publish to #{topic_arn}")
    sns.publish(topic_arn: topic_arn,  subject: "Test", message: "Just testing")
    render json: channels.to_json
  end
end