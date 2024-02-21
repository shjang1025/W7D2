class CreateBands < ActiveRecord::Migration[7.1]
  def change
    create_table :bands do |t|

      t.timestamps
    end
  end
end
