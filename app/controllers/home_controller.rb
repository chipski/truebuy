class HomeController < ApplicationController
  layout "public"
  before_filter :default_company
  
  def index
    
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
