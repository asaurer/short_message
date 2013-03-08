class CreateShortMessageMessages < ActiveRecord::Migration
  def change
    create_table :short_message_messages do |t|
      t.string :message_key
      t.string :sender
      t.string :recipient
      t.integer :status_code
      t.text :text

      t.timestamps
    end
  end
end
