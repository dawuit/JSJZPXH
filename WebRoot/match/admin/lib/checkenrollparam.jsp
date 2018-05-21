<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	/**对比赛项目传参的安全检验*/
	int index = 0;
	if(request.getParameter("matchIndex") != null && request.getParameter("matchIndex").matches("^[0-9]*$"))
		index = Integer.parseInt(request.getParameter("matchIndex"));
	else
	{
		response.sendRedirect("/JSJZPXH/match/admin/lib/adminerror.jsp?error=" + java.net.URLEncoder.encode("提交失败!请检查表单填！", "UTF-8"));
		return;
	}
%>