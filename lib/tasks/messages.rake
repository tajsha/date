desc "Remove message older than a day"
task :remove_old_notifications => :environment do
Notification.delete_all ["created_at < ?", 1.day.ago]
end