<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String str = request.getParameter("success") == null ? "" : request.getParameter("success");
%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta charset="utf-8"/>
        <link href="../../../SemanticUI/semantic.min.css" rel="stylesheet" type="text/css">
        <link href="../../../css/match.css" rel="stylesheet" type="text/css">
        <script src="../../../SemanticUI/jquery.js"></script>
        <script src="../../../SemanticUI/semantic.min.js"></script>
    </head>
    <body class="mainBody">

    </body>
    <!--表单验证提示-->
    <div class="ui small success modal">
        <div class="ui icon header"><i class="archive icon"></i>提示</div>
        <div class="content" style="text-align:center">
            <h3><%=str%></h3>
        </div>
        <div class="actions">
            <div class="ui green ok button"><i class="checkmark icon"></i>返回</div>
        </div>
    </div>

    <script type="text/javascript">
        
        $('.ui.success.modal')
            .modal({
                closable : false,
                blurring: true
            })
        ;     
        
        window.onload = function(){
         	$('.ui.success.modal').modal('show');
        };
       
                           
        $('.ui.green.button').click(function(){
        	location.href = "../matchtype.jsp";
        	
        })

    </script>
</html>