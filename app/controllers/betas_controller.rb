class BetasController < ApplicationController
  before_filter :all_requests, :only => [:index, :requests]

  def index
    @authored_books = current_user.manuscripts
    @beta_books = current_user.betas.where("approval = ?", true)
  end

  def show
    @manuscript = Manuscript.find(params[:id])
  end

  def new
    @manuscript = Manuscript.find(params[:manuscript_id])
    @beta = @manuscript.betas.build(user_id: current_user.id)
    @betaexists = Beta.where("manuscript_id = ? AND user_id = ?",
                  @manuscript.id, current_user.id)
    if @betaexists.present?
      message = "You already sent a request to this user."
    else
      if @beta.save
        message = "A beta read request has been sent to " + @manuscript.user.email
      else
        message = "Sorry, there was a problem, and a request wasn't sent"
      end
    end
    respond_to do |format|
      format.html do
        flash[:notification] = message
        redirect_to beta_path(@manuscript.id)
      end
      format.js
    end
  end

  def edit
    @beta = Beta.find(params[:id])
    userid = @beta.manuscript.user_id
    if userid == current_user.id
      @beta.update_attributes(approval: true)
      message = "You have approved " + @beta.user.email + "to read your manuscript"
    else
      message = "Sorry, there was a problem. " + @beta.user.email + " was not approved"
    end
    flash[:notice] = message
    redirect_to '/requests'
  end
  def requests
  end

  private

  def all_requests
    @requests = Beta.find( :all,
                            :joins => "LEFT JOIN manuscripts as m ON manuscript_id = m.id
                                        WHERE m.user_id = #{current_user.id}")
  end
end
