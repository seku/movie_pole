/*
Just for learning purpose , just temporay, please do not remove

(function(jQuery) {
  $.fn.seku = function(options) {
    var defaults = { 
      
      method_type: "PUT"
    }
    var options = $.extend(defaults, options)
    return this.each(function(){
      var movie_id = $(this).parent(".movie_details").find("a").attr("href").replace("/movies/","")
      var url_path = "/votes/" + movie_id + ""
      var templates = {"alert": "<div id=\"{alert.id}\">{translations.genre} {alert.name}<br/>{translations.rating} {alert.rating}<br/><div class=\"alert_edit\"><a href=\"/users/{user}/weekly_alerts/{alert.id}/edit\">{translations.edit}</a></div><div class=\"alert_delete\"><a href=\"/users/{user}/weekly_alerts/{alert.id}\">{translations.del}</a></div></div>", "alert_edit": "<br/>{translations.genre} {alert.name}<br/>{translations.rating} {alert.rating}<br/><div class=\"alert_edit\"><a href=\"/users/{user}/weekly_alerts/{alert.id}/edit\">{translations.edit}</a></div><div class=\"alert_delete\"><a href=\"/users/{user}/weekly_alerts/{alert.id}\">{translations.del}</a></div>", "flash": "{flash}"}
      $(this).submit(function () {
        $.ajax({
          url: url_path,
          type: options.method_type,
          data: {id: movie_id, user_rating: $(this).find("option:selected").attr("value")},
          dataType: "json",
          success: function(data) {
            $("#flash_for_js").css({"visibility" : "visible"}).empty().append($.tmpl(templates.flash, data)) },
          error: function(data) {
            $("#flash_for_js").css({"visibility" : "visible"}).empty().append($.tmpl(templates.flash, data)) 
          }
        })
      return false
      })
    })
  }
})(jQuery); 

usage: $(".user_rating").seku() 
*/
$(document).ajaxSend(function(event, request, settings) {
  if (typeof(window._authenticity_token) == "undefined") return;
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window._authenticity_token);
});

$(document).ready(function() {
  var register_login_exist = false
  var is_information_alert = false
  var is_information_list = false
  var is_information_language = false
  var is_information_register = false
  var alert_css = {"background-color" : "#F8F8F8", "border" : "1px solid #cecece", "-moz-border-radius" : "5px", "-webkit-border-radius" : "5px", "margin-top" : "5px"}
  var all = {}
  var edit_link = {}
  var edit_link_id = {}
  var params = {}
  var register = "/users/new"
  var not_exist = true //check if login/register form exist in response div 
  var pressed = false // it's needed for cancel button in registration form (if true javascript is enabled)
  var templates = {"alert": "<div id=\"{alert.id}\">{translations.genre} {alert.name}<br/>{translations.rating} {alert.rating}<br/><div class=\"alert_edit\"><a href=\"/users/{user}/weekly_alerts/{alert.id}/edit\">{translations.edit}</a></div><div class=\"alert_delete\"><a href=\"/users/{user}/weekly_alerts/{alert.id}\">{translations.del}</a></div></div>", "alert_edit": "<br/>{translations.genre} {alert.name}<br/>{translations.rating} {alert.rating}<br/><div class=\"alert_edit\"><a href=\"/users/{user}/weekly_alerts/{alert.id}/edit\">{translations.edit}</a></div><div class=\"alert_delete\"><a href=\"/users/{user}/weekly_alerts/{alert.id}\">{translations.del}</a></div>", "flash": "{flash}", "user_rating" : "{user_rating}", "average_rating" : "{average_rating}" }
  
  //set the language of the site  #####################################
  $('#locale').change(function() {
    $.cookie("locale", $('#locale').attr('value')) // set cookie
    window.location.reload()
  })

  
  // weekly_alerts on user site ###################################
  
  $("#create_alert, #alert_add").live("click", function() {
    $("#message").removeClass().addClass("new_alert")
    $("#message").css({"display" : "block"})
    return false
  })

  $(".alert_cancel").live("click", function() {
    $("#message").removeClass()
    $("#message").css({"display" : "none"}) 
    return false
  })
  $(".alert_edit").live("click", function() {
    edit_link_id = $(this).parent().attr("id")
    edit_link = $(this).find("a").attr("href").replace(/\/edit/,"")
    $("#message").removeClass().addClass("edit_alert")
    $("#message").css({"display" : "block"})
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
        $("#message").css({"display" : "block"})
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
          $("#alert_add").hide$("#register_urge").hide()()
          all = 1
        }
        $("#alerts_results").append($.tmpl(templates.alert, data))
        $("#" + data.alert.id + "").css(alert_css)
        $("#message").css({"display" : "none"})
      },
      error: function (data) { alert(translations.alert_exist) }
    })
    return false
  })
  
  // side panel (searching block) #####################################
  
  
  // autocomplete 
  
  $("#search_query").autocomplete({
    url: "/searches/autocomplete.json",
    result_callback: function(result) {
      return $.tmpl("<li><a href=\"/movies/{movie.id}\">{movie.title}</a></li>", result)
    }
  })
  
  $("#more").css({"visibility" : "visible"})
  $("#less").css({"visibility" : "hidden"})
  $("#advanced_search").hide()
  //$("#why_register").css({"visibility" : "visible"}) just for first production
  
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

  // login/registration popUps ################################################

  $("#login").click(function() {
    if (register_login_exist == false) {
      register_login_exist = true
      $.ajax({
      url: $(this).find("a").attr("href"),
      dataType: "html",
      success: function(data) {
        $(data).appendTo("#response")
        $("#backgroundPopup").fadeIn("slow") 
        $("#response").css({"visibility" : "visible"}).fadeIn("slow")
        $("#response > #cancel").addClass("popUp")      
      },
      error: function() {
        window.location.reload()
      }
      })
    }   
    return false
  })  
  
  $("#register, #redirect_login").live("click", function() {
    if (register_login_exist == false) { 
      register_login_exist = true
      $.ajax({
      url: register,
      dataType: "html",
      success: function(data) {
        $(data).appendTo("#response")
        $("#backgroundPopup").fadeIn("slow") 
        $("#response").css({"visibility" : "visible"}).fadeIn("slow")
        $(".registration_site > #cancel").addClass("popUp")      
      },
      error: function() {
        window.location.reload()
      }
      })
      
      /*
      
      $.get(register, null, function(data){
        $(data).appendTo("#response")
        $("#backgroundPopup").fadeIn("slow") 
        $("#response").css({"visibility" : "visible"}).fadeIn("slow")
        $(".registration_site > #cancel").addClass("popUp")
      },"html")
      */
    
    }
    return false
  })

  $(".popUp").live("click", function() {
    register_login_exist = false
    $("#backgroundPopup").fadeOut("slow") 
    $("#response").fadeOut("fast")
    $("#response").empty().css({"visibility" : "hidden"})
    //$(".response > #cancel").removeClass("popUp")
    return false
  })  

  // registration explanation 
    
  $("#register_urge").hide()
  $("#register > img").live("click", function() {
    if (is_information_register == false) {
      $("#register_urge").show()
      is_information_register = true
    } else {
      $("#register_urge").hide()
      is_information_register = false
    }
  return false
  })
 
  // desirable alerts  #####################################################
  
  
  $("#add_movie").live("click", function() {
    $.ajax({
      type: "GET",
      url: $(this).find("a").attr("href"),
      dataType: "json",
      success: function(data) {
        $("#flash_for_js").css({"visibility" : "visible"}).empty().append($.tmpl(templates.flash, data)) },
      error: function (data) { 
        $("#flash_for_js").css({"visibility" : "visible"}).empty().append($.tmpl(templates.flash, data)) }
    })
    return false
  })
  $("#del_from_movie_list").live("click", function() {
    var deleteLink = $(this).find("a").attr("href")
    var deleteId = $(this).parent().attr("id")
    $.post(deleteLink, "_method=delete", function(data) {
      $("#" + deleteId + "").remove()
    })
    return false
  })
  // votes / rating/ stars ##########################################################
