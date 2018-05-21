<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, java.text.SimpleDateFormat"%>
<%@include file="./lib/checkadmin.jsp"%>
<%@include file="./lib/checkenrollparam.jsp"%>
<%
	/**对比赛项目传参的安全检验*/
	if(index > resMatchType.size())
	{
		response.sendRedirect("./lib/adminerror.jsp?error=" + java.net.URLEncoder.encode("参数错误！", "UTF-8"));
		return;
	}
	MatchType match = resMatchType.get(index); 
	SimpleDateFormat dtf = new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
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

     <!--注意事项-->
    <div class="ui info modal">
        <div class="ui header"><i class="upload icon"></i>修改比赛信息</div>
        <div class="ui grid" style="margin:0px 10px">
	        <div class="centered twelve wide column">
	        	<form class="ui form" action="./lib/doaltermatch.jsp" method="POST">
	        	<div class="field">
		        	<label>比赛名称</label>
		            <input name="matchname" type="text" readOnly="" value="<%=match.getMatchname()%>">
				</div>
	        	<div class="two fields">			
        			<div class="field">
			        	<label>报名截止时间</label>
			            <input name="enrolltime"  type="text" value="<%=dtf.format(match.getEnrolltime())%>">
			        </div>
			        <div class="field">
			        	<label>文件上传截止时间</label>
			            <input name="uploadtime" type="text" value="<%=dtf.format(match.getUploadtime())%>">
			        </div>
				</div>
				<div class="field">
		        	<label>注意事项</label>
		            <textarea name="matchinfo" style="resize:none;height:250px" maxlength="500"><%= match.getInfo()%></textarea>
				</div>
				<p>注意：时间格式应为2018-01-01 12:12:12</p>
				<div class="ui error message" ></div> 
	        	</form>
	        </div>
            
        </div>
        <div class="actions">
        	<div class="ui teal return right labeled icon  button"><i class="angle left icon"></i>返回</div>
            <div class="ui green alter right labeled icon  button"><i class="checkmark icon"></i>修改</div>
        </div>
    </div>
    
    
    
    <script type="text/javascript">
    
    	$('.return').click(function(){
    		history.back();
    	});
    
		$('.alter').click(function(){
			$('.ui.form').form('submit');
		})
    
		$('.ui.info')
			.modal({
                closable : false,
                blurring: true
            })
         ;
         window.onload=function(){
         	$('.ui.info').modal('show');
         }
         //表单验证
         $('.ui.form')
		  .form({
		    fields: {
		      matchname: {
		        identifier: 'matchname',
		        rules: [
		          {
		            type   : 'empty',
		            prompt : '请输入比赛名称',
		          },
		          {
		            type   : 'maxLength[50]',
		            prompt : '比赛名称过长',
		          }
		        ]
		      },
		      enrolltime: {
		        identifier: 'enrolltime',
		        rules: [
		          {
		            type   : 'regExp[/^2[0-9]{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (20|21|22|23|[0-1][0-9]):[0-5][0-9]:[0-5][0-9]$/]',
		            prompt : '请输入正确时间',
		          }
		        ]
		      },
		      uploadtime: {
		        identifier: 'uploadtime',
		        rules: [
		          {
		            type   : 'regExp[/^2[0-9]{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (20|21|22|23|[0-1][0-9]):[0-5][0-9]:[0-5][0-9]$/]',
		            prompt : '请输入正确时间',
		          }
		        ]
		      }
		    }
		  });
        
    </script>
</html>
