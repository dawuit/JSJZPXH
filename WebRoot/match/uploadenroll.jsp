<%@page import="java.net.URLEncoder"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.DaoUtils, Utils.User"%>
<%@ include file="./lib/checklogin.jsp" %>
<%@ include file="./lib/checkenrollparam.jsp" %>
<%
	/**对比赛项目传参的安全检验*/
	/**检查下标合法性*/
	if(index > resMatchType.size())
	{
		response.sendRedirect("error.jsp?error=" + java.net.URLEncoder.encode("提交失败!请检查表单填！", "UTF-8"));
		return;
	}
	/**删除以前记录*/
	DaoUtils dao = new DaoUtils();
	dao.deleteEnrollTable(user, resMatchType.get(index));
		
	String uid = user.getUid();
	String matchname = resMatchType.get(index).getMatchname();
	Date uploadtime = new Date();
	String projectname = request.getParameter("projectname");
	String teamname = request.getParameter("teamname");
	String teachername = request.getParameter("teachername");
	String name1 = request.getParameter("name1");
	String number1 = request.getParameter("number1");
	String grade1 = request.getParameter("grade1");
	String qq1 = request.getParameter("qq1");
	String wechat1 = request.getParameter("wechat1");
	String phone1 = request.getParameter("phone1");
	String name2 = request.getParameter("name2");
	String number2 = request.getParameter("number2");
	String grade2 = request.getParameter("grade2");
	String qq2 = request.getParameter("qq2");
	String wechat2 = request.getParameter("wechat2");
	String phone2 = request.getParameter("phone2");
	String name3 = request.getParameter("name3");
	String number3 = request.getParameter("number3");
	String grade3 = request.getParameter("grade3");
	String qq3 = request.getParameter("qq3");
	String wechat3 = request.getParameter("wechat3");
	String phone3 = request.getParameter("phone3");
	EnrollTable enroll = new EnrollTable(uid, matchname, uploadtime, projectname, teamname, teachername, name1, number1, grade1, qq1, wechat1, phone1, name2, number2, grade2, qq2, wechat2, phone2, name3, number3, grade3, qq3, wechat3, phone3,null,null);
	int resCode = dao.insertEnrollTable(enroll);
	if(resCode != 0)
		response.sendRedirect("success.jsp?success=" + java.net.URLEncoder.encode("提交成功!请在规定时间内上传作品相关文件！", "UTF-8"));
	else
		response.sendRedirect("error.jsp?error=" + java.net.URLEncoder.encode("提交失败!请检查表单填！", "UTF-8"));
%>

