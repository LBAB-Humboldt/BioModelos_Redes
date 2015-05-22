class MailerTasks

  def self.send_periodic_notifications
    following = UserRelationship.all
    my_groups = GroupUser.where(:group_user_state_id =>  1)
    user_list = '0'

    following.each do |f|
      user_id = ','+f.user_id.to_s
      user_list += user_id
    end

    my_groups.each do |f|
      user_id = ','+f.user_id.to_s
      user_list += user_id
    end

    users = User.find_by_sql("
                             SELECT u.id, u.name, u.email, u.last_email_send, u.periodicity_id
                             FROM users u
                             WHERE  u.id in ("+user_list+")
                             ")
    users.each do |f|
      if f.periodicity_id.blank?
        days = 7
      else
        case f.periodicity_id
          when 0
            days=0
          when 1
            days=1
          when 2
            days=7
          when 3
            days=30
        end
        days=f.days
      end

      if f.last_email_send.blank?
        last_email_send = Date.today - 1.day
      else
        last_email_send = f.last_email_send
      end

      if last_email_send + days.day <= Date.today && days!=0
        ContactMailer.send_mail_notifications(f.id, f.name, f.email, last_email_send, f.periodicity_id).deliver_now
      end
    end

  end
end