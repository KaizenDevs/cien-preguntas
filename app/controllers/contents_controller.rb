class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def new
    @content = Content.new
  end

  def edit
    @content = Content.find(params[:id])
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      flash[:notice] = "¡El FAQ ha sido creado correctamente!"
      redirect_to contents_path
    else
      flash[:alert] = "El FAQ no se ha podido crear, intentalo de nuevo."
      render 'new'
    end
  end

  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      flash[:notice] = "¡El FAQ se ha actualizado correctamente!"
      redirect_to contents_path
    else
      flash[:alert] = "El FAQ no se ha podido actualizar. Inténtalo de nuevo."
      render 'edit'
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to contents_path
  end

  private
  def content_params
    params.require(:content).permit(:title, :content, :content_order)
  end
end
