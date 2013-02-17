class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:error, :profile]  
  
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    @chart = create_chart
  end
  
  def show
    if ["edit","me"].include?(params[:id])
      @user = current_user
    else
      authorize! :invite, @user, :message => 'Not authorized as an administrator.'
      @user = User.find(params[:id])
    end
  end
  
  def invite
    authorize! :invite, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    @user.send_confirmation_instructions
    redirect_to :back, :only_path => true, :notice => "Sent invitation to #{@user.email}."
  end
  
  def bulk_invite
    authorize! :bulk_invite, @user, :message => 'Not authorized as an administrator.'
    users = User.where(:confirmation_token => nil).order(:created_at).limit(params[:quantity])
    users.each do |user|
      user.send_confirmation_instructions
    end
    redirect_to :back, :only_path => true, :notice => "Sent invitation to #{users.count} users."
  end
  def update_role
    authorize! :update_role, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if ["admin",:admin].include?(params[:role])
      @user.make_admin
    else
      @user.make_customer
    end
    redirect_to :back, :only_path => true, :notice => "Sent invitation to #{@user.email}."
  end
  def edit_admin
    authorize! :edit_admin, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    #@sforg = Sforg.find(params[:sforg_id])
    render :edit
  end
  def update_admin
    authorize! :update_admin, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save
      flash[:info] = "The user was updated!"
    else
      @msg = "User.update_admin errors #{@user.errors.map{|e| e.inspect}}"
      Rails.logger.info(@msg )
      flash[:info] = @msg
    end
    redirect_to user_path(@user)
  end
  
  private
  
  def create_chart
    users_by_day = User.group("DATE(created_at)").count
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date')
    data_table.new_column('number')
    users_by_day.each do |day|
      data_table.add_row([ Date.parse(day[0].to_s), day[1]])
    end
    @chart = GoogleVisualr::Interactive::AnnotatedTimeLine.new(data_table)
  end

end