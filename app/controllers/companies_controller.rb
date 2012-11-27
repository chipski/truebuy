class CompaniesController < InheritedResources::Base 
  defaults :resource_class => Company, :collection_name => 'companies', :instance_name => 'company'
  respond_to :html, :json
  
  
end
