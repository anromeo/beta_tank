class BetasController < ApplicationController

  def index
    @authored_books = current_user.manuscripts
  end

  def show
    @manuscript = Manuscript.find(params[:id])
  end

  def new
    @manuscript = Manuscript.find(params[:manuscript_id])
    @beta = @manuscript.betas.build(user_id: current_user.id)
    if @beta.save
      message = "A beta read request has been sent to " + @manuscript.user.email
      flash[:notification] = message
      redirect_to manuscript_path(@manuscript)
    end
  end
end
