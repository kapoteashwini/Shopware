class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :set_jti
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :orders
  has_many :addresses
  has_one :cart

  enum :role, [:user, :admin]

  def jti
    # Your logic to generate or return the jti
  end



  private

  def set_jti
    self.jti = SecureRandom.uuid
  end

  
  # def jwt_payload
  #      debugger
  #   super.merge('foo' => 'bar')
  # end
end


