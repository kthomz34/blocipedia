class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  
  after_initialize :set_role
  
  enum role: [:standard, :premium, :admin]
  # switch to Rolify 
  
  private 
  
  def set_role
    self.role ||= :standard
  end
end
