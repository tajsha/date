class CreateConversationsSummaries < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW conversation_summaries_with_scalar_subqueries AS
      SELECT c.id,
      s.name as sender_name,
      r.name as recipient_name,
      (select body from messages where messages.conversation_id = c.id order by created_at DESC LIMIT 1) as most_recent_message_body,
      (select messages.created_at from messages where messages.conversation_id = c.id order by created_at DESC LIMIT 1) as most_recent_message_sent_at,
      (select count(id) from messages m2 where m2.conversation_id = c.id) - 1 as reply_count
      FROM conversations c
      inner join users r on r.id = c.recipient_id
      inner join users s on s.id = c.sender_id
      ;
    SQL
  end

  def down
    execute 'DROP VIEW conversation_summaries'
  end
end