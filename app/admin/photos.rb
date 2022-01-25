ActiveAdmin.register Photo do
  # See permitted parameters documentation:
  # # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  # index do
  #   selectable_column
  #   id_column
  #   column :email
  #   column :current_sign_in_at
  #   column :sign_in_count
  #   column :created_at
  #   actions
  # end

  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :image, :image_new, :name, :description, :status, :rejection_reason, :moderated_date, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:image, :name, :description, :status, :moderated, :moderated_date, :user_id, :competition_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
