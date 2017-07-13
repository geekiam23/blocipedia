class User < ActiveRecord::Base
  include Clearance::User
  devise :database_authenticatable, :registerable,  :recoverable, :rememberable, :trackable, :validatable


  has_many :wikis

  before_save { self.email = email.downcase }
  after_initialize { self.role ||= :standard }

  enum role: [:standard, :admin, :premium]

  private

  def send_user_emails
    UserMailer.new_user(self).deliver_now
  end
end
