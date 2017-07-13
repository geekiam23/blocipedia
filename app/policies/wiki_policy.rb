# class WikiPolicy < ApplicationPolicy
#
#   def index
#     true
#   end
#
#   def update?
#     user.present?
#   end
#
#   class Scope < Scope
#
#     attr_reader :user, :scope
#
#      def initialize(user, scope)
#        @user = user
#        @scope = scope
#      end
#
#     def resolve
#       wikis = []
#        if user.role == 'admin'
#          wikis = scope.all # if the user is an admin, show them all the wikis
#        elsif user.role == 'premium'
#          all_wikis = scope.all
#          all_wikis.each do |wiki|
#            if wiki.private == false || wiki.user == user || wiki.collaborators.include?(user)
#              wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
#            end
#          end
#        else # this is the lowly standard user
#          all_wikis = scope.all
#          wikis = []
#          all_wikis.each do |wiki|
#            if wiki.private == false || wiki.users.include?(user)
#              wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
#            end
#          end
#        end
#        wikis # return the wikis array we've built up
#      end
#    end
# end
#
# class WikiPolicy < ApplicationPolicy
#
#   def new?
#     user.present?
#   end
#
#   def show?
#     permit = false
#     if @record.private == true
#       if (@user && @user.role == 'premium' && @record.user == @user) || (@user && @user.role == 'admin')
#         permit = true
#       elsif @user
#         @record.collaborators.each do |c|
#           if c.user_id == @user.id
#             permit = true
#           end
#         end
#       end
#     else
#       permit = true
#     end
#     return permit
#   end
#
#   def create?
#     @user
#   end
#
#   def update?
#     permit = false
#     if @record.private == true
#       if (@user.role == 'premium' && @record.user == @user) || @user.role == 'admin'
#         permit = true
#       else
#         @record.collaborators.each do |c|
#           if c.user_id == @user.id
#             permit = true
#           end
#         end
#       end
# 		elsif !@user
# 			permit = false
# 		else
# 			permit = true
# 		end
# 		return permit
# 	end
#
# 	def destroy?
# 		(@user && @record.user_id == @user.id) || @user && @user.role == "admin"
# 	end
#
# 	class Scope
# 		attr_reader :user, :scope
#
# 		def initialize(user, scope)
# 			@user = user
# 			@scope = scope
# 		end
#
# 		def resolve
# 			wikis = []
# 			if user != nil && user.role == 'admin'
# 				wikis = scope.all # if the user is an admin, show them all the wikis
# 			elsif user != nil && user.role == 'premium'
# 				all_wikis = scope.all
# 				all_wikis.each do |wiki|
# 					# if wiki.private? == false || wiki.user == user || wiki.collaborators.include?(user)
# 						wikis << wiki # if the user is premium, only show them public wikis, or private wikis they created, or private wikis they are a collaborator on
# 					# end
# 				end
# 			else # this is the lowly standard user
# 				all_wikis = scope.all
# 				wikis = []
# 				all_wikis.each do |wiki|
# 					# if wiki.private? == false || wiki.collaborators.include?(user)
# 						wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
# 					# end
# 				end
# 			end
# 			wikis # return the wikis array we've built up
# 		end
# 	end
# end
class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    return true if user.present? && user == article.user
  end

  def destroy?
    return true if user.present? && user == article.user
  end

  private

    def article
      record
    end
end
