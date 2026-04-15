require "net/http"

class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update destroy preview_url]

  def index
    if params[:q].present?
      @documents = Document.where("title LIKE '%#{params[:q]}%'")
    else
      @documents = Current.user.company.documents.all
    end
  end

  def show
  end

  def preview_url
    url = params[:url].presence || @document.external_url
    if url.present?
      begin
        @preview_content = Net::HTTP.get(URI(url))
      rescue => e
        @preview_content = "Error: #{e.message}"
      end
    end
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    @document.uploader = Current.user

    if @document.save
      redirect_to @document, notice: "Document was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @document.update(document_params)
      redirect_to @document, notice: "Document was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @document.destroy
    redirect_to documents_url, notice: "Document was successfully destroyed."
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:title, :description, :external_url, :company_id, :file)
  end
end
