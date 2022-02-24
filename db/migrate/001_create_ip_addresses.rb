Sequel.migration do
  change do
    create_table :ip_addresses do
      primary_key :id
      inet        :ip, null: false, unique: true, index: { type: :gist, opclass: :inet_ops }
      Boolean     :observable, null: false, default: false
      DateTime    :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime    :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
