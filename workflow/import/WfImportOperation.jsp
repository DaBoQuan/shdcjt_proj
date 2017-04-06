<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.file.*,javax.servlet.jsp.JspWriter" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowDataService" class="weaver.workflow.imports.services.WorkflowDataService" scope="page" />

<%!
String getImportTitle(int type)
{
	String title = "";
	switch(type)
	{
		case 0:
			title = "htmllabel";
			break;
		case 1:
			title = "���򵥾ݻ�������";
			break;
		case 2:
			title = "�ϱ��ֶ�";
			break;
		case 3:
			title = "�ϱ���ϸ�ֶ�";
			break;
		case 4:
			title = "���򵥾��ֶ�";
			break;
		case 5:
			title = "select�ֶ���Ϣ";
			break;
		case 6:
			title = "�����ֶ���Ϣ";
			break;
		case 7:
			title = "�ֶι�����Ϣ";
			break;
		case 8:
			title = "��������";
			break;
		case 9:
			title = "���̻�����Ϣ����";
			break;
		case 10:
			title = "�ڵ������Ϣ";
			break;
		case 11:
			title = "�ڵ�����";
			break;
		case 12:
			title = "��־�鿴��Χ";
			break;
		case 13:
			title = "�ڵ�����";
			break;
		case 14:
			title = "�ڵ��Զ����Ҽ�";
			break;
		case 15:
			title = "�ڵ�󸽼�����";
			break;
		case 16:
			title = "�ڵ�ģ������";
			break;
		case 17:
			title = "ģ��ģʽ�ֶ�����";
			break;
		case 18:
			title = "htmlģʽ�ֶ�����";
			break;
		case 19:
			title = "�ڵ��ֶΣ�һ��ģʽ��";
			break;
		case 20:
			title = "��ϸ�ֶ�4������";
			break;
		case 21:
			title = "�ڵ��������";
			break;
		case 22:
			title = "������Ϣ";
			break;
		case 23:
			title = "���ܹ���";
			break;
		case 24:
			title = "���̼ƻ�";
			break;
		case 25:
			title = "�����ֶ�";
			break;
		case 26:
			title = "���̱��";
			break;
		case 27:
			title = "��������";
			break;
		case 28:
			title = "���̴����ĵ�";
			break;
		case 29:
			title = "������";
			break;
		case 30:
			title = "����ת�ƻ�����";
			break;
		case 31:
			title = "����ת�ճ�";
			break;
		case 32:
			title = "����ת�ĵ�";
			break;
		case 33:
			title = "��ʾ��������";	
			break;
		case 34:
			title = "�ֶ�����";
			break;
		default:
			title = "";
			break;
	}
	return title;
		
}
%>
<%
String acceptlanguage = request.getHeader("Accept-Language");
if(!"".equals(acceptlanguage))
	acceptlanguage = acceptlanguage.toLowerCase();

if(!HrmUserVarify.checkUserRight("WorkflowManage:All", user))
{
	response.sendRedirect("/notice/noright.jsp");
	return;
}
FileUpload fu = new FileUpload(request,false);
FileManage fm = new FileManage();

String xmlfilepath="";
int fileid = 0 ;
String remoteAddr = fu.getRemoteAddr();
fileid = Util.getIntValue(fu.uploadFiles("filename"),0);
String type = Util.null2String(fu.getParameter("type"));
String filename = fu.getFileName();

String sql = "select filerealpath from imagefile where imagefileid = "+fileid;
RecordSet.executeSql(sql);
String uploadfilepath="";
if(RecordSet.next()) uploadfilepath =  RecordSet.getString("filerealpath");
String exceptionMsg ="";
if(!uploadfilepath.equals(""))
{
	try
	{
		xmlfilepath = GCONST.getRootPath()+"workflow/import"+File.separatorChar+filename ;
		//System.out.println("xmlfilepath : "+xmlfilepath);
		File oldfile = new File(xmlfilepath);
		if(oldfile.exists())
		{
			oldfile.delete();
		}
		fm.copy(uploadfilepath,xmlfilepath);
	}
	catch(Exception e)
	{
		exceptionMsg = "��ȡ�ļ�ʧ��!";
	}
}
WorkflowDataService.setRemoteAddr(remoteAddr);
WorkflowDataService.setUser(user);
WorkflowDataService.setType(type);
WorkflowDataService.importWorkflowByXml(xmlfilepath);
String workflowid = WorkflowDataService.getWorkflowid();
String formid = WorkflowDataService.getFormid();
String isbill = WorkflowDataService.getIsbill();
Map fieldMap = WorkflowDataService.getFieldMap();
Map nodeMap = WorkflowDataService.getNodeMap();
List oldFieldIds = new ArrayList();
List newFieldIds = new ArrayList();
if(null!=fieldMap)
{
	Set oldIds = fieldMap.keySet();
	for(Iterator it = oldIds.iterator();it.hasNext();)
	{
		String fieldid = (String)it.next();
		
		oldFieldIds.add(fieldid);
		newFieldIds.add(fieldMap.get(fieldid));
	}
}

