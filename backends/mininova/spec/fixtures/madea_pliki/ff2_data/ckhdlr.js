//  Copyright (c) 2000-2008 ZEDO Inc. All Rights Reserved.
function zU5(){
if(document.cookie){
return true;
}
return false;
}
function zB6(){
var za1=new Date();var zi3=new Date();
zi3.setUTCHours(5);
zi3.setUTCMinutes(0);
zi3.setUTCSeconds(0);
var zy3=zi3.getTime()-za1.getTime();
if(zy3<0){
zi3.setUTCDate(zi3.getUTCDate()+1);
zy3=zi3.getTime()-za1.getTime();
}
return zy3;
}
function zB3(zq9,zc10,zd7){
var zc5=new Date();
if(!zd7){zd7=31536000000;}
zc5.setTime(zc5.getTime()+zd7);
document.cookie=zq9+'='+zc10+';expires='+zc5.toGMTString()+';domain=.zedo.com;path=/;';
}
function zF4(ze1,zd6){
var zr5=new Array();
if(!zr5[ze1]||zd6){
var zp1=document.cookie;var zd1=new Array();var zp3=new Array();
zd1=zp1.split(';');
var ze6=(zd1!=null)?zd1.length:0;
for(var i=0;i<ze6;i++){
zd1[i]=zd1[i].replace(/^\s/,'');
zp3=zd1[i].split('=');
zr5[zp3[0]]=zp3[1];
}}
if(zr5[ze1]){return zr5[ze1];}
else{return '';}
}
function zzGetNextAdId(zv3){
var zd2=0;var zc5=new Date();var zt6=zF4('FFcat',false);var zn8=zF4('FFad',false);
if(!zt6){
zt6=zv3;
zn8="-1";
}
zd2=zU6(zt6,zn8,zv3);
return zd2;
}
function zU6(zd4,za4,zv3){
var zw8=false;var zx1=zd4.split(":");var zn2=za4.split(":");var zd2=0;var zx9=0;var i;
for(i=0;i<zx1.length;i++){
if(zx1[i]==zv3){
zx9=zx1[i];
zn2[i]++;
if(zn2[i]>101){zn2[i]=0;}
zd2=zn2[i];
if(isNaN(zd2)){
zd2=0;
zn2[i]=0;
}
zw8=true;
break;
}}
if(!zw8&&zx1.length<60){
zd4=zv3+":"+zd4;
za4=0+":"+za4;
}
else{
if(i==zx1.length){
i--;
}
for(var j=i;j>0;j--){
zx1[j]=zx1[j-1];
zn2[j]=zn2[j-1];
}
zx1[0]=zv3;
zn2[0]=zd2;
zd4=zx1.join(":");
za4=zn2.join(":");
}
if(zU5()){
var zy3=zB6();
zB3('FFcat',zd4,zy3);
zB3('FFad',za4,zy3);
}
else{
zd2=Math.floor((Math.random()* 1000000)% 20);
}
return zd2;
}