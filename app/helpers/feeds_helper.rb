module FeedsHelper
  def find_id_by_url(url)
    Feed.find_by(url: url).id
  end
end
