<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.text.DateFormat"%>
<%@include file="./lib/checkadmin.jsp"%>
<%
	DateFormat dtf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
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

    <div class="ui large matchtypelist modal scrolling">
        <div class="header"><i class="chart bar icon"></i> 比赛项目</div>
        <div class="ui grid" style="margin:10px 0px;min-height:250px">       	  	
        	<div class="centered fourteen wide column">
				<table class="ui celled table" style="text-align:center">
				  <thead>
				    <tr>
				      <th>比赛名称</th>
				      <th>发布时间</th>
				      <th>报名截止时间</th>
				      <th>上传截止时间</th>
				      <th>修改参数</th>
				    </tr>
				  </thead>
				  <tbody>
				  <%
				  	if(resMatchType.size() == 0)
				  	{
				  %>
				  	<tr>
				      <td colspan="5">未发布任何比赛</td>
				    </tr>
				  <%
				  	}else{
				  	for(int i = 0; i < resMatchType.size(); ++i){
				  %>
				    <tr>
				      <td><%=resMatchType.get(i).getMatchname() %></td>
				      <td><%=dtf.format(resMatchType.get(i).getIssuetime()) %></td>
				      <td><%=dtf.format(resMatchType.get(i).getEnrolltime())%></td>
				      <td><%=dtf.format(resMatchType.get(i).getUploadtime())%></td>
				      <td><a class="ui big teal horizontal label" href="altermatch.jsp?matchIndex=<%=i%>">修改</a></td>
				    </tr>
				    <%
				    	}
				    }
				    %>
				  </tbody>
				</table>
			</div>
		</div>
    </div>
    
    <script type="text/javascript">

    
		$('.ui.matchtypelist')
			.modal({
                closable : false,
                blurring: true
            })
         ;
         window.onload=function(){
         	$('.ui.matchtypelist').modal('show');
         }
        
    </script>
</html>