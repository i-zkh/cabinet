class CreateEnHandlings < ActiveRecord::Migration
  def change
    create_table :en_handlings do |t|
      t.integer :user_account
      t.integer :user_id
      t.string :remote_ip

      t.timestamps
    end
  end
end
