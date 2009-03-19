//  Copyright (c) 2000-2009 ZEDO Inc. All Rights Reserved.
var za5=new Array();
function zzProf(zc10){
this.networkId=zc10;
var zzDm1=0;var zzDm2=0;var zzDm3=0;var zzAGrp=0;var zzAct=new Array();var zzActVal=new Array();
this.im=function(arr){
var zq5=this.zzAct;
if(zq5!=null&&zq5!=''){
var za7=zq5.length;
for(j=0;j<arr.length;j++){
for(i=0;i<za7;i++){
if(zq5[i]==arr[j])
return arr[j];
}}}
return 0;
}
this.ima=function(zp_arr_act,zp_arr_min,zp_arr_max){
var zw5=this.zzAct;var zt8=this.zzActVal;
if(zw5!=null&&zw5!=''){
var za7=zw5.length;
for(j=0;j<zp_arr_act.length;j++){
for(i=0;i<za7;i++){
if(zw5[i]==zp_arr_act[j]&&(zt8[i]>=zp_arr_min[j]&&zt8[i]<=zp_arr_max[j])){
return zp_arr_act[j];
}}}}
return-1;
}}
function zB4(){
var zx1=new Date();var zv4=zx1.getDate();
if(zv4>=0&&zv4<=9)
zv4="0"+zv4;
var zt4=zx1.getMonth()+1;
if(zt4>=0&&zt4<=9)
zt4="0"+zt4;
var zq7=(zx1.getFullYear()).toString()+zt4+zv4;
return zq7;
}
function zzGetDmPrf(zo5,zi3){
var zx8='';
if(zi3){
if(zzNewEsi==false){
var zv2=zU0('ZFFdm',false);
}else{
var zv2=zzNewCke['ZFFdm'];}
}else{
if(zzNewEsi==false){
var zv2=zU0('FFdm',false);
}else{
var zv2=zzNewCke['FFdm'];}}
if(zv2.length>0){
var zo6=zv2.split(":");var zz11=zo6.length;
for(i=0;i<zz11;i++){
if(zo6[i].substring(0,zo6[i].indexOf("-"))==zo5){
zx8=zo6[i];
break;
}}}
return zx8;
}
function zzGetBhPrf(zo5,zi3){
var zi9='';
if(zi3){
if(zzNewEsi==false){
var ze3=zU0('ZFFbh',false);
}else{
var ze3=zzNewCke['ZFFbh'];}
}else{
if(zzNewEsi==false){
var ze3=zU0('FFbh',false);
}else{
var ze3=zzNewCke['FFbh'];}}
if(ze3.length>0){
var zi6=ze3.split(":");var zd12=zi6.length;
for(i=0;i<zd12;i++){
if(zi6[i].substring(0,zi6[i].indexOf("-"))==zo5){
zi9=zi6[i];
break;
}}}
return zi9;
}
function zzInitPrf(zr2,zo9){
if(typeof zr2=='undefined'||isNaN(zr2)){
return;
}
if(typeof(za5[zr2])!='undefined'||za5[zr2]!=null){
return za5[zr2];
}
var zy1=new zzProf(zr2);var zw9=zzGetBhPrf(zr2,zo9);var zr8=0;
if(zw9.length>0){
var zc9=zw9.split(",");
if(zc9.length>0){
zd_activity_garray=zc9[1].split("|");
zy1.zzAGrp=zd_activity_garray[0];
zy1.zzAct=new Array();
zy1.zzActVal=new Array();
var zz2=zd_activity_garray[1].split("Z");var zy11=zz2.length;
for(var j=0;j<zy11;j++){
var zv7=zz2[j].split("_");
if(zv7.length>0){
zy1.zzAct[zr8]=zv7[0];
zy1.zzActVal[zr8++]=zv7[1];
}}}}
var zy8=zzGetDmPrf(zr2,zo9);
if(zy8.length>0){
var zp9=zy8.split(",");var zi10=zp9.length;
for(var j=1;j<zi10;j++){
var zz2=zp9[j].split("|");
if(zz2.length>0){
if(zz2[0]=='1'){
zy1.zzDm1=zz2[1];
}else if(zz2[0]=='3'){
zy1.zzDm3=zz2[1];
}else if(zz2[0]=='2'){
zy1.zzDm2=zz2[1];
}}}}
za5[zr2]=zy1;
return zy1;
}
function zzGetDmLength(zo5,zi3){
if(zi3){
var zv2=zU0('ZFFdm',false);
}else{
var zv2=zU0('FFdm',false);}
return zv2.length;
}
function zzGetBhLength(zo5,zi3){
if(zi3){
var ze3=zU0('ZFFbh',false);
}else{
var ze3=zU0('FFbh',false);}
return ze3.length;
}