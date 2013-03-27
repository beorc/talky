class TopicsController < TalkyBaseController
  responders :flash
  respond_to :html

  def show
    @topic = Topic.find(params[:id])
    @topic.hit! if @topic
  end

  def new
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.new
  end

  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.build(params[:topic])
    @topic.user = current_user

    if @topic.save
      respond_with @topic
    else
      render :action => 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(params[:topic])
      respond_with @topic
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      respond_with @topic, location: forum_path(@topic.forum)
    end
  end
end
