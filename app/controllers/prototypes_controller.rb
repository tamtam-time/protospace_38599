class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :new, :destroy]
  before_action :move_to_index, except: [:index, :show]
  before_action :set_prototype, only: [:show, :edit]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if 
      @prototype.save
      redirect_to root_path
      else
        render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if
    prototype.update(prototype_params)
      redirect_to prototype_path(prototype.id)
    else
      redirect_to request.referer
    end
  end

  def edit
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end


  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end

