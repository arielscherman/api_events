ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :dummies, force: true do |t|
    t.string :name
  end
end

class DummyModel < ActiveRecord::Base
  self.table_name = "dummies"
end
