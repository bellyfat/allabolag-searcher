class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :search_term
      t.boolean :found
      t.string :reg_number

      t.timestamps
    end
  end
end
