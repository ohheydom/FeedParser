var pageEvents = function(){
  var changed = false

  $("a[id*=collapse]").click(function(event) {
    content = event.target.id.replace('collapse-','');
    
    if (changed == false) {
      $("#content-" + content).toggle();
      $("#toggle-" + content + " a:first").toggleClass("sortable_collapse");
    }
    
    event.preventDefault();
    changed = false;
  });

  $('#sortable').sortable( { axis: 'y', sort: function( event, ui ) { changed = true; }}).disableSelection();

  $('#save_order_button').click(function(event) {
    var sortable_params = $('#sortable').sortable( "serialize", {key: "sortable" });
    $.ajax({
      url: '/update_feed_order',
      type: 'POST',
      data: {sort_order: $('#sortable').sortable( "toArray" )},
      dataType: 'json'});
    event.preventDefault();
  });

};
$(document).ready(pageEvents);
$(document).on('page:load', pageEvents);
