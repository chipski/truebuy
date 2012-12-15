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
  
  def update_state
    @company = Company.find(params[:id])
    return_to = company_path(@company)
    update_entity_state(@company, params[:state])
    respond_to do |format|
      if @company.save
        format.html { redirect_to return_to }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end  
  
end
