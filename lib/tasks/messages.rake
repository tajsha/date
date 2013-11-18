desc "Remove message older than a month"
task :remove_old_messages => :environment do
  Message.delete_all ["created_at < ?", 1.month.ago]
end