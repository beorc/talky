class CategoriesController < TalkyBaseController
  responders :flash
  respond_to :html

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      #flash[:notice] = "Category was successfully created."
      #redirect_to forums_url
      respond_with @category, location: forums_path
    else
      render :action => 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      #flash[:notice] = "Category was updated successfully."
      #redirect_to forums_url
      respond_with @category, location: forums_path
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.destroy
      flash[:notice] = "Category was deleted."
      redirect_to forums_url
    end
  end
end
