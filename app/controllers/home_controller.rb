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
    @topic = @company.about
    render :about
  end

  def tos
    @topic = @company.tos
    render :about
  end
  
  def privacy
    @topic = @company.privacy
    render :about
  end
  
  def default_company
    @company = Company.default_home
  end

end
