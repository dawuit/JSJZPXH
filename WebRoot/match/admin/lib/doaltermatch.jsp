<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.text.DateFormat, java.text.SimpleDateFormat"%>
<%@include file="./checkadmin.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String matchname = request.getParameter("matchname");
	String enrolltime = request.getParameter("enrolltime");
	String uploadtime = request.getParameter("uploadtime");
	String matchinfo = request.getParameter("matchinfo");
	Date enrolltimed =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enrolltime);
	Date uploadtimed = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(uploadtime);
	int resCode = new DaoUtils().alterMatchType(new MatchType(enrolltimed, uploadtimed, new Date(), matchname, matchinfo));
	if(resCode == 0)
	{
		response.sendRedirect("./adminerror.jsp?error=" + java.net.URLEncoder.encode("修改失败！", "UTF-8"));
		return;
	}
	else
	{
		response.sendRedirect("./adminsuccess.jsp?success=" + java.net.URLEncoder.encode("修改成功！", "UTF-8"));
	}

%>
