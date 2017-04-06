<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.*" %>
<%@page import="org.json.JSONObject"%> 
<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfoHandler" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfo" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="sysInfo" class="weaver.system.SystemComInfo" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<%
    String imagefilename = "/images/hdReport.gif";
    String titlename =  SystemEnv.getHtmlLabelName(24104,user.getLanguage()) + ": "+SystemEnv.getHtmlLabelName(367,user.getLanguage());
    String needfav ="1";
    String needhelp ="";
%>
<body>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/workflow/request/wfAgentStatistic.jsp,_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<%
String requestname = "";
int isgoveproj = 0;
String creatertype = "";
String createrid = "";
String requestlevel = "";
String fromdate2 = "";
String todate2 = "";

int userid = user.getUID();
String allwfids = "";
String wftypes = ",";
ArrayList wftypelist = new ArrayList();
Hashtable wfHST = new Hashtable();
Hashtable wfcountHST = new Hashtable();
int totalcount = 0;
//String sql = "select distinct a.workflowId, b.workflowtype from workflow_agent a, workflow_base b where a.workflowId=b.id and a.beagenterid="+userid+" order by workflowtype";
String sql = "select workflowtype, workflowid, count(distinct requestid) workflowcount from workflow_currentoperator where  agenttype=2 and isremark='2' and agentorbyagentid="+userid+" group by workflowtype, workflowid order by workflowtype, workflowid ";
RecordSet.executeSql(sql);
while(RecordSet.next()){//�������д�������
    String tempwfid = RecordSet.getString("workflowid");//����id
    String tempwftype = RecordSet.getString("workflowtype");//��������
    int wfcounts = Util.getIntValue(RecordSet.getString("workflowcount"),0);
    //int wfcounts = 0;
    //rs.executeSql("select count(distinct requestid) as counts from workflow_currentoperator where agenttype=2 and agentorbyagentid="+userid+" and isremark='2' and workflowid="+tempwfid);
    //if(rs.next()){
    //    wfcounts = Util.getIntValue(rs.getString("counts"),0);
    //}
    if(wfcounts==0) continue;
    
    if(wftypes.indexOf(","+tempwftype+",")>-1){
        String wfids = Util.null2String((String)wfHST.get(tempwftype));
        if(wfids.equals("")) wfids = tempwfid;
        else wfids += ","+tempwfid;
        wfHST.remove(tempwfid);
        wfHST.put(tempwftype,wfids);
    }else{
        wftypes += tempwftype + ",";
        wfHST.put(tempwftype,tempwfid);
        wftypelist.add(tempwftype);
    }
    totalcount += wfcounts;
    wfcountHST.put(tempwfid,""+wfcounts);
    if(allwfids.equals("")) allwfids = tempwfid;
    else allwfids += ","+tempwfid;
}


String allwfids1 = "";
String wftypes1 = ",";
ArrayList wftypelist1 = new ArrayList();
Hashtable wfHST1 = new Hashtable();
Hashtable wfcountHST1 = new Hashtable();
int totalcount1 = 0;
//String sql = "select distinct a.workflowId, b.workflowtype from workflow_agent a, workflow_base b where a.workflowId=b.id and a.beagenterid="+userid+" order by workflowtype";
String sql1 = "select workflowtype, workflowid, count(distinct requestid) workflowcount from workflow_currentoperator where  agenttype=2 and isremark='2' and userid="+userid+" group by workflowtype, workflowid order by workflowtype, workflowid ";
RecordSet.executeSql(sql1);
while(RecordSet.next()){//�������д�������
    String tempwfid = RecordSet.getString("workflowid");//����id
    String tempwftype = RecordSet.getString("workflowtype");//��������
    int wfcounts = Util.getIntValue(RecordSet.getString("workflowcount"),0);
    //int wfcounts = 0;
    //rs.executeSql("select count(distinct requestid) as counts from workflow_currentoperator where agenttype=2 and agentorbyagentid="+userid+" and isremark='2' and workflowid="+tempwfid);
    //if(rs.next()){
    //    wfcounts = Util.getIntValue(rs.getString("counts"),0);
    //}
    if(wfcounts==0) continue;
    
    if(wftypes1.indexOf(","+tempwftype+",")>-1){
        String wfids = Util.null2String((String)wfHST1.get(tempwftype));
        if(wfids.equals("")) wfids = tempwfid;
        else wfids += ","+tempwfid;
        wfHST1.remove(tempwfid);
        wfHST1.put(tempwftype,wfids);
    }else{
        wftypes1 += tempwftype + ",";
        wfHST1.put(tempwftype,tempwfid);
        wftypelist1.add(tempwftype);
    }
    totalcount1 += wfcounts;
    wfcountHST1.put(tempwfid,""+wfcounts);
    if(allwfids1.equals("")) allwfids1 = tempwfid;
    else allwfids1 += ","+tempwfid;
   
}
%>

<br>

