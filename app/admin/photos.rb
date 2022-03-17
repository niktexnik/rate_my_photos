ActiveAdmin.register Photo do
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params :image, :image_new, :name, :description, :status, :rejection_reason, :moderated_date

  scope :all, default: true
  scope :published
  scope :pending
  scope :rejected

  batch_action :revert do |ids|
    batch_action_collection.find(ids).each do |photo|
      photo.revert! :revert unless photo.pending?
    end
    redirect_to admin_photos_path, alert: 'Success'
  end

  batch_action :reject do |ids|
    batch_action_collection.find(ids).each do |photo|
      photo.reject! :reject unless photo.rejected?
    end
    redirect_to admin_photos_path, alert: 'Success'
  end

  batch_action :aprove do |ids|
    batch_action_collection.find(ids).each do |photo|
      photo.aprove! :aprove unless photo.published?
    end
    redirect_to admin_photos_path, alert: 'Success'
  end

  action_item :aprove, only: :show do
    link_to 'Aprove', aprove_admin_photo_path(photo), method: :put if !photo.pending? && !photo.rejected?
  end
  action_item :reject, only: :show do
    link_to 'Reject', reject_admin_photo_path(photo), method: :put if !photo.rejected? && !photo.published?
  end
  action_item :aprove, only: :show do
    link_to 'Revert', revert_admin_photo_path(photo), method: :put if photo.rejected?
  end

  show do
    attributes_table do
      row :image do |photo|
        image_tag photo.image.url(:large)
      end
      row :image_new do |photo|
        image_tag photo.image_new.url(:large) if photo.image_new.present?
      end
      row :name
      row :description
      row :user_name, :user_id do
        link_to(photo.user.name)
      end
      row :created_at
      row :updated_at
      row :moderated_date
      row :status
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end
    f.actions
  end

  index do
    selectable_column
    column :name
    column :description
    column :image do |photo|
      image_tag photo.image_url(:thumb)
    end
    column :image_new do |photo|
      image_tag photo.image_new_url(:thumb) if photo.image_new.present?
    end
    column :rejection_reason
    column :status
    column :action do |photo|
      if photo.pending?
        columns do
          link_to :aprove, aprove_admin_photo_path(photo)
        end
        columns do
          link_to :reject, reject_admin_photo_path(photo)
        end
      end
      if photo.published?
        columns do
          link_to :reject, reject_admin_photo_path(photo)
        end
      end
      if photo.rejected?
        columns do
          link_to :revert, revert_admin_photo_path(photo)
        end
      end
    end
    actions
  end

  member_action :aprove do
    photo = Photo.find(params[:id])
    if photo.image_new.present?
      photo.image = photo.image_new
      photo.image_new = nil
    end
    NotificationsChannel.broadcast_to(
      photo.user,
      title: 'Your photo was approved:',
      body: "Name: #{photo.name}, description: #{photo.description}"
    )
    photo.update(moderated_date: Time.zone.now)
    photo.aprove!
    redirect_to admin_photos_path
  end

  member_action :reject do
    photo = Photo.find(params[:id])
    photo.update(rejection_reason: "Photo cant't be published!")
    NotificationsChannel.broadcast_to(
      photo.user,
      title: 'Your photo was rejected:',
      body: "Name: #{photo.name}, description: #{photo.rejection_reason}"
    )
    photo.reject!
    redirect_to admin_photos_path
  end

  member_action :revert do
    photo = Photo.find(params[:id])
    photo.update(rejection_reason: nil, moderated_date: nil)
    photo.revert!
    redirect_to admin_photos_path
  end
end
