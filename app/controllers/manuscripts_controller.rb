class ManuscriptsController < ApplicationController

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
    elsif params[:upload].present? && @manuscript.save

      filename = params[:upload].original_filename
      file = open(params[:upload])
      if filename.match(/.docx$/)
        doc = Docx::Document.open(file)
        doc = doc.to_html
        doc = doc.gsub('<!DOCTYPE html>', '').gsub('</p>', "--++")
        docArray = doc.split('--++')
        docArray.each do |line|
          content = @manuscript.contents.build(line: line)
          content.save
        end
      elsif filename.match(/.txt$/)
        doc = file.read
        docArray = doc.split('
')
        docArray.each do |line|
          content = @manuscript.contents.build(line: line)
          content.save
        end
      end
      redirect_to @manuscript
    else
      flash[:notice] =  "Please, submit a file or copy" +
                        " and paste your manuscript in the box"
      render :action => "new"
    end
  end

  def show
    @manuscript = Manuscript.find(params[:id])
  end

end
