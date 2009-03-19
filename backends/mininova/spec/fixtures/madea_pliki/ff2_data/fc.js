//  Copyright (c) 2000-2009 ZEDO Inc. All Rights Reserved.
function zF5(zn6,zw2,zc0,zy7,zr7){
this.zn6=zn6;
this.zw2=zw2;
this.zc0=zc0;
this.duration=zy7;
this.zr7=zr7;
this.getCode=function(){
return this.zn6;
};
this.getCapValue=function(){
return this.zw2;
};
this.getTimeStamp=function(){
return this.zc0;
};
this.getCapDuration=function(){
return this.duration;
};
this.getPositions=function(){
return this.zr7;
};
}
var zd0=new Array();var zd3=-1;var zn3=-1;var zw0='';var zq1=0;var zz3=-1;var zo8=0;var zw8=0;var zi1='';var zd1='';var za9=false;var ze2=0;
function zzInitFc(ze0,zt1){
if(zt1==-1){
ze2=0;
}else{
zq1=0;
zn3=-1;
}
if(zd1.length==0){
if(zzNewEsi==false){
zd1=zU0('FFChanCap',false);
}else{
zd1=zzNewCke['FFChanCap'];
}}
var zo1=ze0 * 1000000+zt1;
zw0=new Array();
var zy10=false;
if(zt1>-1&&zd1!=''&&zd1.length!=0){
if(zd1.indexOf('B')==-1){
zd1=zF3(zd1);
}
var zp1=zd1.split('|');var zc5=zp1[0];var zt9=zc5.split('B');
zw8=zt9[0];
zd0['chBase']=zw8;
zc5=zt9[1];
var zy2=zp1[1];var zn0=zc5.split(':');var zo0=zy2.split(':');var zt0=new Array();var zo7=zn0.length;var zi2='';
for(zi2=0;zi2<zo7;zi2++){
if(zn0[zi2].substring(0,zn0[zi2].indexOf(','))==ze0){
zd3=zi2;
zd0[zo1+'_nwkIdx']=zd3;
zy10=true;
zt0=zn0[zi2].split(',');
var zi11=zt0.length;
for(var zx2=1;zx2<zi11;zx2++){
if(zt0[zx2].substring(0,zt0[zx2].indexOf('#'))==zt1){
zn3=zx2;
zd0[zo1+'_chanIdx']=zn3;
zd_adID_array=zt0[zx2].split('#');
var zr11=zd_adID_array.length;
for(var zq4=1;zq4<zr11;zq4++){
if(typeof(zo0[zq1])=='undefined'){
break;
}
var za0=zo0[zq1].split(',');
if(typeof(za0[0])=='undefined')za0[0]=0;
if(typeof(za0[1])=='undefined')za0[1]=1;
if(typeof(za0[2])=='undefined')za0[2]=1;
zw0[zd_adID_array[zq4]]=new zF5(zd_adID_array[zq4],za0[0],za0[1],za0[2],zq4+','+zq1);
zq1++;
}
zd0[zo1+'_chValMap']=zw0;
break;
}else{
zl_temp_pos=zt0[zx2].indexOf('#');
while(zl_temp_pos!=-1){
zq1++;
zl_temp_pos=zt0[zx2].indexOf("#",zl_temp_pos+1);
}}}
break;
}else{
zl_temp_pos=zn0[zi2].indexOf('#');
while(zl_temp_pos!=-1){
zq1++;
zl_temp_pos=zn0[zi2].indexOf("#",zl_temp_pos+1);
}}}
zd0[zo1+'_chValIdx']=zq1;
if(zd3<0||zn3<0){
zd0[zo1+'_found']=false;
}}
if(zi1.length==0){
if(zzNewEsi==false){
zi1=zU0('FFCap',false);
}else{
zi1=zzNewCke['FFCap'];
}}
if(zt1<0&&zi1!=''&&zi1.length!=0){
if(zi1.indexOf('B')==-1){
zi1=zF3(zi1);
}
var zp1=zi1.split('|');var zz6=zp1[0];var zy2=zp1[1];var zy4=zp1[0].split('B');
zz6=zy4[1];
zo8=zy4[0];
zd0['glBase']=zo8;
var zn0=zz6.split(':');var zo7=zn0.length;
for(var zo3=0;zo3<zo7;zo3++){
if(zn0[zo3].substring(0,zn0[zo3].indexOf(','))==ze0){
zz3=zo3;
zd0[ze0+'_nwkIdx']=zz3;
za9=true;
break;
}else{
zl_temp_pos=zn0[zo3].indexOf(',');
while(zl_temp_pos!=-1){
ze2++;
zl_temp_pos=zn0[zo3].indexOf(",",zl_temp_pos+1);
}}}
if(zy2.length>0&&za9){
var zo0=zy2.split(':');var zc7=zn0[zz3].split(',');
zv0=new Array();
for(i=1;i<zc7.length;i++){
if(typeof(zo0[ze2])=='undefined'){
break;
}
var za0=zo0[ze2].split(',');
if(typeof(za0[0])=='undefined')za0[0]=0;
if(typeof(za0[1])=='undefined')za0[1]=1;
if(typeof(za0[2])=='undefined')za0[2]=1;
zv0[zc7[i]]=new zF5(zc7[i],za0[0],za0[1],za0[2],i+','+ze2);
ze2++;
}
zd0[ze0+'_glValMap']=zv0;
}}
zd0[ze0+'_valIdx']=ze2;
if(zz3<0){
zd0[ze0+'_found']=false;
}}
function zzIncrementChanCapForId(ze0,zt1,zy0,zp0){
if(zzNewEsi==true){
document.write('<script language="javascript" src="http://d7.zedo.com/fbar/v2-102/d3/jsc/egc.js?&x=1&n='+ze0+'&c='+zt1+'&a='+zy0+'&d='+zp0+'"></script>');
}else{
var zy3='';var zo1=ze0 * 1000000+zt1;var zw0=zd0[zo1+'_chValMap'];var zd3=zd0[zo1+'_nwkIdx'];
if(zd1!=''&&zd1.length!=0&&zd1.indexOf('B')!=-1){
var zy4=zd1.split('B');var zq2=zy4[0];var zp1=zy4[1].split('|');var zc5=zp1[0];var zy2=zp1[1];var zn0=zc5.split(':');var zo0=zy2.split(':');var zy5='';var zz0='';var za2=false;var zc0=zU1(zq2,zp0);
var zq3=zF1(zq2);
if(zc0>99){
za2=true;
}
if(zd3>-1){
var zt0=zn0[zd3].split(',');
if(zn3!=-1){
var zw6=zt0[zn3].split('#');var i=0;var j=0;var zi4=false;
for(zl_id in zw0){
if(zl_id==zy0){
zi4=true;
}
var zn1=zw0[zl_id].getPositions().split(',');var zz0=zo0[zn1[1]-i].split(',');
if(zz0[1]<zq3){
zw6.splice(zn1[0]-i,1);
zo0.splice(zn1[1]-i,1);
zw0[zl_id]=null;
i++;
if(!zi4){
j++;
}}}
if(zw0[zy0]!=null&&typeof(zw0[zy0])!='undefined'){
var zn1=zw0[zy0].getPositions().split(',');
zz0=zo0[zn1[1]-j];
zz0=zz0.split(',');
zz0[0]++;
zz0[1]=zw0[zy0].getTimeStamp();
za2=false;
if(zz0[1]>99){
za2=true;
}
zz0[2]=zw0[zy0].getCapDuration();
zz0=zz0.join(',');
zo0[zn1[1]-j]=zz0;
}else{
zw6.push(zy0);
zq1=zd0[zo1+'_chValIdx'];
zz0='0'+','+zc0+','+zp0;
zo0.splice(zq1-i,0,zz0);
}
zy5=zw6.join('#');
zt0.splice(zn3,1,zy5);
}else{
zy5=zt1+'#'+zy0;
zz0='0'+','+zc0+','+zp0;
zo0.splice(zq1,0,zz0);
zt0.push(zy5);
}
zn0.splice(zd3,1,zt0.join(','));
}else{
zn0.push(ze0+','+zt1+'#'+zy0);
zo0.push('0,'+zc0+','+zp0);
}
zy3=zq2+'B'+zn0.join(':')+'|'+zo0.join(':');
if(za2||zy3.length>2500){
zy3=zU2(zq2,zn0,zo0);
}
}else{
var zr1=zB0();
zy3=zr1+'B'+ze0+','+zt1+'#'+zy0+'|'+'0,'+zU1(zr1,zp0)+','+zp0;
}
if(zy3.length>=3000){
zU3('FFChanCap',zy3);
}else{
var zw3=new Date();
zw3.setTime(zw3.getTime()+(60 * 60 * 1000 * 24 * 30));
document.cookie='FFChanCap='+zy3+';expires='+zw3.toUTCString()+';path=/;domain=.zedo.com';
}
zU4();
}}
function zzIncrementCapForId(ze0,zz1,zp0){
if(zzNewEsi==true){
document.write('<script language="javascript" src="http://d7.zedo.com/fbar/v2-102/d3/jsc/egc.js?&x=0&n='+ze0+'&f='+zz1+'&d='+zp0+'"></script>');
}else{
var zv1='';var zv0=zd0[ze0+'_glValMap'];var zz3=zd0[ze0+'_nwkIdx'];
if(zi1!=''&&zi1.length!=0&&zi1.indexOf('B')!=-1){
var ze8=zi1.split('B');var zq2=ze8[0];var zp1=ze8[1].split('|');var zz6=zp1[0];var zy2=zp1[1];var zn0=zz6.split(':');var zo0=zy2.split(':');var za2=false;var zc0=zU1(zq2,zp0);var zq3=zF1(zq2);
if(zc0>99){
za2=true;
}
if(zz3>-1){
var zv6=zn0[zz3].split(',');var i=0;var j=0;var zi4=false;
for(zl_id in zv0){
if(zl_id==zz1){
zi4=true;
}
var zn1=zv0[zl_id].getPositions().split(',');var zz0=zo0[zn1[1]-i].split(',');
if(zz0[1]<zq3){
zv6.splice(zn1[0]-i,1);
zo0.splice(zn1[1]-i,1);
zv0[zl_id]=null;
i++;
if(!zi4){
j++;
}}}
if(zv0[zz1]!=null&&typeof(zv0[zz1])!='undefined'){
var zn1=zv0[zz1].getPositions().split(',');var zz0=zo0[zn1[1]-j].split(',');
zz0[0]++;
zz0[1]=zv0[zz1].getTimeStamp();
za2=false;
if(zz0[1]>99){
za2=true;
}
zz0[2]=zv0[zz1].getCapDuration();
zz0=zz0.join(',');
zo0[zn1[1]-j]=zz0;
}else{
zv6.push(zz1);
ze2=zd0[ze0+'_valIdx'];
zo0.splice(ze2-i,0,'0,'+zc0+','+zp0);
}
zn0[zz3]=zv6.join(',');
}else{
zn0.push(ze0+','+zz1);
zo0.push('0,'+zc0+','+zp0);
}
zv1=zq2+'B'+zn0.join(':')+'|'+zo0.join(':');
if(za2||zv1.length>=2500){
zv1=zF6(zq2,zn0,zo0);
}
}else{
var zr1=zB0();
zv1=zr1+'B'+ze0+','+zz1+'|'+'0,'+zU1(zr1,zp0)+','+zp0;
}
if(zv1.length>=3000){
zU3('FFCap',zv1);
}else{
var zw3=new Date();
zw3.setTime(zw3.getTime()+(60 * 60 * 1000 * 24 * 30));
document.cookie='FFCap='+zv1+';expires='+zw3.toUTCString()+';path=/;domain=.zedo.com';
}
zU4();
}}
function zB1(zq9,zx3,zt6,zv11){
var zo2;var zr1;
if(zv11=="FFCap"){
zo2=zd0[zq9+'_glValMap'];
zr1=zd0['glBase'];
}else{
zo2=zd0[zq9+'_chValMap'];
zr1=zd0['chBase'];
}
if(zo2[zx3]==null||typeof(zo2[zx3])=='undefined'){
return true;
}
var zz9=zo2[zx3].getCapDuration();var zc0=zo2[zx3].getTimeStamp();
if(zz9!=zt6){
zc0=zB2(zo2[zx3].getTimeStamp(),zz9,zt6);
zo2[zx3].duration=zt6;
zo2[zx3].zc0=zc0;
}
var zq3=zF1(zr1);
if(zq3>zc0){
return true;
}
return false;
}
function zzIsCapReached(ze0,zz1,zc4,zp0,zp8){
var za1=(zU0('ZEDOIDX')=='')?0:1;var zx4=102;
if(!za1){
if(ze0=='496'){
zx4=50;
}
if(Math.floor(Math.random()*zx4)<Math.floor(zc4 /((zp0==0)?1:zp0))){
return false;
}else{
return true;
}}
if(typeof(zd0[ze0+'_glValMap'])=='undefined' 
||zd0[ze0+'_glValMap']==null){
if(typeof(zd0[zp8+'_found'])=='undefined'
||zd0[zp8+'_found']==false){
zzInitFc(ze0,-1);
}}
var zv0=zd0[ze0+'_glValMap'];
if(typeof(zv0)=='undefined' 
||zv0[zz1]==null 
||typeof(zv0[zz1])=='undefined'){
return false;
}
var zr5=zB1(ze0,zz1,zp0,'FFCap');
if((!zr5&&parseInt(zv0[zz1].getCapValue())<zc4-1)
||zr5){
return false;
}
return true;
}
function zzIsChanCapReached(ze0,zv9,zy0,zc4,zp0){
var zo1=ze0*1000000+zv9;var za1=(zU0('ZEDOIDX')=='')?0:1;var zx4=102;
if(!za1){
if(ze0=='496'){
zx4=50;
}
if(Math.floor(Math.random()* zx4)<Math.floor(zc4 /((zp0==0)?1:zp0))){
return false;
}else{
return true;
}}
if(typeof(zd0[zo1+'_chValMap'])=='undefined' 
||zd0[zo1+'_chValMap']==null){
if(typeof(zd0[ze0+'_found'])=='undefined'
||zd0[ze0+'_found']==false){
zzInitFc(ze0,zv9);
}}
var zw0=zd0[zo1+'_chValMap'];
if(typeof(zw0)=='undefined' 
||zw0[zy0]==null 
||typeof(zw0[zy0])=='undefined'){
return false;
}
var zr5=zB1(zo1,zy0,zp0,'FFChanCap');
if((!zr5&&parseInt(zw0[zy0].getCapValue())<zc4-1)
||zr5){
return false;
}
return true;
}
function zU4(){
zd1=null;
ad_id_posn=null;
zw0=null;
zv0=null;
zi1=null;
}
function zU3(za10,zr9){
var zz8=zr9.length / 4;var zc6=zr9;var zd10=(zU0('ZEDOIDA')=='')?'unknown':zU0('ZEDOIDA');
for(var i=0;i<4;i++){
var zq6=new Image();var zv10=escape(zc6.substring(0,zz8-1));
zc6=zc6.substring(zz8);
var za3=za10+'.length>3KB,'+'u='+zd10+','+'c'+i+'='+zv10;
zq6.src='http://r1.zedo.com/log/ERR.gif?v=fbar/v2-102/d3;'+za3+'b='+navigator.userAgent;
}}
function zB0(){
var zd5=new Date();
zd5.setUTCFullYear(2007,0,1);
zd5.setUTCHours(0,0,0,0);
zd5.setTime(zd5.getTime()+5 * 60 * 60 * 1000);
var zi7=new Date();
zi7.setTime(zi7.getTime());
return Math.ceil((zi7-zd5)/(24 * 60 * 60 * 1000))-1;
}
function zF1(ze4){
var zq3=zB0()+1;
return zq3-ze4;
}
function zU1(ze4,zx10){
var zx11=zF1(ze4);var zc0=zx11+zx10-1;
return zc0;
}
function zF6(zo11,zw1,zn2){
var zi8=zB0();var zn7=zi8-zo11;var zp4=0;var zz0;
for(var i=0;i<zw1.length;i++){
var zo4=zw1[i].split(',');
for(var j=1;j<zo4.length;j++){
zz0=zn2[zp4].split(',');
zz0[1]=zz0[1]-zn7;
if(zz0[1]<=0){
zo4.splice(j,1);
zn2.splice(zp4,1);
zp4--;
j--;
}else{
zn2[zp4]=zz0.join(',');
}
zp4++;
}
if(zo4.length==1){
zw1.splice(i,1);
i--;
}else{
zw1[i]=zo4.join(',');
}}
return zi8+'B'+zw1.join(':')+'|'+zn2.join(':');
}
function zB2(zp11,zr10,zt10){
var ze12=zp11-zr10+1;var zc0=ze12+zt10-1;
return zc0;
}
function zU2(zw11,zw1,zn2){
var zn8=zB0();var zn7=zn8-zw11;var zz5=0;
for(var i=0;i<zw1.length;i++){
var zt0=zw1[i].split(',');
for(var j=1;j<zt0.length;j++){
var zd6=zt0[j].split('#');
for(var k=1;k<zd6.length;k++){
zz0=zn2[zz5].split(',');
zz0[1]=zz0[1]-zn7;
if(zz0[1]<=0){
zn2.splice(zz5,1);
zd6.splice(k,1);
k--;
zz5--;
}else{
zn2[zz5]=zz0.join(',');
}
zz5++;
}
if(zd6.length==1){
zt0.splice(j,1);
j--;
}else{
zt0[j]=zd6.join('#');
}}
if(zt0.length==1){
zw1.splice(i,1);
i--;
}else{
zw1[i]=zt0.join(',');
}}
return zn8+'B'+zw1.join(':')+'|'+zn2.join(':');
}
function zF3(ze10){
var zr1=zB0();var zc3=ze10.split('|');var zo4=zc3[0];var zz0=zc3[1];var zo0=zz0.split(':');
for(var idx=0;idx<zo0.length;idx++){
zc3=zo0[idx].split(',');
zc3[1]=zF2(zc3[1],zr1);
zc3.push(1);
zo0[idx]=zc3.join(',');
}
return zr1+'B'+zo4+'|'+zo0.join(':');
}
function zF2(ze11,ze4){
var zw7;
zw7=parseInt(ze11 / 24);
return(zw7>ze4)?zw7-ze4:0;
}