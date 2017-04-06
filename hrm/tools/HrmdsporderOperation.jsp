<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="OrganisationCom" class="weaver.rtx.OrganisationCom" scope="page" />

<%
int userid=user.getUID();

String method = request.getParameter("method");
String departmentid = Util.fromScreen(request.getParameter("departmentid"),user.getLanguage()) ;
String subcompanyid1 = Util.fromScreen2(request.getParameter("subcompanyid1"),user.getLanguage());
//String resourcename = Util.null2String(request.getParameter("resourcename")) ;
//if(!resourcename.equals("")) session.setAttribute("resourcenameAAA",resourcename);
if(method.equals("SaveOrder")){
	if(!HrmUserVarify.checkUserRight("Hrmdsporder:Add",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
	String ids=Util.fromScreen(request.getParameter("ids"),user.getLanguage()) ;
	String dsporderdb=Util.fromScreen(request.getParameter("dsporderdb"),user.getLanguage()) ;
	String id = "";
	String dsporderValue = "";
	String dsporderdbValue = "";
	ArrayList idsArray = Util.TokenizerString(ids, ",");
	ArrayList dsporderdbArray = Util.TokenizerString(dsporderdb, ",");
	for(int i=0;i<idsArray.size();i++){
        id = (String)idsArray.get(i);
        dsporderdbValue = (String)dsporderdbArray.get(i);//���ݿ������ֵ
        dsporderValue = Util.null2String(request.getParameter("dsporder_"+id));//ҳ���ϵ�ֵ
	    if(!dsporderdbValue.equals(dsporderValue)){
			String SaveOrdersql =  "update hrmresource set dsporder="+dsporderValue+" where id="+id;
			RecordSet.executeSql(SaveOrdersql) ;
			
				//ͬ��RTX�˵��û���Ϣ.
				boolean checkrtxuser = OrganisationCom.checkUser(Integer.parseInt(id));//����û��Ƿ����
				if(checkrtxuser){   //���ھͱ༭�������ھ�����
					OrganisationCom.editUser(Integer.parseInt(id));//�༭
				} else {
					OrganisationCom.addUser(Integer.parseInt(id));//����
				}
	   }
	}
	response.sendRedirect("/hrm/tools/Hrmdsporder.jsp?departmentid="+departmentid+"&subcompanyid1="+subcompanyid1) ;
}
else if(method.equals("Edit")){
	if(!HrmUserVarify.checkUserRight("HrmdsporderEdit:Edit",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
}
String id=Util.fromScreen(request.getParameter("id"),user.getLanguage()) ;
String dsporder=Util.fromScreen(request.getParameter("dsporder"),user.getLanguage()) ;
String sql="update hrmresource set dsporder="+dsporder+" where id="+id ;
RecordSet.executeSql(sql) ;

//ͬ��RTX�˵��û���Ϣ.
	boolean checkrtxuser = OrganisationCom.checkUser(Integer.parseInt(id));//����û��Ƿ����
	if(checkrtxuser){   //���ھͱ༭�������ھ�����
		OrganisationCom.editUser(Integer.parseInt(id));//�༭
	} else {
		OrganisationCom.addUser(Integer.parseInt(id));//����
	}

response.sendRedirect("Hrmdsporder.jsp") ;
}
%>