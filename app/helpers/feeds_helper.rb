module FeedsHelper
  def bold_if_new(post)
    if cookies[:last_viewed]
      post.published.localtime > Time.parse(cookies[:last_viewed]) ? "title_bold" : "title_normal"
    else
      "title_normal"
    end
  end

  def format_time(post)
    post.published.localtime.strftime('%B %d, %Y at %I:%M %P')
  end

  def set_time_cookie
    cookies.permanent[:last_viewed] = Time.now
  end

  def remove_non_digits(param)
    param.map! { |num| num[/\d+-\d+/].split("-").map(&:to_i) }
  end
end
