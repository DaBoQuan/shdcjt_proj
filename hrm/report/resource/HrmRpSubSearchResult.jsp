<%@ page import="weaver.general.Util,
                 weaver.docs.docs.CustomFieldManager"%>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="AllManagers" class="weaver.hrm.resource.AllManagers" scope="page"/>

<%
    String userid =""+user.getUID();
    /*Ȩ���ж�,�����ʲ�����Ա�Լ��������ϼ�*/
    boolean canView = false;
    ArrayList allCanView = new ArrayList();
    String tempsql = tempsql ="select resourceid from HrmRoleMembers where resourceid>1 and roleid in (select roleid from SystemRightRoles where rightid=22)";
    RecordSet.executeSql(tempsql);
    while(RecordSet.next()){
        String tempid = RecordSet.getString("resourceid");
        allCanView.add(tempid);
        AllManagers.getAll(tempid);
        while(AllManagers.next()){
            allCanView.add(AllManagers.getManagerID());
        }
    }// end while
    for (int i=0;i<allCanView.size();i++){
        if(userid.equals((String)allCanView.get(i))){
            canView = true;
        }
    }
    if(!canView) {
        response.sendRedirect("/notice/noright.jsp") ;
        return ;
    }
    /*Ȩ���жϽ���*/

    int scopeId = Util.getIntValue(request.getParameter("scopeId"),0);
    String[] checkcons = request.getParameterValues("check_con");
    String sqlwhere = "";
    String temOwner = "";

    if(checkcons!=null){
        for(int i=0;i<checkcons.length;i++){
            String tmpcolname = ""+Util.null2String(request.getParameter("con"+checkcons[i]+"_colname"));
            String tmphtmltype = ""+Util.null2String(request.getParameter("con"+checkcons[i]+"_htmltype"));
            String tmptype = ""+Util.null2String(request.getParameter("con"+checkcons[i]+"_type"));
            String tmpopt = ""+Util.null2String(request.getParameter("con"+checkcons[i]+"_opt"));
            String tmpvalue = ""+Util.null2String(request.getParameter("con"+checkcons[i]+"_value"));
            String tmpopt1 = ""+Util.null2String(request.getParameter("con"+checkcons[i]+"_opt1"));
            String tmpvalue1 = ""+Util.null2String(request.getParameter("con"+checkcons[i]+"_value1"));

            //����where�Ӿ�

            temOwner = "tCustom";

            if((tmphtmltype.equals("1")&& tmptype.equals("1"))||tmphtmltype.equals("2")){
                sqlwhere += "and ("+temOwner+"."+tmpcolname;
                if(tmpopt.equals("1"))	sqlwhere+=" ='"+tmpvalue +"' ";
                if(tmpopt.equals("2"))	sqlwhere+=" <>'"+tmpvalue +"' ";
                if(tmpopt.equals("3"))	sqlwhere+=" like '%"+tmpvalue +"%' ";
                if(tmpopt.equals("4"))	sqlwhere+=" not like '%"+tmpvalue +"%' ";
            }else if(tmphtmltype.equals("1")&& !tmptype.equals("1")){
                sqlwhere += "and ("+temOwner+"."+tmpcolname;
                if(!tmpvalue.equals("")){
                    if(tmpopt.equals("1"))	sqlwhere+=" >"+tmpvalue +" ";
                    if(tmpopt.equals("2"))	sqlwhere+=" >="+tmpvalue +" ";
                    if(tmpopt.equals("3"))	sqlwhere+=" <"+tmpvalue +" ";
                    if(tmpopt.equals("4"))	sqlwhere+=" <="+tmpvalue +" ";
                    if(tmpopt.equals("5"))	sqlwhere+=" ="+tmpvalue +" ";
                    if(tmpopt.equals("6"))	sqlwhere+=" <>"+tmpvalue +" ";

                    if(!tmpvalue1.equals(""))
                        sqlwhere += " and "+temOwner+"."+tmpcolname;
                }
                if(!tmpvalue1.equals("")){
                    if(tmpopt1.equals("1"))	sqlwhere+=" >"+tmpvalue1 +" ";
                    if(tmpopt1.equals("2"))	sqlwhere+=" >="+tmpvalue1 +" ";
                    if(tmpopt1.equals("3"))	sqlwhere+=" <"+tmpvalue1 +" ";
                    if(tmpopt1.equals("4"))	sqlwhere+=" <="+tmpvalue1 +" ";
                    if(tmpopt1.equals("5"))	sqlwhere+=" ="+tmpvalue1+" ";
                    if(tmpopt1.equals("6"))	sqlwhere+=" <>"+tmpvalue1 +" ";
                }
            }
            else if(tmphtmltype.equals("4")){
                sqlwhere += "and ("+temOwner+"."+tmpcolname;
                if(!tmpvalue.equals("1")) sqlwhere+="<>'1' ";
                else sqlwhere +="='1' ";
            }
            else if(tmphtmltype.equals("5")){
                sqlwhere += "and ("+temOwner+"."+tmpcolname;
                if(tmpopt.equals("1"))	sqlwhere+=" ="+tmpvalue +" ";
                if(tmpopt.equals("2"))	sqlwhere+=" <>"+tmpvalue +" ";
            }
            else if(tmphtmltype.equals("3") && !tmptype.equals("2") && !tmptype.equals("18") && !tmptype.equals("19")&& !tmptype.equals("17") && !tmptype.equals("37")&& !tmptype.equals("65") ){
                sqlwhere += "and ("+temOwner+"."+tmpcolname;
                if(tmpopt.equals("1"))	sqlwhere+=" ="+tmpvalue +" ";
                if(tmpopt.equals("2"))	sqlwhere+=" <>"+tmpvalue +" ";
            }
            else if(tmphtmltype.equals("3") && (tmptype.equals("2")||tmptype.equals("19"))){ // �����ڴ���
                sqlwhere += "and ("+temOwner+"."+tmpcolname;
                if(!tmpvalue.equals("")){
                    if(tmpopt.equals("1"))	sqlwhere+=" >'"+tmpvalue +"' ";
                    if(tmpopt.equals("2"))	sqlwhere+=" >='"+tmpvalue +"' ";
                    if(tmpopt.equals("3"))	sqlwhere+=" <'"+tmpvalue +"' ";
                    if(tmpopt.equals("4"))	sqlwhere+=" <='"+tmpvalue +"' ";
                    if(tmpopt.equals("5"))	sqlwhere+=" ='"+tmpvalue +"' ";
                    if(tmpopt.equals("6"))	sqlwhere+=" <>'"+tmpvalue +"' ";

                    if(!tmpvalue1.equals(""))
                        sqlwhere += " and "+temOwner+"."+tmpcolname;
                }
                if(!tmpvalue1.equals("")){
                    if(tmpopt1.equals("1"))	sqlwhere+=" >'"+tmpvalue1 +"' ";
                    if(tmpopt1.equals("2"))	sqlwhere+=" >='"+tmpvalue1 +"' ";
                    if(tmpopt1.equals("3"))	sqlwhere+=" <'"+tmpvalue1 +"' ";
                    if(tmpopt1.equals("4"))	sqlwhere+=" <='"+tmpvalue1 +"' ";
                    if(tmpopt1.equals("5"))	sqlwhere+=" ='"+tmpvalue1+"' ";
                    if(tmpopt1.equals("6"))	sqlwhere+=" <>'"+tmpvalue1 +"' ";
                }
            }
            else if(tmphtmltype.equals("3") && (tmptype.equals("17") || tmptype.equals("18") || tmptype.equals("37") || tmptype.equals("65") )){       // �Զ�������Դ����ͻ������ĵ��Ĵ���
                sqlwhere += "and (','+CONVERT(varchar,"+temOwner+"."+tmpcolname+")+',' ";
                if(tmpopt.equals("1"))	sqlwhere+=" like '%,"+tmpvalue +",%' ";
                if(tmpopt.equals("2"))	sqlwhere+=" not like '%,"+tmpvalue +",%' ";
            }

            sqlwhere +=") ";

        }
    }

    CustomFieldManager cfm = new CustomFieldManager("HrmCustomFieldByInfoType",scopeId);
    cfm.getCustomFields();
    String selectSql = "select id ";
    String temSql = "";
    while(cfm.next()){
        temSql += ",field"+cfm.getId();
    }

    rs.executeSql("select colname,showorder from HrmRpSubDefine where scopeid="+scopeId+" and resourceid="+userid+" order by showorder");
    ArrayList allCols= new ArrayList();
    while(rs.next()){
        allCols.add(rs.getString("colname"));
    }

    selectSql += temSql + " from cus_fielddata "+temOwner+" where scope='HrmCustomFieldByInfoType' and scopeid="+scopeId+" "+sqlwhere;
    RecordSet.executeSql(selectSql);
    //System.out.println("======================");
    //System.out.println(selectSql);
