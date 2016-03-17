json.array!(@jewels) do |jewel|
  json.extract! jewel, :id, :user_id, :color, :price, :weight, :jewel_name, :jewel_description
  json.url jewel_url(jewel, format: :json)
end
