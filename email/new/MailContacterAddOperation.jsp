<%@page import="weaver.email.MailSend"%>
<%@page import="weaver.email.domain.MailContact"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="cms" class="weaver.email.service.ContactManagerService" scope="page" />
<jsp:useBean id="gms" class="weaver.email.service.GroupManagerService" scope="page" />
<%@ include file="/systeminfo/init.jsp" %>
<%

			
			String method=Util.null2String(request.getParameter("method"));
			String id=Util.null2String(request.getParameter("id"));
			String mailUserName=Util.null2String(request.getParameter("mailUserName"));
			String mailUserEmail=Util.null2String(request.getParameter("mailUserEmail"));
			String mailUserDesc=Util.null2String(request.getParameter("mailUserDesc"));
			String mailUserMobileP=Util.null2String(request.getParameter("mailUserMobileP"));
			String mailUserTelP=Util.null2String(request.getParameter("mailUserTelP"));
			String mailUserIMP=Util.null2String(request.getParameter("mailUserIMP"));
			String mailUserAddressP=Util.null2String(request.getParameter("mailUserAddressP"));
			String mailUserTelW=Util.null2String(request.getParameter("mailUserTelW"));
			String mailUserFaxW=Util.null2String(request.getParameter("mailUserFaxW"));
			String mailUserCompanyW=Util.null2String(request.getParameter("mailUserCompanyW"));
			String mailUserDepartmentW=Util.null2String(request.getParameter("mailUserDepartmentW"));
			String mailUserPostW=Util.null2String(request.getParameter("mailUserPostW"));
			String mailUserAddressW=Util.null2String(request.getParameter("mailUserAddressW"));
		
			
		
			MailContact  mc=new MailContact();
			mc.setId(id);
			String returnvalue="";
			mc.setMailUserAddressP(mailUserAddressP);
			mc.setMailUserCompanyW(mailUserCompanyW);
			mc.setMailUserDepartmentW(mailUserDepartmentW);
			mc.setMailUserDesc(mailUserDesc);
			mc.setMailUserFaxW(mailUserFaxW);
			mc.setMailUserIMP(mailUserIMP);
			//�ʼ���ַ
			mc.setMailAddress(mailUserEmail);
			//�ֻ�
			mc.setMailUserTel(mailUserMobileP);
			//�绰
			mc.setMailUserTelW(mailUserTelW);
			//��λ
			mc.setMailUserTmailUserPostWelP(mailUserPostW);
			//mailUserAddressW
			mc.setMailUserTemailUserAddressWlP(mailUserAddressW);
			mc.setMailUserTelP(mailUserTelP);
			mc.setMailUserName(mailUserName);
			if("contacterAdd".equals(method)){
					if(cms.addContact(mc,user.getUID())!=-1){
						returnvalue="1";
					}else{
						returnvalue="-1";
					}
			}else if("contacterEdit".equals(method)){
					cms.editContact(mc,user.getUID());
					//�õ���ǰ�û������ݿ������������
					//String countGroup=","+gms.getGroupCountStr(user.getUID());
					//System.out.println("���ݿ������������"+countGroup);
					
					//�õ���Ҫ����ϵ����ӵ���Щ������ȥ
					String groupIds[] = request.getParameterValues("groupId");
					String tempstr="";
					if(null!=groupIds){
							for(int i=0;i<groupIds.length;i++){
								if(!"".equals(groupIds[i])){
									tempstr+=groupIds[i]+",";
								}
							}
						cms.addGroupToContact(tempstr,Util.getIntValue(id));
					}
					/* if(null!=countGroup){
							if(null!=groupIds){
								for(int i=0;i<groupIds.length;i++){
										//ɾ���������飬�õ���Ҫɾ������
										countGroup=countGroup.replaceAll(","+groupIds[i]+",", ",");
								}
							}
					}
					System.out.println("��Ҫɾ������Ϊ"+countGroup); */
					returnvalue="1";
			}
			//out.clear();
			//out.println(returnvalue);
			response.sendRedirect("/email/new/MailContacterAdd.jsp?id="+id+"&returnvalue="+returnvalue); 
%>

