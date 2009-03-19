(function(){

    /*Shortcut for getElementById*/
    var $ = function(id) {
        if (document.all) {
            return document.all[id];
        }
        else {
            return document.getElementById(id);
        }
    }

    var $$ = function(tagName) {
        return document.getElementsByTagName(tagName);
    }    

    // Client-side ad cache buster
    ord=Math.random()*10000000000000000;

    this.ad_utils = {

        ord : ord,
        ad_queue : new Array(),
        //Deprecated in favor of the more descriptive expand_ad - 
        //since more than just the iframe can/will be adjusted by
        //this function.    
        resize_iframe : function (iframe) {
            this.expand_ad(iframe);
        },

        //As each advertisement loads - expand_ad modifies the DOM and 
        //restyles the page to allow the advertisement to display
        //properly.    
        //Note: Ideally, this is called from each ad's iframe's onload.
        //We wait for the onload event, because it provides some assurance
        //that the DOM elements we care about have already loaded.    
        expand_ad : function (iframe) {

            var slot = iframe.id;
            var element = $(slot);
            var fDoc = iframe.contentDocument 
                || window.frames[iframe.name].document;
            var adObject = null;

            try {
                adObject = fDoc.ad;
            }
            catch (e) {
                consoleLog("Cannot access ad parameters: " + e.toString());
            }

            //Detected an ad object
            if (adObject) { 

                //Register ad parameters in primary document
                if (!document.ads) 
                    document.ads = {};
                document.ads[adObject.cid] = adObject;

                //Adjust ad size
                if (adObject.w) {
                    element.width = parseInt(adObject.w) + 'px';
                }
                if (adObject.h) {
                    element.height = parseInt(adObject.h) + 'px';
                }

                if (adObject.st) {
                    this.expand_supertab(adObject);
                }
                else if (iframe.id == "top_ad" 
                    && this.is_open(adObject)) {
                    this.expand_top_banner(adObject);
                }

                if (adObject.wrap) {
                    this.expand_wrap(adObject);
                }

                if (adObject.bamf) {
                    this.expand_bamf(adObject, element);
                }

                if (adObject.inner_bamf) {
                    this.expand_inner_bamf(adObject);
                }

                if (adObject.relative_bamf) {
                    this.expand_relative_bamf(adObject);
                }

                if (this.is_open(adObject)) {
                    //Detect if the ad has a hidden label
                    var before = $(slot + "_before");
                    if (before) {
                        this.expand_label(before);
                    }

                    var after = $(slot + "_after");
                    if (after) {
                        this.expand_label(after);
                    }
                }

                //Manually override styles
                if (adObject.styles) {
                    for (var id in adObject.styles) {
                        generic.override_style(id, adObject.styles[id].style);
                    }
                }
            }
        },

        is_open: function(adObject) {
            return adObject 
                   && adObject.w 
                   && adObject.h 
                   && adObject.w > 0 
                   && adObject.h > 0;
        },

        //Styles the page to properly fit a supertab
        expand_supertab : function(adObject) {
            $('nb15').className='supertab';
        },

        //Styles the page to properly fit a top banner
        expand_top_banner : function(adObject) {
            $('nb15').className='banner'; 
        },

        //Restyles the bamf's iframe into the correct location
        //DEPRECATED
        expand_bamf : function(adObject, element)    {

            var bamf = adObject.bamf;

            //extend the iframe's styles
            generic.extend(element.style, bamf.style);
        },
        //plucks a node out of an ad, and plugs it into the page.
        //DEPRECATED
        expand_inner_bamf : function(adObject) {

            var inner_bamf = adObject.inner_bamf;
            var targetNode = $(inner_bamf.targetId);

            //position the element after the targetNode
            if (targetNode && inner_bamf.node) {
                generic.insert_after(inner_bamf.node, targetNode); 
            }
        },
        expand_relative_bamf : function(adObject) {

            var relative_bamf = adObject.relative_bamf;
            var targetNode = $(relative_bamf.targetId);
            var attach = generic[relative_bamf.relation];

            //position the element after the targetNode
            if (targetNode && relative_bamf.node) {
                attach(relative_bamf.node, targetNode); 
            }
        },
        expand_wrap : function(adObject) {

            if (!adObject.styles) {
                adObject.styles = {};
            }
            var styles = {
                wrapper:{
                  style:{
                    background: adObject.wrap
                  }
                },
                root:{
                  style:{
                    background: "transparent"
                  }
                },
                footer:{
                  style:{
                    background: "#ffffff"
                  }
                },
                pagecontent:{
                  style:{
                    height:"100%"
                  }
                }
            };
            generic.extend(adObject.styles, styles);

        },

        //makes a hidden label visible
        expand_label : function(label) {
            label.className = label.className.replace(/hidden/,"");
        },

        validate_iframes : function() {

            var iframes = $$('iframe');
            var rotated = false;
            var reloaded = false;
            var reloaded_redirect = "/rg/FIREFOX_RELOADED_IFRAME//";
            var rotated_redirect = "/rg/FIREFOX_ROTATED_IFRAME//";
            var empty_script = "/images/a/js/blank.js";

            for (var i=0; i < iframes.length; i++) {

                var iframe = iframes[i];
                var outerUrl = iframe.src
                var innerUrl = "";
                var fDoc = iframe.contentDocument 
                    || window.frames[iframe.name].document;

                // Verify that this is an advertisement iframe
                if (!outerUrl.match( /images\/a/ ) &&
                    !outerUrl.match( /ads\/emulate/ ) ){
                    continue;
                }

                try {
                    //consoleLog(outerUrl);
                    //consoleLog(fDoc.location.toString());
                    innerUrl = (fDoc.location).toString();
                }
                catch (e) {
                    consoleLog(e.toString());
                }

                // Verify that the inner and outer urls match.
                if (innerUrl == outerUrl) {
                    consoleLog("match");
                }
                else {
                    // Verify that the position keyvalues match
                    var outerSlot = outerUrl.match(/p=[^;]/);
                    var innerSlot = innerUrl.match(/p=[^;]/);

                    if (outerSlot && innerSlot && 
                        outerSlot.toString() == innerSlot.toString()){

                        consoleLog("reload");
                        generic.load_script(reloaded_redirect + empty_script);
                        //iframe.src = reloaded_redirect + iframe.src;
                    }
                    else {
                        consoleLog("rotated");
                        generic.load_script(rotated_redirect + empty_script);
                        //iframe.src = rotated_redirect + iframe.src;
                    }
                }
            }

        }

    };

    this.generic = {

        //Insert an element into the DOM after a given node
        insert_after : function(newNode, targetNode) {
            try {
                targetNode.parentNode.insertBefore(newNode, targetNode.nextSibling);
            }
            catch (err){
                targetNode.parentNode.appendChild(newNode);
            }
        },
        //Insert an element into the DOM before a given node
        insert_before : function(newNode, targetNode) {
            targetNode.parentNode.insertBefore(newNode, targetNode);
        },
        //Insert an element into the DOM inside a given node
        insert_inside : function(newNode, targetNode) {
            targetNode.appendChild(newNode);
        },

        //Recursively extends all of the properties of the targetObject
        //with the properties of the sourceObject
        extend : function(targetObject, sourceObject) {
            for (var h in sourceObject) {
                if (targetObject[h]) {
                    if (targetObject[h] != sourceObject[h]) {
                        this.extend(targetObject[h], sourceObject[h]);
                    }
                }
                else { 
                    targetObject[h] = sourceObject[h];
                }
            }
        },

        override_style :function(id, style) {

            var style_node = style_node = document.createElement("style");
            style_node.setAttribute("type","text/css");

            var style_str = "#" + id + " {";
            for (var k in style) {
                style_str += k + ":" + style[k] + " !important;";
            }
            style_str += "}";

            if (style_node.styleSheet) {
                //IE
                style_node.styleSheet.cssText=style_str;
            }
            else {
                try {
                    //Mozilla
                    style_node.innerHTML = style_str;
                }
                catch(err) {
                    //Safari
                    style_node.innerText = style_str;
                }
            }

            $$('head')[0].appendChild(style_node);
        },

        load_script : function(src){
            var script = document.createElement('script');
            script.type = "text/javascript";
            script.src = src;
            $$('head')[0].appendChild( script );
        }
    };

    var makeSwfParam = function(name, value) {
        return ((value)) ? '<param name="' + name + '" value="' + value + '">' 
                 : '';
    }

    var makeSwfEmbed = function(name, value) {
        return ((value)) ? ' ' + name + '="' + value + '" ' 
                 : '';
    }


    this.flashAdUtils = {

        makeFlashAd: function(args) {
            var swfID = args.id;
            var swfSRC = args.src;
            var swfWidth = args.width;
            var swfHeight = args.height;
            var swfBgcolor = args.bgcolor;
            var swfWmode = args.wmode;
            var swfSAlign = args.salign;
            var swfScale = args.scale;
            var swfExtraParams = args.extraParams;
            var swfExtraTAGs = args.extraTAGs;

            var swfClickThru = escape(args.clickThru);
            var swfClickTAGs = args.clickTAGs;


            if (swfID==null || swfSRC==null 
                || swfWidth==null || swfHeight==null) {
                consoleLog('makeFlashAd: Missing required params');
                return;
            }

            var clickSTR = '';
            if ((swfClickTAGs)) {
                for (var i=0; i<swfClickTAGs.length; i++) {
                        if (swfClickTAGs[i]) {
                                clickSTR = clickSTR 
                            + '&clickTAG'+(i+1) 
                                + '=' 
                                + escape(swfClickTAGs[i]);
                        }
                }
            }
            if ((swfExtraTAGs)) {
                for (var tag in swfExtraTAGs) {
                    clickSTR = clickSTR
				+ '&' + escape(tag) 
				+ '=' + escape(swfExtraTAGs[tag]);
                }
            }

            var extra_obj = '';
            var extra_emb = '';
            try {
                var reserved = { 
                    width:1, height:1, src:1, bgcolor:1,
                    wmode:1, salign:1, scale:1, flashvars:1
                };
                for (var param in swfExtraParams) {
                    if (reserved[param])
                        continue;

                    extra_obj = extra_obj 
                        + makeSwfParam(param, swfExtraParams[param]);
                    extra_emb = extra_emb
                        + makeSwfEmbed(param, swfExtraParams[param]);
                }
            } catch (err) {}

            var bgcolor_obj = makeSwfParam('bgcolor', swfBgcolor);
            var bgcolor_emb = makeSwfEmbed('bgcolor', swfBgcolor);

            var wmode_obj = makeSwfParam('wmode', swfWmode);
            var wmode_emb = makeSwfEmbed('wmode', swfWmode);

            var scale_obj = makeSwfParam('scale', swfScale);
            var scale_emb = makeSwfEmbed('scale', swfScale);

            var salign_obj = makeSwfParam('salign', swfSAlign);
            var salign_emb = makeSwfEmbed('salign', swfSAlign);

            var swfSTR = '<object '
                + ' classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" '
                + ' codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" '
                + ' width="'+swfWidth+'" '
                + ' height="'+swfHeight+'" '
                + ' id="swf_'+swfID+'">'
                + '<param name="movie" value="'+swfSRC+'">'
                + '<param name="flashvars" value="clickTAG='+swfClickThru+'&'+clickSTR+'">'
                + '<param name="play" value="true">'
                + '<param name="quality" value="high">'
                + '<param name="allowScriptAccess" value="always">'
                +  scale_obj
                +  salign_obj
                +  bgcolor_obj
                +  wmode_obj
                +  extra_obj
                + '<embed src="'+swfSRC+'" '
                + ' flashvars="clickTAG='+swfClickThru+'&'+clickSTR+'" '
                + ' quality="high" '
                + ' play="true" '
                + ' width="'+swfWidth+'" '
                + ' height="'+swfHeight+'" '
                + ' name="swf_'+swfID+'" '
                + ' allowScriptAccess="always" '
                + ' type="application/x-shockwave-flash" '
                + ' pluginspage="http://www.macromedia.com/go/getflashplayer" '
                +  scale_emb
                +  salign_emb
                +  bgcolor_emb
                +  wmode_emb
                +  extra_emb
                + '></embed></object>';
                

            return swfSTR;
        },

        canPlayFlash: function(minFlashVersion) {
            var canPlay = false;

            if (minFlashVersion == null) {
                minFlashVersion = 6;
            } else {
	        minFlashVersion = parseInt(minFlashVersion);
	    }

            var flashPlugin = (navigator.mimeTypes && navigator.mimeTypes["application/x-shockwave-flash"]) 
                    ? navigator.mimeTypes["application/x-shockwave-flash"].enabledPlugin 
                    : 0;
            if (flashPlugin && navigator.plugins["Shockwave Flash"]) {
                    var words = navigator.plugins["Shockwave Flash"].description.split(" ");
                    var pluginVersion;
                    for (var i=0; i<words.length; ++i) {
                    if (isNaN(parseInt(words[i])))
                        continue;
                    pluginVersion = parseInt(words[i]);
                }
                canPlay = pluginVersion >= minFlashVersion;

            } else 
            if (navigator.userAgent 
                && navigator.userAgent.indexOf("MSIE") >= 0
                && (navigator.appVersion.indexOf("Win") != -1)) {

                try {
                    var axo = new ActiveXObject('ShockwaveFlash.ShockwaveFlash.' + minFlashVersion);
                    axo.AllowScriptAccess = "always";
                    var versionStr = new String(axo.GetVariable("$version"));
                    var version = versionStr.match(/([0-9]+)/);
                    canPlay = version[1] >= minFlashVersion;
                } catch (err) {}
            }

            return canPlay;
        }
    };

})();

function consoleLog(message) {
	try {
		if ((window.console) && (window.console.log)) {
			window.console.log(message);
		} else
		if ((console) && (console.log)) {
			console.log(message);
		} else {
			throw(message);
		}
	} catch (err) {}
}

/*Initialization Code*/
if (window.addEventListener) {
    window.addEventListener("load", ad_utils.validate_iframes, false);
}
/*Activates elements with class="yesScript" */
document.getElementsByTagName('html')[0].className += " scriptsOn";
