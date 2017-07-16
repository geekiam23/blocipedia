class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

  def collaborator_for(user_id)
    collaborators.where(user_id: user.id).first
  end
end