List oldNodeIds = new ArrayList();
List newNodeIds = new ArrayList();
if(null!=nodeMap)
{
	Set oldIds = nodeMap.keySet();
	for(Iterator it = oldIds.iterator();it.hasNext();)
	{
		String nodeid = (String)it.next();
		
		oldNodeIds.add(nodeid);
		newNodeIds.add(nodeMap.get(nodeid));
	}
}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>  
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
<%if(acceptlanguage.indexOf("zh-tw")>-1||acceptlanguage.indexOf("zh-hk")>-1){%>
<script language=javascript src="/workflow/mode/chinaexcelweb_tw.js"></script>
<%}else{%>
<script language=javascript src="/workflow/mode/chinaexcelweb.js"></script>
<%} %>
<script language=javascript>
function displayExcel()
{
	var divs = document.getElementsByTagName("div");
	if(divs)
	{
		divs[0].style.display="none";
	}
}
var oldFieldIds = new Array();
var newFieldIds = new Array();

<%
for(int i=0;i<oldFieldIds.size();i++)
{
	String id = (String)oldFieldIds.get(i);
%>
	oldFieldIds.push(<%=id%>);
<%
}
%>
<%
for(int i=0;i<newFieldIds.size();i++)
{
	String id = (String)newFieldIds.get(i);
%>
	newFieldIds.push(<%=id%>);
<%
}
%>
var oldNodeIds = new Array();
var newNodeIds = new Array();
<%
for(int i=0;i<oldNodeIds.size();i++)
{
	String id = (String)oldNodeIds.get(i);
%>
	oldNodeIds.push(<%=id%>);
<%
}
%>
<%
for(int i=0;i<newNodeIds.size();i++)
{
	String id = (String)newNodeIds.get(i);
%>
	newNodeIds.push(<%=id%>);
<%
}
%>
function getIndex(newids,oldids,oldid)
{
	var newid = "";
	var index = -1;
	try
	{
		for (i = 0; i < oldids.length; i++)
	   	{
	   		var tempoldid = oldids[i];
	   		if(oldid==tempoldid)
	   		{
	   			index = i;
	   		}
	   	}
	   	if(index>-1)
	   	{
	   		newid = newids[index];
	   	}
   	}
   	catch(e)
   	{
   	}
   	return newid;
}
function readmode()
{
<%
RecordSet.executeSql("select * from workflow_formmode where formid="+formid+" and isbill="+isbill);
int selectSize = RecordSet.getCounts();
while(RecordSet.next())
{
	String modeid = RecordSet.getString("id");
	String isprint = RecordSet.getString("isprint");
%>
	CellWeb1.ReadHttpFile("/workflow/mode/ModeReader.jsp?modeid=<%=modeid%>&isform=<%=isbill%>");
	//CellWeb1.ReadHttpFile("/workflow/mode/ModeReader.jsp?modeid=<%=modeid%>&isform=1");
    var Cols = CellWeb1.GetMaxCol();
    var Rows = CellWeb1.GetMaxRow();
    
    for(var i = 1;i<=Cols;i++)
    {
    	for(var j = 1;j<=Rows;j++)
    	{
    		var isProtect = CellWeb1.IsCellProtect(j,i);
    		CellWeb1.SetCellProtect(j,i,j,i,false);
    		var cellvalue = CellWeb1.GetCellUserStringValue(j,i);
    		cellvalue = cellvalue.replace(/(^\s*)|(\s*$)/g, "");
    		if(cellvalue.length>1)
    		{
    			if(cellvalue.indexOf("field")==0)
    			{
    				var oldid = cellvalue.substring(5,cellvalue.indexOf("_"));
    				
    				var newid = getIndex(newFieldIds,oldFieldIds,oldid);
    				if(newid!="")
    				{
    					cellvalue = cellvalue.replace("field"+oldid+"_","field"+newid+"_")
    					CellWeb1.SetCellUserStringValue(j,i,j,i,cellvalue);
    					
    				}
    			}
    			else if(cellvalue.indexOf("wfl")==0)
    			{
    				var oldid = cellvalue.substring(cellvalue.indexOf("_")+1,cellvalue.length);
    				var newid = getIndex(newNodeIds,oldNodeIds,oldid);
    				if(newid!="")
    				{
    					//cellvalue = cellvalue.replace("_"+oldid,"_"+newid)
    					cellvalue = "wfl<%=workflowid%>_"+newid;
    					CellWeb1.SetCellUserStringValue(j,i,j,i,cellvalue);
    				}
    			}
    		}
    		CellWeb1.SetCellProtect(j,i,j,i,isProtect);
    	}
    }
    var modestring = CellWeb1.SaveDataAsZipText();
    alert("��һ�������� "+<%=selectSize%>+" ��ִ�о��ܵ���ɹ�����ȴ������ȷ����");
    //saveNewMode('<%=modeid%>','<%=isprint%>',modestring);
    saveNewMode('<%=modeid%>','<%=isprint%>',modestring,"<%=isbill%>");
<%
selectSize--;
}
RecordSet.executeSql("select * from workflow_nodemode where workflowid = "+workflowid+" and formid="+formid);
selectSize = RecordSet.getCounts();
while(RecordSet.next())
{
	String modeid = RecordSet.getString("id");
	String nodeid = RecordSet.getString("nodeid");
	String isprint = RecordSet.getString("isprint");
	
%>
	
    CellWeb1.ReadHttpFile("/workflow/mode/ModeReader.jsp?modeid=<%=modeid%>&nodeid=<%=nodeid%>&isform=0");
    var Cols = CellWeb1.GetMaxCol();
    var Rows = CellWeb1.GetMaxRow();
    for(var i = 1;i<=Cols;i++)
    {
    	for(var j = 1;j<=Rows;j++)
    	{
    		var isProtect = CellWeb1.IsCellProtect(j,i);
    		CellWeb1.SetCellProtect(j,i,j,i,false);
    		var cellvalue = CellWeb1.GetCellUserStringValue(j,i);
    		cellvalue = cellvalue.replace(/(^\s*)|(\s*$)/g, "");
    		if(cellvalue.length>1)
    		{
    			if(cellvalue.indexOf("field")==0)
    			{
    				var oldid = cellvalue.substring(5,cellvalue.indexOf("_"));
    				
    				var newid = getIndex(newFieldIds,oldFieldIds,oldid);
    				if(newid!="")
    				{
    					cellvalue = cellvalue.replace("field"+oldid+"_","field"+newid+"_");
    					CellWeb1.SetCellUserStringValue(j,i,j,i,cellvalue);
    				}
    			}
    			else if(cellvalue.indexOf("wfl")==0)
    			{
    				var oldid = cellvalue.substring(cellvalue.indexOf("_")+1,cellvalue.length);
    				var newid = getIndex(newNodeIds,oldNodeIds,oldid);
    				if(newid!="")
    				{
    					//cellvalue = cellvalue.replace("_"+oldid,"_"+newid)
    					cellvalue = "wfl<%=workflowid%>_"+newid;
    					CellWeb1.SetCellUserStringValue(j,i,j,i,cellvalue);
    				}
    			}
    		}
    		CellWeb1.SetCellProtect(j,i,j,i,isProtect);
    	}
    }
    var modestring = CellWeb1.SaveDataAsZipText();
    alert("�ڶ��������� "+<%=selectSize%>+" ��ִ�о��ܵ���ɹ�����ȴ������ȷ����");
    //saveNewMode('<%=modeid%>','<%=isprint%>',modestring);
    saveNewMode('<%=modeid%>','<%=isprint%>',modestring,"0");
<%
selectSize--;
}
%>
}
function saveNewMode(modeid,isprint,modestring,isform)
{
	var xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
	xmlHttp.onreadystatechange = function()
	{
		if (xmlHttp.readyState == 4) 
		{
	    }
	}
	xmlHttp.open("POST", "/workflow/export/wf_operationxml.jsp", true);
	xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	modestring = escape(modestring).replace(/\+/g, '%2B').replace(/\"/g,'%22').replace(/\'/g, '%27').replace(/\//g,'%2F')
	//xmlHttp.send("src=savemode&modeid="+modeid+"&isprint="+isprint+"&modestring="+modestring);
	xmlHttp.send("src=savemode&isform="+isform+"&modeid="+modeid+"&isprint="+isprint+"&modestring="+modestring);
}
readmode();
</script>
</head>
<BODY onload="displayExcel();">
	<%
	out.println("<TABLE class=liststyle><COLGROUP><COL width='25%'><COL width='25%'><COL width='30%'><COL width='15%'><COL width='5%'><TR class=Title><TH colSpan=5>������</TH></TR><TR class=Spacing><TD class=Line1 colSpan=5></TD></TR>");

   	out.println("<tr>");
    out.println("<td><a href='/system/basedata/basedata_workflow.jsp?wfid="+workflowid+"' target='_blank'>�鿴�������̻�������</a></td>");
    out.println("<td></td>");
    out.println("<td></td>");
    out.println("<td></td>");
    out.println("<td></td>");
    out.println("</tr>");
    out.println("");
	
	exceptionMsg = Util.null2String(WorkflowDataService.getExceptionMsg());
	Map MsgMap = WorkflowDataService.getMsgMap();
	out.println("<TABLE class=liststyle><COLGROUP><COL width='25%'><COL width='25%'><COL width='30%'><COL width='15%'><COL width='5%'><TR class=Title><TH colSpan=5>������</TH></TR><TR class=Spacing><TD class=Line1 colSpan=5></TD></TR>");

   	out.println("<tr class=header>");
    out.println("<td>����id</td>");
    out.println("<td>����</td>");
    out.println("<td>����</td>");
    out.println("<td>����</td>");
    out.println("<td>����״̬</td>");
    out.println("</tr>");
    boolean islight=false;
    String bgcolorvalue="#f5f5f5";
    if(MsgMap!=null)
    {
	    if (MsgMap.size() > 0) 
	    {
	    	List MsgList = new ArrayList(); 
	    	Map msg = new HashMap();
	    	String status = "";
	    	String title = "";
	    	for(int i = 0;i<35;i++)
	    	{
	    		MsgList = (List)MsgMap.get(""+i);
	    		if(MsgList!=null)
	    		{
	    			if(MsgList.size()>0)
	    			{
	    				title = getImportTitle(i);
	    				out.println("<TR class=Title><TH colSpan=5>"+title+"</TH></TR><TR class=Spacing><TD class=Line1 colSpan=5></TD></TR>");
	    				for(int j=0;j<MsgList.size();j++)
		                {
		                	if(islight){
		                        bgcolorvalue="#f5f5f5";
		                        islight=!islight;
		                    }else{
		                        bgcolorvalue="#e7e7e7";
		                        islight=!islight;
		                    }
		                	msg.clear();
		                	msg = (Map)MsgList.get(j);
		                	status = (String)msg.get("status");
		                	if(status.equals("1"))
		                	{
		                		status = "�ɹ�";
		                	}
		                	else
		                	{
		                		status = "ʧ��";
		                	}
		    	            out.println("<tr bgcolor="+bgcolorvalue+">");
		    	            out.println("<td>"+msg.get("key")+"</td>");
		    	            out.println("<td>"+msg.get("tablename")+"</td>");
		    	            out.println("<td style='word-break:break-all;'>"+msg.get("msgname")+"</td>");
		    	            out.println("<td style='word-break:break-all;'>"+msg.get("desc")+"</td>");
		    	            out.println("<td>"+status+"</td>");
		    	            out.println("</tr>");
		                }
	    			}
	     		
	    		}
	    	}
	    }
    }
    if(islight){
        bgcolorvalue="#f5f5f5";
        islight=!islight;
    }else{
        bgcolorvalue="#e7e7e7";
        islight=!islight;
    }
    //System.out.println("exceptionMsg : "+exceptionMsg);
    if(!exceptionMsg.equals(""))
    {
    	out.println("<tr bgcolor="+bgcolorvalue+">");
        out.println("<td colSpan=5>"+exceptionMsg+"</td>");
        out.println("</tr>");
    }
    out.println("<TR><TD class=Line colSpan=5></TD></TR></table>");
%>
</BODY>
</HTML>