class CategoriesController < TalkyBaseController
  responders :flash
  respond_to :html

  def index
    @categories = Category.all
  end

  def create
    if resource.save
      #flash[:notice] = "Category was successfully created."
      #redirect_to forums_url
      respond_with resource, location: forums_path
    else
      render :action => 'new'
    end
  end

  def update
    if resource.update_attributes(params[:category])
      #flash[:notice] = "Category was updated successfully."
      #redirect_to forums_url
      respond_with resource, location: forums_path
    end
  end

  def destroy
    if resource.destroy
      #flash[:notice] = "Category was deleted."
      redirect_to forums_url
    end
  end

  private

  def resource
    return @category if @category.present?

    id = params[:id]
    return @category = Category.find(id) if id.present?
    @category = Category.new(params[:category])
  end
end