/*
  $(".star-rating-control > div > a").click(function() {
    var user_rating = $(this).html() 
    var movie_id = $(this).parents(".movie_details").find("a").attr("href").replace("/movies/","")
    $.ajax({
        type: "get",
        url: "/compare_tastes/find_closest_users",
        data: {movie_id: movie_id, rating: user_rating},
        dataType: "json",
        success: function(xhr) {
          console.log(xhr)
        }
    })
  })

*/  
  $(".star-rating-control > div > a").click(function() {
    $(this).parent("div").rating('select') //jquery.rating.js functionality 
    var user_rating = $(this).html() 
    var movie_id = $(this).parents(".movie_details").find("a").attr("href").replace("/movies/","")
    if ($(this).parents("#stars").attr("rel") == 0) {
      $.ajax({
        type: "POST",
        url: "/votes/",
        data: {id: movie_id, user_rating: user_rating},
        dataType: "json",
        success: function(data) {
          $(".imdb_rating").find("span").empty().append($.tmpl(templates.average_rating, data))
          $("#stars").attr("rel", $.tmpl(templates.user_rating, data))
          $("#flash_for_js").css({"visibility" : "visible"}).show().empty().append($.tmpl(templates.flash, data)) 
          setTimeout("clear_flash()", 3000)
        }
      })
    } else {
      if (user_rating == 0) {
        $.ajax({
          type: "POST",
          url: "/votes/" + movie_id + "",
          data: "_method=delete",
          dataType: "json",
          success: function(data) {
            $(".imdb_rating").find("span").empty().append($.tmpl(templates.average_rating, data))
            $("#stars").attr("rel", $.tmpl(templates.user_rating, data))
            $("#flash_for_js").css({"visibility" : "visible"}).show().empty().append($.tmpl(templates.flash, data)) 
            setTimeout("clear_flash()", 3000)
          }
        })
      } else {
        $.ajax({
          type: "PUT",
          url: "/votes/" + movie_id + "",
          data: {id: movie_id, user_rating: user_rating},
          dataType: "json",
          success: function(data) {
            $(".imdb_rating").find("span").empty().append($.tmpl(templates.average_rating, data))
            $("#stars").attr("rel", $.tmpl(templates.user_rating, data))
            $("#flash_for_js").css({"visibility" : "visible"}).show().empty().append($.tmpl(templates.flash, data)) 
            setTimeout("clear_flash()", 3000)
          }
        })
      }
    }
    
    return false
  })
  clear_flash = function () {
    $("#flash_for_js").hide(700).empty().css({"visibility" : "hidden"})
  }  
 
  // features on user site ##########################################
  
  //subtitle_language
  $('#user_language').change(function() {
    $.get("/users/set_subtitles_language", {language: "" + $(this).find("option:selected").attr("value") + ""}) 
  })
  
  $(".tip").toggle_button().exclusive().bind("on", function(){
    $(".tip_block").css({"display" : "block"}).append($(this).find("img").attr("rel"))
  }).bind("off", function(){
    $(".tip_block").empty().css({"display" : "none"})
  })

  
// ####################### comment #########################

  $(".comment_form").click(function() {
    $(this).empty()
  }) 

 
// ######################  compare_tastes ###################

  $(".compared_user_votes > div[rel=\"voted\"]").css({"border" : "solid 1px red"}) 
  
  
  
})
