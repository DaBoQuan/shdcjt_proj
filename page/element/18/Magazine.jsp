<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="weaver.conn.*" %>
<%@ include file="/homepage/element/content/Common.jsp" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page import="java.io.BufferedReader" %>
<jsp:useBean id="dnm" class="weaver.docs.news.DocNewsManager" scope="page"/>
<jsp:useBean id="dm" class="weaver.docs.docs.DocManager" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="oDocManager" class="weaver.docs.docs.DocManager" scope="page"/>
<%
	/*
		������Ϣ
		--------------------------------------
		hpid:����ҳID
		subCompanyId:��ҳ�����ֲ��ķֲ�ID
		eid:Ԫ��ID
		ebaseid:����Ԫ��ID
		styleid:��ʽID
		
		������Ϣ
		--------------------------------------
		String strsqlwhere ��ʽΪ ����1^,^����2...
		int perpage  ��ʾҳ��
		String linkmode �鿴��ʽ  1:��ǰҳ 2:����ҳ
 
		
		�ֶ���Ϣ
		--------------------------------------
		fieldIdList
		fieldColumnList
		fieldIsDate
		fieldTransMethodList
		fieldWidthList
		linkurlList
		valuecolumnList
		isLimitLengthList

		��ʽ��Ϣ
		----------------------------------------
		String hpsb.getEsymbol() ����ͼ��
		String hpsb.getEsparatorimg()   �зָ��� 
	*/

%>
<%
//ͼƬ��С
int imgWidth=120;
int imgHeight = 108;

ArrayList magazineList=new ArrayList();
if(!"".equals(strsqlwhere))	magazineList=Util.TokenizerString(strsqlwhere,"^,^");
if(magazineList.size()<=0) return;

boolean hasImg=false;
boolean hasTitle=false;
boolean hasBrief=false;
boolean hasList=false;

if(fieldColumnList.contains("img")) hasImg=true;
if(fieldColumnList.contains("docsubject")) hasTitle=true;
if(fieldColumnList.contains("summary")) hasBrief=true;
if(fieldColumnList.contains("list")) hasList=true;


int index = fieldColumnList.indexOf("img");

if(index!=-1){
	String imgfieldId = (String)fieldIdList.get(index);
	String sql = "";
	
	if(hpc.getIsLocked(hpid).equals("1")) {
		sql="select imgsize from hpFieldLength where eid="+ eid + " and efieldid=" + imgfieldId+"" +" and userid="+hpc.getCreatorid(hpid)+" and usertype="+hpc.getCreatortype(hpid);
	}else{
    	sql="select imgsize from hpFieldLength where eid="+ eid + " and efieldid=" + imgfieldId+"" +" and userid="+hpu.getHpUserId(hpid,""+subCompanyId,user)+" and usertype="+hpu.getHpUserType(hpid,""+subCompanyId,user);
	}

    rs.execute(sql);
    if (rs.next()){
			String imgSize = Util.null2String(rs.getString("imgsize"));
			
			if(!"".equals(imgSize)){
				ArrayList imgSizeAry = Util.TokenizerString(imgSize,"*");
				imgWidth = Util.getIntValue((String)imgSizeAry.get(0),imgWidth);
				imgHeight = Util.getIntValue((String)imgSizeAry.get(1),imgHeight);
			}
    }
    
}

