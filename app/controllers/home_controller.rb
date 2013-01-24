class HomeController < ApplicationController

  before_filter :default_company
  
  def index
    if current_user
      redirect_to company_path(@company) 
    else
      render "companies/show"
    end
  end
  
  def about
    @about = Company.default_about(@company)
  end

  def tos
    @tos = Company.default_tos(@company)
  end
  
  def privacy
    @privacy = Company.default_privacy(@company)
  end
  
  def default_company
    @company = Company.default_home
  end

end
