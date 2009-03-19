//  Copyright (c) 2000-2009 ZEDO Inc. All Rights Reserved.
function zzInclude(src){
var zr3;
try{
zr3=new XMLHttpRequest();
}catch(e){
try{
zr3=new ActiveXObject('Msxml2.XMLHTTP');
}catch(e){
try{
zr3=new ActiveXObject('Microsoft.XMLHTTP');
}catch(e){
if(document.cookie.indexOf('FFERROR')==-1){
var zq6=new Image();var za3='Your browser does not support AJAX!';var zp5='ads2';
zq6.src='http://r1.zedo.com/log/ERR.gif?v=fbar/v2-102/d3;'+za3+'b='+navigator.userAgent;
document.cookie="FFERROR=0";
}
return false;
}}}
zr3.open('GET',src,false);
zr3.send(null);
if(zr3.status==200){
eval(zr3.responseText);
}}
runIdx()
