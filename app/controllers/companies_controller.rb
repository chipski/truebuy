class CompaniesController < InheritedResources::Base 
  defaults :resource_class => Company, :collection_name => 'companies', :instance_name => 'company'
  respond_to :html, :json
  
  
  def show
    @company = Company.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end
  
  def editOFF
    @company = Company.find(params[:id])
    @photos = Photo.initial
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

end
