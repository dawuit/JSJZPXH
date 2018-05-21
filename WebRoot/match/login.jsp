<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.text.DateFormat"%>
<%
	DaoUtils dao = new DaoUtils();
	ArrayList<MatchType> resMatchType = (ArrayList<MatchType>)dao.selectMatchType();
	String matchname = "———————";
	String enrolltime = "未发布比赛";
	String uploadtime = "未发布比赛";
	String info = "";
	DateFormat ddtf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	/**取最新的一次比赛信息*/
	if(resMatchType.size() > 0)
	{
		matchname = resMatchType.get(0).getMatchname();
		enrolltime = ddtf.format(resMatchType.get(0).getEnrolltime());
		uploadtime = ddtf.format(resMatchType.get(0).getUploadtime());
		info = resMatchType.get(0).getInfo();
		info = info.replace("\n", "<br/>");
	}
%>

<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta charset="utf-8"/>
        <link href="../SemanticUI/semantic.min.css" rel="stylesheet" type="text/css">
        <link href="../css/match.css" rel="stylesheet" type="text/css">
        <script src="../SemanticUI/jquery.js"></script>
        <script src="../SemanticUI/semantic.min.js"></script>
   </head>
    <body class="mainBody">

    </body>
    <!--注意事项-->   
    <div class="ui attention modal">
        <div class="header">注意事项</div>
        <div class="image content">
            <div class="ui medium image">
                <img src="../image/logo.jpg">
                <img src="../image/code.jpg">
            </div>
            <div class="description">
                <h2 style="text-align:center">本次报名的是<%=matchname%>比赛</h2>
                <div class="ui divider"></div>
                <div style="font-size:20px">
                    <p>报名截止时间：<%=enrolltime%></p>
                    <p>提交作品截止时间：<%=uploadtime%></p>
                    <p><%=info%></p>
                </div>
            </div>
        </div>
        <div class="actions">
        	<% if(session.getAttribute("islogin") == null){ %>
            <div class="ui tologin blue right labeled icon big button">&nbsp;&nbsp;&nbsp;&nbsp;登陆&nbsp;&nbsp;&nbsp;&nbsp;<i class="user icon"></i></div>
            <% }else{ %>
            <div class="ui personal teal right labeled icon big button">个人中心<i class="user icon"></i></div>
        	<% } %>
        	<div class="ui toenroll green right labeled icon big button">开始报名<i class="checkmark icon"></i></div>
        </div>
    </div>
    <!--登陆-->
    <div class="ui small login modal ">
        <div class="header">登陆</div>
        <form class="ui form loginForm" method="POST" action="./dologin.jsp">
            <div class="ui grid">
                <div class="five wide column"></div>
                <div class="ui eleven wide column form">
                    <div class="inline field">
                        <label>学号</label>
                        <div class="ui large left icon input">
                            <input placeholder="学号" type="text" name="userName">
                            <i class="user icon"></i>
                        </div>
                    </div>
                    <div class="inline field">
                        <label>密码</label>
                        <div class="ui large left icon input" >
                            <input type="password" name="password">
                            <i class="lock icon"></i>
                        </div>
                    </div>
                    <h4 class="headerLabel">(请使用教务系统账号登陆)</h4>
                </div>           
            </div>
            <div class="ui error message" style="width:80%;margin:20px auto"></div> 
        </form>  
        
        <div class="actions">
            <div class="ui goback large red right labeled icon button">返回<i class="angle left icon"></i></div>
            <div class="ui green large submit right labeled icon button">登陆<i class="sign in icon"></i></div>
        </div>
    </div>
    
    <script type="text/javascript">
        $('.tologin').click(function(){
            $('.ui.login.modal').modal('show');
        });

        $('.goback').click(function(){
             $('.ui.attention.modal').modal('show');
         });
         
        $('.toenroll.button').click(function(){
             location.href = "./enroll.jsp?matchIndex=0";
         });
    	
    	$('.personal.button').click(function(){
             location.href = "./user.jsp?matchIndex=0";
         });
    		
    
        $('.ui.login.modal')
            .modal({
                allowMultiple: false,
                closable : false,
                blurring: true
            })
        ;
        
        $('.ui.attention.modal')
            .modal({
                allowMultiple: false,
                closable : false,
                blurring: true
            })     
        ;
        
        window.onload = function()
        {
        	$('.ui.attention.modal').modal('show');
        }
        
        $('.ui.submit.button').click(function(){
        	$('.ui.loginForm').form('submit');
        });
        
        $('.ui.form')
		  .form({
		    fields: {
		      userName: {
		        identifier: 'userName',
		        rules: [
		          {
		            type   : 'empty',
		            prompt : '请输入正确学号',
		          },
		          {
		            type   : 'maxLength[20]',
		            prompt : '请输入正确学号',
		          }
		        ]
		      },
		      password: {
		        identifier: 'password',
		        rules: [
		          {
		            type   : 'empty',
		            prompt : '请输入密码',
		          }
		        ]
		      }
		    }
		  });
        
    </script>
</html>