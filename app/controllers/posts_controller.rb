class PostsController < TalkyBaseController
  responders :flash
  respond_to :html

  def new
    if params[:quote]
      quote_post = Post.find(params[:quote])
      if quote_post
        resource.body = quote_post.body
      end
    end
  end

  def create
    if resource.save
      #flash[:notice] = "Post was successfully created."
      #redirect_to topic_path(@post.topic)
      respond_with resource, location: topic_path(resource.topic)
    else
      render :action => 'new'
    end
  end

  def update
    if resource.update_attributes(params[:post])
      #flash[:notice] = "Post was successfully updated."
      #redirect_to topic_path(@post.topic)
      respond_with resource
    end
  end

  def destroy
    if resource.topic.posts_count > 1
      if resource.destroy
        #flash[:notice] = "Post was successfully destroyed."
        #redirect_to topic_path(@post.topic)
        respond_with resource, location: topic_path(resource.topic)
      end
    else
      if resource.topic.destroy
        #flash[:notice] = "Topic was successfully deleted."
        #redirect_to forum_path(@post.forum)
        respond_with resource.topic, location: forum_path(resource.forum)
      end
    end
  end

  private

  def resource
    return @post if @post.present?

    topic_id = params[:topic_id]
    @topic = Topic.find(topic_id) if topic_id.present?

    id = params[:id]
    return @post = Post.find(id) if id.present?

    @post = Post.new(params[:post])
    if @topic.present?
      @post.topic = @topic
      @post.forum = @topic.forum
    end
    @post.user = current_user
  end
end
