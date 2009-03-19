//  Copyright (c) 2000-2009 ZEDO Inc. All Rights Reserved.
var ze6=new Array();
function zU0(zq0,zp6){
if(!ze6[zq0]||zp6){
var zv1=document.cookie;var zc1=new Array();var zv3=new Array();
zc1=zv1.split(';');
var zr6=(zc1!=null)?zc1.length:0;
for(var i=0;i<zr6;i++){
zc1[i]=zc1[i].replace(/^\s/,'');
zv3=zc1[i].split('=');
ze6[zv3[0]]=zv3[1];
}}
if(ze6[zq0]){
return ze6[zq0];
}
else{
return '';
}}