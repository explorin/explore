class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_attached_file :avatar, :styles => { :small => ["100x100#", :jpg], :medium => ["200x200#", :jpg], :default_url => "missing.png" }

  validates_attachment :avatar, 
  						content_type: {content_type: ['image/jpeg','image/jpg', 'image/png', 'image/gif']},
  						size: {less_than: 5.megabytes}

  def set_default_role
    self.role ||= :user
  end

end
