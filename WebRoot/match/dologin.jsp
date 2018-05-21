<%@page import="Utils.BNUZLogin"%>
<%@ page import="Utils.EnrollTable"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.DaoUtils, Utils.User, Utils.MatchType"%>
<%
	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	DaoUtils exeSelect = new DaoUtils();
	User resUser = exeSelect.selectUser(new User(userName, password, null, null));
	/**先在数据库中查询是否有该账号，没有再去教务系统爬取登陆信息成功则加入数据库*/
	if(resUser == null)
	{
		resUser = new BNUZLogin().doLogin(userName, password);
		if(resUser != null)
		{
			new DaoUtils().insertUser(resUser);
		}
		else
		{
			response.sendRedirect("faillogin.jsp");
			return;
		}
	}
	
	session.setMaxInactiveInterval(1800);
	session.setAttribute("user", resUser);
	session.setAttribute("islogin", true);
	if(resUser.getUauth().equals("0"))		
		response.sendRedirect("user.jsp?matchIndex=0");
	else
		response.sendRedirect("./admin/manage.jsp");
		
%>
