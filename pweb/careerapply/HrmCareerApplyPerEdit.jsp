<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="EduLevelComInfo" class="weaver.hrm.job.EducationLevelComInfo" scope="session" />
<html>
<%!
    /**
     * Add by Charoes ,remove the zero behind a Two Digit precision Decimal .
     * @param s
     * @return
     */
    private String trimZero(String s){
        int index = s.indexOf(".");
        if(index !=-1){
            String temp = s.substring(index+1);
            if(temp.equals("00"))
                s = s.substring(0,index);
            else{
                if(temp.substring(temp.length()-1).equals("0") ){
                    s = s.substring(0,s.length()-1)      ;
                }
            }
        }
        return s;
    }

%>
<%
String id = request.getParameter("id"); 
%>
<head>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<body>
<DIV class=HdrProps></DIV>
<FORM name=resourcepersonalinfo id=resource action="HrmCareerApplyOperation.jsp" method=post>
<input type=hidden name=operation>
<input type=hidden name=id value="<%=id%>">
<DIV>

  <BUTTON class=btnSave accessKey=E type=button onclick=edit()><U>E</U>-����</BUTTON>
  <BUTTON class=btn accessKey=B type=button onclick="location.href='HrmCareerApplyPerView.jsp?id=<%=id%>'"><U>B</U>-����</BUTTON>
 </DIV>
 <TABLE class=Form>
    <COLGROUP> <COL width="49%"> <COL width=10> <COL width="49%"> 
	<TBODY> 
    <TR> 
      <TD vAlign=top>
      <TABLE width="100%">
          <COLGROUP> <COL width=20%> <COL width=80%>
	      <TBODY> 
          <TR class=Section> 
            <TH colSpan=2>������Ϣ</TH>
          </TR>
          <TR class=Separator> 
            <TD class=Sep1 colSpan=2></TD>
          </TR>	  
 <%
  String sql = "";
  sql = "select * from HrmCareerApply where id = "+id;  
  rs.executeSql(sql);
  while(rs.next()){
    String birthday = Util.null2String(rs.getString("birthday"));
    String folk = Util.null2String(rs.getString("folk"));
    String nativeplace = Util.null2String(rs.getString("nativeplace"));
    String regresidentplace = Util.null2String(rs.getString("regresidentplace"));
    String certificatenum = Util.null2String(rs.getString("certificatenum"));    
    String maritalstatus = Util.null2String(rs.getString("maritalstatus"));
    String policy = Util.null2String(rs.getString("policy"));
    String bememberdate = Util.null2String(rs.getString("bememberdate"));
    String bepartydate = Util.null2String(rs.getString("bepartydate"));
    String islabouunion = Util.null2String(rs.getString("islabouunion"));
    String educationlevel = Util.null2String(rs.getString("educationlevel"));
    String degree = Util.null2String(rs.getString("degree"));
    String healthinfo = Util.null2String(rs.getString("healthinfo"));
    String height = Util.null2String(rs.getString("height"));
    String weight = Util.null2String(rs.getString("weight"));
    String residentplace = Util.null2String(rs.getString("residentplace"));
    String homeaddress = Util.null2String(rs.getString("homeaddress"));
    String tempresidentnumber = Util.null2String(rs.getString("tempresidentnumber"));    
%>        
	 <TR> 
            <TD >��������</TD>
            <TD class=Field>
              <BUTTON class=Calendar id=selectbirthday onclick="getbirthdayDate()"></BUTTON> 
              <SPAN id=birthdayspan ><%=birthday%>
              </SPAN> 
              <input type="hidden" name="birthday" value="<%=birthday%>">                            
            </TD>
          </TR>
	      <TR> 
            <TD >����</TD>
            <TD class=Field> 
              <input type=text name=folk value="<%=folk%>">
            </TD>
          </TR>
	      <TR> 
            <TD >����</TD>
            <TD class=Field> 
              <input type=text name=nativeplace value="<%=nativeplace%>">
            </TD>
          </TR>
	      <TR> 
            <TD >����</TD>
            <TD class=Field> 
              <input type=text name=regresidentplace value="<%=regresidentplace%>">
            </TD>
          </TR>
	      <TR> 
            <TD >���֤��</TD>
            <TD class=Field> 
              <input type=text name=certificatenum value="<%=certificatenum%>">
            </TD>
          </TR>
	      <TR> 
            <TD >����״��</TD>
            <TD class=Field> 
              <select name=maritalstatus value="<%=maritalstatus%>">
                <option value="0" <%if(maritalstatus.equals("0")){%> selected <%}%>>δ��</option>
                <option value="1" <%if(maritalstatus.equals("1")){%> selected <%}%>>�ѻ�</option>
                <option value="2" <%if(maritalstatus.equals("2")){%> selected <%}%>>���� </option>
              </select>
            </TD>
          </TR>
	      <TR> 
            <TD >������ò</TD>
            <TD class=Field> 
              <input type=text name=policy value="<%=policy%>">
            </TD>
          </TR>
	      <TR> 
            <TD >��������</TD>
            <TD class=Field>
              <button class=Calendar id=selectbememberdate onClick="getbememberdateDate()"></button> 
              <span id=bememberdatespan ><%=bememberdate%></span> 
              <input type="hidden" name="bememberdate" value="<%=bememberdate%>">               
            </TD>
          </TR>
	      <TR> 
            <TD >�뵳����</TD>
            <TD class=Field>
              <button class=Calendar id=selectbepartydate onClick="getbepartydateDate()"></button> 
              <span id=bepartydatespan ><%=bepartydate%></span> 
              <input type="hidden" name="bepartydate" value="<%=bepartydate%>">               
            </TD>
          </TR>
	      <TR> 
            <TD >�����Ա</TD>
            <TD class=Field>
              <select class=saveHistory id=islabouunion name=islabouunion value="<%=islabouunion%>">
                <option value=1 <%if(islabouunion.equals("1")){%> selected <%}%>>��</option>
                <option value=0 <%if(islabouunion.equals("0")){%> selected <%}%>>��</option>                
              </select>               
            </TD>
          </TR>
	      <TR> 
            <TD >ѧ��</TD>
            <TD class=Field>
              <BUTTON class=Browser name="btneducationlevel"  onclick="onShowEduLevel(educationlevelspan,educationlevel)"> </BUTTON>
              <SPAN id=educationlevelspan><%=EduLevelComInfo.getEducationLevelname(educationlevel)%></SPAN>
              <INPUT type=hidden name=educationlevel value="<%=educationlevel%>">              
            </TD>
          </TR>
	      <TR> 
            <TD >ѧλ</TD>
            <TD class=Field> 
              <input type=text name=degree value="<%=degree%>">
            </TD>
          </TR>
	      <TR> 
            <TD >����״��</TD>
            <TD class=Field>
              <select class=saveHistory id=healthinfo name=healthinfo value="<%=healthinfo%>">
                <option value=0 <%if(healthinfo.equals("0")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(824,7)%></option>
                <option value=1 <%if(healthinfo.equals("1")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(821,7)%></option>
                <option value=2 <%if(healthinfo.equals("2")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(154,7)%></option>
                <option value=3 <%if(healthinfo.equals("3")){%> selected <%}%>><%=SystemEnv.getHtmlLabelName(825,7)%></option>
              </select>               
            </TD>
          </TR>
	      <TR> 
            <TD >���</TD>
            <TD class=Field>
              <input class=saveHistory maxlength=5  size=5 name=height value="<%=trimZero(height)%>" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("height")'>
              cm
            </TD>
          </TR>
       	  <TR> 
            <TD >����</TD>
            <TD class=Field>
              <input class=saveHistory maxlength=5  size=5 name=weight value="<%=trimZero(weight)%>"  onKeyPress="ItemNum_KeyPress()" onBlur='checknumber("weight")'>
              kg
            </TD>
          </TR>
	      <TR> 
            <TD >�־�ס��</TD>
            <TD class=Field> 
              <input type=text name=residentplace value="<%=residentplace%>">
            </TD>
          </TR>
<!--	      <TR> 
            <TD >��ͥ��ϵ��ʽ</TD>
            <TD class=Field> 
              <input type=text name=homeaddress value="<%=homeaddress%>">
            </TD>
          </TR>
-->          
	      <TR> 
            <TD >��ס֤����</TD>
            <TD class=Field> 
              <input type=text name=tempresidentnumber value="<%=tempresidentnumber%>">
            </TD>
          </TR>
<%
  }
%>        

 	      </tbody>
       </table>
   </tr>

 
<%
  sql = "select * from HrmFamilyInfo where resourceid = "+id;  
  rs.executeSql(sql);  
%>
	<TR> 
      <TD vAlign=top> 
        <TABLE width="100%" cols=6 id="oTable" class=ListShort>
          <COLGROUP> 
   		    <COL width=3%> 
		    <COL width=12%> 
			<COL width=10%>
			<COL width=30%>
			<COL width=15%>
			<COL width=30%>
	      <TBODY>
		  <input type=hidden name=rownum>	  
          <TR class=Section> 
            <TH colspan=2>��ͥ���</TH>
	    <Td align=right colspan=4>
	    <BUTTON class=btnNew accessKey=A onClick="addRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(551,7)%></BUTTON>
	    <BUTTON class=btnDelete accessKey=D onClick="javascript:if(isdel()){deleteRow1()};"><U>D</U>-ɾ��</BUTTON>  	    
           </Td>
          </TR>
          <TR class=Separator> 
            <TD class=Sep1 colSpan=6></TD>
          </TR>	
		  <tr class=Header>
            <td ></td>
		    <td >��Ա	</td>
			<td >��ν	</td>
			<td >������λ</td>
			<td >ְ��</td>
			<td >��ַ	</td>
		  </tr>
<%
  int rownum = 0;
  while(rs.next()){
    String member = Util.null2String(rs.getString("member"));
	String title = Util.null2String(rs.getString("title"));
	String company = Util.null2String(rs.getString("company"));
	String jobtitle = Util.null2String(rs.getString("jobtitle"));
	String address = Util.null2String(rs.getString("address"));
%>
	      <tr>
            <td>
             <input type='checkbox' name='check_node' value='0'>
           </td>
	        <TD class=Field> 
              <input type=text  name="member_<%=rownum%>" value="<%=member%>">
            </TD>
	        <TD class=Field> 
              <input type=text  name="title_<%=rownum%>" value="<%=title%>">
            </TD>
	        <TD class=Field> 
              <input type=text  name="company_<%=rownum%>" value="<%=company%>">
            </TD>
	        <TD class=Field> 
              <input type=text  name="jobtitle_<%=rownum%>" value="<%=jobtitle%>">
            </TD>
	        <TD class=Field> 
              <input type=text  name="address_<%=rownum%>" value="<%=address%>">
            </TD>
	      </tr> 
<%
	rownum++;
  }
%>        
      </tbody>
       </table>
   </tr>
	
   </tbody>
</table>
</form>
 <script language=vbs>
sub onShowEduLevel(inputspan,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/educationlevel/EduLevelBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	inputspan.innerHtml = id(1)
	inputname.value=id(0)
	else 
	inputspan.innerHtml = ""
	inputname.value=""
	end if
	end if
end sub
 </script>
 <script language=javascript>
  function edit(){ 
    document.resourcepersonalinfo.operation.value="editper";
    document.resourcepersonalinfo.rownum.value=rowindex;
	document.resourcepersonalinfo.submit();
  }  

rowindex = <%=rownum%>;
function addRow()
{
	ncol = oTable.cols;
	oRow = oTable.insertRow();
	
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(); 
		oCell.style.height=24;
		oCell.style.background= "#efefef";
		switch(j) {
            case 0:
				var oDiv = document.createElement("div");
				var sHtml = "<input type='checkbox' name='check_node' value='0'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;			
			case 1:
				var oDiv = document.createElement("div");
				var sHtml =  "<input type=text  name='member_"+rowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text  name='title_"+rowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			
			case 3: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text  name='company_"+rowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
            case 4: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text  name='jobtitle_"+rowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
		    case 5: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text  name='address_"+rowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;				
		}
	}
	rowindex = rowindex*1 +1;
	document.resource.rownum.value = rowindex;
}

function deleteRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
    for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node')
			rowsum1 += 1;
	} 
	
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node'){
			if(document.forms[0].elements[i].checked==true) {
				oTable.deleteRow(rowsum1+2);	
			}
			rowsum1 -=1;
		}	
	}	
}
function isdel(){
	if(confirm("��ȷ��ɾ����")){
		return true;
	}else{
		return false;
	}
}
</script> 
</body>
<SCRIPT language="javascript"  src="/js/datetime.js"></script>
<SCRIPT language="javascript"  defer="defer" src="/pweb/pwebJsDatetime/WdatePicker.js"></script>
</html>
