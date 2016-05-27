<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>斗鱼弹幕 DEMO</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="description" content="This is my page">
  </head>
 
  <script type='text/javascript' src='dwr/engine.js'></script>
  <script type='text/javascript' src='dwr/util.js'></script>
  <script type="text/javascript" src="dwr/interface/MessagePush.js"></script>
  <script type='text/javascript' src='js/jquery-1.5.1.js'></script>
  <script type="text/javascript">
  
  /*************************************************************
  LovelyLife Player V1.0
  Edited By LovelyLife
  At 2006-09-16
  All rights reservered
  Code Start
  Modify by http://www.tt419.cn/ 
  *************************************************************/
  var playid = "LovelyLifePlayer"
  var status = "status"
  var curId,arrPL,selected
  var isStop,isLoop
  arrPL = new Array()  //播放器列表
  cur = 0
  curId = 0
  isStop = false
  selected = 0
  isLoop = true
  function songObj(Id,url, name){
  this.Id  = Id
  this.url = url
  this.name = name
  }
  function playAndpauseIt(){
  if(document.getElementById(status).innerText == '暂停'){
  document.getElementById(playid).controls.pause()
  document.getElementById(status).innerHTML ='播放'
  }
  else{ document.getElementById(status).innerText = '暂停'
  document.getElementById(playid).controls.play()}
  }
  function stopIt(){
  isStop = true
  document.getElementById(status).innerHTML ='播放'
  document.getElementById(playid).controls.stop()
  }
  function showTimer(){
  var cp=document.getElementById(playid).controls.currentPosition
  var cps=document.getElementById(playid).controls.currentPositionString
  var dur=document.getElementById(playid).currentMedia.duration;
  var durs=document.getElementById(playid).currentMedia.durationString;
  var s = document.getElementById(playid).playState
  var o = document.getElementById(playid).openState
  if( s==2 || s==3)
  document.getElementById('pos').innerText = " " + cps + "/" + durs + " "
  else
  document.getElementById('pos').innerText = " 00:00/" + durs + " "
  if( s == 1 ){
  if(isLoop && (curId > (arrPL.length - 1))){
  curId = 0
  return 0
  }
  clearIt()
  if(curId<0 || curId>arrPL.length){
  alert("当前没有歌曲！，请查看播放列表！")
  return false
  }
  nxtPlay()
  }
  if( s == 10 && arrPL.length >0 )
  nxtPlay()
  }
  function nxtPlay(){
  isStop = true
  if(curId > arrPL.length - 1){
  document.getElementById("songName").innerText = "没有歌曲了，请选择上一曲!"
  document.getElementById(playid).URL = "NULL"
  return false
  }
  curId++
  clearIt()
  setIt(curId)
  PlayIt(curId)
  }
  function prePlay(){
  isStop = true
  if(curId<0){
  document.getElementById("songName").innerText = "没有歌曲了，请选择下一曲!"
  document.getElementById(playid).URL = "NULL"
  return false
  }
  curId--
  clearIt()
  setIt(curId)
  PlayIt(curId)
  }
  function PlayIt(cid){
  if(curId<0 || curId>arrPL.length -1){
  document.getElementById("songName").innerText = "当前没有歌曲！，请查看播放列表！"
  return false
  }
   url = arrPL[cid].url;
    
  curId = cid
  if(url == "None"){
  document.getElementById("songName").innerText = "加载歌曲未找到!播放下一曲！"
  nxtPlay()
  return false
  }
  document.getElementById(playid).URL = url
  document.getElementById("songName").innerText = arrPL[cid].name
  }
  function clearIt(){
  if((arrPL.length - 1 <0) || selected < 0 || selected > arrPL.length){
    
  return false
  }
    
  }
  function setIt(tid){
  if(tid<0 || tid>arrPL.length-1){
  document.getElementById("songName").innerText = "当前没有歌曲！，请查看播放列表！"
  return false
  }
    
  }
  function InitPlay(songName,url,auto){
  var strTemp = "<object classid=\"CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6\""
  strTemp += " type=\"application/x-oleobject\" width=\"0\" height=\"0\" id=" + playid
  strTemp += " style=\"position:relative; left:0px; top:0px; width:0px; height:0px;\">\n"
  strTemp += " <param name=\"autoStart\" value=\""+auto+"\">\n"
  strTemp += " <param name=\"balance\" value=\"0\">\n"
  strTemp += " <param name=\"currentPosition\" value=\"0\">\n"
  strTemp += " <param name=\"currentMarker\" value=\"0\">\n"
  strTemp += " <param name=\"enableContextMenu\" value=\"0\">\n"
  strTemp += " <param name=\"enableErrorDialogs\" value=\"0\">\n"
  strTemp += " <param name=\"enabled\" value=\"-1\">\n"
  strTemp += " <param name=\"fullScreen\" value=\"0\">\n"
  strTemp += " <param name=\"invokeURLs\" value=\"0\">\n"
  strTemp += " <param name=\"mute\" value=\"0\">\n"
  strTemp += " <param name=\"playCount\" value=\"1\">\n"
  strTemp += " <param name=\"rate\" value=\"1\">\n"
  strTemp += " <param name=\"uiMode\" value=\"none\">\n"
  strTemp += " <param name=\"volume\" value=\"40\">\n"
  strTemp += " <param name=\"URL\" value=\"" + url + "\">\n"
  strTemp += "</object>\n<font class=HighLight style=\"background-color: #EEE;padding: 8px;height:30px;width:100%\">"
  strTemp += "<b>点播的歌曲: <marquee width=30% speed=3><font color=red id=songName>" + songName + "</font></marquee>"
  strTemp += "  [<font id=pos></font>]"
  strTemp += " [<font onclick=playAndpauseIt() style='cursor:hand;' id=" + status + ">播放</font>]"
  strTemp += "[<font onclick=stopIt() style='cursor:hand;'>停止</font>]"
  if((arrPL.length - 2) >= 0){
  strTemp += "[<font onclick=prePlay() style='cursor:hand;'>上曲</font>]"
  strTemp += "[<font onclick=nxtPlay() style='cursor:hand;'>下曲</font>]"
  }
  strTemp += " </b>"
  document.getElementById('player').innerHTML = strTemp;
  //temptimer=setInterval('showTimer()',1000);
  }
  function playX(cur){
  PlayIt(cur)
  clearIt()
  setIt(cur)
  curId = cur
  selected = cur
  }
  function MakeList(Id,Url,Name){
  arrPL[cur] = new songObj(Id,Url, Name)
  cur++
  }
  function loopIt(){
  if(isLoop){
  document.getElementById('sloop').innerText = "不循环"
  isLoop = false
  }else{
  document.getElementById('sloop').innerText = "循环播放"
  isLoop = true
  }
  }
  /* Code End */
  
  /*
  window.attachEvent('onload', function(){
    //InitPlay("Maps","http://m2.music.126.net/zeL32kn8IGvWUhZCf0FWfA==/5974746185669438.mp3", 1);
    //InitPlay("偏爱","http://m2.music.126.net/pcQxArpCzvFYAxP0M1XXQw==/7732865278752458.mp3", 2);
    playAndpauseIt();
    });
  */
  
  
  
  
  		var musicCount=1;
  		//通过该方法与后台交互，确保推送时能找到指定用户
         function onPageLoad(){
            var userId = '${userinfo.humanid}';
            MessagePush.onPageLoad(userId);
          }
         //推送信息
		 function showMessage(autoMessage){
			 document.getElementById('messagesDiv').innerHTML=document.getElementById('messagesDiv').innerHTML+autoMessage;
			//DIV 自动滚动到底部
			var div = document.getElementById('messagesDiv'); 
			div.scrollTop = div.scrollHeight; 
			this.focus();
			//alert(autoMessage);
			
			//判断弹幕信息是否是点歌弹幕
			var musicName="";
			if(autoMessage.indexOf("@")>0){
				musicName=autoMessage.substring(autoMessage.indexOf("@")+1,autoMessage.lastIndexOf("@"));
				
				$.ajax({
	                 url: "http://s.music.163.com/search/get/",
	                 dataType: "jsonp",
	                 data: {
	                     'type': 1,
	                     's': musicName,
	                     'limit': 1
	                 },
	                 jsonp: "callback",
	                 cache: false,
	                 success: function(data) {
	                	 
	                	 var  musicUrl="";
	                	 var tempName="";
	                	 for(var o in data){  
	                	        //alert("o====="+o);  
	                	        //alert("data[o]===="+data[o]);  
	                	        //alert("text:"+data[o].songCount);
	                	        
	                	        var temps=data[o].songs;
	                	        for(var temp in temps){
	                	        	//alert("temp.id====="+temp.id);  
	                    	        //alert("歌曲URL===="+temps[temp].audio);  
	                    	        musicUrl=temps[temp].audio;
	                    	        tempName=temps[temp].name;
	                    	        
	                	        }
	                	 }
	                	 
	                	 //musicCount++;
	                	 //alert("musicCount======"+musicCount+",musicUrl==="+musicUrl+",tempName==="+tempName);
	                	// MakeList(musicCount,musicUrl,tempName);
	                	//alert("222222");
	                	
	                	//MakeList(musicCount,musicUrl,tempName);
	                	
	                	if(musicCount!=1){
	                		//document.getElementById(musicCount-1).controls.stop();
	                		document.getElementById("LovelyLifePlayer").controls.stop();
	                	}
	                	
	                	//document.getElementById(musicCount).controls.stop()
	                	
	                	InitPlay(tempName,musicUrl, musicCount);
	                	    //InitPlay("偏爱","http://m2.music.126.net/pcQxArpCzvFYAxP0M1XXQw==/7732865278752458.mp3", 2);
	                	playAndpauseIt();
	                	musicCount++;
	                 }
	             });
				
			}
				
				
				
		}
		 function startListen(){
			 var roomId=document.getElementById('roomId').value;
			 if(roomId != ""){
				 jQuery.ajax({
		                 type: "post",
		                 url: "startListenForDY.do",
		                 data: "roomId=" + roomId+"&operator=start",
		                 success: function (result) {
		                     //alert(result.msg);
		                 }
		             });
			 }else{
				 alert("请输入要监听的房间号!");
			 }
			 
		 }
		 
		
		 
		 //停止监听
		 function stopListen(){
			 var roomId=document.getElementById('roomId').value;
			 if(roomId != ""){
				 jQuery.ajax({
		                 type: "post",
		                 url: "startListenForDY.do",
		                 data: "roomId=" + roomId+"&operator=stop",
		                 success: function (result) {
		                     //alert(result.msg);
		                 }
		             });
			 }else{
				 alert("请输入要监听的房间号!");
			 }
			 
		 }
		 
		 
		 
		 //停止监听
		 function musicListen(){
			 alert("aaaaaaaa");
			 
		 
		 }
		 
		
         
  </script>
  
  
  <body  onload="onPageLoad();dwr.engine.setActiveReverseAjax(true);dwr.engine.setNotifyServerOnPageUnload(true);"> 
    斗鱼弹幕监听程序. <hr>
    
    监听房间ID:<input type="text" id="roomId" name="roomId" value="599899" /><br />
   <input type="button" id="button1" value="启动监听" onclick="startListen()" />
   <input type="button" id="button2" value="停止监听" onclick="stopListen()"/>
   <input type="button" id="button2" value="测试网易云api" onclick="musicListen()"/>
   
   <PRE>
   
   <span style="font-weight:bold;color:blue">
弹幕点歌 格式 如下：
   	主播大大，我要点歌@张学友情书@
   	</span>
   </PRE>
  <!--   音乐控件开始  --> 
   <script>

</script>
<div id=player style="width:70%"></div>
 
<script>
//MakeList(1,"http://m2.music.126.net/zeL32kn8IGvWUhZCf0FWfA==/5974746185669438.mp3","Maps");

//MakeList(2,"http://m2.music.126.net/zeL32kn8IGvWUhZCf0FWfA==/5974746185669438.mp3","情书");

</script>


  <!--   音乐控件结束--> 
    <br>
    <div id="messagesDiv" style="border-style:solid; border-width:1px; border-color:#000;margin-top:10px;width:380px;height:350px;overFlow-y:scroll; " >
      
    </div>
    
    
    
  </body>
</html>
