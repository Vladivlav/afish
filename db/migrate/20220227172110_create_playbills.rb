class CreatePlaybills < ActiveRecord::Migration[6.1]
  def change
    create_table :playbills do |t|
      t.string 'title', null: false, comment: 'name of performance'
      t.daterange 'duration', null: false, comment: 'period of showing the event in the theatre'
      t.integer 'status', default: 1
      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE playbills
      ADD CONSTRAINT playbills_reservation EXCLUDE USING GIST (duration WITH &&);
    SQL
  end
end
