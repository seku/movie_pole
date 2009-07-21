(function($){
 $.fn.button = function(){
  return this.each(function(){
    var e = $(this)
    e.bind("on", function(on_event){
      e.trigger("before_on", on_event)
      if(!on_event.isImmediatePropagationStopped()){
        if(!e.data("on")){
          e.data("on", true)
          e.trigger("toggle")
        }
      }
      return false
    }).click(function(){
      e.trigger("on")
      return false
    })
  })
 }
})(jQuery);

(function($){
 $.fn.toggle_button = function(is_on){
  return this.each(function(){
    var e = $(this)
    e.bind("on", function(on_event){
      e.trigger("before_on", on_event)
      if(!on_event.isImmediatePropagationStopped()){
        if(!e.data("on")){
          e.data("on", true)
          e.trigger("toggle", "on")
        }
      }
      return false
    }).bind("off", function(){
      if(e.data("on")){
        e.data("on", false)
        e.trigger("toggle", "off")
      }
      return false
    }).click(function(){
      if(e.data("on")){
        e.trigger("off")
      } else {
        e.trigger("on")
      }
      return false
    })
    
    if(is_on) e.data("on", true)
  })
 }
})(jQuery);

(function($){
 $.fn.exclusive = function(){
  var els = this
  return this.each(function(){
    var e = $(this)
    e.bind("before_on", function(){
      els.not(e).each(function(){
        $(this).data("on") && $(this).trigger("off")
      })
      return false
    })
  })
 }
})(jQuery);

(function($){
 $.fn.box = function(klass){
  return this.each(function(){
    var e = $(this)

    e.bind("on", function(on_event){
      e.trigger("before_on", on_event)
      if(!on_event.isImmediatePropagationStopped()){
        e.show()
        e.data("on", true)
      }
      return false
    }).bind("off", function(){
      e.find("> ." + klass).trigger("off")
      e.hide()
      e.data("on", false)
      return false
    }).addClass(klass)
  })
 }
})(jQuery);

(function($){
 $.fn.cache = function(callback){
  return this.each(function(){
    var e = $(this)
    e.bind("init", function(){
      e.data("cached", true)
      callback()
      return false
    }).bind("invalidate", function(){
      e.data("cached", false)
      return false
    }).bind("on", function(){
      if(!e.data("cached")) {
        e.trigger("init")
      }
      return false
    })
  })
 }
})(jQuery);

(function($){
 $.fn.join_handlers = function(event_types){
  var els = this
  return this.each(function(i){
    var e = $(this)
    $.each(event_types.split(/\s+/), function(ignored, event_type){
      e.bind(event_type, function(ignored, first){
        var next = els[i + 1] || els[0]
        if(first && $.inArray(first, els) != -1) {
          if(first != next) {
            $(next).trigger(event_type, first)
          }
        } else {
          $(next).trigger(event_type, e.context)
        }
        return false
      })
    })
  })
 }
})(jQuery);


