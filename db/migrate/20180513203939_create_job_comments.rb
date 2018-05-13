class CreateJobComments < ActiveRecord::Migration[5.1]
  def change
    create_table :job_comments do |t|
      t.text :content

      t.timestamps
      t.references :job, foreign_key: true
    end
  end
end
