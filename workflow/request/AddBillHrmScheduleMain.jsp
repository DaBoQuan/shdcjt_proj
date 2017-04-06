<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowAddRequestTitle.jsp" %>

<form name="frmmain" method="post" action="BillHrmScheduleMainOperation.jsp" enctype="multipart/form-data">
    <%@ include file="/workflow/request/WorkflowAddRequestBody.jsp" %>
    
    <table class=viewform>
        <tr><td height=15></td></tr>
        <tr>
            <td>
            <BUTTON Class=BtnFlow type=button accessKey=A onclick="addRow()"><U>A</U>-<%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></BUTTON>
            <BUTTON Class=BtnFlow type=button accessKey=E onclick="deleteRow1();"><U>E</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(16756,user.getLanguage())%>
            </td>
        </tr>
        <TR class=Spacing><TD class=Line1></TD></TR>
        </TR>
        <tr>
            <td>
            <%
            int colcount = 0 ;
            int colwidth = 0 ;
            fieldids.clear() ;
            fieldlabels.clear() ;
            fieldhtmltypes.clear() ;
            fieldtypes.clear() ;
            fieldnames.clear() ;
            fieldviewtypes.clear() ;

            RecordSet.executeProc("workflow_billfield_Select",formid+"");
            while(RecordSet.next()){
                String theviewtype = Util.null2String(RecordSet.getString("viewtype")) ;
                if( !theviewtype.equals("1") ) continue ;   // ����ǵ��ݵ������ֶ�,����ʾ

                fieldids.add(Util.null2String(RecordSet.getString("id")));
                fieldlabels.add(Util.null2String(RecordSet.getString("fieldlabel")));
                fieldhtmltypes.add(Util.null2String(RecordSet.getString("fieldhtmltype")));
                fieldtypes.add(Util.null2String(RecordSet.getString("type")));
                fieldnames.add(Util.null2String(RecordSet.getString("fieldname")));
                fieldviewtypes.add(theviewtype);
            }

            // ȷ���ֶ��Ƿ���ʾ���Ƿ���Ա༭���Ƿ��������
            isfieldids.clear() ;              //�ֶζ���
            isviews.clear() ;              //�ֶ��Ƿ���ʾ����
            isedits.clear() ;              //�ֶ��Ƿ���Ա༭����
            ismands.clear() ;              //�ֶ��Ƿ�����������

            RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
            while(RecordSet.next()){
                String thefieldid = Util.null2String(RecordSet.getString("fieldid")) ;
                int thefieldidindex = fieldids.indexOf( thefieldid ) ;
                if( thefieldidindex == -1 ) continue ;
                String theisview = Util.null2String(RecordSet.getString("isview")) ;
                if( theisview.equals("1") ) colcount ++ ;
                isfieldids.add(thefieldid);
                isviews.add(theisview);
                isedits.add(Util.null2String(RecordSet.getString("isedit")));
                ismands.add(Util.null2String(RecordSet.getString("ismandatory")));
            }

            if( colcount != 0 ) colwidth = 95/colcount ;


    %>
            <table class=liststyle cellspacing=1 id="oTable">
              <COLGROUP> 
              <tr class=header> 
                <td width="5%">&nbsp;</td>
   <%
            ArrayList viewfieldnames = new ArrayList() ;
            
            // �õ�ÿ���ֶε���Ϣ����ҳ����ʾ

            int detailfieldcount = -1 ;

            for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

                String fieldid=(String)fieldids.get(i);  //�ֶ�id
                String isview="0" ;    //�ֶ��Ƿ���ʾ
                String isedit="0" ;    //�ֶ��Ƿ���Ա༭
	            String ismand="0" ;    //�ֶ��Ƿ��������

                int isfieldidindex = isfieldids.indexOf(fieldid) ;
                if( isfieldidindex != -1 ) {
                    isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
                    isedit=(String)isedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
                    ismand=(String)ismands.get(isfieldidindex);    //�ֶ��Ƿ��������
                }
                if( ! isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��
                
                String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
                String fieldlable = "" ;                        //�ֶ���ʾ��
                int languageid = 0 ;                                                   
                
                fieldname=(String)fieldnames.get(i);
                languageid = user.getLanguage() ;
                fieldlable = SystemEnv.getHtmlLabelName( Util.getIntValue((String)fieldlabels.get(i),0),languageid );

                viewfieldnames.add(fieldname) ;
%>
                <td width="<%=colwidth%>%"><%=fieldlable%></td>
<%          }
%>
              </tr>
            </table>
            </td>
        </tr>
    </table>
    
    <input type='hidden' id=nodesnum name=nodesnum>
	<input type="hidden" name="needwfback" id="needwfback" value="1" />
