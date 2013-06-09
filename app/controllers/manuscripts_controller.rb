class ManuscriptsController < ApplicationController
  def new
    @manuscript = Manuscript.new
  end

  def create
    @manuscript = Manuscript.new(params[:manuscript])

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
        require 'docx'
        doc = Docx::Document.open(file)
        doc = doc.to_html
        doc = doc.gsub('<!DOCTYPE html>', '').gsub('</p>', '++--')
        doc = strip_tags(doc)
        docArray = doc.split('++--')
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

  private
  def strip_tags(html)
    return html if html.blank?
    if html.index("<")
      text = ""
      tokenizer = HTML::Tokenizer.new(html)

    while token = tokenizer.next
      node = HTML::Node.parse(nil, 0, 0, token, false)
          # result is only the content of any Text nodes
      text << node.to_s if node.class == HTML::Text
    end
      # strip any comments, and if they have a newline at the end (ie. line with
      # only a comment) strip that too
      text.gsub(/<!--(.*?)-->[\n]?/m, "")
    else
      html # already plain text
    end
  end
end
