<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.sql.Timestamp, java.text.DateFormat, java.net.URLEncoder"%>
<%@ include file="./lib/checkadmin.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String matchname = request.getParameter("matchname");
	
	/**检查是否已经报名*/
	EnrollTable enroll = new DaoUtils().selectEnrollTable(new User(uid, null, null,null), new MatchType(null,null,null,matchname,null));
	if(enroll == null)
	{
		response.sendRedirect("./lib/adminerror.jsp?error=" + URLEncoder.encode("参数错误！", "UTF-8"));
		return;
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
    <!--报名表格-->
    <div class="ui large enrolltable modal scrolling">
        <div class="header"><i class="student icon"></i> 报名信息</div>
            <div class="ui grid" style="margin:10px">
                    <div class="ui medium image content four wide column">
                        <img src="../../image/logo.jpg">
                        <img src="../../image/code.jpg">
                    </div>
                <div class="twelve wide column">
                    <h2 class="centered" style="text-align:center"><%=enroll.getMatchname()%>报名表</h2>
                    <div class="ui divider"></div>
                    <form class="ui form">
                        <div class="two fields">
                            <div class="field">
                                <label>*作品名称(50字内)</label>
                                <input disabled value="<%=enroll.getProjectname() %>" class="projectName" name="projectname" type="text">
                            </div>
                            <div class="field">
                                <label>*团队名字(50字内)</label>
                                <input disabled value="<%=enroll.getTeamname() %>" class="teamName" name="teamname" type="text">
                            </div>
                        </div>
                        <div class="field">
                            <label>*指导老师</label>
                            <input disabled value="<%=enroll.getTeachername() %>" class="teacherName" name="teachername" type="text">
                        </div>
                        <div class="six fields">
                            <div class="field">
                                <label>*组长姓名</label>
                                <input disabled value="<%=enroll.getName1() %>" class="name1" name="name1" value="<%=user.getName()%>" readonly  type="text">
                            </div>
                            <div class="field">
                                <label>*学号</label>
                                <input disabled value="<%=enroll.getNumber1() %>" class="number1" name="number1" value="<%=user.getUid()%>" readonly  type="text">
                            </div>
                            <div class="field">
                                <label>*专业年级</label>
                                <input disabled value="<%=enroll.getGrade1() %>" class="grade1" name="grade1" type="text">
                            </div>
                            <div class="field">
                                <label>*QQ</label>
                                <input disabled value="<%=enroll.getQq1() %>" class="qq1" name="qq1" type="text">
                            </div>
                            <div class="field">
                                <label>*微信</label>
                                <input disabled value="<%=enroll.getWechat1() %>" class="wechat1" name="wechat1" type="text">
                            </div>
                            <div class="field">
                                <label>*手机号</label>
                                <input disabled value="<%=enroll.getPhone1() %>" class="phone1" name="phone1" type="text">
                            </div>
                        </div>
                        <div class="six fields">
                            <div class="field">
                                <label>组员1姓名</label>
                                <input disabled value="<%=enroll.getName2() %>" name="name2" type="text">
                            </div>
                            <div class="field">
                                <label>学号</label>
                                <input disabled value="<%=enroll.getNumber2() %>" name="number2" type="text">
                            </div>
                            <div class="field">
                                <label>专业年级</label>
                                <input disabled value="<%=enroll.getGrade2() %>" name="grade2" type="text">
                            </div>
                            <div class="field">
                                <label>QQ</label>
                                <input disabled value="<%=enroll.getQq2() %>" name="qq2" type="text">
                            </div>
                            <div class="field">
                                <label>微信</label>
                                <input disabled value="<%=enroll.getWechat2() %>" name="wechat2" type="text">
                            </div>
                            <div class="field">
                                <label>手机号</label>
                                <input disabled value="<%=enroll.getPhone2() %>" name="phone2" type="text">
                            </div>
                        </div>
                        <div class="six fields">
                            <div class="field">
                                <label>组员2姓名</label>
                                <input disabled value="<%=enroll.getName3() %>" name="name3" type="text">
                            </div>
                            <div class="field">
                                <label>学号</label>
                                <input disabled value="<%=enroll.getNumber3() %>" name="number3" type="text">
                            </div>
                            <div class="field">
                                <label>专业年级</label>
                                <input disabled value="<%=enroll.getGrade3() %>" name="grade3" type="text">
                            </div>
                            <div class="field">
                                <label>QQ</label>
                                <input disabled value="<%=enroll.getQq3() %>" name="qq3" type="text">
                            </div>
                            <div class="field">
                                <label>微信</label>
                                <input disabled value="<%=enroll.getWechat3() %>" name="wechat3" type="text">
                            </div>
                            <div class="field">
                                <label>手机号</label>
                                <input disabled value="<%=enroll.getPhone3() %>" name="phone3" type="text">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        <div class="actions">
        	<div class="ui return teal big right labeled icon button">返回<i class="left chevron icon"></i> </div>
        </div>
    </div>

    <script type="text/javascript">
        
        $('.ui.enrolltable.modal')
            .modal({
                closable : false,
                blurring: true
            })
        ;
        
        window.onload = function(){
         	$('.ui.enrolltable.modal').modal('show');
        }
        
        $('.ui.return.button').click(function(){
        	history.back();
        })
         ;
    </script>
</html>