</form>

<script language=javascript>

rowindex = 0 ;
deleteindex=0;

function addRow()
{
	oRow = oTable.insertRow(-1);

    oCell = oRow.insertCell(-1); 
    oCell.style.height=24;
    oCell.style.background= "#D2D1F1";
	    
    var oDiv = document.createElement("div");
    var sHtml = "<input type='checkbox' name='check_node' value='"+rowindex+"'>"; 
    oDiv.innerHTML = sHtml;
    oCell.appendChild(oDiv);
<%
    for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

        String fieldhtml = "" ;
        String fieldid=(String)fieldids.get(i);  //�ֶ�id
        
        String isview="0" ;    //�ֶ��Ƿ���ʾ
        String isedit="0" ;    //�ֶ��Ƿ���Ա༭
        String ismand="0" ;    //�ֶ��Ƿ��������

        int isfieldidindex = isfieldids.indexOf(fieldid) ;
        if( isfieldidindex != -1 ) {
            isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
            isedit=(String)isedits.get(isfieldidindex);    //�ֶ��Ƿ���Ա༭
            ismand=(String)ismands.get(isfieldidindex);    //�ֶ��Ƿ��������
        }
        if( ! isview.equals("1") ) continue ;           //����ʾ��������һ��ѭ��

        String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
        String fieldhtmltype = "" ;                     //�ֶε�ҳ������
        String fieldtype = "" ;                         //�ֶε�����
        String fieldlable = "" ;                        //�ֶ���ʾ��
        int languageid = user.getLanguage() ;
        fieldname=(String)fieldnames.get(i);
        fieldhtmltype=(String)fieldhtmltypes.get(i);
        fieldtype=(String)fieldtypes.get(i);
        
        if(ismand.equals("1"))  needcheck+=",field"+fieldid + "_" + i ;   //�����������,�����������ļ����

        // ���濪ʼ������ʾ�ֶ�
        
        if(fieldhtmltype.equals("1")){                          // �����ı���
            if(fieldtype.equals("1")){                          // �����ı����е��ı�
                if(isedit.equals("1")){
                    if(ismand.equals("1")) {
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=50 onChange='checkinput1(field"+fieldid+"_\"+rowindex+\",field"+fieldid+"_\"+rowindex+\"span)'><span id='field"+fieldid+"_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ;
                    }else{
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' value='' size=50>";
                    }
                }
            }
            else if(fieldtype.equals("2")){                     // �����ı����е�����
                if(isedit.equals("1")){
                    if(ismand.equals("1")) {
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=10 onKeyPress='ItemCount_KeyPress()' onBlur='checkcount1(this);checkinput1(field"+fieldid+"_\"+rowindex+\",field"+fieldid+"_\"+rowindex+\"span)'><span id='field"+fieldid+"_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ; 
                    }else{
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=10 onKeyPress='ItemCount_KeyPress()' onBlur='checkcount1(this)'>" ;
                    }
                }
            }
            else if(fieldtype.equals("3")){                     // �����ı����еĸ�����
                if(isedit.equals("1")){
                    if(ismand.equals("1")) {
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=10 onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this);checkinput1(field"+fieldid+"_\"+rowindex+\",field"+fieldid+"_\"+rowindex+\"span)'><span id='field"+fieldid+"_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ;
                    }else{
                        fieldhtml = "<input type=text name='field"+fieldid+"_\"+rowindex+\"' size=10 onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this)'>" ;
                    }
                }
            }
        }                                                       // �����ı�����������
        else if(fieldhtmltype.equals("2")){                     // �����ı���
            if(isedit.equals("1")){
                if(ismand.equals("1")) {
                    fieldhtml = "<textarea name='field"+fieldid+"_\"+rowindex+\"' onChange='checkinput1(field"+fieldid+"_\"+rowindex+\",field"+fieldid+"_\"+rowindex+\"span)' rows='4' cols='40' style='width:80%'></textarea><span id='field"+fieldid+"_\"+rowindex+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ; 
                }else{
                    fieldhtml = "<textarea name='field"+fieldid+"_\"+rowindex+\"' rows='4' cols='40' style='width:80%'></textarea>" ;
                }
            }
        }                                                           // �����ı�����������
        else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
            String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
            String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
            String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
            String showid = "";                                     // �½�ʱ��Ĭ��ֵ

            if(fieldtype.equals("8") && !prjid.equals("")){       //�����ťΪ��Ŀ,��ǰ��Ĳ����л����ĿĬ��ֵ
                showid = "" + Util.getIntValue(prjid,0);
            }else if((fieldtype.equals("9") || fieldtype.equals("37")) && !docid.equals("")){ //�����ťΪ�ĵ�,��ǰ��Ĳ����л���ĵ�Ĭ��ֵ
                showid = "" + Util.getIntValue(docid,0);
            }else if((fieldtype.equals("1") ||fieldtype.equals("17")) && !hrmid.equals("")){ //�����ťΪ��,��ǰ��Ĳ����л����Ĭ��ֵ
                showid = "" + Util.getIntValue(hrmid,0);
            }else if((fieldtype.equals("7") || fieldtype.equals("18")) && !crmid.equals("")){ //�����ťΪCRM,��ǰ��Ĳ����л��CRMĬ��ֵ
                showid = "" + Util.getIntValue(crmid,0);
            }else if(fieldtype.equals("4") && !hrmid.equals("")){ //�����ťΪ����,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ�Ĳ��ŵõ�����Ĭ��ֵ)  
                showid = "" + Util.getIntValue(ResourceComInfo.getDepartmentID(hrmid),0);
            }else if(fieldtype.equals("24") && !hrmid.equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(ResourceComInfo.getJobTitle(hrmid),0);
            }else if(fieldtype.equals("32") && !hrmid.equals("")){ //�����ťΪְ��,��ǰ��Ĳ����л����Ĭ��ֵ(��������Դ��ְ��õ�ְ��Ĭ��ֵ)
                showid = "" + Util.getIntValue(request.getParameter("TrainPlanId"),0);				
            }

            if(showid.equals("0")) showid = "" ;
            
            if(! showid.equals("")){       // ���Ĭ��ֵ��Ӧ��Ĭ����ʾֵ,����Ӳ���id��ò�������
                String tablename=BrowserComInfo.getBrowsertablename(fieldtype);
                String columname=BrowserComInfo.getBrowsercolumname(fieldtype);
                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);
                String sql="select "+columname+" from "+tablename+" where "+keycolumname+"="+showid;

                RecordSet.executeSql(sql);
                if(RecordSet.next()) {
                    if(!linkurl.equals("")) 
                    {
        				if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                    	{
                    		showname = "<a href='javaScript:openhrm(" + showid + ");' onclick='pointerXY(event);'>" + RecordSet.getString(1) + "</a>&nbsp";
                    	}
        				else
        					showname = "<a href='"+linkurl+showid+"'>"+RecordSet.getString(1)+"</a>&nbsp";
        			}
                    else 
                        showname =RecordSet.getString(1) ;
                }
            }
            
            if(fieldtype.equals("2")){                              // �����ťΪ����
                showname = currentdate;
                showid = currentdate;
            }

            if(isedit.equals("1")){ 
                if( !fieldtype.equals("37") ) {    //  ���ĵ����⴦��
                    fieldhtml = "<button class=Browser onclick=onShowBrowser('"+fieldid+"_\"+rowindex+\"','"+url+"','"+linkurl+"','"+fieldtype+"','"+ismand+"') title='"+SystemEnv.getHtmlLabelName( 172 ,user.getLanguage() )+"'></button>" ; 
                } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
                    fieldhtml = "<button class=AddDocFlow onclick=onShowBrowser('"+fieldid+"_\"+rowindex+\"','"+url+"','"+linkurl+"','"+fieldtype+"','"+ismand+"')>"+SystemEnv.getHtmlLabelName( 611 ,user.getLanguage() )+"</button>&nbsp;&nbsp<button class=AddDocFlow onclick='onNewDoc("+fieldid+"_\"+rowindex+\")' title='"+SystemEnv.getHtmlLabelName( 82 ,user.getLanguage() )+"'>"+SystemEnv.getHtmlLabelName( 82 ,user.getLanguage() )+"</button>" ;
                 }
            }
            fieldhtml += "<input type=hidden name='field"+fieldid+"_\"+rowindex+\"' value='"+showid+"'><span id='field"+fieldid+"_\"+rowindex+\"span'>"+ Util.toScreen(showname,user.getLanguage()) ;
            
            if(ismand.equals("1") && showname.equals("")) {
               fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>" ; 
            }
            fieldhtml += "</span>" ; 
        }                                                       // �����ť��������                       
        else if(fieldhtmltype.equals("4")) {                    // check��   
            fieldhtml += "<input type=checkbox value=1 name='field"+fieldid+"_\"+rowindex+\"' " ; 
            
            if(isedit.equals("0"))  fieldhtml += "DISABLED" ;  
            
            fieldhtml += ">" ;
        }                                                       // check����������
        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
            fieldhtml += "<select name='field"+fieldid+"_\"+rowindex+\"' " ;
            if(isedit.equals("0")) fieldhtml += "DISABLED" ;
            fieldhtml += ">" ;
           
            // ��ѯѡ�������п���ѡ���ֵ
            char flag= Util.getSeparator() ;
            rs.executeProc("workflow_SelectItemSelectByid",""+fieldid+flag+isbill);  
            while(rs.next()){
                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
                fieldhtml += "<option value='"+tmpselectvalue+"'>"+tmpselectname+"</option>" ;
            }
            fieldhtml += "</select>" ;
        }                                          // ѡ����������� ���������ж�����
%>
        
        oCell = oRow.insertCell(-1);  
		oCell.style.height=24;
		oCell.style.background= "#D2D1F1";
	    
        var oDiv = document.createElement("div");
        var sHtml = "<%=fieldhtml%>" ; 
        oDiv.innerHTML = sHtml;
        oCell.appendChild(oDiv);
<%
    }       // ѭ������
%>
        
	rowindex = rowindex*1 +1;
    document.frmmain.nodesnum.value = rowindex ;
	
}


function deleteRow1()
{
    var flag = false;
	var ids = document.getElementsByName('check_node');
	for(i=0; i<ids.length; i++) {
		if(ids[i].checked==true) {
			flag = true;
			break;
		}
	}
    if(flag) {
		if(isdel()){
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
                        oTable.deleteRow(rowsum1);
                    }
                    rowsum1 -=1;
                }
            }
        }
    }else{
        alert('<%=SystemEnv.getHtmlLabelName(22686,user.getLanguage())%>');
		return;
    }
}	
</script> 


<script language=vbs>
sub onShowDate(spanname,inputname,ismand)
	returndate = window.showModalDialog("/systeminfo/Calendar.jsp",,"dialogHeight:320px;dialogwidth:275px")
	if returndate<>"" then
	    spanname.innerHtml= returndate
        inputname.value=returndate
	else
	    if ismand = 1 then
	        spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
        else 
            spanname.innerHtml = ""
        end if
        inputname.value= ""
	end if
end sub

sub onShowFeeType(spanname,inputname,ismand)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp?sqlwhere=where feetype='1'")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	spanname.innerHtml = id(1)
	inputname.value=id(0)
	else 
    if ismand = 1 then
	    spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
    else 
        spanname.innerHtml = ""
    end if
	inputname.value=""
	end if
	end if
end sub

sub onShowCustomer(spanname,inputname,ismand)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	spanname.innerHtml = id(1)
	inputname.value=id(0)
	else 
	if ismand = 1 then
	    spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
    else 
        spanname.innerHtml = ""
    end if
	inputname.value=""
	end if
	end if
end sub

sub onShowProject(spanname,inputname,ismand)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp")
	if NOT isempty(id) then
    if id(0)<> "" then
    spanname.innerHtml = id(1)
    inputname.value=id(0)
    else
    if ismand = 1 then
        spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
    else 
        spanname.innerHtml = ""
    end if
    inputname.value=""
    end if
	end if
end sub
</script>
<SCRIPT language="javascript" src="/js/selectDateTime.js"></script>