%>
<HTML>
<HEAD>
    <LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<%
    String imagefilename = "/images/hdMaintenance.gif";
    String titlename = SystemEnv.getHtmlLabelName(15101,user.getLanguage()) ;
    String needfav ="1";
    String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(15518,user.getLanguage())+",javascript:window.history.back(-1),_self} " ;
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
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


<%----------------------------�Զ�����ϸ�ֶ� begin--------------------------------------------%>

<%

    int colcount1 = allCols.size() ;
    int colwidth1 = 0 ;

    if( colcount1 != 0 ) {
        colwidth1 = 90/colcount1 ;

%>
    <table Class=ListStyle id="oTable"  cellspacing="1" cellpadding="0">
        <tr class=header>
            <td width="<%=10%>%" nowrap><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></td>
<%
        cfm.beforeFirst();
        for(int i=0; i<allCols.size(); i++){
            while(cfm.next()){
                if(allCols.get(i).equals("field"+cfm.getId())){
                    String fieldlable =String.valueOf(cfm.getLable());
%>
            <td width="<%=colwidth1%>%" nowrap><%=fieldlable%></td>
<%
                    break;
                }
            }
            cfm.beforeFirst();
        }
%>
        </tr>
<%

        boolean isttLight = false;
        while(RecordSet.next()){
            isttLight = !isttLight ;
%>
        <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'>
            <td width="<%=10%>%" nowrap>
                <a href="/hrm/resource/HrmResource.jsp?id=<%=RecordSet.getString("id")%>"><%=ResourceComInfo.getLastname(RecordSet.getString("id"))%></a><br>
            </td>
<%
            for(int i=0; i<allCols.size(); i++){
                while(cfm.next()){
                    if(allCols.get(i).equals("field"+cfm.getId())){
                        String fieldid=String.valueOf(cfm.getId());  //�ֶ�id
                        String fieldhtmltype = String.valueOf(cfm.getHtmlType());
                        String fieldtype=String.valueOf(cfm.getType());
                        String fieldvalue =  Util.null2String(RecordSet.getString("field"+fieldid)) ;

%>
            <td class=field nowrap style="TEXT-VALIGN: center">
<%
                        if(fieldhtmltype.equals("1")||fieldhtmltype.equals("2")){                          // �����ı���
%>
                <%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>
<%
                        }else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
                            String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
                            String showid = "";                                     // �½�ʱ��Ĭ��ֵ

                            String newdocid = Util.null2String(request.getParameter("docid"));

                            if( fieldtype.equals("37") && !newdocid.equals("")) {
                                if( ! fieldvalue.equals("") ) fieldvalue += "," ;
                                fieldvalue += newdocid ;
                            }

                            if(fieldtype.equals("2") ||fieldtype.equals("19")){
                                showname=fieldvalue; // ����ʱ��
                            }else if(!fieldvalue.equals("")) {
                                String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                                String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
                                String sql = "";

                                HashMap temRes = new HashMap();

                                if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")||fieldtype.equals("65")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                                }
                                else {
                                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                                }

                                rs.executeSql(sql);
                                while(rs.next()){
                                    showid = Util.null2String(rs.getString(1)) ;
                                    String tempshowname= Util.toScreen(rs.getString(2),user.getLanguage()) ;
                                    temRes.put(String.valueOf(showid),tempshowname);
                                }
                                StringTokenizer temstk = new StringTokenizer(fieldvalue,",");
                                String temstkvalue = "";
                                while(temstk.hasMoreTokens()){
                                    temstkvalue = temstk.nextToken();

                                    if(temstkvalue.length()>0&&temRes.get(temstkvalue)!=null){
                                        showname += temRes.get(temstkvalue);
                                    }
                                }

                            }
%>
                    <%=showname%>
<%
                        }else if(fieldhtmltype.equals("4")) {                    // check��
%>
                <input type=checkbox disabled <%if(fieldvalue.equals("1")){%> checked <%}%> >
<%
                        }else if(fieldhtmltype.equals("5")){
                            cfm.getSelectItem(cfm.getId());
                            while(cfm.nextSelect()){
                                if(cfm.getSelectValue().equals(fieldvalue)){
%>
            <%=cfm.getSelectName()%>
<%
                                    break;
                                }
                            }
                        }
%>
            </td>
<%
                        break;
                    }
                }
                cfm.beforeFirst();
            }
        }

%>
        </tr>

        </table>
<%
    }
%>

<%----------------------------�Զ�����ϸ�ֶ� end  --------------------------------------------%>

		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>

<BODY>