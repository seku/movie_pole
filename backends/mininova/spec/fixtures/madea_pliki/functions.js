var cookieQueries=new Array();var isKonqueror=(navigator.vendor=="KDE");var isIE6=((window.ActiveXObject&&!window.XMLHttpRequest)?true:false);var _nameidx,_lastbold;function realOffset(B,A){var C=0;while(B){C+=B[A];B=B.offsetParent}return C}if(!Array.indexOf){Array.prototype.indexOf=function(B){for(var A=0;A<this.length;A++){if(this[A]===B){return A}}return -1}}if(!window.XMLHttpRequest){window.XMLHttpRequest=function(){var B=["Microsoft.XMLHTTP","MSXML2.XMLHTTP.5.0","MSXML2.XMLHTTP.4.0","MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP"];for(var A=0;A<B.length;A++){try{return new ActiveXObject(B[A])}catch(C){}}return false}}function show_adcode(A){if(!document.phpAds_used){document.phpAds_used=","}phpAds_random=new String(Math.random());phpAds_random=phpAds_random.substring(2,11);document.write('<script type="text/javascript" src="');document.write("http://ads.mininova.org/adjs.php?n="+phpAds_random);document.write("&amp;"+A);document.write("&amp;exclude="+document.phpAds_used);if(document.referrer){document.write("&amp;referer="+escape(document.referrer))}document.write('"><\/script>')};