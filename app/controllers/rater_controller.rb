class RaterController < ApplicationController 
  
  def create                                  
    if current_user.present? && params[:klass]
      #ToDo check the security effects of doing below!
      obj = eval "#{params[:klass]}.find(#{params[:id]})"     
      begin
        if params[:dimension].present?
          # if obj.can_rate?(user_id, dimension=nil)
          obj.rate params[:score].to_i, current_user.id, "#{params[:dimension]}"       
        else
          obj.rate params[:score].to_i, current_user.id 
        end
      rescue Exception=>e
        render :json => {:success=>false, :error=>e}
      else      
        render :json => true 
      end
    else
      render :json => false        
    end
  end                                        
  
  
end