<form name=frmmain method=post action="requestDetailAgentList.jsp">
<input type="hidden" id="allwfids" name="allwfids" value="<%=allwfids%>">
<input type="hidden" id="allwfids1" name="allwfids1" value="<%=allwfids1%>">
<table width=100% height=100% border="0" cellspacing="1" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
            <tr>
                <td valign="top">
                <table class="viewform">
                    <colgroup>
                    <col width="49%">
                    <col width="">
                    <col width="49%">
            
										<tr><td valign="top" colspan=3>
										<TABLE class=ViewForm>
											<TR>		
												<td><%=SystemEnv.getHtmlLabelName(21192,user.getLanguage())%></td>
												<TD CLASS="Field">
													<input type=text value="" name="requestname" class = 'InputStyle' style="width:60%"> 
													<!--<SPAN id=remind style='cursor:hand'><IMG src='/images/remind.png' align=absMiddle></SPAN>-->
												</TD>
							
												<TD WIDTH="10%"><%=SystemEnv.getHtmlLabelName(792,user.getLanguage())%></TD>
												<TD CLASS="Field">
												<!-- 
													<button class=browser onClick="onShowResource()"></button>
												 -->
												 <!-- �����button�����һ��type="button" 2012-08-15 ypc �޸� -->
												<button type="button" class=browser onClick="onShowMHrm('agentornamespan','agentorid')"></button>
												<span id="agentornamespan"></span>
												<input name="agentorid" type=hidden value="">
											</TD>
										</TR>
										<!-- ������ָ���и� �� % �� ����λ 2012-08-14 ypc �޸� -->
										<TR style="height:5%;"><td colspan="4" class="line"></td></TR>
										<!--<TR><td colspan=4 class="line"></td></TR>-->
										<TR>	
											<TD WIDTH="10%"><%=SystemEnv.getHtmlLabelName(603,user.getLanguage())%></TD>
											<TD  WIDTH="20%" CLASS="Field">
												<select class=inputstyle  name=requestlevel style=width:60% size=1>
													<option value=""> </option>
													<option value="0"><%=SystemEnv.getHtmlLabelName(225,user.getLanguage())%></option>
													<option value="1"><%=SystemEnv.getHtmlLabelName(15533,user.getLanguage())%></option>
													<option value="2"><%=SystemEnv.getHtmlLabelName(2087,user.getLanguage())%></option>
												</select>
											</TD>
											<TD WIDTH="10%"><%=SystemEnv.getHtmlLabelName(19680,user.getLanguage())%></TD>
											<TD width ="20%" CLASS="Field"> 
												<!-- 2012-08-23 ypc �˴���button ��Ҫ ��� type���� ָ����������button -->
												<BUTTON type="button" class=calendar id=SelectDate3  onclick="gettheDate(fromdate,fromdatespan)"></BUTTON>
												<SPAN id=fromdatespan></SPAN>
												-&nbsp;&nbsp;
												<!-- 2012-08-23 ypc �˴���button ��Ҫ ��� type���� ָ����������button -->
												<BUTTON type="button" class=calendar id=SelectDate4 onclick="gettheDate(todate,todatespan)"></BUTTON>
												<SPAN id=todatespan ></SPAN>
												<input type="hidden" name="fromdate" value="">
												<input type="hidden" name="todate" value="">
											</TD>
										</TR>
										<!-- ������ָ���и� �� % �� ����λ 2012-08-14 ypc �޸� -->
										<TR style="height:5%;"><td colspan="4" class="line"></td></TR>
										<!--<TR><td colspan=4 class="line"></td></TR>-->
										<TR>
											<TD WIDTH="10%"><%=SystemEnv.getHtmlLabelName(24535,user.getLanguage())%></TD>
											<TD  WIDTH="20%" CLASS="Field">
												<select class=inputstyle  name=agenttype style=width:60% size=1>
													<option value=""> </option>
													<option value="2"><%=SystemEnv.getHtmlLabelName(24536,user.getLanguage())%></option>
													<option value="1"><%=SystemEnv.getHtmlLabelName(24537,user.getLanguage())%></option>
												</select>
											</TD>
										</TR>
									</TABLE>
								</td></tr>                    
                    
                    <tr style="height:5%;"><td class="line" colspan="3"></td></tr>
                    
                    <tr>
                    <td valign=top>
 					 <table class="viewform">
                    
                    
                    <tr class="Title" ><th><%=SystemEnv.getHtmlLabelName(24536,user.getLanguage())%>:<%=totalcount%></th></tr>
                    <!-- 2012-08-14 ypc �޸� -->
                    <tr style="height:5%;"><td class="Line1"></td></tr>
                    <tr>
                        <%
                        //int leftmum = wftypelist.size()/2;
                        //if(wftypelist.size()%2!=0) leftmum+=1;
                        int leftmum = wftypelist.size();
                        %>
                        <td valign=top>
                            <table class="viewform">
                                
                                <%
                                for(int i=0;i<leftmum;i++){
                                    String tempwftypeid = (String)wftypelist.get(i);
                                    String tempwftypename = WorkTypeComInfo.getWorkTypename(tempwftypeid);
                                %>
                                <tr>
                                    <td>
                                        <UL>
                                                <LI><a><%=tempwftypename%></a>
                                                <%
                                                String wfids = Util.null2String((String)wfHST.get(tempwftypeid));
                                                ArrayList wfidsArr = Util.TokenizerString(wfids,",");
                                                %>
                                                <UL>
                                                <%
                                                for(int j=0;j<wfidsArr.size();j++){
                                                    String tempwfid = (String)wfidsArr.get(j);
                                                    String tempwfname = WorkflowComInfo.getWorkflowname(tempwfid);
                                                    int tempcounts = Util.getIntValue((String)wfcountHST.get(tempwfid),0);
                                                %>
                                                <LI><a href="requestDetailAgentList.jsp?workflowid=<%=tempwfid%>&agenttype=2"><%=tempwfname%>(<%=tempcounts%>)</a>
                                                <%}%>
                                                </UL>
                                        </UL>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                        <td></td>
                        
                        </table>
						</td>
                        
                        
                        
                        <td valign=top>
 					 <table class="viewform">
                    
                    
                    <tr class="Title" ><th><%=SystemEnv.getHtmlLabelName(24537,user.getLanguage())%>:<%=totalcount1%></th></tr>
                    <!-- 2012-08-14 ypc �޸� -->
                    <tr style="height:5%;"><td class="Line1"></td></tr>
                    <tr>
                        <%
                        //int leftmum = wftypelist.size()/2;
                        //if(wftypelist.size()%2!=0) leftmum+=1;
                        int leftmum1 = wftypelist1.size();
                        %>
                        <td valign=top>
                            <table class="viewform">
                                
                                <%
                                for(int i=0;i<leftmum1;i++){
                                    String tempwftypeid = (String)wftypelist1.get(i);
                                    String tempwftypename = WorkTypeComInfo.getWorkTypename(tempwftypeid);
                                %>
                                <tr>
                                    <td>
                                        <UL>
                                                <LI><a><%=tempwftypename%></a>
                                                <%
                                                String wfids = Util.null2String((String)wfHST1.get(tempwftypeid));
                                                ArrayList wfidsArr = Util.TokenizerString(wfids,",");
                                                %>
                                                <UL>
                                                <%
                                                for(int j=0;j<wfidsArr.size();j++){
                                                    String tempwfid = (String)wfidsArr.get(j);
                                                    String tempwfname = WorkflowComInfo.getWorkflowname(tempwfid);
                                                    int tempcounts = Util.getIntValue((String)wfcountHST1.get(tempwfid),0);
                                                %>
                                                <LI><a href="requestDetailAgentList.jsp?workflowid=<%=tempwfid%>&agenttype=1"><%=tempwfname%>(<%=tempcounts%>)</a>
                                                <%}%>
                                                </UL>
                                        </UL>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                        <td></td>
                        
                        </table>
						</td>
                        
                        </tr>
                      </tr>

                                            
                </table>

                </td>
            </tr>
            <tr>
                <td height="10"></td>
            </tr>
        </table>
    </td>
    <td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>

</form>
<!--
<script language=vbs>
    sub onShowResource()
        id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
        if NOT isempty(id) then
            if id(0)<> "" then
                agentornamespan.innerHtml = id(1)
                frmmain.agentorid.value=id(0)
            else
                agentornamespan.innerHtml = ""
                frmmain.agentorid.value=""
            end if
        end if
    end sub

	sub onShowMHrm(spanname,inputename)
		tmpids = document.all(inputename).value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&tmpids)
		if (Not IsEmpty(id1)) then
				if id1(0)<> "" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all(inputename).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&curname&"&nbsp"
					wend
					sHtml = sHtml&resourcename&"&nbsp"
					document.all(spanname).innerHtml = sHtml
					
				else
					document.all(spanname).innerHtml =""
					document.all(inputename).value=""
				end if
				end if
	end sub
</script>  -->
</body>
</html>

<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
<!-- vbsת������ ����onShowMHrm() 2012-08-15 ypc �޸�-->
<script language="javascript">
	function onShowMHrm(spanname,inputename){
	    tmpids = $GetEle(inputename).value
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="+tmpids)
		if (data){
			if(data.id!=""){
				resourceids = data.id
				resourcename = data.name
				var sHtml = ""
				
				resourceids = resourceids.substring(1);
				$GetEle(inputename).value= resourceids
				resourcename = resourcename.substring(1);
				  var ids = resourceids.split(",");
				  var  names =resourcename.split(",");
				  for( var i=0;i<ids.length;i++){
				      if(ids[i]!=""){
				       sHtml = sHtml+"<a href='/hrm/resource/HrmResource.jsp?id="+ids[i]+"'  >"+names[i]+"</a>&nbsp";
				      }
				 }
				$GetEle(spanname).innerHTML = sHtml
				
			}else{
				$GetEle(spanname).innerHTML =""
				$GetEle(inputename).value=""
			}
		}
	}
</script>
<script type="text/javascript">
    function doSearch(){
        frmmain.submit();
    }
</script>		    