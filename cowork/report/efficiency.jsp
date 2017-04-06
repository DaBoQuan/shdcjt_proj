<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="CoTypeComInfo" class="weaver.cowork.CoTypeComInfo" scope="page"/>
<%@ include file="/systeminfo/init.jsp" %>

<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%
	//����������� ��
	String imagefilename = "/images/hdDOC.gif";
	String titlename = SystemEnv.getHtmlLabelName(24966,user.getLanguage());
	String needfav ="1";
    String needhelp ="";
%>

<HTML>
  <HEAD>
  	<!--JS��Css�������� -->  	
    <LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
    <script language="javascript" type="text/javascript" src="/js/jquery/jquery.js"></script>
    <script type="text/javascript" src="/cowork/js/cowork.js"></script>
  </HEAD>
  <BODY>
  	
  	<!--������-->  	
    <%@ include file="/systeminfo/TopTitle.jsp" %>
    
    
    <!--�˵���-->
	<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
	<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(this)',_top} " ;
    RCMenuHeight += RCMenuHeightStep ;
	%>
	<%@ include file="/systeminfo/RightClickMenu.jsp" %>
	<%
		int interval = Util.getIntValue(request.getParameter("interval"),10);
		String intervalType = Util.null2String(request.getParameter("intervalType"));
		String jointype = Util.null2String(request.getParameter("jointype"));
		String principal = Util.null2String(request.getParameter("principal"));
		String typeid = Util.null2String(request.getParameter("typeid"));
	%>
	
	
	
    <TABLE width=100% height=100% border="0" cellspacing="0" cellpadding="0">
      <colgroup>
        <col width="10">
          <col width="">
            <col width="10">
              <tr>
                <td height="10" colspan="3"></td>
              </tr>
              <tr>
                <td></td>
                <td valign="top">             
                	<TABLE class=Shadow>
                    <tr>
                      <td valign="top">
                      		<form name="frmSearch" action="efficiency.jsp">
                      			<TABLE class="viewform">
                      				<tr>
				                      <td width="20%" >������</td>
				                      <td class="field">
											 <button type="button" class=browser onclick="onShowResourceOnly('principal','spanPrincipal')"></button>		 
											 <span id="spanPrincipal"><%=ResourceComInfo.getResourcename(principal)%></span>
											 <input type=hidden name="principal"  id="principal" value="<%=principal%>">
									  </td>
				                     </tr>
				                     <TR style="height: 1px"><TD class=Line colspan=2></TD></TR> 
				                    <tr>
				                      <td width="20%" >ʱ����</td>
				                      <td class="field">
											<input class="inputstyle"   name="interval" value="<%=interval%>">
											<select name="intervalType" id="intervalType">
												<option value="d" <%if("d".equals(intervalType)||"".equals(intervalType)) out.println(" selected "); %>>��</option>
												<option value="m" <%if("m".equals(intervalType)) out.println(" selected "); %>>��</option>
												<option value="y" <%if("y".equals(intervalType)) out.println(" selected "); %>>��</option>
											</select>
									  </td>
				                     </tr>
				                     <TR style="height: 1px"><TD class=Line colspan=2></TD></TR> 
				                     <tr>
				                      <td>δ��������</td>
				                      	<td class="field">
											<select name="jointype" id="jointype"> 
												<option value="principal" <%if("principal".equals(jointype)||"".equals(jointype)) out.println(" selected "); %>>������δ����</option>
												<option value="part" <%if("part".equals(jointype)) out.println(" selected "); %>>������δ����</option>
											 </select>											
										</td>
				                     </tr>
				                     <TR style="height: 1px"><TD class=Line colspan=5></TD></TR> 
				                     <tr>
				                      <td>Э������</td>
				                      	<td class="field">
											<select name="typeid" id="typeid">
											 <option value="" <%if("".equals(typeid)){%> selected <%}%> >---</option> 
											<%				
									            while(CoTypeComInfo.next()){
									                String tmptypeid=CoTypeComInfo.getCoTypeid();
									                String typename=CoTypeComInfo.getCoTypename();   
									        %>
									          <option value="<%=tmptypeid%>" <%if(tmptypeid.equals(""+typeid)){%> selected <%}%> ><%=typename%></option>
									        <%
									            }
									        %>
									        </select>																					
										</td>
				                     </tr>
				                     <TR style="height: 1px"><TD class=Line colspan=5></TD></TR> 
			                     </TABLE>
                      		</form>
                      		
                      		 <%
                      		String sqlWhere="";
                      		 
                      		if(HrmUserVarify.checkUserRight("collaborationmanager:edit", user)) { 
                      			sqlWhere="where c1.status=1 ";
                      		} else {
                      			sqlWhere="where c1.status=1 and  c1.coworkers like '%,"+user.getUID()+",%'";
                      		}
                      		
                      		int dateInterval=-1*interval;
                      		if("m".equals(intervalType)){
                      			dateInterval=-1*interval*31;
                      		} else if("y".equals(intervalType)){
                      			dateInterval=-1*interval*365;
                      		}
                      		String curDate=TimeUtil.getCurrentDateString();
                      		String preDate=TimeUtil.dateAdd(curDate,dateInterval);
                      		sqlWhere+=" and c2.createdate<'"+preDate+"' ";
                      		
                      		//System.out.println("preDate:"+preDate);
                      		if(!"".equals(principal)) sqlWhere+=" and c1.principal="+principal+" ";
                      		
                      		if(!"".equals(typeid)) sqlWhere+=" and c1.typeid="+typeid+" ";
                      		
                      		String strFromAdd="";
                      		if("principal".equals(jointype)||"".equals(jointype)){
                      			strFromAdd=" select t2.id,max(t1.createdate) as createdate   from   cowork_discuss t1 left join cowork_items t2  on t1.coworkid=t2.id where t1.discussant=t2.principal    group by t2.id ";

                      		}  else if("part".equals(jointype)){
                      			strFromAdd=" select coworkid as id,max(createdate) as createdate from  cowork_discuss  group by coworkid ";                      			 
                     		}
                      		
                      		String fromSql=" from cowork_items  c1 left join ("+strFromAdd+") c2 on c1.id=c2.id ";
                      		
                            String backfields =" c1.id,c1.name,c1.principal,c1.typeid,c2.createdate";
                            String tableString =" <table tabletype=\"none\" pagesize=\"15\" >"+
                                                 "	   <sql backfields=\""+backfields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlprimarykey=\"c1.id\" sqlsortway=\"Desc\"  sqlorderby=\"c2.createdate\"     sqlisdistinct=\"true\"/>"+
                                                 "			<head>"+
                                                 "				<col width=\"15%\"  text=\"�ֲ�\" column=\"principal\" transmethod=\"weaver.splitepage.transform.SptmForCowork.getSubCompanyName\"/>"+
                                                 "				<col width=\"15%\"  text=\"����\" column=\"principal\" transmethod=\"weaver.splitepage.transform.SptmForCowork.getDepateName\"/>"+
                                                 "				<col width=\"10%\"  text=\"������\" column=\"principal\" href =\"/hrm/resource/HrmResource.jsp?\" linkkey=\"id\" linkvaluecolumn=\"principal\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastnames\"/>"+
                                                 "				<col width=\"25%\" text=\"Э������\" column=\"name\" href =\"/cowork/ViewCoWork.jsp?view=yes\"  linkkey=\"id\" linkvaluecolumn=\"id\" target=\"_fullwindow\"/>"+
                                                 "				<col width=\"15%\" text=\"Э������\" column=\"typeid\" transmethod=\"weaver.cowork.CoTypeComInfo.getCoTypename\"/>"+
                                                 "				<col width=\"20%\"  text=\"������ʱ��\" orderkey=\"c2.createdate\"  column=\"createdate\" />"+
                                                 "			</head>"+    			
                                                 "</table>"; 
                          %> 
                          
                          
                          <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run" showExpExcel="true"/>  
                      		
                      		
                      </td>
                     </tr>
                     </TABLE>                  	               	
                </td>
                <td></td>
              </tr>
              <tr>
                <td height="10" colspan="3"></td>
              </tr>
            </table>
          </BODY>
        </HTML>
        
        <!-- JavaScript���� -->
         <SCRIPT LANGUAGE="JavaScript">
          function onSearch(obj){        
             obj.disabled=true ;
             frmSearch.submit();
          }
        </SCRIPT>
