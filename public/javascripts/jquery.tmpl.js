/* Nano Templates (Tomasz Mazur, Jacek Becela) */

(function($){
  $.tmpl = function(tmpl, data){
    return tmpl.replace(/\{([^{}]*)}/g, function(str, key){
      var keys = key.split("."), value = data[keys.shift()]
      $.each(keys, function(){ value = value[this] })
      return value
    })
  }
})(jQuery);
