// JavaScript Document
function aEventsHandler() {
	TagElements = document.getElementsByTagName('A');
	i=0;
	while (i <= TagElements.length-1) {
	    if ( (TagElements[i].id != 'linkBoxOpen') && (TagElements[i].id != 'linkBoxClose') ) {
    		if (TagElements[i].className.substring(0,4) == 'btn_') {
    			TagElements[i].onmouseover = function(){ btn_over(this); } 
    			TagElements[i].onmouseout = function(){ btn_out(this); } 
    		}
        }
		i++;
	}
}

function btn_over(aObject)
{
	Tag_aElements = aObject.getElementsByTagName('strong');
	Tag_aElements[0].style.display = 'none';
	Tag_aElements[1].style.display = 'inline';
	Tag_aElements = aObject.getElementsByTagName('i');
	Tag_aElements[0].style.display = 'none';
	Tag_aElements[1].style.display = 'inline';
}
function btn_out(aObject)
{
	Tag_aElements = aObject.getElementsByTagName('strong');
	Tag_aElements[1].style.display = 'none';
	Tag_aElements[0].style.display = 'inline';
	Tag_aElements = aObject.getElementsByTagName('i');
	Tag_aElements[1].style.display = 'none';
	Tag_aElements[0].style.display = 'inline';
}

function findAndFix(TagName) {
	var f = 'DXImageTransform.Microsoft.AlphaImageLoader';

	var TagElements = new Array();
	var ImagePathName = new String();
	var ImageName = new String();
	TagElements = document.getElementsByTagName(TagName);
	
	i=0;
	while (i <= TagElements.length-1) {
		ImagePathName = TagElements[i].currentStyle['backgroundImage'];
		var bgImg = TagElements[i].currentStyle.backgroundImage || TagElements[i].style.backgroundImage;
		
		if (bgImg && bgImg != 'none') {
			if (bgImg.match(/^url[("']+(.*\.png)[)"']+$/i)) {
				var s = RegExp.$1;
				if (TagElements[i].currentStyle.width == 'auto' && TagElements[i].currentStyle.height == 'auto') {
					TagElements[i].style.width = TagElements[i].offsetWidth + 'px';
					TagElements[i].style.height = TagElements[i].offsetHeight + 'px';
				}

				if ((TagElements[i].currentStyle.backgroundRepeat != 'repeat-y') && (TagElements[i].currentStyle.backgroundRepeat != 'repeat-x') && (TagElements[i].currentStyle.backgroundRepeat != 'repeat') && (TagElements[i].currentStyle.backgroundPositionY != 'bottom')) {
					TagElements[i].style.backgroundImage = 'none';
					TagElements[i].style.filter = 'progid:'+f+'(src="'+s+'",sizingMethod="crop")';
				}
			}
		} else {
			if (TagName == 'IMG') {
				var bgImg = TagElements[i].src;
				if (bgImg.indexOf('.png')!=-1) {
					TagElements[i].src = '/duac/assets/images/transparent.gif';
					TagElements[i].style.backgroundImage = 'none';
					TagElements[i].style.width = TagElements[i].offsetWidth + 'px';
					TagElements[i].style.filter = 'progid:'+f+'("enabled=true,sizingMethod="image",src="'+bgImg+')';
				}
			}
		}
/*
		if (TagName == 'A') {
			 for (var n = 0; n < TagElements[i].childNodes.length; n++)
				if (TagElements[i].childNodes[n].style) TagElements[i].childNodes[n].onMouseOver = new Function("alert('Here!');");
	
		}
*/

		i++;
	}
}


function isIE6() {
var detect = navigator.userAgent.toLowerCase();
if(!(navigator && navigator.userAgent && navigator.userAgent.toLowerCase)) {
  	        return false;
  	    } else {
  	        if(detect.indexOf('msie') + 1) {
  	            // browser is internet explorer
  	            var ver = function() {
  	                // http://msdn.microsoft.com/workshop/author/dhtml/overview/browserdetection.asp
  	                // Returns the version of Internet Explorer or a -1
  	                // (indicating the use of another browser).
  	                var rv = -1; // Return value assumes failure
  	                if (navigator.appName == 'Microsoft Internet Explorer') {
  	                    var ua = navigator.userAgent;
  	                    var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
  	                    if (re.exec(ua) != null) {
  	                        rv = parseFloat( RegExp.$1 );
  	                    }
  	                }
  	                return rv;
  	            };
  	            // if the version can be found and the version is less than our version number it is invalid
				if ((ver() == 6)) {
					findAndFix('STRONG');
					findAndFix('I');
					findAndFix('DIV');
					findAndFix('A');
					findAndFix('SPAN');
					findAndFix('LI');
					findAndFix('UL');
					findAndFix('IMG');
					findAndFix('EM');
					findAndFix('FIELDSET');
					findAndFix('h1');
  	            }
			}
  	    }
} 

isIE6();
aEventsHandler();