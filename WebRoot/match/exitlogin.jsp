<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	session.removeAttribute("islogin");
	response.sendRedirect("./login.jsp");
%>

