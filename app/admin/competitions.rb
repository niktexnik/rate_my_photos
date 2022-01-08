ActiveAdmin.register Competition do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :competition_name, :competition_description, :competition_image, :start_date, :end_date
  #
  # or
  #
  # permit_params do
  #   permitted = [:competition_name, :competition_description, :competition_image, :start_date, :end_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
