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
		RCMenu += "{����,javascript:doSave(this),_self} " ;
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
	                                <TD class="Field">
                                     <% 
                                        out.println("<input name='txtCodePrefix' class='inputStyle' type='text' value='"+codePrefix+"'  onchange='doCodePrefixChange()'>");
                                       %>
                                    </TD>
                                </TR>  
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>�Ƿ�ʹ����Ŀ���ʹ���</TD>
                                    <TD class="Field">
                                        <% 
                                            out.println("<input name='chkIsNeedProjTypeCode' class='inputStyle' type='checkbox' value='1' onclick='doProTypeChange()'");
                                            if (isNeedProjTypeCode) out.println(" checked");
                                            out.println(">");
                                        %>
                                    </TD>
                                </TR>                                  
                                <TR><TD class=Line colSpan=2></TD></TR>                            
                                <TR>
                                    <TD>��</TD>
                                    <TD class="Field">
                                         <% 
                                            out.println("<input name='chkYear' class='inputStyle' type='checkbox' value='1' onclick='doYearChange1()'");
                                            if ("1".equals(year)) {
                                                out.println(" checked>");
                                                out.println("<select name='selYear' onchange='doYearChange2()'><OPTION selected value='1'>2-YEAH</OPTION><OPTION value='2'>4-YEAH</OPTION></select>");
                                            } else if ("2".equals(year)){
                                                 out.println(" checked>");
                                                 out.println("<select name='selYear' onchange='doYearChange2()'><OPTION value='1'>2-YEAH</OPTION><OPTION selected value='2'>4-YEAH</OPTION></select>");
                                            } else {
                                                out.println(">");
                                                out.println("<select name='selYear' onchange='doYearChange2()'><OPTION selected value='1'>2-YEAH</OPTION><OPTION value='2'>4-YEAH</OPTION></select>");
                                            }
                                            
                                        %>
                                    </TD>
                                </TR>
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>��</TD>
                                    <TD class="Field">
                                       <% 
                                            out.println("<input name='chkMonth' class='inputStyle' type='checkbox' value='1' onclick='doMonthChange()'");
                                            if ("1".equals(month)) out.println(" checked");
                                            out.println(">");
                                       %>
                                    </TD>
                                </TR>
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>��</TD>
                                    <TD class="Field">
                                        <% 
                                            out.println("<input name='chkDate' class='inputStyle' type='checkbox' value='1' onclick='doDateChange()'");
                                            if ("1".equals(date)) out.println(" checked");
                                            out.println(">");
                                        %>
                                    </TD>
                                </TR>  
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>��ˮ�ų���</TD>
                                    <TD class="Field">
                                        <% 
                                            out.println("<input name='txtGlideNum' class='inputStyle' type='text' value='"+glideNum+"' onChange='doGlideNumChage()'>");
                                        %>
                                    </TD>
                                </TR>                                 
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>�Ƿ����ô�����</TD>
                                    <TD class="Field">
                                        <% 
                                            out.println("<input name='txtUseCode'  class='inputStyle' type='checkbox' value='1'");
                                            if (isUseCode) out.println(" checked");
                                            out.println(">");
                                        %>                                    
                                    </TD>
                                </TR> 
                                <TR><TD class=Line colSpan=2></TD></TR>
                                <TR>
                                    <TD>Ԥ��</TD>
                                    <TD class="Field">  
		                                  <font color='#660033'>                                      
		                                     <Span id="spanCodePrefix">
		                                          <%out.println(codePrefix); %>
		                                     </Span>
		                                  </font>
                                          &nbsp;
                                        <font color='#6633CC'> 
	                                         <Span id="spanIsNeedProjTypeCode">
	                                            <%if (isNeedProjTypeCode) out.println("XMLY"); %>
	                                        </Span>
                                        </font>
                                        &nbsp;
                                        <font color='#FF33CC'>
	                                         <Span id="spanYear">
	                                            <%if ("1".equals(year)) out.println("YY");
	                                            else if ("2".equals(year)) out.println("YYYY"); %>
	                                        </Span>
                                        </font>
                                        &nbsp;
                                        <font color='#666633'>
                                         <Span id="spanMonth">
                                            <%if ("1".equals(month)) out.println("MM"); %>
                                        </Span>
                                        </font>
                                        &nbsp;
                                        <font color='#CC00FF'>
                                         <Span id="spanDate">
                                            <%if ("1".equals(date)) out.println("DD"); %>
                                        </Span>
                                        </font>
                                        &nbsp;
                                        <font color='#996666'>
                                         <Span id="spanGlideNum">
                                            <%if (glideNum!=0) out.println(Util.add0(1,glideNum)); %>
                                        </Span> 
                                        </font> 
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

<Script language="javaScript">
    function doSave(obj){
        obj.disabled = true ;
        frmPara.submit();
    }

    function doCodePrefixChange(){     
        document.getElementById("spanCodePrefix").innerText=frmPara.txtCodePrefix.value;
    }

    function doProTypeChange(){     
        if (frmPara.chkIsNeedProjTypeCode.checked){
            document.getElementById("spanIsNeedProjTypeCode").innerText="XMLY";
        } else {
            document.getElementById("spanIsNeedProjTypeCode").innerText="";
        }
    }

    function doYearChange1(){  
        if (frmPara.chkYear.checked){
            if (frmPara.selYear.value==1){
                document.getElementById("spanYear").innerText="YY";  
            } else {
                document.getElementById("spanYear").innerText="YYYY";  
            }
        } else {
            document.getElementById("spanYear").innerText="";
        }      
    }
    
     function doYearChange2(){  
        if (frmPara.chkYear.checked){
            if (frmPara.selYear.value==1){          
                document.getElementById("spanYear").innerText="YY";  
            } else {
                document.getElementById("spanYear").innerText="YYYY";  
            }
        } 
     }

    function doMonthChange(){     
          if (frmPara.chkMonth.checked){
            document.getElementById("spanMonth").innerText="MM";
        } else {
            document.getElementById("spanMonth").innerText="";
        }
       
    }

    function doDateChange(){     
          if (frmPara.chkDate.checked){
            document.getElementById("spanDate").innerText="DD";
        } else {
            document.getElementById("spanDate").innerText="";
        }       
    }

    function doGlideNumChage(){            
        var m_length = document.all("txtGlideNum").value;
        if (m_length!=0){
            var deltaStr = "";
            var wasteCodeValue="1";
            if (wasteCodeValue.length < m_length) {
                for (var i = 0; i < m_length-wasteCodeValue.length; i ++) {
                    deltaStr +="0";
                }
            }
            wasteCodeValue = deltaStr + wasteCodeValue;
            document.getElementById("spanGlideNum").innerText=wasteCodeValue;    
        } else {
            document.getElementById("spanGlideNum").innerText="";    
        }
    }
</Script>
</HTML>
