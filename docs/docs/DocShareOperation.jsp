<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>

<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.docs.docs.DocComInfo" %>
<%@ page import="weaver.docs.docs.DocInfo" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="DocViewer" class="weaver.docs.docs.DocViewer" scope="page"/>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="ApproveParameter" class="weaver.workflow.request.ApproveParameter" scope="page"/>
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="DocApproveWfManager" class="weaver.docs.docs.DocApproveWfManager" scope="page" />
<jsp:useBean id="AppDetachComInfo" class="weaver.hrm.appdetach.AppDetachComInfo" scope="page"/>

<jsp:useBean id="SpopForDoc" class="weaver.splitepage.operate.SpopForDoc" scope="page"/>
<%
String docsubject= Util.null2String(request.getParameter("docsubject"));


boolean blnOsp = "true".equals(request.getParameter("blnOsp"));  //���ڴ�Ź������ѶԻ��������

char flag=Util.getSeparator();
String ProcPara = "";
String id = Util.null2String(request.getParameter("id"));
String method = Util.null2String(request.getParameter("method"));
String docid = Util.null2String(request.getParameter("docid")); 
String relatedshareid = Util.null2String(request.getParameter("relatedshareid")); 
String sharetype = Util.null2String(request.getParameter("sharetype")); 
String rolelevel = Util.null2String(request.getParameter("rolelevel")); 
String seclevel = Util.null2String(request.getParameter("seclevel"));
String sharelevel = Util.null2String(request.getParameter("sharelevel"));

String userid = "0" ;
String departmentid = "0" ;
String subcompanyid="0";
String roleid = "0" ;
String foralluser = "0" ;
String crmid="0";
int sharecrm=0;
String orgGroupId="0";
if(sharetype.equals("1")) userid = relatedshareid ;
if(sharetype.equals("2")) subcompanyid = relatedshareid ;
if(sharetype.equals("3")) departmentid = relatedshareid ;
if(sharetype.equals("4")) roleid = relatedshareid ;
if(sharetype.equals("5")) foralluser = "1" ;
if(sharetype.equals("6")) orgGroupId = relatedshareid ;


//3:����
//user info
int userid_share=user.getUID();
String logintype_share = user.getLogintype();
String userSeclevel_share = user.getSeclevel();
String userType_share = ""+user.getType();
String userdepartment_share = ""+user.getUserDepartment();
String usersubcomany_share = ""+user.getUserSubCompany1();

boolean canEdit = false;
boolean canShare = false ;
String userInfo=logintype_share+"_"+userid_share+"_"+userSeclevel_share+"_"+userType_share+"_"+userdepartment_share+"_"+usersubcomany_share;
ArrayList PdocList = SpopForDoc.getDocOpratePopedom(""+docid,userInfo);
if (((String)PdocList.get(1)).equals("true")) canEdit = true ;
if (((String)PdocList.get(3)).equals("true")) canShare = true ;
if(canEdit){
    canShare = true;
}

if(method.equals("delete")){
	if(!canShare){
		response.sendRedirect("/notice/noright.jsp");
		return;
	}
	RecordSet.executeProc("DocShare_Delete",id);
    DocViewer.setDocShareByDoc(docid);
    response.sendRedirect("DocShare.jsp?docid="+docid);
	return;
}
if(method.equals("add")){
	if(!canShare){
		response.sendRedirect("/notice/noright.jsp");
		return;
	}	
	if(sharetype.equals("5")){
		
		List scopes = AppDetachComInfo.getAppDetachScopes(user.getUID()+"");
		if(scopes!=null&&scopes.size()>0){
			for(int i=0;i<scopes.size();i++) {
				Map scope = (Map) scopes.get(i);
				sharetype = (String)scope.get("type");
				
				userid = "0" ;
				departmentid = "0" ;
				subcompanyid="0";
				roleid = "0" ;
				rolelevel = Util.null2o((String)scope.get("rolelevel"));
				if(sharetype.equals("1")) userid = (String)scope.get("content");
				if(sharetype.equals("2")) subcompanyid = (String)scope.get("content");
				if(sharetype.equals("3")) departmentid = (String)scope.get("content");
				if(sharetype.equals("4")) roleid = (String)scope.get("content");
		
				ProcPara = docid;
				ProcPara += flag+sharetype;
				ProcPara += flag+seclevel;
				ProcPara += flag+rolelevel;
				ProcPara += flag+sharelevel;
				ProcPara += flag+userid;
				ProcPara += flag+subcompanyid;
				ProcPara += flag+departmentid;
				ProcPara += flag+roleid;
				ProcPara += flag+foralluser;
				ProcPara += flag+"0" ;              //  crmid 
				ProcPara += flag+orgGroupId ;              //  orgGroupId

				//RecordSet.executeProc("DocShare_IFromDocSecCategory",ProcPara);
				RecordSet.executeProc("DocShare_IFromDocSecCat_G",ProcPara);
			}
		}
		
	} else {
	
	
	ProcPara = docid;
	ProcPara += flag+sharetype;
	ProcPara += flag+seclevel;
	ProcPara += flag+rolelevel;
	ProcPara += flag+sharelevel;
	ProcPara += flag+userid;
	ProcPara += flag+subcompanyid;
	ProcPara += flag+departmentid;
	ProcPara += flag+roleid;
	ProcPara += flag+foralluser;
	ProcPara += flag+"0" ;              //  crmid 
	ProcPara += flag+orgGroupId ;              //  orgGroupId

	//RecordSet.executeProc("DocShare_IFromDocSecCategory",ProcPara);
	RecordSet.executeProc("DocShare_IFromDocSecCat_G",ProcPara);
	
	}
	
    response.sendRedirect("DocShare.jsp?docid="+docid); 
	return;
}


