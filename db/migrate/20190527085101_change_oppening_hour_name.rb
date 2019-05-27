class ChangeOppeningHourName < ActiveRecord::Migration[5.2]
  def change
    rename_column :doctors, :oppening_hour, :opening_hour
  end
end
