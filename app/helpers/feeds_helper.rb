module FeedsHelper
  def bold_if_new(post_date)
    if cookies[:last_viewed]
      post_date > Time.parse(cookies[:last_viewed]) ? "title_bold" : "title_normal"
    else
      "title_normal"
    end
  end
end
