$(document).ready(function(){
  $('#sortable').sortable( { axis: 'y' });
  $('#sortable').disableSelection();
  $("a[id*=collapse]").click(function(event) {
    content = event.target.id.replace('collapse-','');
    $("#content-" + content).toggle();
    event.preventDefault();
  });
  $('#save_order_button').click(function(event) {
    var sortable_params = $('#sortable').sortable( "serialize", {key: "sortable" });
    $.ajax({
      url: '/update_feed_order',
      type: 'POST',
      data: {sort_order: $('#sortable').sortable( "toArray" )},
      dataType: 'json'});
    event.preventDefault();
  });

});
