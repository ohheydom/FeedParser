class FeedDecorator < Draper::Decorator
  delegate_all

  def delete_link
    h.link_to h.feed_path(object.id), method: :delete, data: { confirm: 'Are you sure?' } do
      h.content_tag(:i, nil, class: 'fa fa-times')
    end
  end

  def remove_bad_link
    h.link_to 'Remove?', h.feed_path(object.id), method: :delete
  end

  def edit_link
    h.link_to h.edit_feed_path(object.id) do
      h.content_tag(:i, nil, class: 'fa fa-pencil-square-o')
    end
  end

  def title_link
    h.link_to object.title, '#', id: "collapse-#{object.url.parameterize}", class: 'sortable_expand'
  end
end
