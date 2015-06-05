class ContactMailer < ActionMailer::Base
  default from: "feedback@biomodelos.humboldt.org.co"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_us.subject
  #
  def contact_us(message)
    @message = message
    @datetime = DateTime.now
    mail to: "biomodelos@humboldt.org.co",  subject: "Feedback desde BioModelos"
  end

  def send_mail_notifications(id, name, email, last_email_send, periodicity)
    @name = name
    @email = email
    following = UserRelationship.where(:follower_id => id)
    my_groups = GroupUser.where(:user_id => id, :group_user_state_id =>  1)
    user_list = '0'
    group_list = '0'

    following.each do |f|
      user_id = ','+f.user_id.to_s
      user_list += user_id
    end

    my_groups.each do |f|
      group_id = ','+f.group_id.to_s
      group_list += group_id
    end

    # ---------------------------------------------------------------
    last_email_send -= 300.day # Only for Quick Testing - Remove in production
    # ---------------------------------------------------------------

    @notifications = User.find_by_sql("
      SELECT * FROM (
        SELECT
          g.id,
          g.name,
          gu.user_id,
          u.name user_name,
          gu.updated_at,
          'new_user' type
        FROM groups g, group_users gu, users u
        WHERE g.id = gu.group_id AND u.id = gu.user_id AND gu.group_user_state_id = 1
        AND gu.group_id in (" + group_list + ") AND gu.updated_at > '" + l( last_email_send) + "'
        UNION
        SELECT
          g.id,
          g.name,
          sg.species_id,
          s.sci_name user_name,
          sg.updated_at,
          'new_specie' type
        FROM groups g, species_groups sg, species_group_states gus, species s
        WHERE g.id = sg.group_id AND s.id = sg.species_id AND sg.species_group_state_id = 1
        AND sg.group_id in (" + group_list + ") AND sg.updated_at > '" + l( last_email_send ) + "'
        UNION
        SELECT
          m.id,
          s.sci_name name,
          r.user_id,
          u.name user_name,
          r.updated_at,
          'review' type
        FROM reviews r, models m, species s, users u
        WHERE m.id = r.model_id and s.id=m.species_id AND u.id = r.user_id
        AND r.user_id in (" + user_list + ") AND r.updated_at > '" + l(last_email_send) + "'
      )ORDER BY updated_at DESC LIMIT 35
    ")
    @periodicity = periodicity

    case periodicity
      when 1
        subj="Notificacion Diaria de Actividad en Biomodelos"
      when 2
        subj="Notificacion Semanal de Actividad en Biomodelos"
      when 3
        subj="Notificacion Mensual de Actividad en Biomodelos"
    end
    #mail to: mail,  subject: subj
    if @notifications
      mail from: "noreply@biomodelos.humboldt.org.co", to: "miguelstratoss@gmail.com",  subject: subj
      user=User.find(id)
      user.last_email_send=Date.today
      user.save
    end
  end
end
