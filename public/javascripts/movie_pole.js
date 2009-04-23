$(document).ajaxSend(function(event, request, settings) {
  if (typeof(window._authenticity_token) == "undefined") return;
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window._authenticity_token);
});

$(document).ready(function() {
  var all = {}
  var edit_link = {}
  var edit_link_id = {}
  var params = {}
  var templates = {"alert": "<div id=\"{alert.id}\"><br/>{translations.genre} {alert.name}<br/>{translations.rating} {alert.rating}<br/><div class=\"alert_edit\"><a href=\"/users/{user}/alerts/{alert.id}/edit\">{translations.edit}</a></div><div class=\"alert_delete\"><a href=\"/users/{user}/alerts/{alert.id}\">{translations.del}</a></div></div>", "alert_edit": "<br/>{translations.genre} {alert.name}<br/>{translations.rating} {alert.rating}<br/><div class=\"alert_edit\"><a href=\"/users/{user}/alerts/{alert.id}/edit\">{translations.edit}</a></div><div class=\"alert_delete\"><a href=\"/users/{user}/alerts/{alert.id}\">{translations.del}</a></div>"}
  
  //set the language of the site
  $('#locale').change(function() {
    $.cookie("locale", $('#locale').attr('value')) // set cookie
    window.location.reload()
  })
  
  // autocomplete the search block 
  $("#search_query").autocomplete({
    url: "/searches/autocomplete.json",
    result_callback: function(result) {
      return $.tmpl("<li><a href=\"/movies/{movie.id}\">{movie.title}</a></li>", result)
    }
  })

  $("#create_alert, #alert_add").live("click", function() {
    $("#message").removeClass().addClass("new_alert")
    $("#message").css({"visibility" : "visible"})
    return false
  })

  $(".alert_cancel").live("click", function() {
    $("#message").removeClass()
    $("#message").css({"visibility" : "hidden"}) 
    return false
  })
  $(".alert_edit").live("click", function() {
    edit_link_id = $(this).parent().attr("id")
    edit_link = $(this).find("a").attr("href").replace(/\/edit/,"")
    $("#message").removeClass().addClass("edit_alert")
    $("#message").css({"visibility" : "visible"})
    return false
  })

  $(".alert_delete").live("click", function() {
    var deleteLink = $(this).find("a").attr("href")
    var deleteId = $(this).parent().attr("id")
    $.post(deleteLink, "_method=delete", function(data) {
      if (all == 1) { $("#alert_add").show() } 
      $("#" + deleteId + "").remove()
    })
    return false
  })

  $(".edit_alert > .new_alert").live('submit', function() {
    $.ajax({
      type: "PUT",
      url: edit_link,
      data: $(this).serialize(),
      dataType: "json",
      success: function(data) {
        data.translations = translations
        if (data.alert.genre_id == 1) {
          $("#alert_add").hide()
          all = 1 
          $("#results").empty()
          $("#results").append($.tmpl(templates.alert, data))
        } else {
          all = 0
          $("#alert_add").show()
          $("#" + edit_link_id + "").empty().append($.tmpl(templates.alert_edit, data))
        }
        $("#message").css({"visibility" : "hidden"})
      }, 
      error: function (data) { alert(translations.alert_exist) }   
    })
    return false
  })
  
  $(".new_alert > .new_alert").live('submit', function() {
    $("#message").removeClass()
    $.ajax({
      type: "POST",
      dataType: "json",
      url: $(this).attr("action"),
      data: $(this).serialize(), 
      success: function(data){
        data.translations = translations
        if (data.alert.genre_id == 1) {
          $("#results").empty()
          $("#alert_add").hide()
          all = 1
        }
        $("#results").append($.tmpl(templates.alert, data))
        $("#message").css({"visibility" : "hidden"})
      },
      error: function (data) { alert(translations.alert_exist) }
    })
    return false
  })
  $("#more").css({"visibility" : "visible"})
  $("#advanced_search").hide()
  $("#more").live("click", function() {
    $("#advanced_search").show("slow")
    $("#more").hide()
    return false
  }) 
  $("#register_urge").hide()
  $("#why_register").css({"visibility" : "visible"})
  $("#why_register").live("click", function() { 
    $("#register_urge").slideToggle(500)
    return false
  })
})
 
 
 
 
