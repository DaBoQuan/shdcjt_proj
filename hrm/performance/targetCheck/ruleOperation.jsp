<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="weaver.general.SessionOper" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="weaver.hrm.performance.goal.GoalUtil" %> 

<%@ include file="/systeminfo/init.jsp" %>
<%
String cycle = Util.null2String(request.getParameter("cycle"));
String checkDate = Util.null2String(request.getParameter("checkDate"));
String checkType = Util.null2String(request.getParameter("checkType"));

//���ö�������(deptId|hrmId|postId)
String objBeRuled = Util.null2String(request.getParameter("objBeRuled"));
//���ö���ID
int objId = Util.getIntValue(request.getParameter("objId"));
//��������:
String objByRuled = "formular"+objBeRuled;


//**********************************************
//������
cycle = "3";
checkDate = "2006";
checkType = "3";
objBeRuled = "hrmId";
objId = 8;
//**********************************************


String conditions = "";
String formula = "";
boolean conditionsResult = true;
String formulaHrmId = "";
String formulaPostId = "";
String formulaDeptId = "";
String hrmId = "";
String postId = "";
String deptId = "";
String sql = "";


weaver.hrm.performance.targetcheck.RuleOperation r = new weaver.hrm.performance.targetcheck.RuleOperation();
r.revisePointByRule(objId, checkType, cycle, checkDate);
%>






