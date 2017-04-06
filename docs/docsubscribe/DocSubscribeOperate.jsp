<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>
<%@ page import="weaver.docs.docSubscribe.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp"%>
<%@ include file="/docs/common.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="SysRemindWorkflow" class="weaver.system.SysRemindWorkflow" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="session" />
<jsp:useBean id="DocViewer" class="weaver.docs.docs.DocViewer" scope="page"/>
<jsp:useBean id="SptmForDoc" class="weaver.splitepage.transform.SptmForDoc" scope="page"/>

<%    
    char flag = 2 ;
    String ProcPara = "";  
    int docIdsLength = 0 ;    
    
    String operation = Util.null2String(request.getParameter("operation"));   
    String subscribeIds = Util.null2String(request.getParameter("subscribeIds"));
    String docIds = Util.null2String(request.getParameter("docIds"));
    Calendar today = Calendar.getInstance();
    String currentData = Util.add0(today.get(Calendar.YEAR), 4) +"-"+
                 Util.add0(today.get(Calendar.MONTH) + 1, 2) +"-"+
                 Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;


   if (operation.equals("add")){   //�����ĵ�����ҳ��    
        String[] subscribeDocIds = request.getParameterValues("docids"); 
        if (subscribeDocIds != null) docIdsLength = subscribeDocIds.length;  
    
        String searchCase = request.getParameter("searchCase");
        String subscribeDesc = Util.fromScreen(request.getParameter("subscribeDesc"),7);      
        String state = "1";                  //����״̬  1.������,2.����׼3.���ջ�
        int hrmId = user.getUID();  
        String subscribetype = user.getLogintype();
        for (int i=0 ;i<docIdsLength;i++){
             
            String docId =  subscribeDocIds[i];  
            String owenerId = DocComInfo.getDocOwnerid(docId);   
            String owenerType= DocComInfo.getUsertype(docId);            
            ProcPara = docId ;
            ProcPara += flag  + ""+hrmId ;
            ProcPara += flag  + owenerId ;
            ProcPara += flag  + currentData ;
            ProcPara += flag  + "" ;
            ProcPara += flag  + searchCase ;
            ProcPara += flag  + subscribeDesc ;
            ProcPara += flag  + "" ;
            ProcPara += flag  + "" ;
            ProcPara += flag  + state ;
            ProcPara += flag  + subscribetype ;
            ProcPara += flag  + owenerType ;
            
            //out.println(ProcPara+"<br>");
            rs.executeProc("DocSubscribe_Insert",ProcPara);  
            String requestname=SptmForDoc.getName1(""+user.getUID(),user.getLogintype())+"���������� "+DocComInfo.getDocname(docId);


            String remark=" ��<a target=_blank href=/docs/docsubscribe/DocSubscribeApprove.jsp>��׼</a>";
      
            SysRemindWorkflow.setDocSysRemind(requestname,0,user.getUID(),owenerId,remark);
        }
        response.sendRedirect("DocSubscribeHistory.jsp");

    } else if (operation.equals("approve")){                         
          ArrayList idList = Util.TokenizerString(subscribeIds,",");
          ArrayList docidList = Util.TokenizerString(docIds,",");
          String subScribeDescStr = "" ;
          
          for (int i=0 ;i<idList.size();i++){
               String id = (String)idList.get(i);
               String docId = (String)docidList.get(i);              
               String otherSubscribe = Util.null2String(request.getParameter("otherDocId_"+id));
              
              //�޸�subscribe��
               String updateSql = "update DocSubscribe set  state = '2' ,otherSubscribe = '"+otherSubscribe+"',approveDate='"+currentData+"' where id = "+id;
               // out.println(updateSql);
               rs.executeSql(updateSql);  
               
               //�õ������ߵ�id�Լ������ߵ�type
               String subscribeHrmId = "";
               String subscribetype = "";
               rs.executeSql("select hrmid,subscribetype from  DocSubscribe where id ="+id);
               if (rs.next()){
                   subscribeHrmId = Util.null2String(rs.getString("hrmid"));
                   subscribetype= Util.null2String(rs.getString("subscribetype"));   //1:�ڲ�  2:�ⲿ
               }
                
               //�޸Ĺ����
                if ("1".equals(subscribetype)){  
                    ProcPara = docId;
                    ProcPara += flag+"1"; 
                    ProcPara += flag+"10";
                    ProcPara += flag+"0"; 
                    ProcPara += flag+"1"; 
                    ProcPara += flag+subscribeHrmId;    
                    ProcPara += flag+"0"; 
                    ProcPara += flag+"0";  
                    ProcPara += flag+"0";    
                    ProcPara += flag+"0";    
                    ProcPara += flag+"0" ;          
                } else {
                    ProcPara = docId;
                    ProcPara += flag+"9"; 
                    ProcPara += flag+"10";
                    ProcPara += flag+"0"; 
                    ProcPara += flag+"1"; 
                    ProcPara += flag+"0";    
                    ProcPara += flag+"0"; 
                    ProcPara += flag+"0";  
                    ProcPara += flag+"0";    
                    ProcPara += flag+"0";    
                    ProcPara += flag+subscribeHrmId ;     
                }
                
                rs.executeProc("DocShare_IFromDocSecCategory",ProcPara);

                DocViewer.setDocShareByDoc(docId);
                subScribeDescStr+="<a target=_blank href=/docs/docs/DocDsp.jsp?id="+docId+"> "+DocComInfo.getDocname(docId)+" </a>&nbsp;&nbsp;";     
                
              String otherSubscribeDocNames ="";  
              if (!"".equals(otherSubscribe)){
                   String[] tempStr =  Util.TokenizerString2(otherSubscribe,",");
                   for (int j=0;j<tempStr.length;j++){
                       String docId2 = tempStr[j];
                         //�޸Ĺ����
                        if ("1".equals(subscribetype)){  
                            ProcPara = docId2;
                            ProcPara += flag+"1"; 
                            ProcPara += flag+"10";
                            ProcPara += flag+"0"; 
                            ProcPara += flag+"1"; 
                            ProcPara += flag+subscribeHrmId;    
                            ProcPara += flag+"0"; 
                            ProcPara += flag+"0";  
                            ProcPara += flag+"0";    
                            ProcPara += flag+"0";    
                            ProcPara += flag+"0" ;          
                        } else {
                            ProcPara = docId2;
                            ProcPara += flag+"9"; 
                            ProcPara += flag+"10";
                            ProcPara += flag+"0"; 
                            ProcPara += flag+"1"; 
                            ProcPara += flag+"0";    
                            ProcPara += flag+"0"; 
                            ProcPara += flag+"0";  
                            ProcPara += flag+"0";    
                            ProcPara += flag+"0";    
                            ProcPara += flag+subscribeHrmId ;     
                        }
                         
                        rs.executeProc("DocShare_IFromDocSecCategory",ProcPara);

                        DocViewer.setDocShareByDoc(docId2);                   
                        otherSubscribeDocNames += "&nbsp;<a target=_blank href=/docs/docs/DocDsp.jsp?id="+docId2+"> "+DocComInfo.getDocname(docId2)+" </a>&nbsp;";
                   }
               }  
                 //��������
                 String requestname="�ĵ� "+DocComInfo.getDocname(docId)+"���ĳɹ�!";
                 String   remark="������Ķ��ĵ��ĵ�&nbsp;<a target=_blank href=/docs/docs/DocDsp.jsp?id="+docId+">"+DocComInfo.getDocname(docId)+"</a>&nbsp;�ѱ�"+SptmForDoc.getName1(""+user.getUID(),user.getLogintype())+"��׼! ";

                 if (!"".equals(otherSubscribeDocNames)) remark += "����������׼��"+otherSubscribeDocNames+"��ƪ�ĵ�";
                 remark += " ����ϸ��Ϣ,���Բ鿴���Ķ�����ʷ!";                   
                 if ("1".equals(subscribetype)){   
                    SysRemindWorkflow.setDocSysRemind(requestname,0,user.getUID(),subscribeHrmId,remark);              
                 } else {
                    //�ⲿ�û�Ŀǰû��Ĭ������
                 }              
          }              
             response.sendRedirect("DocSubscribeApprove.jsp");        
    }else if (operation.equals("reject")){  
          String subScribeDescStr = "" ;
          ArrayList idList = Util.TokenizerString(subscribeIds,",");
          ArrayList docidList = Util.TokenizerString(docIds,",");
          for (int i=0 ;i<idList.size();i++){
			    String id = (String)idList.get(i);
                String docId = (String)docidList.get(i);     
			   
			   //�õ������ߵ�id
			   String subscribeHrmId = "";
               String subscribetype = "";
               rs.executeSql("select hrmid,subscribetype from  DocSubscribe where id ="+id);
               if (rs.next()){
                   subscribeHrmId = Util.null2String(rs.getString("hrmid"));
                   subscribetype= Util.null2String(rs.getString("subscribetype"));   //1:�ڲ�  2:�ⲿ
               }

			   //�޸Ĺ����
               if ("1".equals(subscribetype)){
			     rs.executeSql("delete from docshare where docid ="+docId+" and userid ="+subscribeHrmId +" and sharetype=1");
               }  else {
                    rs.executeSql("delete from docshare where docid ="+docId+" and crmid ="+subscribeHrmId +" and sharetype=1");
               }
               DocViewer.setDocShareByDoc(docId);                			    
			  
			   //��������
               String docName = DocComInfo.getDocname(docId);
			   String requestname="�����ĵ� <<"+docName+">> ���ܾ�!";
			   String  remark="�����붩�ĵ��ĵ� <"+docName+"> �ѱ�"+SptmForDoc.getName1(""+user.getUID(),user.getLogintype())+"�ܾ�! ";	
               if ("1".equals(subscribetype)){
                    SysRemindWorkflow.setDocSysRemind(requestname,0,user.getUID(),subscribeHrmId,remark);                    
               } else {
                    //�ⲿ�û�Ŀǰû��Ĭ������
               } 		   
			     
			   //�޸�subscribe��
			   String updateSql = "delete from DocSubscribe  where id = "+id;
			   // out.println(updateSql);
			   rs.executeSql(updateSql);  
          }              
             response.sendRedirect("DocSubscribeApprove.jsp");        
    }   else if (operation.equals("getback")){  //�ĵ��ջز���     
          ArrayList idList = Util.TokenizerString(subscribeIds,",");
          for (int i=0 ;i<idList.size();i++){
               String id = (String)idList.get(i);               
               String docId = "0";
               String subscribeHrmId = "0";
               String otherSubscribe="";
               String subscribetype="";

               rs.executeSql("select hrmid,docid,otherSubscribe,subscribetype from docsubscribe where id ="+id);
               if (rs.next()){
                    docId = Util.null2String(rs.getString("docid"));
                    subscribeHrmId = Util.null2String(rs.getString("hrmid"));
                    otherSubscribe=Util.null2String(rs.getString("otherSubscribe"));               
                    subscribetype= Util.null2String(rs.getString("subscribetype"));   //1:�ڲ�  2:�ⲿ
                }
                //�޸�subscribe��
                rs.executeSql("update docsubscribe set state ='3' where id ="+id);                          
              
               //ɾ�����docshare��¼   
               String deleteShareSql = "";
               if ("1".equals(subscribetype)){
                    deleteShareSql = "delete from DocShare where docid="+docId+" and userid="+subscribeHrmId +" and sharelevel=1 and (sharesource='' or sharesource is null)";
               } else {
                   deleteShareSql = "delete from DocShare where docid="+docId+" and crmid="+subscribeHrmId +" and sharelevel=1 and (sharesource='' or sharesource is null)";
               }
               rs.executeSql(deleteShareSql);
               
               //ɾ�����docsharedetail��¼
               String deleteShareDetailSql="";
               if ("1".equals(subscribetype)){
                    deleteShareDetailSql="delete from ShareinnerDoc where   sharelevel=1 and sharesource=0 and type=1 and sourceid="+docId+" and content="+subscribeHrmId;
               } else {
                   deleteShareDetailSql="delete from ShareouterDoc where  type=9 and sharelevel=1 and sharesource=0 and docid="+docId+" and content="+subscribeHrmId;
               }                 
                rs.executeSql(deleteShareDetailSql);

                if (!"".equals(otherSubscribe)){
                  String[] tempStrs =  Util.TokenizerString2(otherSubscribe,",");
                  for (int j=0 ;j<tempStrs.length;j++){
                      String tempDocid = tempStrs[j];
                      
                     //ɾ�����docshare��¼                       
                       if ("1".equals(subscribetype)){
                            deleteShareSql = "delete from DocShare where docid="+tempDocid+" and userid="+subscribeHrmId +" and sharelevel=1 and (sharesource='' or sharesource is null)";
                       } else {
                           deleteShareSql = "delete from DocShare where docid="+tempDocid+" and crmid="+subscribeHrmId +" and sharelevel=1 and (sharesource='' or sharesource is null)";
                       }
                       rs.executeSql(deleteShareSql);

                    //ɾ�����docsharedetail��¼
                   if ("1".equals(subscribetype)){
                        deleteShareDetailSql="delete from ShareinnerDoc where sourceid="+tempDocid+" and content="+subscribeHrmId +" and sharelevel=1 and type=1 and sharesource=0";
                   } else {
                       deleteShareDetailSql="delete from ShareouterDoc where sourceid="+tempDocid+" and content="+subscribeHrmId +" and sharelevel=1 and type=9 and sharesource=0";
                   }   
                    rs.executeSql(deleteShareDetailSql);
                  }
                
                }
          }           
           response.sendRedirect("DocSubscribeBack.jsp");
        
    }
%>
