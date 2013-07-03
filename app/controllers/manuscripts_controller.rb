class ManuscriptsController < ApplicationController
  before_filter :find_manuscript, only: [:destroy, :show]

  def index
    @manuscripts = Manuscript.all
  end

  def new
    @manuscript = current_user.manuscripts.build
  end

  def create
    @manuscript = current_user.manuscripts.build(params[:manuscript])

    # checks to see if the text area is empty or not
    if params[:book].present? && @manuscript.save

      # splits the book into paragraphs
      book = params[:book].split('\r\n')

      book.each do |line|
        @manuscript.contents.build(line: line)
        @manuscript.save
      end

      redirect_to @manuscript
    elsif params[:upload].present?

      filename = params[:upload].original_filename
      file = open(params[:upload])
      if filename.match(/.docx$/)
        @manuscript.save
        doc = Docx::Document.open(file)
        doc = doc.to_html
        doc = doc.gsub('<!DOCTYPE html>', '').gsub('</p>', "--++")
        docArray = doc.split('--++')
        docArray.each do |line|
          content = @manuscript.contents.build(line: line)
          content.save
        end
      elsif filename.match(/.txt$/)
        @manuscript.save
        doc = file.read
        docArray = doc.split('
')
        docArray.each do |line|
          content = @manuscript.contents.build(line: line)
          content.save
        end
      else
          flash[:notice] = "Sorry, you can only upload a docx or txt file."
          render action: "new"
          return
      end
      redirect_to @manuscript
    else
      flash[:notice] =  "Please, submit a file or copy" +
                        " and paste your manuscript in the box"
      render :action => "new"
    end
  end

  def show
  end

  def destroy
    flash[:notice] = "You have deleted " + @manuscript.title
    @manuscript.destroy
    redirect_to betas_path
  end

  private

  def find_manuscript
    @manuscript = Manuscript.find(params[:id])
  end
end
