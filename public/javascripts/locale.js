$(document).ready(function() {
  $('#locale').change(function() {
    //alert($.cookie('locale'));
    $.cookie("locale", $('#locale').attr('value')); // set cookie
    window.location.reload();
  })
})
 
