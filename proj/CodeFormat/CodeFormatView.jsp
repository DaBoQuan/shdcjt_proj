<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util"%>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="ProjCodeParaBean" class="weaver.proj.form.ProjCodeParaBean" scope="page"/>
<HTML>
    <HEAD>
        <LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
        <SCRIPT language="javascript" src="/js/weaver.js"></SCRIPT>
    </HEAD>

<%
    boolean canEdit = false ;
    //�ж��Ƿ������Ŀ�����ά��Ȩ��
    if (HrmUserVarify.checkUserRight("ProjCode:Maintenance",user)) {
        canEdit = true ;   
    }

    String imagefilename = "/images/sales.gif";
    String titlename = "��Ŀ�����������";
    String needfav ="1";
    String needhelp ="";//ȡ����Ӧ���õ�ֵ
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    if (canEdit) {
        RCMenu += "{�༭,javascript:location='CodeFormatEdit.jsp',_self} " ;
        RCMenuHeight += RCMenuHeightStep ;
    }
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:window.history.go(-1),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<%
    ProjCodeParaBean.getCodePara();
    String codePrefix = Util.null2String(ProjCodeParaBean.getCodePrefix());
    boolean isNeedProjTypeCode = ProjCodeParaBean.isNeedProjTypeCode();
    String year= Util.null2String(ProjCodeParaBean.getStrYear());
    String month = Util.null2String(ProjCodeParaBean.getStrMonth());
    String date = Util.null2String(ProjCodeParaBean.getStrDate());
    int glideNum = ProjCodeParaBean.getGlideNum();
    boolean isUseCode = ProjCodeParaBean.isUseCode();
%>
<TABLE width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<COLGROUP>
<COL width="10">
<COL width="">
<COL width="10">
<TR>
    <TD height="10" colspan="3"></TD>
</TR>
<TR>
    <TD></TD>
    <TD valign="top">
         <TABLE class=Shadow>
            <TR>
                <TD valign="top">
                    <FORM  name=frmPara method=post action="CodeFormatOperation.jsp">
                        <TABLE class=ViewForm>
                            <COLGROUP>
                            <COL width="15%">
                            <COL width="85%">                            
                            <TBODY>
                                <TR class="Title"><TH>��Ŀ���</TH><TD></TD></TR>
                                <TR><TD class=Line1 colSpan=2></TD></TR>
                                <TR>
                                    <TD>ǰ׺</TD>
                                    <TD class="Field"><%if ("".equals(codePrefix)){out.println("��");} else {out.println(codePrefix);}%></TD>
                                </TR>  
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>�Ƿ�ʹ����Ŀ���ʹ���</TD>
                                    <TD class="Field">
                                        <% 
                                            if (isNeedProjTypeCode) out.println("ʹ��");
                                            else  out.println("��ʹ��");
                                        %>
                                    </TD>
                                </TR>                                  
                                <TR><TD class=Line colSpan=2></TD></TR>                            
                                <TR>
                                    <TD>��</TD>
                                    <TD class="Field">
                                         <% 
                                            if ("1".equals(year)) out.println("2-YEAR");
                                            else if ("2".equals(year))  out.println("4-YEAR");
                                            else  out.println("��ʹ��");
                                        %>
                                    </TD>
                                </TR>
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>��</TD>
                                    <TD class="Field">
                                        <%
                                            if ("1".equals(month)) out.println("ʹ��");
                                            else  out.println("��ʹ��");
                                        %>
                                    </TD>
                                </TR>
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>��</TD>
                                    <TD class="Field">
                                        <%
                                            if ("1".equals(date)) out.println("ʹ��");
                                            else  out.println("��ʹ��");
                                        %>
                                    </TD>
                                </TR>  
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>��ˮ��</TD>
                                    <TD class="Field">
                                        <%
                                            if (glideNum==0) 
                                                out.println("��");
                                            else 
                                                out.println(glideNum);
                                        %>
                                    </TD>
                                </TR>                                 
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>�Ƿ����ô�����</TD>
                                    <TD class="Field">
                                        <% 
                                            if (isUseCode) out.println("����");
                                            else  out.println("������");
                                        %>                                    
                                    </TD>
                                </TR> 
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>Ԥ��</TD>
                                    <TD class="Field">
                                        <Span name="spanPreview">
                                        <% 
                                            boolean isHaveSet = false ;     
                                            String strConsist="("; 
                                            if (!"".equals(codePrefix)){                                                                            
	                                            out.println("<font color='#660033'>"+codePrefix+"</font>");
	                                            strConsist+="ǰ׺+";
                                                isHaveSet = true ;
                                            }
                                            if (isNeedProjTypeCode) {
                                                out.println("<font color='#6633CC'>XMLY</font>");
                                                strConsist+="��Ŀ���ʹ���+";
                                                isHaveSet = true ;
                                            }
                                            if ("1".equals(year)) {
                                                out.println("<font color='#FF33CC'>YY</font>");
                                                strConsist+="��+";
                                                isHaveSet = true ;
                                            } else if ("2".equals(year)) {
                                                out.println("<font color='#FF33CC'>YYYY</font>");
                                                strConsist+="��+";
                                                isHaveSet = true ;
                                            }
                                            if ("1".equals(month)){
                                                out.println("<font color='#666633'>MM</font>");
                                                strConsist+="��+";
                                                isHaveSet = true ;
                                             }
                                            if ("1".equals(date)) {
                                                out.println("<font color='#CC00FF'>DD</font>");
                                                strConsist+="��+";
                                                isHaveSet = true ;
                                            }
                                            if (glideNum!=0) {
                                                out.println("<font color='#996666'>"+Util.add0(1,glideNum)+"</font>");  
                                                strConsist+="��ˮ��";
                                                isHaveSet = true ;
                                            }   
                                            strConsist+=")";   
                                            
                                            if (!isHaveSet) strConsist="";                                         
                                        %>                                     
                                        </Span>                                       
                                        &nbsp;&nbsp;&nbsp;&nbsp;<%=strConsist%>
                                    </TD>
                                </TR>                                
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD valign="top">��ע</TD>
                                    <TD>
                                        XMLY(ָ������Ŀ���ͱ�� ��:��������Ŀ���͵Ĵ����� LYX �Ǵ˴�����LYX)<BR> 
                                        YYYY (��λ������ ��:1983,1985...) YY(��λ������ ��:83,85...)<BR>
                                        MM(��λ������ ��:10,11...)<BR>
                                        DD(��λ������ ��:08,23...)<BR>
                                             �Ƿ����ô�����:ָ��������Ŀ���͵ı����,�����Ź����Ƿ�ʹ��
                                    </TD>
                                </TR>
                            </TBODY>
                         </TABLE>
                    </FORM>
                </TD>
            </TR>            
         </TABLE>
    </TD>
    <TD></TD>
</TR>
<TR>
    <TD height="10" colspan="3"></TD>
</TR>
</BODY>
</HTML>
