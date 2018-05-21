<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Utils.*, org.apache.poi.hssf.usermodel.HSSFCell,
	org.apache.poi.hssf.usermodel.HSSFRow,
	org.apache.poi.hssf.usermodel.HSSFSheet,
	org.apache.poi.hssf.usermodel.HSSFWorkbook,
	org.apache.poi.ss.util.CellRangeAddress,
	java.io.OutputStream"%>
<%@include file="./checkadmin.jsp"%>
<%@include file="./checkenrollparam.jsp"%>
<%
	/**对比赛项目传参的安全检验*/
	if(index > resMatchType.size())
	{
		response.sendRedirect("./adminerror.jsp?error=" + java.net.URLEncoder.encode("参数错误！", "UTF-8"));
		return;
	}
	
	ArrayList<EnrollTable> enrolllist = new ArrayList<EnrollTable>();
	enrolllist = new DaoUtils().selectAllEnrollTable(resMatchType.get(index));
			
	if(enrolllist.size() == 0)
	{
		response.sendRedirect("./adminerror.jsp?error=" + java.net.URLEncoder.encode("无报名信息！", "UTF-8"));
		return;
	}
	
	//创建HSSFWorkbook对象(excel的文档对象)
	HSSFWorkbook wb = new HSSFWorkbook();
	//建立新的sheet对象（excel的表单）
	HSSFSheet sheet=wb.createSheet(enrolllist.get(0).getMatchname());
	//在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
	HSSFRow row1=sheet.createRow(0);
	//创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
	HSSFCell cell=row1.createCell(0);
	//设置单元格内容
	cell.setCellValue(enrolllist.get(0).getMatchname());
	//合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
	sheet.addMergedRegion(new CellRangeAddress(0,0,0,6));
	for(int i = 0;i<enrolllist.size(); ++i)
	{
		HSSFRow rowt1 = sheet.createRow(i*8+1);
		//作品名称
		rowt1.createCell(0).setCellValue("作品名称:");;
		rowt1.createCell(1).setCellValue(enrolllist.get(i).getProjectname());
		sheet.addMergedRegion(new CellRangeAddress(i*8+1,i*8+1,1,3));
		//团队名称
		rowt1.createCell(4).setCellValue("团队名称:");
		rowt1.createCell(5).setCellValue(enrolllist.get(i).getTeamname());
		sheet.addMergedRegion(new CellRangeAddress(i*8+1,i*8+1,5,6));
		
		HSSFRow rowt2 = sheet.createRow(i*8+2);
		//指导老师
		rowt2.createCell(0).setCellValue("指导老师:");
		rowt2.createCell(1).setCellValue(enrolllist.get(i).getTeachername());
		sheet.addMergedRegion(new CellRangeAddress(i*8+2,i*8+2,1,6));
		//第三行
		HSSFRow rowt3 = sheet.createRow(i*8+3);
		rowt3.createCell(0).setCellValue("角色");
		rowt3.createCell(1).setCellValue("姓名");
		rowt3.createCell(2).setCellValue("学号");
		rowt3.createCell(3).setCellValue("年级专业");
		rowt3.createCell(4).setCellValue("QQ");
		rowt3.createCell(5).setCellValue("微信");
		rowt3.createCell(6).setCellValue("手机");
		//第四行
		HSSFRow rowt4 = sheet.createRow(i*8+4);
		rowt4.createCell(0).setCellValue("组长:");
		rowt4.createCell(1).setCellValue(enrolllist.get(i).getName1());
		rowt4.createCell(2).setCellValue(enrolllist.get(i).getNumber1());
		rowt4.createCell(3).setCellValue(enrolllist.get(i).getGrade1());
		rowt4.createCell(4).setCellValue(enrolllist.get(i).getQq1());
		rowt4.createCell(5).setCellValue(enrolllist.get(i).getWechat1());
		rowt4.createCell(6).setCellValue(enrolllist.get(i).getPhone1());
		//第五行
		HSSFRow rowt5 = sheet.createRow(i*8+5);
		rowt5.createCell(0).setCellValue("组员1:");
		rowt5.createCell(1).setCellValue(enrolllist.get(i).getName2());
		rowt5.createCell(2).setCellValue(enrolllist.get(i).getNumber2());
		rowt5.createCell(3).setCellValue(enrolllist.get(i).getGrade2());
		rowt5.createCell(4).setCellValue(enrolllist.get(i).getQq2());
		rowt5.createCell(5).setCellValue(enrolllist.get(i).getWechat2());
		rowt5.createCell(6).setCellValue(enrolllist.get(i).getPhone2());
		//第六行
		HSSFRow rowt6 = sheet.createRow(i*8+6);
		rowt6.createCell(0).setCellValue("组员2:");
		rowt6.createCell(1).setCellValue(enrolllist.get(i).getName3());
		rowt6.createCell(2).setCellValue(enrolllist.get(i).getNumber3());
		rowt6.createCell(3).setCellValue(enrolllist.get(i).getGrade3());
		rowt6.createCell(4).setCellValue(enrolllist.get(i).getQq3());
		rowt6.createCell(5).setCellValue(enrolllist.get(i).getWechat3());
		rowt6.createCell(6).setCellValue(enrolllist.get(i).getPhone3());
		//第七行
		HSSFRow rowt7 = sheet.createRow(i*8+7);
		rowt7.createCell(0).setCellValue("作品链接:");
		rowt7.createCell(1).setCellValue(enrolllist.get(i).getDropboxurl());
		sheet.addMergedRegion(new CellRangeAddress(i*8+7,i*8+7,1,4));
		rowt7.createCell(5).setCellValue("链接密码:");
		rowt7.createCell(6).setCellValue(enrolllist.get(i).getBoxpassword());
	}
	//输出Excel文件
    OutputStream output=response.getOutputStream();
    response.reset();
    response.setHeader("Content-disposition", "attachment; filename="+ URLEncoder.encode(resMatchType.get(index).getMatchname(), "UTF-8") +".xls");
    response.setContentType("application/msexcel");        
    wb.write(output);
    output.close();
%>