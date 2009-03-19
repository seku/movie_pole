//  Copyright (c) 2000-2009 ZEDO Inc. All Rights Reserved.
var y9=new Image();
function U5(a9){
var n6=a9.toString().match(/function\s+(\w*)/)[1];
if((n6==null)||(n6.length==0)){
return "anonymous();";
}
else{
return n6+"();";
}}
function B5(){
var q8="";
for(var a=arguments.caller;a!=null;a=a.caller){
q8+=U5(a.callee);
if(a.caller==a)break;
}
return q8;
}
function U6(){
var x3="";var n6="anonymous();";var n8=0;
window.onerror=null;
for(var i=0;i<arguments.length;i++){
x3+='a'+i+'='+arguments[i]+';';
if(i==2){
n8=escape(arguments[i]);
}}
x3=B5()+x3;
if(navigator.cookieEnabled){
x3=x3+'c='+navigator.cookieEnabled+';';
}
x3=x3+"C="+document.cookie+";";
if(document.cookie.indexOf('FFERROR')==-1){
var r9='ads2';
y9.src='http://r1.zedo.com/log/ERR.gif?v=bar/v15-003/d3;'+x3+'b='+navigator.userAgent;
document.cookie="FFERROR="+n8;
}
return true;
}
window.onerror=U6; 
var r6=new Array();var v7=0;
function F0(y2){
if(v7<1){
var c4=''+window.location.search;var y4=new Array();var q6=c4.indexOf(';l=')+1;
if(q6>1){
r6['l']=c4.substring(q6+2);
c4=c4.substring(0,q6);
}
c4=c4.replace(/^\?/,'');
y4=c4.split(';');
v7=y4.length;
for(var i=0;i<v7;i++){
if(y4[i].length>2){
r6[y4[i].substring(0,1)]=y4[i].substring(2,y4[i].length);
}}}
if(r6[y2]){return r6[y2];}
else{return '';}
}
function F4(){
var p0=U0('ZEDOIDX',false);var v1=navigator.userAgent.toLowerCase();var v9=((v1.indexOf('mac')!=-1)&&(v1.indexOf('msie 4.')!=-1));var i4=navigator.javaEnabled();var t5=0;
p0=1;
if(v9){
return p0;
}
else if(navigator.mimeTypes&&
navigator.mimeTypes["application/x-shockwave-flash"]&&
navigator.mimeTypes["application/x-shockwave-flash"].enabledPlugin){
if(navigator.plugins&&navigator.plugins["Shockwave Flash"]){
var y3=navigator.plugins["Shockwave Flash"].description;
if(parseInt(y3.substring(y3.indexOf(".")-2))>=4){
t5=1;
}}}
if(i4){p0 |=4;}
if(t5){p0 |=8;}
r1=new Date();
o1.src="http://simg.zedo.com/speed-test/10k.gif?"+zzRand;
o1.onload=F1; 
if(B1()){
if(p0<16){
B0('ZEDOIDX',p0,432000000);
}
else{
B0('ZEDOIDX',p0,2592000000);
}}
return p0;
}
var x0=0;var a0=0;var q2=0;var i10=new Image();
var v3=new Array();
function B0(v6,e7,a7){
var c1=new Date();
if(!a7){a7=31536000000;}
c1.setTime(c1.getTime()+a7);
document.cookie=v6+'='+e7+';expires='+c1.toGMTString()+';domain=.zedo.com;path=/;';
}
function U0(y2,z7){
if(!v3[y2]||z7){
var y7=document.cookie;var y1=new Array();var r7=new Array();
y1=y7.split(';');
var w6=(y1!=null)?y1.length:0;
for(var i=0;i<w6;i++){
y1[i]=y1[i].replace(/^\s/,'');
r7=y1[i].split('=');
v3[r7[0]]=r7[1];
}}
if(v3[y2]){return v3[y2];}
else{return '';}
}
function F2(){
var d2=new Date();var t0=new Date();
t0.setUTCHours(5);
t0.setUTCMinutes(0);
t0.setUTCSeconds(0);
var w4=t0.getTime()-d2.getTime();
if(w4<0){
t0.setUTCDate(t0.getUTCDate()+1);
w4=t0.getTime()-d2.getTime();
}
return w4;
}
var r1;var o1=new Image();
function F1(){
var a3=new Date();var r3=a3.getTime()-r1.getTime();var n3=10239/r3;
if(n3>6){
var p0=U0('ZEDOIDX',false);
p0 |=16;
if(B1()){
if(p0<16){
B0('ZEDOIDX',p0,432000000);
}
else{
B0('ZEDOIDX',p0,2592000000);
}}}}
function B1(){
if(document.cookie.indexOf('ZEDOIDX')!=-1){
return true;
}else{
return false;
}}
function B2(){
var p0=U0('ZEDOIDX',false);var v1=navigator.userAgent.toLowerCase();var y6=(v1.indexOf('mac')!=-1);var o6=(!y6&&(v1.indexOf('msie 5')!=-1)||(v1.indexOf('msie 6')!=-1));
document.writeln('<scri'+'pt language=VBS'+'cript>');
document.writeln('on error resume next');
document.writeln('a0=IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.5"))');
document.writeln('if(a0<=0)then a0=IsObject(CreateObject("ShockwaveFlash.ShockwaveFlash.4"))');
document.writeln('</scr'+'ipt>');
var i4=navigator.javaEnabled();
p0=1;
if(i4){p0 |=4;}
if(a0){p0 |=8;}
if(o6){
document.body.style.behavior='url(#default#clientCaps)';
if(document.body.connectionType=='lan'){
p0 |=16;
}}
else{
r1=new Date();
o1.src="http://simg.zedo.com/speed-test/10k.gif?"+zzRand;
o1.onload=F1;
}
if(B1()){
if(p0<16){
B0('ZEDOIDX',p0,432000000);
}
else{
B0('ZEDOIDX',p0,2592000000);
}}
return p0;
}
function B4(q4){
var a2=0;var c1=new Date();var c7=U0('FFcat',false);var a8=U0('FFad',false);
if(!c7){
c7=q4;
a8="-1";
w1=U0('FFSkp',false);
if(w1.length>0){
c1.setUTCDate(c1.getUTCDate()-1);
document.cookie='FFSkp=1;expires='+c1.toGMTString()+';domain='+document.domain+';path=/;';
}}
a2=F5(c7,a8,q4);
zzPos=a2;
return a2;
}
function F5(z5,r5,q4){
var z9=false;var p3=z5.split(":");var q3=r5.split(":");var a2=0;var t9=0;var i;
for(i=0;i<p3.length;i++){
if(p3[i]==q4){
t9=p3[i];
q3[i]++;
if(q3[i]>101){q3[i]=0;}
a2=q3[i];
if(isNaN(a2)){
i10.src='http://r1.zedo.com/ads2/p/'+zzRand+'/NaN.gif?v=bar/v15-003/d3;C='+document.cookie+';b='+navigator.userAgent;
a2=0;
q3[i]=0;
}
z9=true;
break;
}}
if(!z9&&p3.length<60){
z5=q4+":"+z5;
r5=0+":"+r5;
}
else{
if(i==p3.length){
i--;
}
for(var j=i;j>0;j--){
p3[j]=p3[j-1];
q3[j]=q3[j-1];
}
p3[0]=q4;
q3[0]=a2;
z5=p3.join(":");
r5=q3.join(":");
}
if(B1()){
var w4=F2();
B0('FFcat',z5,w4);
B0('FFad',r5,w4);
}
else{
a2=Math.floor((Math.random()* 1000000)% 20);
}
return a2;
}
function B3(t7,d9){
if(t7.length<1){
return 0;
}
if((t7==0)&&(d9>0)){
return 1;
}
if(t7>d9){
return 1;
}else{
return 0;
}}
function F3(z3){
if(z3>255){
z3=(z3 & 255);
}
return z3;
}
function U4(z3){
var i9=0;
if(z3>255){
i9=((z3>>16)& 4095);
}
return i9;
}
function U3(z3){
var o9=0;
if(z3>255){
o9=((z3>>8)& 255);
}
return o9;
}
var a1='http://yads.zedo.com/ads2/';var x7='http://d3.zedo.com/ads2/';var x6='http://d7.zedo.com/ads2/';var o0=U0('ZEDOIDX',false);var r0=254;var d4="";var t1=0;var c0='';var o2="";var e1=0;var n5=0;
var o5='';var c3='';var w1='';var y0=new Date();var x5=new Date();var e5='';var d0=navigator.userAgent.toLowerCase();var c2=parseInt(navigator.appVersion);
var v2=((d0.indexOf('msie')!=-1)&&(d0.indexOf('opera')==-1)&&(d0.indexOf('webtv')==-1));var p6=(v2&&(c2>=4));var i2=(d0.indexOf('mac')!=-1);
var i3=((d0.indexOf('mac')!=-1)&&(d0.indexOf('msie 4.')!=-1));var d5=(d0.indexOf('webtv')!=-1);var e6=((d0.indexOf('gecko')!=-1)&&(c2==5));var w3=(d0.indexOf('opera')!=-1);var n0=F0('n');
var n1=F0('w');var i1=F0('h');var z0=F0('c');var e0=F0('d');var v0=F0('s');var p1=F0('q');var z2=F0('l');var y5=unescape(F0('t'));var e3="";var e4="";
if(!n0){n0=0;}
if(!n1){n1=0;}
if(!i1){i1=0;}
if((!z0)||(z0<0)||(z0>999999)){z0=0;}
if(!e0){e0=0;}
if(e0<0||e0>95){
e0=0;
}
if(!v0){v0=0;}
if(isNaN(parseInt(o0)))o0=0;
var zzStr='';
if(typeof zzCountry=='undefined'){
var zzCountry=255;}
if(typeof zzMetro=='undefined'){
var zzMetro=0;}
if(typeof zzState=='undefined'){
var zzState=0;}var zzSection=v0;var zzD=window.document;var zzRand=(Math.floor(Math.random()* 1000000)% 10000);var zzCustom='';var zzPat='';var zzSkip='';var zzExp='';var zzTrd='';var zzPos=0;
var zzNw=0;var zzCh=0;var zzDm1=0;var zzDm2=0;var zzDm3=0;var zzDm4=0;var zzDm5=0;var zzDm6=0;var zzDm7=0;var zzDm8=0;var zzDm9=0;var zzDm10=0;var zzAGrp=0;var zzAct=new Array();
var zzActVal=new Array();
if(i2&&v2){
var p4=document.createElement("div");
p4.className="zd_src";
p4.id="zd_src";
document.body.appendChild(p4);
}
if(n0!=0){
zzNw=n0;
}
if(document.getElementById||document.all){
if(y5){
document.title=y5;
}}
if(p1!=""){
p1=unescape(p1);
var d7=p1.replace(/&/g,'zzazz');
e5='&q='+escape(d7);
p1=';q='+escape(p1);
zzPat=p1;
}
if(z2!=""){
zzTrd=escape(z2);
z2='&l='+escape(z2);
}
zzCustom=escape(F0('p'));
if(zzCustom.length>1)
e4='&p='+zzCustom;
var w5=z0.toString().indexOf('/');
if(w5!=-1){
e1=parseInt(z0.substr(0,w5));
}else{
e1=parseInt(z0);
}
zzCh=e1;
n5=parseInt(n0)+","+parseInt(e1);
e1=parseInt(e1)+(parseInt(n0)* 1000000);
if(o0<=0||o0>31){
if(document.all&&!i2&&!w3){
o0=B2();
}else{
o0=F4();
}}
if(o0<=0||o0>31){
o0=1;
}
o0=((e0<<8)|o0);
q2=n5+","+e0;
x0=B4(q2);
var p7=x0;var t3=U0(q2,false);
x5.setTime(x5.getTime()+F2());
y0.setUTCHours(y0.getUTCHours()+4);
y0.setUTCMinutes(y0.getUTCMinutes());
y0.setUTCSeconds(y0.getUTCSeconds());
zzSkip=';expires='+y0.toGMTString()+';domain='+document.domain+';path=/;';
zzExp=';expires='+y0.toGMTString()+';domain='+document.domain+';path=/;';
zzStr='i='+x0+';';
if(t3.length>0&&t3!=0){
o5=t3;
var n4=o5.split(',');
if(n4!=null&&n4.length>1){
x0=n4[0];
}}
else{
c3=t3;
if(parseInt(c3)==0){
if((B1())&&(x0==0)){
B0(q2,0,-2592000000);
}}
else{
w1=U0('FFSkp',false);
if(w1.length>0){
if(w1.indexOf(q2+":")>=0){
if(x0==0){
var c1=new Date("October 12,1988 13:14:00");
document.cookie='FFSkp='+w1+';expires='+c1.toGMTString()+';domain=.'+document.domain+';path=/;';
zzSkip=":"+zzSkip;
}
else{
c3=0;
}}
else{
zzSkip=':'+w1+zzSkip;
}}
else{
zzSkip=":"+zzSkip;
}}}
if((F0('g')&&(typeof c9!='undefined')&&(c9=='demographic'))
||(!F0('g')||isNaN(F0('g')))){
if(zzGeo==254){
r0=U0('FFgeo',false);
}else{ 
r0=zzGeo; 
}
}else{
r0=F0('g');
e3="&g="+r0;
}
if(isNaN(parseInt(r0))){r0=254;e3="&g="+r0;}
r0=parseInt(r0);
t1=parseInt(F3(r0));
zzCountry=t1;
if(r0>255){
zzState=U3(r0);
if(zzState!=0){
d4=";w="+zzState;
}
zzMetro=U4(r0);
if(zzMetro!=0){
d4+=";m="+zzMetro;
}}
if(document.cookie.match(/ZEDOIDA=([^;]*)/))
zzuid=RegExp.$1;
zzStr=zzStr+'u='+zzuid+';e=i;s='+v0+';g='+t1+d4+p1+';z='+Math.random();
if(B3(c3,x0)){
c0='http://d3.zedo.com/ads2/i/'+o0+'/'+r0+'/'+e1+'/99/b.js';
}else{
c0='http://d3.zedo.com/ads2/'+'d/'+o0+'/'+t1+'/'+n0+'/'+z0+'/i'+x0+'.js?z='+zzRand;
}
if(i2&&v2){
document.getElementById("zd_src").innerHTML='<scr'+'ipt language="JavaScript" src="'+c0+'"></sc'+'ript>';
}else{
document.write('<scr'+'ipt language="JavaScript" src="'+c0+'"></sc'+'ript>');
}
if(zzuid!="unknown"){
if(!(zzuid.match(/^[A-Za-z0-9@-]*$/))){
var c1=new Date('October 12,1988 13:14:00');
document.cookie='ZEDOIDA=-1;expires='+c1.toGMTString()+';domain=.zedo.com;path=/;';
d1.src='http://fg.zedo.com/init/'+Math.random()+'/g.gif';
}}