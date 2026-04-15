class Api::DocumentsController < ApplicationController
  allow_unauthenticated_access
  before_action :authenticate_with_api_key

  def index
    documents = @current_api_user.company.documents
    render json: documents.as_json(only: %i[id title description external_url company_id created_at])
  end

  def show
    document = Document.find(params[:id])
    render json: document.as_json(only: %i[id title description external_url company_id created_at])
  end

  private

  def authenticate_with_api_key
    token = request.headers["Authorization"]&.removeprefix("Bearer ")
    @current_api_user = token && User.find_by(api_key: token)
    unless @current_api_user
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
