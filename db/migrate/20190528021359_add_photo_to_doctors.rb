class AddPhotoToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :photo, :string
  end
end
