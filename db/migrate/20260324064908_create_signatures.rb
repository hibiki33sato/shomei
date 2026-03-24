class CreateSignatures < ActiveRecord::Migration[8.1]
  def change
    create_table :signatures do |t|
      t.string :name_kanji
      t.string :name_yomi
      t.string :area
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
