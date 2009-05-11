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
  var register = "/users/new"
  var not_exist = true //check if register form exist in response div 
  var pressed = false // it's needed for cancel button in registration form (if true javascript is enabled)
  var templates = {"alert": "<div id=\"{alert.id}\"><br/>{translations.genre} {alert.name}<br/>{translations.rating} {alert.rating}<br/><div class=\"alert_edit\"><a href=\"/users/{user}/weekly_alerts/{alert.id}/edit\">{translations.edit}</a></div><div class=\"alert_delete\"><a href=\"/users/{user}/weekly_alerts/{alert.id}\">{translations.del}</a></div></div>", "alert_edit": "<br/>{translations.genre} {alert.name}<br/>{translations.rating} {alert.rating}<br/><div class=\"alert_edit\"><a href=\"/users/{user}/weekly_alerts/{alert.id}/edit\">{translations.edit}</a></div><div class=\"alert_delete\"><a href=\"/users/{user}/weekly_alerts/{alert.id}\">{translations.del}</a></div>", "flash": "{flash}"}
  
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

  $(".edit_alert > .new_weekly_alert").live('submit', function() {
    $.ajax({
      type: "PUT",
      url: edit_link,
      data: $(this).serialize(),
      dataType: "json",
      success: function(data) {
        data.translations = translations
        if (data.alert.genre_name == "all") {
          $("#alert_add").hide()
          all = 1 
          $("#alerts_results").empty()
          $("#alerts_results").append($.tmpl(templates.alert, data))
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
  
  $(".new_alert > .new_weekly_alert").live('submit', function() {
    $("#message").removeClass()
    $.ajax({
      type: "POST",
      dataType: "json",
      url: $(this).attr("action"),
      data: $(this).serialize(), 
      success: function(data){
        data.translations = translations
        if (data.alert.genre_name == "all") {
          $("#alerts_results").empty()
          $("#alert_add").hide()
          all = 1
        }
        $("#alerts_results").append($.tmpl(templates.alert, data))
        $("#message").css({"visibility" : "hidden"})
      },
      error: function (data) { alert(translations.alert_exist) }
    })
    return false
  })
  $("#more").css({"visibility" : "visible"})
  $("#advanced_search").hide()
  $("#register_urge").hide()
  $("#why_register").css({"visibility" : "visible"})
  
  $("#more").live("click", function() {
    $("#advanced_search").show("slow")
    $("#more").css({"visibility" : "hidden"})
    $("#less").css({"visibility" : "visible"})
    return false
  }) 

  $("#less").live("click", function() {
    $("#advanced_search").hide("slow")
    $("#more").css({"visibility" : "visible"})
    $("#less").css({"visibility" : "hidden"})
    return false
  })

  
  $("#why_register").live("click", function() { 
    $("#register_urge").slideToggle(500)
    return false
  })
  
  $("#register, #redirect_login").live("click", function() {
    $.get(register, null, function(data){
      if (not_exist) { 
        not_exist = false
        $(data).appendTo("#response")
      }
      $("#backgroundPopup").fadeIn("slow") 
      $("#response").fadeIn("slow")
      pressed = true
    },"html")
    return false
  })

  $("#cancel").live("click", function() {
    if (pressed) {
      $("#backgroundPopup").fadeOut("slow") 
      $("#response").fadeOut("fast")
      return false
    }
  })

  $("#add_movie").live("click", function() {
    $.ajax({
      type: "GET",
      url: $(this).find("a").attr("href"),
      dataType: "json",
      success: function(data) {
        $("#flash").empty().append($.tmpl(templates.flash, data)) },
      error: function (data) { 
        $("#flash").empty().append($.tmpl(templates.flash, data)) }
    })
    return false
  })
  $(".del_from_movie_list").live("click", function() {
    var deleteLink = $(this).find("a").attr("href")
    var deleteId = $(this).parent().attr("id")
    $.post(deleteLink, "_method=delete", function(data) {
      $("#" + deleteId + "").remove()
    })
    return false
  })
})
 
 
 
 
