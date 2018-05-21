<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.sql.Timestamp, java.text.DateFormat, java.net.URLEncoder"%>
<%@ include file="./lib/checkadmin.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String matchname = request.getParameter("matchname");
	
	/**检查是否已经报名*/
	UploadWork work = new DaoUtils().selectUploadWork(new User(uid, null, null,null), new MatchType(null,null,null,matchname,null));
	if(work == null)
	{
		response.sendRedirect("./lib/adminerror.jsp?error=" + URLEncoder.encode("参数错误！", "UTF-8"));
		return;
	}

%>

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
    <body class="mainBody">

    </body>
    <!--报名表格-->
    <div class="ui uploadwork modal scrolling">
        <div class="header"><i class="upload icon"></i><%=uid %> 的作品</div>
            <div class="ui grid" style="margin: 10px">
                <div class="twelve wide column centered">
                    <h2 class="centered" style="text-align:center"><%=matchname%></h2>
                    <div class="ui divider"></div>
                    <form class="ui form" action="" method="POST">
                        <div class="fields">
                            <div class="twelve wide field">
                                <label>网盘链接*</label>
                                <input class="dropboxurl" readonly name="dropboxurl" type="text" value="<%=work.getDropboxurl()%>">
                            </div>
                            <div class="four wide field">
                                <label>密码</label>
                                <input class="boxpassword" readonly name="boxpassword" type="text" value="<%=work.getBoxpassword()%>">
                            </div>
                        </div>
                    </form>			
                </div>
            </div>
        <div class="actions">
        	<div class="ui return teal big right labeled icon button">返回<i class="left chevron icon"></i> </div>
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
        

    </script>
</html>