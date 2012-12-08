module LifeCycleState
  include AASM 
  
  # State machine, should be shared in mixin but error now
  #include LifeCycleState   
  aasm :column => :state do
    state :new,      :initial => true              
    state :review,   :enter => :make_review 
    state :launch,   :enter => :make_launch 
    state :active,   :enter => :make_active
    state :inactive, :enter => :make_inactive
    state :error,    :enter => :make_inactive  
    state :list_only,:enter => :make_list_only
     
    event :mark_review do
      transitions :to => :review
    end
    event :mark_launch do
      transitions :to => :launch #, :from => [:review, :inactive, :active, :list_only, :error]
    end
    event :mark_active do
      transitions :to => :active #, :from => [:review, :inactive, :active, :list_only, :error]
    end
    event :mark_inactive do
      transitions :to => :inactive #, :from => [:active, :new, :inactive, :list_only, :error]
    end  
    event :mark_error do
      transitions :to => :error #, :from => [:active, :new, :inactive, :list_only, :error]
    end
    event :mark_list_only do
      transitions :to => :list_only #, :from => [:active, :new, :inactive, :list_only, :error]
    end
    event :mark_admin_only do
      transitions :to => :new #, :from => :all
    end
  end
  def make_review
    # make all children campaigns for review
    #self.children.map{|c| c.mark_review!}
  end
  def make_launch
    # make all children campaigns for make_launch
    #self.children.map{|c| c.mark_launch!}
  end
  def make_active
    # propogate down to children   
    Rails.logger.info("Campaign.make_active for child campaigns #{self.children.size}")     
    #self.children.map{|c| c.mark_active!}
  end
  def make_inactive
    # propogate down to children 
    Rails.logger.info("Campaign.make_inactive for child campaigns #{self.children.size}")     
    #self.children.map{|c| c.mark_inactive!}  
  end 
  def make_list_only
    # propogate down to children 
    #self.children.map{|c| c.mark_list_only!}
    # propogate to sf  
  end
  def delete_children
    #self.children.map{|c| c.delete_children}
  end

  
  
end