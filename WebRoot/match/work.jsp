<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.sql.Timestamp, java.text.DateFormat, java.net.URLEncoder"%>
<%@ include file="./lib/checklogin.jsp" %>
<%@ include file="./lib/checkenrollparam.jsp"%>
<%
	/**对比赛项目传参的安全检验*/
	/**检查是否有比赛项目*/
	if(resMatchType.size() < index || resMatchType.size() == 0)
	{
		response.sendRedirect("error.jsp?error=" + URLEncoder.encode("未发布赛事", "UTF-8"));
		return;
	}
	
	/**检查是否时间已经截止*/
	if(new Date().after(resMatchType.get(index).getUploadtime()))
	{
		response.sendRedirect("error.jsp?error=" + URLEncoder.encode("提交时间截止", "UTF-8"));
		return;
	}
	
	String matchname = resMatchType.get(index).getMatchname();
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
    <!--报名表格-->
    <div class="ui uploadwork modal scrolling">
        <div class="header"><i class="upload icon"></i>提交作品</div>
            <div class="ui grid" style="margin: 10px">
                <div class="twelve wide column centered">
                    <h2 class="centered" style="text-align:center"><%=matchname%></h2>
                    <div class="ui divider"></div>
                    <form class="ui form" action="./uploadwork.jsp?matchIndex=<%=index%>" method="POST">
                        <div class="fields">
                            <div class="twelve wide field">
                                <label>网盘链接*</label>
                                <input class="dropboxurl" name="dropboxurl" type="text">
                            </div>
                            <div class="four wide field">
                                <label>密码</label>
                                <input class="boxpassword" name="boxpassword" type="text">
                            </div>
                        </div>
                    
                        <h4>注意：*字段必填</h4>
                        <div class="ui error message"></div> 
                    </form>			
                </div>
            </div>
        <div class="actions">
        	<div class="ui return teal big right labeled icon button">返回<i class="left chevron icon"></i> </div>
            <div class="ui form green big right labeled icon button">提交<i class="checkmark icon"></i></div>
        </div>
    </div>

    <script type="text/javascript">
        
        $('.ui.uploadwork.modal')
            .modal({
                closable : false,
                blurring: true
            })
        ;
        
        window.onload = function(){
         	$('.ui.uploadwork.modal').modal('show');
        }
        
        $('.ui.return.button').click(function(){
        	history.back();
        })
         ;
         
        

        $('.ui.form.green.button').click(function(){

			$('.ui.form').form('submit');
        });
        
        /**表单验证*/
         $('.ui.form')
		  .form({
		    fields: {
		      dropboxurl: {
		        identifier: 'dropboxurl',
		        rules: [
		          {
		            type   : 'regExp[/(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]/]',
		            prompt : '请输入正确的网盘链接'
		          },
		          {
		          	type   : 'maxLength[100]',
		            prompt : '链接不能超过100个字符'
		          }
		        ]
		      },
		      boxpassword: {
		        identifier: 'boxpassword',
		        rules: [
		          {
		          	type   : 'maxLength[20]',
		            prompt : '密码不能超过20个字符'
		          }
		        ]
		    },
		 } 
	});
    </script>
</html>