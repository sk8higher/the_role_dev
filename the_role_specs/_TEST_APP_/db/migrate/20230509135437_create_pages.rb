class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.integer :person_id

      t.string  :title
      t.text    :content
      t.string  :state, default: :draft

      t.timestamps
    end
  end
end
