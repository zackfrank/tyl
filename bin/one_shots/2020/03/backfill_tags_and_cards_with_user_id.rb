# Backfills all cards and tags with a user ID

user_id = User.first.id

ActiveRecord::Base.transaction do
  # Update all cards
  Card.find_each do |card|
    puts "\nUpdating card: #{card.title}"

    card.update(user_id: user_id)
  end

  # Update all tags
  Tag.find_each do |tag|
    puts "\nUpdating tag: #{tag.name}"

    tag.update(user_id: user_id)
  end

  puts "\nDone."
end
