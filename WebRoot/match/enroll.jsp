<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.sql.Timestamp, java.text.DateFormat, java.net.URLEncoder"%>
<%@ include file="./lib/checklogin.jsp" %>
<%@ include file="./lib/checkenrollparam.jsp"%>
<%
	/**对比赛项目传参的安全检验*/
	/**检查是否有比赛项目*/
	if(resMatchType.size() < index || resMatchType.size() == 0)
	{
		response.sendRedirect("error.jsp?error=" + URLEncoder.encode("未发布赛事", "UTF-8"));
		return;
	}
	
	/**检查是否已经报名*/
	if(new DaoUtils().selectEnrollTable(user, resMatchType.get(index)) != null)
	{
		response.sendRedirect("error.jsp?error=" + URLEncoder.encode("您已报名，不可重复报名！", "UTF-8"));
		return;
	}
	/**检查是否时间已经截止*/
	if(new Date().after(resMatchType.get(index).getEnrolltime()))
	{
		response.sendRedirect("error.jsp?error=" + URLEncoder.encode("报名日期截止", "UTF-8"));
		return;
	}
	
	String matchname = resMatchType.get(index).getMatchname();
 %>

<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta charset="utf-8"/>
        <link href="../SemanticUI/semantic.min.css" rel="stylesheet" type="text/css">
        <link href="../css/match.css" rel="stylesheet" type="text/css">
        <script src="../SemanticUI/jquery.js"></script>
        <script src="../SemanticUI/semantic.min.js"></script>
    </head>
    <body class="mainBody">

    </body>
    <!--报名表格-->
    <div class="ui large enrolltable modal scrolling">
        <div class="header"><i class="upload icon"></i>报名</div>
            <div class="ui grid" style="margin:10px">
                    <div class="ui medium image content four wide column">
                        <img src="../image/logo.jpg">
                        <img src="../image/code.jpg">
                    </div>
                <div class="twelve wide column">
                    <h2 class="centered" style="text-align:center"><%=matchname%>报名表</h2>
                    <div class="ui divider"></div>
                    <form class="ui form" action="./uploadenroll.jsp?matchIndex=<%=index%>" method="POST">
                        <div class="two fields">
                            <div class="field">
                                <label>*作品名称(50字内)</label>
                                <input class="projectName" name="projectname" type="text">
                            </div>
                            <div class="field">
                                <label>*团队名字(50字内)</label>
                                <input class="teamName" name="teamname" type="text">
                            </div>
                        </div>
                        <div class="field">
                            <label>*指导老师</label>
                            <input class="teacherName" name="teachername" type="text">
                        </div>
                        <div class="six fields">
                            <div class="field">
                                <label>*组长姓名</label>
                                <input class="name1" name="name1" value="<%=user.getName()%>" readonly  type="text">
                            </div>
                            <div class="field">
                                <label>*学号</label>
                                <input class="number1" name="number1" value="<%=user.getUid()%>" readonly  type="text">
                            </div>
                            <div class="field">
                                <label>*专业年级</label>
                                <input class="grade1" name="grade1" type="text">
                            </div>
                            <div class="field">
                                <label>*QQ</label>
                                <input class="qq1" name="qq1" type="text">
                            </div>
                            <div class="field">
                                <label>*微信</label>
                                <input class="wechat1" name="wechat1" type="text">
                            </div>
                            <div class="field">
                                <label>*手机号</label>
                                <input class="phone1" name="phone1" type="text">
                            </div>
                        </div>
                        <div class="six fields">
                            <div class="field">
                                <label>组员1姓名</label>
                                <input name="name2" type="text">
                            </div>
                            <div class="field">
                                <label>学号</label>
                                <input name="number2" type="text">
                            </div>
                            <div class="field">
                                <label>专业年级</label>
                                <input name="grade2" type="text">
                            </div>
                            <div class="field">
                                <label>QQ</label>
                                <input name="qq2" type="text">
                            </div>
                            <div class="field">
                                <label>微信</label>
                                <input name="wechat2" type="text">
                            </div>
                            <div class="field">
                                <label>手机号</label>
                                <input name="phone2" type="text">
                            </div>
                        </div>
                        <div class="six fields">
                            <div class="field">
                                <label>组员2姓名</label>
                                <input name="name3" type="text">
                            </div>
                            <div class="field">
                                <label>学号</label>
                                <input name="number3" type="text">
                            </div>
                            <div class="field">
                                <label>专业年级</label>
                                <input name="grade3" type="text">
                            </div>
                            <div class="field">
                                <label>QQ</label>
                                <input name="qq3" type="text">
                            </div>
                            <div class="field">
                                <label>微信</label>
                                <input name="wechat3" type="text">
                            </div>
                            <div class="field">
                                <label>手机号</label>
                                <input name="phone3" type="text">
                            </div>
                        </div>
                        <h4>注意：*字段必填</h4>
                        <div class="ui error message"></div> 
                    </form>			
                </div>
            </div>
        <div class="actions">
        	<div class="ui return teal big right labeled icon button">返回<i class="left chevron icon"></i> </div>
            <div class="ui form green big right labeled icon button">提交<i class="checkmark icon"></i></div>
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
         
        

        $('.ui.form.green.button').click(function(){

			$('.ui.form').form('submit');
        });
        /**表单验证*/
         $('.ui.form')
		  .form({
		    fields: {
		      projectname: {
		        identifier: 'projectname',
		        rules: [
		          {
		            type   : 'minLength[1]',
		            prompt : '作品名称长度不符合要求'
		          },
		          {
		          	type   : 'maxLength[50]',
		            prompt : '作品名称长度不符合要求'
		          }
		        ]
		      },
		      teamname: {
		        identifier: 'teamname',
		        rules: [
		          {
		            type   : 'minLength[1]',
		            prompt : '团队名称长度不符合要求'
		          },
		          {
		          	type   : 'maxLength[50]',
		            prompt : '团队名称长度不符合要求'
		          }
		        ]
		    },
		    teachername: {
		        identifier: 'teachername',
		        rules: [
		          {
		            type   : 'minLength[1]',
		            prompt : '老师姓名长度不符合要求'
		          },
		          {
		          	type   : 'maxLength[20]',
		            prompt : '老师姓名长度不符合要求'
		          }
		        ]
		    },
		    name1: {
		        identifier: 'name1',
		        rules: [
		          {
		            type   : 'minLength[1]',
		            prompt : '组长姓名长度不符合要求'
		          },
		          {
		          	type   : 'maxLength[20]',
		            prompt : '组长姓名长度不符合要求'
		          }
		        ]
		    },
		   grade1: {
		        identifier: 'grade1',
		        rules: [
		          {
		            type   : 'minLength[1]',
		            prompt : '专业年级长度不符合要求'
		          },
		          {
		          	type   : 'maxLength[20]',
		            prompt : '专业年级长度不符合要求'
		          }
		        ]
		    },
		    qq1: {
		        identifier: 'qq1',
		        rules: [
		          {
		            type   : 'regExp[/^[0-9]{1,15}$/]',
		            prompt : 'qq不符合要求'
		          }
		        ]
		    },
		    wechat1: {
		        identifier: 'wechat1',
		        rules: [
		          {
		            type   : 'maxLength[50]',
		            prompt : '微信不符合要求'
		          },
		          {
		            type   : 'empty',
		            prompt : '微信不符合要求'
		          }
		        ]
		    },
		     phone1: {
		        identifier: 'phone1',
		        rules: [
		          {
		            type   : 'regExp[/^[0-9]{11}$/]',
		            prompt : '手机号不符合要求'
		          }
		        ]
		    }
		 } 
	});
    </script>
</html>