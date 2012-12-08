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
    case params[:state] 
    when "active"
      @company.mark_active    
      puts "Campaign.update_state marked active "
    when "inactive" 
      @company.mark_inactive    
      puts "Campaign.update_state marked mark_inactive "
    when  "review" 
      @company.mark_review    
      puts "Campaign.update_state marked mark_review "
    when "launch" 
      @company.mark_launch    
      puts "Campaign.update_state marked mark_launch "
    when  "list_only" 
      @company.mark_list_only    
      puts "Campaign.update_state marked mark_list_only "
      return_to = admin_new_campaigns_path
    when "admin_only" 
      @company.mark_admin_only    
      puts "Campaign.update_state marked mark_admin_only "
    when  "error" 
      @company.mark_error    
      puts "Campaign.update_state marked mark_error "
    end      
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
