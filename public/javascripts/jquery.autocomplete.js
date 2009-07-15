(function($){
  $.fn.autocomplete = function(options) {
    var defaults = {
      url: "/search",
      min_chars: 2,
      timeout: 500,
      limit: 10,
      autocomplete_element: "ul.autocomplete_results", // # i.e. table (gets hidden/shown during autocomplete)
      results_container: "ul.autocomplete_results", // # i.e. tbody (results get inserted here)
      clear: ".clear", // # appears when typing, when clicked - clears the input
      result_callback: function(result) { return "<li>" + result.name + "</li>" },
    }
    
    var options = $.extend(defaults, options)
  
    return this.each(function(){
    
      var raw_input = this
      var input = $(this)
      var autocomplete_element = $(options.autocomplete_element)
      var results_container = $(options.results_container)
      var typing_timeout = null
      var clear = $(options.clear)
      
      clear.click(function(){$(this).hide(); input.val("").focus()})
      
      input.attr("autocomplete", "off")
      
      var reset = function() {
        autocomplete_element.hide()
        results_container.html("")
      }
      
      $(document).click(function(e){ 
        var on_element = $(e.target).is(options.autocomplete_element)
        var on_parents = $(e.target).parents(options.autocomplete_element).length > 0
        var on_input   = e.target == raw_input
        if (!(on_element || on_parents || on_input)){
          reset()
        }
      })
      
      input.keyup(function(e){
        var query = $.trim(input.attr('value'))
        clearInterval(typing_timeout)
        
        query.length > 0 ? clear.show() : clear.hide()
        
        if (e.which == 27) { // esc
          input.val("").blur()
          reset()
        } else {
      
          if (query.length >= options.min_chars) {
            typing_timeout = window.setTimeout(function() {
              var params = {}
              params[input.attr("name")] = query
              $.getJSON(options.url, params, function(data){
                reset()
                if (data.length > 0) {
                  $.each(data, function(i, item){
                    if (i < options.limit) {
                      results_container.append(options.result_callback(item))
                    }
                  })
                  autocomplete_element.show()
                }
              })
            }, options.timeout)
            
          } else if (query.length == 0) {
            reset()
          }
          
        }
    })
  })
 }
})(jQuery);
