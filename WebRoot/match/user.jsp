<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.sql.Timestamp, java.text.DateFormat"%>
<%@include file="./lib/checklogin.jsp"%>
<%@include file="./lib/checkenrollparam.jsp" %>
<%
	/**对比赛项目传参的安全检验*/
	if(index > resMatchType.size())
		index = 0;
	
	/**获取比赛信息*/
	String defaultEnrollTime = "";
	String defaultUploadTime = "";
	String defaultMatchName = "未发布赛事";
	String defaultInfo = "无";
	/**是否上传报名表*/
	EnrollTable resenroll = null;
	UploadWork reswork = null;
	DateFormat ddtf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	if(resMatchType.size() > 0)
	{
		defaultEnrollTime = ddtf.format(resMatchType.get(index).getEnrolltime());
		defaultUploadTime = ddtf.format(resMatchType.get(index).getUploadtime());
		defaultMatchName = resMatchType.get(index).getMatchname();
		defaultInfo = resMatchType.get(index).getInfo().replace("\n", "<br/>");
		reswork = new DaoUtils().selectUploadWork(user, resMatchType.get(index));
		resenroll = new DaoUtils().selectEnrollTable(user, resMatchType.get(index));		
	}
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
    <div class="ui large user modal scrolling">
        <div class="header"><i class="user icon"></i> <%= user.getName() %>【<%= user.getUid() %>】</div>
        <div class="ui centered grid">
            <div class="five wide column">
                <div class="ui slide left reveal image content">
                    <div class="medium  visible content">
                        <img class="ui fluid image" src="../image/tom.jpg">
                    </div>
                    <div class="medium hidden content">
                        <img class="ui fluid image" src="../image/nan.jpg">
                    </div>
                </div>
            </div>
            <div class="eleven wide column">
                <h3>比赛项目</h3>
                <form class="matchNameForm" action="./user.jsp" method="GET">
                    <div class="ui fluid dropdown selection">
                        <input name="matchIndex" value="<%= index %>" type="hidden">
                        <i class="dropdown icon"></i>
                        <div class="text"><%= defaultMatchName %></div>
                       	<div class="menu transition hidden">
                        <% 
                        	for(int i = 0; i<resMatchType.size(); ++i)
                        	{
           						String matchname = resMatchType.get(i).getMatchname();
                       	%>
                            <div class="item" data-value="<%=i%>"><%=matchname%></div>
                        <%
                        	}
                        %>
                        </div>
                       	
                    </div>
                </form>
                <div class="ui divider"></div>
                <div class="matchinfo">
                    <div>
                        <h3>报名表<%= "<label style='margin-left:5%;font-weight:normal'>截止时间："+ defaultEnrollTime + "</label>" %></h3>
                        <%= resenroll == null ? "<a class='ui submitenroll big red tag label'>未提交</a>" : "<div class='ui big green tag label'>已提交</div>"%> 
                        <%= resenroll != null ? "<a class='ui alter big teal tag label' style='margin-left:5%'>点击修改</a>":""%>
                        <a class="ui big toinfo yellow tag label" style="margin-left:5%">注意事项</a>
                    </div>
                    <div class="ui divider"></div>
                    <div>
                        <h3>提交作品<%= "<label style='margin-left:5%;font-weight:normal'>截止时间："+ defaultUploadTime + "</label>" %></h3>
                    <%if(reswork == null){ %>
                        <a class="ui big upload red tag label">未提交</a>
                    <%}else{ %>
                    	<div class="ui big green tag label">已提交</div>
                        <a class="ui alterupload big teal tag label" style="margin-left:5%">点击修改</a>
                    <% } %>
                    </div>
                    <h4>注意:请上传网盘地址和密码</h4>
                    <div class="ui divider"></div>
                </div>
            </div>         
        </div>    
        <div class="actions">
            <div class="ui exit big red right labeled icon button">退出登录<i class="sign out icon"></i></div>
            <div class="ui return big green right labeled icon button">返回<i class="right chevron icon"></i> </div>            
        </div>
    </div>
    
    <!--注意事项-->
    <div class="ui small info modal">
        <div class="ui icon header"><i class="archive icon"></i>注意事项</div>
        <div class="ui content" style="padding-left:20%">
            <p><%= defaultInfo %></p>
        </div>
        <div class="actions">
            <div class="ui green ok inforeturn button"><i class="checkmark icon"></i>返回</div>
        </div>
    </div>
    
    <script type="text/javascript">
    	/**选择比赛项目*/
        $('.ui.selection').dropdown({
        	onChange : function(){
        	$('.matchNameForm').submit();
        }
        });
        
       $('.ui.user.modal').modal({
                closable : false,
                blurring: true
            });
            
       $('.ui.info.modal').modal({
                closable : false,
                blurring: true
            });
            
       window.onload = function()
       {
            $('.ui.user.modal').modal('show');
       }
       /**返回上一页面*/
       $('.return.button').click(function(){
       		location.replace("./login.jsp");
       });
        /**退出登录*/
        $('.exit.button').click(function(){
        	location.replace("./exitlogin.jsp");
        })
        /**注意事项提示框返回*/
        $('.inforeturn.button').click(function(){
        	$('.ui.user.modal').modal('show');
        })
        /**显示注意事项*/
        $('.toinfo.label').click(function(){
        	$('.ui.info.modal').modal('show');
        })
        /**上传文件*/
        $('.upload.label').click(function(){
        	location.href = "work.jsp?matchIndex=<%=index%>";
        })
        /**修改上传文件*/
        $('.alterupload.label').click(function(){
        	location.href = "alterwork.jsp?matchIndex=<%=index%>";
        })
        /*提交报名表*/
        $('.submitenroll.label').click(function(){
        	location.href = "enroll.jsp?matchIndex=<%=index%>";
        })
        /**修改报名表*/
        $('.alter.label').click(function(){
        	location.href = "alterenroll.jsp?matchIndex=<%=index%>";
        })
    </script>
</html>