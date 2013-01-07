class HomeController < ApplicationController

  def index
    if current_user
      @company = Company.default_home
      redirect_to company_path(@company) 
    else
      @company = Company.default_home
      render "companies/show"
    end
  end

end
