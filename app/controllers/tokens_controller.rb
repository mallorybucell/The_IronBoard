class TokensController < ApplicationController
  before_filter :authenticate_admin!

  def create
    current_admin.generate_api_token!(params[:description])
    redirect_to :back, notice: "Token generated"
  end

  def destroy
    token = current_admin.tokens.find params[:id] #check this
    token.disable!
    redirect_to :back, notice: "Token disabled"
  end

end
