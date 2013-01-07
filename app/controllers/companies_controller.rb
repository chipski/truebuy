class CompaniesController < InheritedResources::Base 
  defaults :resource_class => Company, :collection_name => 'companies', :instance_name => 'company'
  respond_to :html, :json
  
  before_filter :authenticate_user!, :except => [:error, :show, :index]  
  
  def show
    resource
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end
  
  def editOFF
    resource
    @photos = Photo.initial
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end
  
  def update_state
    resource
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
  
  protected
    def resource
      @company = Company.find_by_permalink(params[:id])
    end
    def collectionOff
      @companies ||= end_of_association_chain.paginate(:page => params[:page])
    end 
    def begin_of_association_chainOFF
      @current_user
    end
    
end
