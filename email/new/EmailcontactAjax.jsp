<%@page import="java.net.URLDecoder"%>
<%@page import="weaver.email.service.ContactManagerService"%>
<%@page import="weaver.email.sequence.MailContacterSequence"%>
<%@ page language="java" contentType="text/html; charset=gbk" %>
<jsp:useBean id="mrs" class="weaver.email.service.MailResourceService" scope="page" />
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="gms" class="weaver.email.service.GroupManagerService" scope="page" />
<%@ page import="net.sf.json.*" %>
<%
			
			String method = Util.null2String(request.getParameter("method"));
			String srzids = Util.null2String(request.getParameter("srzids")).toLowerCase();
			String srzname=Util.null2String(request.getParameter("srzname"));
			srzname=URLDecoder.decode(srzname, "utf-8");
			String sql="";
			if("haved".equals(method)&&!"".equals(srzname)){
				
				ArrayList arrylist=new ArrayList();
				ArrayList arrylist_id=new ArrayList();
				//��¼���������id��Ա
				ArrayList arrylist_newid=new ArrayList();
				String srzids_sz[]=srzids.split("@;");
				if(null!=srzids_sz&&!"".equals(srzids)){
						sql="select  mailaddress,id from MailUserAddress  where userId='"+user.getUID()+"'";
						rs.execute(sql);
						while(rs.next()){
							arrylist.add((rs.getString("mailaddress")+"").toLowerCase());
							arrylist_id.add(rs.getString("id"));
						}
						//�������ʼ���ϵ�ˣ������ݿ����Ƿ����
						for(int i=0;i<srzids_sz.length;i++){
							//��������ڣ��򴴽��µ���ϵ��
							if(!arrylist.contains(srzids_sz[i])){
								int ContacterId = MailContacterSequence.getInstance().get();
								//��������ϵ���ڵ�ǰ�û�����ϵ���в����ڣ��������û�����ǰ�û�����ϵ����
								String temp_name=srzids_sz[i];
								String e_name=temp_name.substring(0,temp_name.indexOf("@"));
								sql="insert into MailUserAddress (id,mailaddress,mailuserName,userid)values("+ContacterId+",'"+temp_name+"','"+e_name+"',"+user.getUID()+")";
								//System.out.println("�����µ��ʼ���ϵ��"+sql);
								rs.execute(sql);
								//��¼�µ���ϵ��id
								arrylist_newid.add(ContacterId);
							}
						}
						for(int i=0;i<srzids_sz.length;i++){
							for(int j=0;j<arrylist.size();j++){
								String temp_str=arrylist.get(j)+"";
								if(temp_str.equals(srzids_sz[i])){
									//��¼��(��ǰ�ʹ��ڵ�)����ϵ��id
									arrylist_newid.add(arrylist_id.get(j));
									break;
								}
							}
						}
				}
				if(gms.isNameRepeat(srzname, user.getUID())) {
					out.clear();
					out.print(0); //�����ظ�
				} else {
					int groupId = gms.createGroup(user.getUID(), srzname);
					if(groupId != -1) {
							//������ɹ�	
							String newpeople="";
							for(int i=0;i<arrylist_newid.size();i++){
									newpeople+=arrylist_newid.get(i)+",";
							}	
							ContactManagerService sj=new ContactManagerService();
							//�����г�Ա��ӵ�������ȥ
							//System.out.println(newpeople+"�����г�Ա��ӵ�������ȥ"+groupId);
							sj.addContactToGroup(newpeople,groupId);
							out.clear();
							out.println(1); //������ɹ�
					}else{
							out.clear();
							out.print(2); //������ʧ��
					}
				}
		}
%>