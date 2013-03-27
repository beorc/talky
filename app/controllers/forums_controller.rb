class ForumsController < TalkyBaseController
  responders :flash
  respond_to :html

  def show
    @forum = Forum.find(params[:id])
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(params[:forum])

    if @forum.save
      #flash[:notice] = "Forum was successfully created."
      #redirect_to forums_url
      respond_with @forum
    else
      render :action => 'new'
    end
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])

    if @forum.update_attributes(params[:forum])
      #flash[:notice] = "Forum was updated successfully."
      #redirect_to forum_url(@forum)
      respond_with @forum
    end
  end

  def destroy
    @forum = Forum.find(params[:id])

    if @forum.destroy
      #flash[:notice] = "Category was deleted."
      #redirect_to forums_url
      respond_with @forum, location: forums_path
    end
  end
end