if(method.equals("addMutil")){   
	if(!canShare){
		response.sendRedirect("/notice/noright.jsp");
		return;
	}        
        String[] shareValues = request.getParameterValues("txtShareDetail"); 
        if (shareValues!=null) {
        	
			List scopes = AppDetachComInfo.getAppDetachScopes(user.getUID()+"");
			if(scopes!=null&&scopes.size()>0){
				List shareValueList = new ArrayList();
				String tseclevel = "0";
				String tsharelevel = "0";
				String tdownloadlevel = "1";
				boolean hasAll = false;
				
				for(int i=0;i<shareValues.length;i++) {
					String shareValue = shareValues[i];
					if(shareValue.startsWith("5_")){
						hasAll = true;
						String[] paras = Util.TokenizerString2(shareValues[i],"_");
						tseclevel=paras[3] ;
						tsharelevel=paras[4];
						if(paras.length >= 6) {
							tdownloadlevel=paras[5];
						}
					} else {
						shareValueList.add(shareValue);
					}
				}
				for(int i=0;hasAll&&i<scopes.size();i++) {
					Map scope = (Map) scopes.get(i);
					String shareValue = scope.get("type") + "_" + scope.get("content") + "_" + Util.null2o((String)scope.get("rolelevel")) + "_" + tseclevel + "_" + tsharelevel + "_" + tdownloadlevel;
					shareValueList.add(shareValue);
				}
				if(hasAll) shareValues = (String[]) shareValueList.toArray(new String[shareValueList.size()]);
			}
			
            for (int i=0;i<shareValues.length;i++){
               
                //out.println(shareValues[i]+"<br>");
                String[] paras = Util.TokenizerString2(shareValues[i],"_");
                sharetype = paras[0];
                seclevel=paras[3] ;
                sharelevel=paras[4] ;
				String downloadlevel=paras[5];//TD12005
				
                if(sharetype.equals("4")) {
                    roleid = paras[1] ;
                    rolelevel=paras[2] ;
                }

                if(sharetype.equals("5")) foralluser = "1" ;
                // for TD.4240 edit by wdl
                /*
                if(sharetype.equals("2")) { //�ֲ�
                   subcompanyid = paras[1] ;
                }*/
                if ("1".equals(sharetype)||"3".equals(sharetype)||"9".equals(sharetype)||sharetype.equals("2")||sharetype.equals("6")){  //1:��������Դ    3:�ಿ��   9://��ͻ�...2:��ֲ�	6:��Ⱥ��
                    String tempStrs[]=Util.TokenizerString2(paras[1],",");
                    for(int k=0;k<tempStrs.length;k++){
                        
                        String tempStr = tempStrs[k];
                        if ("1".equals(sharetype)) userid=tempStr;
                        if ("3".equals(sharetype)) departmentid=tempStr;
                        if ("9".equals(sharetype)) crmid=tempStr;
                        if ("2".equals(sharetype)) subcompanyid=tempStr;
                        if ("6".equals(sharetype)) orgGroupId=tempStr;
                        // end
                        
                        ProcPara = docid;
                        ProcPara += flag+sharetype;
                        ProcPara += flag+seclevel;
                        ProcPara += flag+rolelevel;
                        ProcPara += flag+sharelevel;
                        ProcPara += flag+userid;
                        ProcPara += flag+subcompanyid;
                        ProcPara += flag+departmentid;
                        ProcPara += flag+roleid;
                        ProcPara += flag+foralluser;
                        ProcPara += flag+crmid ;              //  crmid 
                        ProcPara += flag+orgGroupId ;              //  orgGroupId						
                        ProcPara += flag+downloadlevel;//TD12005
                        //System.out.println(ProcPara);
                        //RecordSet.executeProc("DocShare_IFromDocSecCategory",ProcPara);
                        RecordSet.executeProc("DocShare_IFromDocSecCat_G",ProcPara);
                    }                       
                } else {    
                   String tempUserId=""+user.getUID();
                   if("80".equals(sharetype)||"81".equals(sharetype)||"84".equals(sharetype)||"85".equals(sharetype)||"-80".equals(sharetype)||"-81".equals(sharetype)){ //�ĵ�������ID
                     String strSql="select doccreaterid from docdetail where id="+docid;
                     RecordSet.executeSql(strSql);
                     if (RecordSet.next()){
                       tempUserId=Util.null2String(RecordSet.getString(1));
                     }                     
                   }                    

                    ProcPara = docid;
                    ProcPara += flag+sharetype;
                    ProcPara += flag+seclevel;
                    ProcPara += flag+rolelevel;
                    ProcPara += flag+sharelevel;
                    ProcPara += flag+tempUserId;
                    ProcPara += flag+subcompanyid;
                    ProcPara += flag+departmentid;
                    ProcPara += flag+roleid;
                    ProcPara += flag+foralluser;
                    ProcPara += flag+"0" ;              //  crmid 
					ProcPara += flag+downloadlevel;//TD12005
					
                    //RecordSet.executeProc("DocShare_IFromDocSecCategory",ProcPara);
                    RecordSet.executeProc("DocShare_IFromDocSecCategoryDL",ProcPara);
                }
            
                //for (int j=0;j<paras.length;j++){
                //   out.println(paras[j]+"<br>");
                //}
                //out.println("==========================");
            }
        }	  
       
       response.sendRedirect("DocShare.jsp?docid="+docid+"&blnOsp="+blnOsp); 
	   return;
}
if(method.equals("delMShare")) {
	if(!canShare){
		response.sendRedirect("/notice/noright.jsp");
		return;
	}	
    String[] delShareIds = request.getParameterValues("chkShareId");    
    if (delShareIds!=null) {
        for (int i=0;i<delShareIds.length;i++){
            String delShareId = delShareIds[i];
            RecordSet.executeSql("delete docshare where id="+delShareId);
        }
        DocViewer.setDocShareByDoc(docid); 
    }
    response.sendRedirect("DocShare.jsp?docid="+docid+"&blnOsp="+blnOsp); 
	return;
}

