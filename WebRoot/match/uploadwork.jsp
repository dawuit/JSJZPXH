<%@page import="java.net.URLEncoder"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.DaoUtils, Utils.User"%>
<%@ include file="./lib/checklogin.jsp" %>
<%@ include file="./lib/checkenrollparam.jsp" %>
<%
	/**对比赛项目传参的安全检验*/
	/**检查下标合法性*/
	if(index > resMatchType.size()  || resMatchType.size() == 0)
	{
		response.sendRedirect("error.jsp?error=" + java.net.URLEncoder.encode("提交失败!请检查表单填！", "UTF-8"));
		return;
	}
	/**删除以前记录*/
	DaoUtils dao = new DaoUtils();
	dao.deleteUploadWork(user, resMatchType.get(index));
		
	String uid = user.getUid();
	String matchname = resMatchType.get(index).getMatchname();
	Date uploadtime = new Date();
	String dropboxurl = request.getParameter("dropboxurl");
	String boxpassword = request.getParameter("boxpassword");
	UploadWork work = new UploadWork(uid, matchname, uploadtime, dropboxurl, boxpassword);
	int resCode = dao.insertUploadWork(work);
	if(resCode != 0)
		response.sendRedirect("success.jsp?success=" + java.net.URLEncoder.encode("提交成功!", "UTF-8"));
	else
		response.sendRedirect("error.jsp?error=" + java.net.URLEncoder.encode("提交失败!请检查表单填！", "UTF-8"));
%>

