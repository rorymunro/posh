class ForumsController < ApplicationController   
before_action :signed_in_user, only: [:create, :destroy]
   
  def show
    @forum = Forum.find(params[:id])
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    @forum = Forum.new(forum_params)
    
    if @forum.save
      flash[:notice] = "Forum successfully created."
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum = Forum.find(params[:id])
  end
  
  def update
    @forum = Forum.find(params[:id])
    
    if @forum.update_attributes(forum_params)
      flash[:notice] = "Forum deleted."
      redirect_to forum_url(@forum)
    end
  end
  
  def destroy
    @forum = Forum.find(params[:id])
    
    if @forum.destroy
      flash[:notice] = "Category deleted."
      redirect_to forums_url
    end
  end
private

  def forum_params
    params.require(:forum).permit(:title, :description, :state, :position, :category_id)
  end
  


  
end