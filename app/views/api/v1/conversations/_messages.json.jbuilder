json.current_page pagy&.page
json.total_pages pagy&.pages
json.total_count pagy&.count

json.messages do
  json.array! records do |message|
    json.extract! message, :id, :content, :user, :created_at
  end
end
