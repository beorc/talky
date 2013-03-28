class ForumsController < TalkyBaseController
  responders :flash
  respond_to :html

  def create
    if resource.save
      #flash[:notice] = "Forum was successfully created."
      #redirect_to forums_url
      respond_with resource, location: forums_path
    else
      render :action => 'new'
    end
  end

  def update
    if resource.update_attributes(params[:forum])
      #flash[:notice] = "Forum was updated successfully."
      #redirect_to forum_url(@forum)
      respond_with resource
    end
  end

  def destroy
    if resource.destroy
      #flash[:notice] = "Category was deleted."
      #redirect_to forums_url
      respond_with resource, location: forums_path
    end
  end

  private

  def resource
    return @forum if @forum.present?

    id = params[:id]
    return @forum = Forum.find(id) if id.present?
    @forum = Forum.new(params[:forum])
  end
end
