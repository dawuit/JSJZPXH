<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.text.DateFormat"%>
<%@include file="./lib/checkadmin.jsp"%>
<%@include file="./lib/checkenrollparam.jsp" %>
<%
	/**对比赛项目传参的安全检验*/
	if(index > resMatchType.size())
		index = 0;
	
	/**获取比赛信息*/
	String defaultMatchName = "未发布赛事";
	ArrayList<Personallist> personal = null;
	if(resMatchType.size() > 0)
	{
		defaultMatchName = resMatchType.get(index).getMatchname();
		personal = new DaoUtils().selectPersonal(resMatchType.get(index));	
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

    <div class="ui large enrolllist modal scrolling">
        <div class="header"><i class="student icon"></i> 报名情况</div>
        <div class="ui grid" style="margin:10px 0px;min-height:250px">       	  	
          <form class="matchNameForm centered fourteen wide column" action="./enrolllist.jsp?matchtype=<%=index%>" method="GET">
          	<h3> 比赛项目</h3>
              <div class="ui fluid dropdown selection">
                  <input name="matchIndex" value="<%= index %>" type="hidden">
                  <i class="dropdown icon"></i>
                  <div class="text"><%= defaultMatchName %></div>
                 	<div class="menu transition hidden">
                  	<% 
                  	for(int i = 0; i<resMatchType.size(); ++i)
                  	{
     						String matchname = resMatchType.get(i).getMatchname();
                 	%>
                      <div class="item" data-value="<%=i%>"><%=matchname%></div>
	                <%
	                }
	                %>
                	</div>
                </div>
            </form>
        	<div class="centered fourteen wide column">
        		<a class="ui big yellow horizontal label" href="./lib/outputexcelenroll.jsp?matchIndex=<%=index%>">导出报名表</a>
        		<label style="">总人数: <%=personal == null?0:personal.size() %></label>
				<table class="ui celled table" style="text-align:center">
				  <thead>
				    <tr>
				      <th>学号</th>
				      <th>姓名</th>
				      <th>报名时间</th>
				      <th>上传时间</th>
				      <th>查看报名</th>
				      <th>查看作品</th>
				    </tr>
				  </thead>
				  <tbody>
				  <%
				  	if(personal == null || personal.size() == 0)
				  	{
				  %>
				  	<tr>
				      <td colspan="6">无报名记录</td>
				    </tr>
				  <%
				  	}else{
				  	for(int i = 0; i < personal.size(); ++i){
				  %>
				    <tr>
				      <td><%=personal.get(i).getName() %></td>
				      <td><%=personal.get(i).getUid() %></td>
				      <td><%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(personal.get(i).getEnrolltime())%></td>
				      <td><%=personal.get(i).getUploadtime() == null ? "<i class='large red remove icon'></i>" : new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(personal.get(i).getUploadtime()) %></td>
				      <td><a class="ui big green horizontal label" href="showenroll.jsp?uid=<%=personal.get(i).getUid()%>&matchname=<%=URLEncoder.encode(defaultMatchName,"UTF-8")%>">查看</a></td>
				      <td><%=personal.get(i).getUploadtime() == null ? "<div class='ui red big horizontal label'>查看</div>" : ("<a class='ui big green horizontal label' href='showwork.jsp?uid=" + personal.get(i).getUid() + "&matchname=" + URLEncoder.encode(defaultMatchName,"UTF-8") + "'>查看</a>")%></td>
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
    	/**选择比赛项目*/
        $('.ui.selection').dropdown({
        	onChange : function(){
        	$('.matchNameForm').submit();
        }
        });
    
		$('.ui.enrolllist')
			.modal({
                closable : false,
                blurring: true
            })
         ;
         window.onload=function(){
         	$('.ui.enrolllist').modal('show');
         }
        
    </script>
</html>