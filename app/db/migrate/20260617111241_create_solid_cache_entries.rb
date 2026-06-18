class CreateSolidCacheEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_cache_entries do |t|
      t.binary :key, null: false
      t.binary :value, null: false
      t.datetime :created_at, null: false
      t.integer :key_hash, null: false, limit: 8
      t.integer :byte_size, null: false

      t.index :key_hash, unique: true
      t.index [:key_hash, :byte_size]
      t.index :byte_size
    end
  end
end
