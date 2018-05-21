<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.sql.Timestamp, java.text.DateFormat"%>
<%@include file="./lib/checkadmin.jsp"%>
<!DOCTYPE html>
<html>
	<head>
        <title></title>
        <meta charset="utf-8"/>
        <link href="../../SemanticUI/semantic.min.css" rel="stylesheet" type="text/css">
        <link href="../../css/match.css" rel="stylesheet" type="text/css">
        <script src="../../SemanticUI/jquery.js"></script>
        <script src="../../SemanticUI/semantic.min.js"></script>
   </head>
<body>
  <div class="ui big visible sidebar inverted vertical menu">
  	<div class="item">BNUZ计算机作品协会</div>
  	<div class="item"><%= user.getName()+"【"+ user.getUid() + "】" %></div>
  	<a class="item" href="issuematch.jsp" target="iframe" >发布新的比赛项目<i class="upload icon"></i></a>
    <a class="item" href="matchtype.jsp" target="iframe">已发布的比赛项目<i class="chart bar icon"></i></a>
    <a class="item" href="enrolllist.jsp?matchIndex=0" target="iframe">报名情况<i class="student icon"></i></a>
    <a class="item exit">退出登录<i class="sign out icon"></i></a>
  </div>
  <div class="pusher">
	    <iframe id="iframe" style="position:fixed; right:0;bottom:0" frameborder="0" src="./matchtype.jsp" name="iframe">
	    </iframe>
  </div>
</body>
<script type="text/javascript">
	
    function changeFrameHeight(){
        var ifm= document.getElementById("iframe"); 
        ifm.height=document.documentElement.clientHeight;
		ifm.width=document.documentElement.clientWidth - $('.menu').width();
    }

    window.onresize=function(){  
         changeFrameHeight();  
    } 
    
    changeFrameHeight();
	
	/**退出登录*/
	$('.exit').click(function(){
		location.replace('../exitlogin.jsp');
	});
</script>
</html>