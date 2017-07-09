class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,  :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy

  before_save      { self.email = email.downcase }
  before_save { self.role ||= :standard }

  enum role: [:standard, :admin, :premium]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :standard
  end

  private

  def send_user_emails
    UserMailer.new_user(self).deliver_now
  end
end
