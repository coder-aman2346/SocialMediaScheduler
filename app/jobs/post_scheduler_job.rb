class PostSchedulerJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    return if post.published?
    linkedin_api = LinkedInApi.new(post.user)
    response = linkedin_api.publish(post.content)

    if response.success?
      post.update(published: true)
    else
      Rails.logger.error("Failed to publish post: #{response.error}")
    end
  end
end