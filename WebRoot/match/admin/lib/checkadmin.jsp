<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.sql.Timestamp, java.text.DateFormat"%>
<%
	if(session.getAttribute("islogin") == null )
	{
		response.sendRedirect("/JSJZPXH/match/error.jsp?error=" + java.net.URLEncoder.encode("未登录，请先登录！", "UTF-8"));
		return;
	}
	
	User user = (User)session.getAttribute("user");
	if(user.getUauth().equals("0"))
	{
		response.sendRedirect("/JSJZPXH/match/error.jsp?error=" + java.net.URLEncoder.encode("不是管理员！", "UTF-8"));
		return;
	}
	ArrayList<MatchType> resMatchType = new DaoUtils().selectMatchType();
%>
