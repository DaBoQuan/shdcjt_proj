<%@ page import="java.math.*,weaver.conn.*" %>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page"/>
<jsp:useBean id="BudgetfeeTypeComInfo" class="weaver.fna.maintenance.BudgetfeeTypeComInfo" scope="page"/>

<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/workflow/request/WorkflowViewRequestTitle.jsp" %>
<form name="frmmain" method="post" action="BillHrmScheduleMainOperation.jsp">
    <%@ include file="/workflow/request/WorkflowViewRequestBody.jsp" %>
    
    <table class=viewform>
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

            RecordSet.executeProc("workflow_FieldForm_Select",nodeid+"");
            while(RecordSet.next()){
                String thefieldid = Util.null2String(RecordSet.getString("fieldid")) ;
                int thefieldidindex = fieldids.indexOf( thefieldid ) ;
                if( thefieldidindex == -1 ) continue ;
                String theisview = Util.null2String(RecordSet.getString("isview")) ;
                if( theisview.equals("1") ) colcount ++ ;
                isfieldids.add(thefieldid);
                isviews.add(theisview);
            }

            if( colcount != 0 ) colwidth = 100/colcount ;


    %>
            <table class=liststyle cellspacing=1 id="oTable">
              <COLGROUP> 
              <tr class=header> 
   <%
            ArrayList viewfieldnames = new ArrayList() ;
            
            // �õ�ÿ���ֶε���Ϣ����ҳ����ʾ
            int detailfieldcount = -1 ;

            for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

                String fieldid=(String)fieldids.get(i);  //�ֶ�id
                String isview="0" ;    //�ֶ��Ƿ���ʾ

                int isfieldidindex = isfieldids.indexOf(fieldid) ;
                if( isfieldidindex != -1 ) {
                    isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
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
<%          
            BigDecimal countexpense = new BigDecimal("0") ;
            BigDecimal countrealfeefum = new BigDecimal("0") ;
            int countaccessory = 0 ;
            boolean isttLight = false;

            RecordSet.executeSql(" select * from Bill_HrmScheduleDetail where scheduleid ="+billid );
            while(RecordSet.next()) {
                isttLight = !isttLight ;
%>
              <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'> 
<%
                for(int i=0;i<fieldids.size();i++){         // ѭ����ʼ

                    String fieldid=(String)fieldids.get(i);  //�ֶ�id
                    String isview="0" ;    //�ֶ��Ƿ���ʾ

                    int isfieldidindex = isfieldids.indexOf(fieldid) ;
                    if( isfieldidindex != -1 ) {
                        isview=(String)isviews.get(isfieldidindex);    //�ֶ��Ƿ���ʾ
                    }

                    String fieldname = "" ;                         //�ֶ����ݿ���е��ֶ���
                    String fieldhtmltype = "" ;                     //�ֶε�ҳ������
                    String fieldtype = "" ;                         //�ֶε�����
                    String fieldlable = "" ;                        //�ֶ���ʾ��
                    int languageid = 0 ;

                    languageid = user.getLanguage() ;
                    fieldname=(String)fieldnames.get(i);
                    fieldhtmltype=(String)fieldhtmltypes.get(i);
                    fieldtype=(String)fieldtypes.get(i);

                    String fieldvalue =  Util.null2String(RecordSet.getString(fieldname)) ;
                    
                    if( ! isview.equals("1") ) continue ;
                    else {
%>                  
                      <td class=field style="TEXT-VALIGN: center"> 
                      <%
                        if(fieldhtmltype.equals("1") || fieldhtmltype.equals("2")){                          // �����ı��� , �����ı���
                      %>
                      <%=Util.toScreen(fieldvalue,user.getLanguage())%>
                      <%
                        }                                                   // �����ı�������ı�����������
                        else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
                            String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
                            String linkurl =BrowserComInfo.getLinkurl(fieldtype);   // ���ֵ�����ʱ�����ӵ�url
                            String showname = "";                                                   // ֵ��ʾ������
                            String showid = "";                                                     // ֵ
                            
                            
                            if(fieldtype.equals("2") ||fieldtype.equals("19")  )	showname=fieldvalue; // ����ʱ��
                            else if(!fieldvalue.equals("")) {
                                String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                                String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
                                
                                if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                                }
                                else {
                                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                                }
                                
                                RecordSet rs3 = new RecordSet() ;
                                rs3.executeSql(sql);
                                while(rs3.next()){
                                    showid = Util.null2String(rs3.getString(1)) ;
                                    String tempshowname= Util.toScreen(rs3.getString(2),user.getLanguage()) ;
                                    if(!linkurl.equals(""))
                                    {
                        				if("/hrm/resource/HrmResource.jsp?id=".equals(linkurl))
                                    	{
                                    		showname = "<a href='javaScript:openhrm(" + showid + ");' onclick='pointerXY(event);'>" + tempshowname + "</a>&nbsp";
                                    	}
                        				else
                        					showname += "<a href='"+linkurl+showid+"&requestid="+requestid+"'>"+tempshowname+"</a> " ;
                        			} 
                                    else 
                                        showname += tempshowname ;
                                }
                            }
                       %>
                        <%=showname%>
                       <%
                        }                                                       // �����ť��������                    
                        else if(fieldhtmltype.equals("4")) {                    // check��   
                       %>
                        <input type=checkbox value=1 name="field<%=fieldid%>" DISABLED <%if(fieldvalue.equals("1")){%> checked <%}%>>
                       <%   
                        }                                                       // check����������
                        else if(fieldhtmltype.equals("5")){                     // ѡ���   select
                       %>
                        <select name="field<%=fieldid%>"  DISABLED >
                       <%
                            // ��ѯѡ�������п���ѡ���ֵ
                            rs.executeProc("workflow_SelectItemSelectByid",""+fieldid+flag+isbill);  
                            while(rs.next()){
                                String tmpselectvalue = Util.null2String(rs.getString("selectvalue"));
                                String tmpselectname = Util.toScreen(rs.getString("selectname"),user.getLanguage());
                       %>
                        <option value="<%=tmpselectvalue%>" <%if(fieldvalue.equals(tmpselectvalue)){%> selected <%}%>><%=tmpselectname%></option>
                       <%
                            }
                       %>
                        </select>
                       <%
                        }                                          // ѡ����������� ���������ж�����
                       %>
                      </td>
<%
                    }
                }
%>
              </tr>
<%          }   %>
            </table>
            </td>
        </tr>
    </table>
    <br>

    <%@ include file="/workflow/request/WorkflowViewSign.jsp" %>
</form>

