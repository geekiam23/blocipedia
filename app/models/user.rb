class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  before_save { self.email = email.downcase if email.present? }
  before_save { self.role ||= :standard }
  before_save :format_name

  has_many :wikis, dependent: :destroy
  
  enum role: [:standard, :premium, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def format_name
    if name
      name_array = []
      name.split.each do |name_part|
        name_array << name_part.capitalize
      end

      self.name = name_array.join(" ")
    end
  end

  def set_default_role
    self.role ||= :standard
  end
end
