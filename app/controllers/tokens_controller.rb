class TokensController < ApplicationController
  before_filter :authenticate_admin!
end
