# app/controllers/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super

    if current_user
      params[:user][:collection].reject(&:empty?).each do |collection_id|
        UserCollection.create(user_id: current_user.id, collection_id: collection_id)
      end
    end
  end




  def update
    super

    current_user.user_collections.destroy_all
    params[:user][:collection].reject(&:empty?).each do |collection_id|
      UserCollection.create(user_id: current_user.id, collection_id: collection_id)
    end
  end
end 