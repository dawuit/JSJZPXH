<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.sql.Timestamp, java.text.DateFormat"%>
<%	
	if(session.getAttribute("islogin") == null)
	{
		response.sendRedirect("/JSJZPXH/match/error.jsp?error=" + java.net.URLEncoder.encode("未登录，请先登录！", "UTF-8"));
		return;
	}
	
	User user = (User)session.getAttribute("user");

	if(user == null)
	{
		response.sendRedirect("/JSJZPXH/match/error.jsp?error=" + java.net.URLEncoder.encode("未登录，请先登录！", "UTF-8"));
		session.removeAttribute("islogin");
		return;
	}	

	ArrayList<MatchType> resMatchType = new DaoUtils().selectMatchType();
%>