%>
<TABLE id="_contenttable_<%=eid%>" class=Econtent  width="100%" cellPadding='0' cellSpacing='0' <%if(magazineList.size()>0) out.println(" height='120px' ");%> >
   <TR>	
	<TD width=1px></TD>
	 <TD width='*' valign="top">
		<table  width="100%"  cellPadding='0' cellSpacing='0'>
		<%

		for(int i=0;i<magazineList.size();i++){
			String magzineType=(String)magazineList.get(i);
			String strList="";
			String typeName="";
			rs.executeSql("select name from WebMagazinetype where id="+magzineType);
			if(rs.next()) typeName=Util.null2String(rs.getString("name"));

			rs.executeSql("select id,name,releaseYear,docid from WebMagazine where typeID = " + magzineType+" order by id desc");
			
			strList+="<select style='width:70%' id=\"selectMagazine_"+i+"_"+eid+"\">";
			String firstMagazineId="";
			String firsDocId="";
			String firstReleaseYear="";
			String url="";
			String url2="";
			int row=1;
			String selected="";
			while(rs.next())	{
				String id=Util.null2String(rs.getString("id"));
				String name=Util.null2String(rs.getString("name"));
				String docid=Util.null2String(rs.getString("docid"));
				
				if(docid.startsWith(",")){
					docid = docid.replaceFirst(",","");
				}
				
				if(!"".equals(docid)) {
					int tempLoc=docid.indexOf(",");
					if(tempLoc!=-1) docid=docid.substring(0,tempLoc);
				}
				
				
				String releaseYear=Util.null2String(rs.getString("releaseYear"));
				if(row==1){
					firstMagazineId=id;
					firsDocId=docid;
					firstReleaseYear=releaseYear;
					url="/tom_magazine.jsp?typeID="+magzineType+"&id="+id+"";
					url2="/tom_magazine.jsp?typeID="+magzineType+"&id=";
					selected=" selected ";
					row++;
				}
			
				strList+="<option value=\""+id+"\" "+selected+">"+"<font class=font>"+releaseYear+SystemEnv.getHtmlLabelName(445,user.getLanguage())+name+"</font>"+"</option>";
				selected="";
			}

			strList+="</select>&nbsp;&nbsp;<img src='/images/go.gif' align=\"absmiddle\" border=0 style='cursor:hand' onmousemove='return false;' onclick=\"openMaginze(selectMagazine_"+i+"_"+eid+",'"+url2+"','"+linkmode+"')\">";
			
			String strImg="";
			String strTitle="";
			String strBrief="";
			String strContent="";
			String strDocSubject="";
			if("2".equals(linkmode)) url="javascript:openFullWindowForXtable('"+url+"')";	
			if(!"".equals(firsDocId)){
			    firsDocId=oDocManager.getNewDocid(firsDocId);
				ConnStatement statement=new ConnStatement();  
                String tempSql="";
                try{
                if((statement.getDBType()).equals("oracle")){
                     tempSql="select d1.docsubject,d2.doccontent from docdetail d1, DocDetailcontent d2  where d1.id=d2.docid and d1.id="+firsDocId;                    
                } else {
                    tempSql="select docsubject,doccontent from docdetail where id="+firsDocId;
                }
                statement.setStatementSql(tempSql) ;	
                statement.executeQuery();			
				
				
				if(statement.next()) {
					strDocSubject= statement.getString("docsubject");
				    if((statement.getDBType()).equals("oracle")){
                         CLOB theclob = statement.getClob("doccontent");
                         String readline = "";
                         StringBuffer clobStrBuff = new StringBuffer("");
                         BufferedReader clobin = new BufferedReader(theclob.getCharacterStream());
                         while ((readline = clobin.readLine()) != null) clobStrBuff = clobStrBuff.append(readline);
                         clobin.close() ;
                         strContent = clobStrBuff.toString();
                     }else{
                         strContent=Util.null2String(statement.getString("doccontent"));
                     }
						
								
					int tmppos = strContent.indexOf("!@#$%^&*");		
					if (tmppos != -1) strBrief = strContent.substring(0, tmppos);
					
					strImg = hpes.getImgPlay(request,firsDocId,strContent,imgWidth,imgHeight,hpc.getStyleid(hpid),eid);			
					

					if(hasTitle){
						strTitle=Util.null2String(strDocSubject);
						String titleFiledid=(String)fieldIdList.get(fieldColumnList.indexOf("docsubject"));
						strTitle="<a href=\""+url+"\" >"+"<font class=font>"+hpu.getLimitStr(eid,titleFiledid ,strTitle,user,hpid,subCompanyId)+"</font>"+"</a>";
					}

					if(hasBrief){						
						String brifFiledid=(String)fieldIdList.get(fieldColumnList.indexOf("summary"));	
						strBrief="<a href=\""+url+"\" >"+"<font class=font>"+hpu.getLimitStr(eid,brifFiledid,strBrief,user,hpid,subCompanyId)+"</font>"+"</a>";
					}
					
					
				}
                }finally{
                	statement.close();
                }
			}


			String imgSymbol="";
			if (!"".equals(esc.getIconEsymbol(hpec.getStyleid(eid)))) imgSymbol="<img name='esymbol' src='"+esc.getIconEsymbol(hpec.getStyleid(eid))+"'>";
		%>


		<tr>
			<td>
				<table width="100%" valign="top" >
				<tr>
					<td  valign="top">
					<%if(hasImg) out.println(strImg);%>
					</td>
					<td  width="100%" valign="top">
						<table width="100%" class="magzine" >
						<tr>
							<td><b><%=imgSymbol%><%=strTitle%></b></td>
						</tr>

						<tr class='sparator' style="height:1px"><td style='padding:0px'></td></tr>

						<tr>
							<td><%if(hasBrief) out.println(strBrief);%></td>
						</tr>						

						</table>						

						<table  width="100%" cellPadding='0' cellSpacing='0'>
						<tr>
							<td><%if(hasList) out.println(strList);%></td>
						</tr>
						</table>					
					</td>
				</tr>				
				</table>
			</td>
		</tr>
		<%if(i+1<magazineList.size()){%>
				<TR class='sparator' style="height:1px" height=1px><td style='padding:0px'></td></TR>
		<%}%>
		<%
		}
		%>
		</table>

	</TD>    
	<TD width=1px></TD>
  </TR>
</TABLE>






