class TopicsController < TalkyBaseController
  responders :flash
  respond_to :html
  has_scope :page, default: 1

  def show
    resource.hit!
    @posts = apply_scopes(resource.posts)
  end

  def create
    if resource.save
      respond_with resource
    else
      render :action => 'new'
    end
  end

  def update
    params[:topic].delete :body
    if resource.update_attributes(params[:topic])
      respond_with resource
    else
      render :action => 'edit'
    end
  end

  def destroy
    if resource.destroy
      respond_with resource, location: forum_path(resource.forum)
    end
  end

  private

  def resource
    return @topic if @topic.present?

    forum_id = params[:forum_id]
    @forum = Forum.find(forum_id) if forum_id.present?

    id = params[:id]
    return @topic = Topic.find(id) if id.present?
    @topic = Topic.new(params[:topic])
    @topic.forum = @forum if @forum.present?
    @topic.user = current_user
    @topic
  end
end
