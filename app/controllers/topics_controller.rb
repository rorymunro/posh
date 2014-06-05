class TopicsController < ApplicationController  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:edit, :destroy] 
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
    @topic = @forum.topics.build(topic_params)
    @topic.user = current_user
    
    if @topic.save
      flash[:notice] = "You successfully created a topic!"
      redirect_to topic_url(@topic)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Subject deleted."
      redirect_to topic_url(@topic)
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    
    if @topic.destroy
      flash[:notice] = "Topic was deleted successfully."
      redirect_to forum_url(@topic.forum)
    end
  end

private

  def topic_params
    params.require(:topic).permit(:title, :body, :sticky, :locked)
  end
  def correct_user
      @topic = current_user.topics.find_by(id: params[:id])
      redirect_to topic_url if @topic.nil?
    end


  
end