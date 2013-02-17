class User < ActiveRecord::Base
  rolify
  letsrate_rater
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :omniauthable, #encryptable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :locations
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :opt_in, :provider, :uid, :uuid
  attr_accessible :first_name, :last_name, :gender, :date_of_birth, :hometown, :about, :avatar_url, :profile_url, :status
  after_create :add_user_to_mailchimp unless Rails.env.test?
  after_create :add_initial_role
  before_destroy :remove_user_from_mailchimp unless Rails.env.test?

  # override Devise method
  # no password is required when the account is created; validate password when the user sets one
  validates_confirmation_of :password
  def password_required?
    if !persisted? 
      !(password != "")
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
  def confirmation_required?
    false
  end
  def active_for_authentication?
    confirmed? || confirmation_period_valid?
  end

  def self.find_for_facebook_omniauth(omniauth, signed_in_resource=nil)
    basic = {
        provider:  omniauth.provider,
        uid:       omniauth.uid,
        }
    User.where(basic).first || User.create(basic.merge(
        first_name: omniauth.info.first_name,  
        last_name:  omniauth.info.last_name,   
        location:  omniauth.info.location,   # sure of
        email:     omniauth.info.email,
        password:  Devise.friendly_token[0,20],
        ))
  end  
  
  def facebook_client(access_token)
     Koala::Facebook::API.new(access_token)
  end

  def self.configure_facebook_user(authorisation_hash, code)
    user = User.where(:email => authorisation_hash.info.email).first

    unless user
      user = User.create(:email => authorisation_hash.info.email,
                         :first_name => authorisation_hash.extra.raw_info.first_name,
                         :last_name => authorisation_hash.extra.raw_info.last_name,
                         :gender => authorisation_hash.extra.raw_info.gender.to_sym,
                         :date_of_birth => authorisation_hash.extra.raw_info.birthday_date,
                         :hometown => authorisation_hash.extra.raw_info.hometown.name,
                         :about => authorisation_hash.extra.raw_info.bio,
                         :password => Devise.friendly_token[0,20],
                         :avatar_url => authorisation_hash.extra.raw_info.pic,
                         :profile_url => authorisation_hash.extra.raw_info.profile_url,
                         :status => authorisation_hash.extra.raw_info.status
                        )
      Rails.logger.info("Fb Create User authorisation_hash=#{authorisation_hash.inspect}")
    end
    user.add_role :member unless user.has_role? :admin  
    begin
      user.fb_token = User.facebook_oauth_client.get_access_token(code)
    rescue
      #External api call rescue all!
    end
    Rails.logger.info("Fb connecting extra=#{authorisation_hash.extra.inspect}")
    user.provider = authorisation_hash.provider
    user.uid = authorisation_hash.uid
    user.save
    user.confirm!
    user.remember_me!
    user_location = authorisation_hash.extra.raw_info.current_location ? authorisation_hash.extra.raw_info.current_location : authorisation_hash.extra.raw_info.current_address
    Location.from_fb(user_location, user)
    Location.from_fb(authorisation_hash.extra.raw_info.hometown_location, user)
    user
  end
  def facebook_oauth_client
    Koala::Facebook::OAuth.new(APP_CONFIG['facebook']['app_key'], APP_CONFIG['facebook']['app_secret'],
                               "#{APP_CONFIG['facebook']['callback']}/users/auth/facebook/callback")
  end
  
  # new function to set the password
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  # new function to determine whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end
  # new function to provide access to protected method pending_any_confirmation
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
   
  # below allows  render :partial => @users, :as => :user
  def to_partial_path() 
    "users/#{type}" 
  end 
  def avatar_url
    "/assets/default/DefaultAvatar2.png"
  end
    
  def add_initial_role
    self.add_role :customer unless self.has_role? :admin  
  end 
  def role_name
    main_role = roles.where(:resource_type=>nil)[0]
    main_role ? main_role["name"] : "nothing"
  end
  def make_admin
    self.remove_role :customer if self.has_role? :customer  
    self.add_role :admin
  end
  def make_customer
    self.remove_role :admin if self.has_role? :admin  
    self.add_role :customer
  end
    
  private

  def add_user_to_mailchimp
    unless self.email.include?('@example.com') or !self.opt_in?
      mailchimp = Hominid::API.new(APP_CONFIG['mailchimp']['api_key'])
      list_id = mailchimp.find_list_id_by_name "visitors"   
      #ToDo add some user information to model and mailchimp
      info = { }
      result = mailchimp.list_subscribe(list_id, self.email, info, 'html', false, true, false, true)
      Rails.logger.info("MAILCHIMP SUBSCRIBE: result #{result.inspect} for #{self.email}")
    end
  end
  def remove_user_from_mailchimp
    unless self.email.include?('@example.com')
      mailchimp = Hominid::API.new(APP_CONFIG['mailchimp']['api_key'])
      begin
        list_id = mailchimp.find_list_id_by_name "visitors"
        result = mailchimp.list_unsubscribe(list_id, self.email, true, false, true)  
        Rails.logger.info("MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{self.email}")
      rescue
        Rails.logger.info("MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{self.email}")
      end
      
    end
  end
  
end

#able "users", :force => true do |t|
#   t.string   "encrypted_password",     :default => "", :null => false
#   t.string   "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.integer  "sign_in_count",          :default => 0
#   t.datetime "current_sign_in_at"
#   t.datetime "last_sign_in_at"
#   t.string   "current_sign_in_ip"
#   t.string   "last_sign_in_ip"
#   t.string   "confirmation_token"
#   t.datetime "confirmed_at"
#   t.datetime "confirmation_sent_at"
#   t.string   "unconfirmed_email"
#   t.datetime "created_at",                             :null => false
#   t.datetime "updated_at",                             :null => false

#   t.string   "name"
#   t.string   "email",                  :default => "", :null => false
#   t.string   "status"
#   t.string   "first_name"
#   t.string   "last_name"
#   t.string   "gender"
#   t.string   "avatar_url"
#   t.string   "profile_url"
#   t.datetime "date_of_birth"
#   t.string   "hometown"
#   t.text     "about"

#   t.string   "state",                  :default => "new"
#   t.string   "provider"
#   t.string   "uid"
#   t.string   "password"
#   t.string   "fb_token"

#   t.string   "uuid"
#   t.string   "analytics_id"
#   t.string   "rating_count"
#   t.string   "rating_average"
#   t.string   "review_count"
#   t.boolean  "opt_in"
#   t.string   "email_count"
# end
#