if(method.equals("finish")) {
    //���й���
    DocViewer.setDocShareByDoc(docid);
    
    //����ǵ����򽫻��������̵Ĵ���//״̬�Ѿ���DocManager.java������
    if (blnOsp&&Util.getIntValue(docid,0)>0){
		if("-1".equals(DocComInfo.getDocStatus(docid))){
			RecordSet.executeSql("update DocDetail set docStatus='1' where id="+docid);
		}
		
		if("-6".equals(DocComInfo.getDocStatus(docid))){
			RecordSet.executeSql("update DocDetail set docStatus='6' where id="+docid);
		}
    	
        if (("-3".equals(DocComInfo.getDocStatus(docid))||"3".equals(DocComInfo.getDocStatus(docid)))&&SecCategoryComInfo.needApprove(DocComInfo.getDocSecCategory(docid))){//��Ҫ����
        	
        	if("-3".equals(DocComInfo.getDocStatus(docid)))
      			RecordSet.executeSql("update DocDetail set docStatus='3' where id="+docid);
        	
                    String approveType="1";
					int intDocId=0;
					if(docid!=null&&!docid.equals("")){
						intDocId=Integer.parseInt(docid);
					}
                    //DocApproveWfManager.approveWf(intDocId,approveType,user);


//          
                    int workflowId=-1;
					String isOpenApproveWf="";/*isOpenApproveWfΪ1��ʾ�����ĵ���Ч�������ĵ�ʧЧ���� ��isOpenApproveWfΪ2��ʾ������׼�����������ĵ�������ǰʹ�õ���׼�������� fanggsh 20060928 fot TD5032*/

                    RecordSet.executeSql("select approveWorkflowId,isOpenApproveWf from DocSecCategory where id="+DocComInfo.getDocSecCategory(docid));
                    if(RecordSet.next()) {
						workflowId=RecordSet.getInt("approveWorkflowId");
						isOpenApproveWf=Util.null2String(RecordSet.getString("isOpenApproveWf"));
                    }

					if(isOpenApproveWf.equals("1")){
						DocApproveWfManager.setRequest(request);
						String approveWfStatus=DocApproveWfManager.approveWf(intDocId,approveType,user);
						if("false".equals(approveWfStatus)){
							RecordSet.executeSql("update DocDetail set docStatus='0' where id="+intDocId);
							//RecordSet.executeSql("update DocDetail set isHistory='1',docStatus='7' where id<>"+intDocId+" and docEditionId=(select docEditionId from DocDetail where id="+intDocId+")");
							RecordSet.executeSql(" update docdetail set docstatus = 7,ishistory = 1 where id <> " + intDocId + " and docedition > 0 and docedition < (select docedition from DocDetail where id="+intDocId+") and doceditionid > 0 and doceditionid = (select docEditionId from DocDetail where id="+intDocId+")");
						}
					}

					if(workflowId>0&&isOpenApproveWf.equals("2")){
						//��������      
						ApproveParameter.resetParameter();
						ApproveParameter.setWorkflowid(workflowId);
						ApproveParameter.setNodetype("0");
						ApproveParameter.setApproveid(Util.getIntValue(docid));
						ApproveParameter.setApprovetype("9");
						ApproveParameter.setRequestname(docsubject);          
						ApproveParameter.setGopage("/docs/docs/DocApprove.jsp?id=");
						ApproveParameter.setBackpage("/docs/docs/DocApprove.jsp?id="); 
						if(ApproveParameter.getFormid()==67) {
							response.sendRedirect("/workflow/request/BillInnerSendDocOperation.jsp?docid="+docid+"&src=save&iscreate=1&blnOsp="+blnOsp);
						} else {
							RecordSet.executeSql("select a.requestid,a.requestname from workflow_requestbase a, bill_Approve b where a.workflowid="+workflowId+" and a.currentnodetype=0 and a.requestid=b.requestid and b.approveid="+docid);
								
							if(RecordSet.next()){//���ĵ���Ӧ�����������Ѵ���������������Ŀǰ���ڴ����ڵ�
							    String tempRequestid = RecordSet.getString(1);
							    String tempnodeid = ""+ApproveParameter.getNodeid();
							    String temprequestname = RecordSet.getString(2);
							    response.sendRedirect("/workflow/request/BillApproveOperation.jsp?workflowid="+workflowId+"&requestid="+tempRequestid+"&docid="+docid+"&src=submit&iscreate=0&blnOsp="+blnOsp+"&nodeid="+tempnodeid+"&nodetype=0&isbill=1&formid=28&requestname="+URLEncoder.encode(temprequestname) + "&isremark=0");
							}else{   
							response.sendRedirect("/workflow/request/BillApproveOperation.jsp?docid="+docid+"&src=submit&iscreate=1&blnOsp="+blnOsp);   
							}
						}  
						return;
					}




        }
      %>
            <SCRIPT LANGUAGE="JavaScript">   
           // alert(3)
           	 window.parent.returnValue="1"; 
            window.parent.close(); 
               
            </SCRIPT>
        <% 
           return ;                

    }
    //�ض���
    response.sendRedirect("DocDsp.jsp?id="+docid);
    return ;
}

if(method.equals("unfinish")) {
	//TD.6077 �½��������Ҫ�����������Ѵ��ڣ���δȷ��ֱ�ӹرգ���Ҫ���½��ĵ���زݸ�״̬
    if(("-3".equals(DocComInfo.getDocStatus(docid))||"3".equals(DocComInfo.getDocStatus(docid)))&&SecCategoryComInfo.needApprove(DocComInfo.getDocSecCategory(docid))){
	    RecordSet.executeSql("update docdetail set docstatus = '"+0+"' where id="+docid);
    } else if(!"0".equals(DocComInfo.getDocStatus(docid))&&SecCategoryComInfo.isSetShare(DocComInfo.getDocSecCategory(docid))){
    	RecordSet.executeSql("update docdetail set docstatus = '"+0+"' where id="+docid);
    }
    %>
    <SCRIPT LANGUAGE="JavaScript">
    //alert(2)
       window.parent.returnValue="1";   
       window.parent.close(); 
       
    </SCRIPT>
<% 
    return;
}
%>