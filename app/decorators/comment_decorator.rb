class CommentDecorator < Draper::Decorator
  decorates :comment
  delegate_all

  def friendly_title
    title.gsub(' ', '-').downcase
  end

  def truncated_body
    h.raw h.truncate(body, length: 200, omission: "...")
  end

  def friendly_date
    created_at.strftime("%d/%m/%Y : %R")
  end
end