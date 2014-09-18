class ChargesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    if params[:card][:cvv] == '123'
      render :nothing => true, :status => 402, :content_type => 'application/json'
    else
      render :nothing => true, :status => 201, :content_type => 'application/json'
    end
  end

end
