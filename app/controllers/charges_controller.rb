class ChargesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    if params[:card][:number] == '1234123412341234'
      render :nothing => true, :status => 402, :content_type => 'application/json'
    else
      render :json => {id: 10}, :status => 201, :content_type => 'application/json'
    end
  end

end
