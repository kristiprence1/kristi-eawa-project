json.resources do
  json.partial! partial: 'home/index', as: :all_item, collection: @all_books
end