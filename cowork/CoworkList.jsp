<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.general.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<LINK href="/css/Weaver.css" type='text/css' rel='STYLESHEET'>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<style type="text/css">
	div.rtop,div.rbottom {background: #FFF;height:2px;overflow:hidden;line-height:2px}}
	div.rtop div {overflow: hidden;line-height:1px}
	div.rbottom div {overflow: hidden;line-height:1px}
	div.r2{margin: 0 1px ;padding:0px}
	div.r3{margin: 0 0.5px;padding:0px}
	.labelTitle{width:auto;font:9px verdana, arial, sans-serif !important;text-align:center;vertical-align:middle;padding-left:3px;padding-right:3px;}
	.label{float:left;margin-right:5px;} 
</style>
<%
int userid=user.getUID();
// �鿴����
String type = Util.null2String(request.getParameter("type"));
//��ע�Ļ���ֱ�Ӳ����Э��
String viewType = Util.null2String(request.getParameter("viewtype"));
//����ʽ
String orderType = Util.null2String(request.getParameter("orderType"));
//�Ƿ�����������
String isSearch = Util.null2String(request.getParameter("isSearch"));
//�ؼ���
String name = Util.null2String(request.getParameter("name"));
//Э����ID
String typeid = Util.null2String(request.getParameter("typeid"));
//Э��״̬
String status = Util.null2String(request.getParameter("status"));
//��������
String jointype = Util.null2String(request.getParameter("jointype"));
// ������
String creater = Util.null2String(request.getParameter("creater"));
//������
String principal = Util.null2String(request.getParameter("principal"));
//��ʼʱ��
String startdate = Util.null2String(request.getParameter("startdate"));
// ����ʱ��
String enddate = Util.null2String(request.getParameter("enddate"));

String labelid=Util.null2String(request.getParameter("labelid"));

String projectid=Util.null2String(request.getParameter("projectid"));
String taskIds=Util.null2String(request.getParameter("taskIds"));

String paramsStr="type="+type+"&orderType="+orderType+"&isSearch="+isSearch+"&name="+name+"&typeid="+typeid
+"&status="+status+"&jointype="+jointype+"&creater="+creater+"&principal="+principal+"&startdate="+startdate+"&enddate="+enddate+"&labelid="+labelid;

paramsStr+= "&projectid="+projectid+"&taskIds="+taskIds;

String searchStr="";
  if(isSearch.equals("true")){
	if(!name.equals("")){
		searchStr += " and name like '%"+name+"%' "; 
	}
	if(!typeid.equals("")){
		searchStr += "  and typeid='"+typeid+"'  ";
	}
	if(!status.equals("")){
		searchStr += " and status ="+status+"";
	}
	if(jointype.equals("")){        //���� ��ע
		searchStr += " and jointype is not null";
	}else if(jointype.equals("1")){ //��ע
		searchStr += " and jointype=1";
	}else if(jointype.equals("2")){ //����
		searchStr += " and jointype=0";
	}
	if(!creater.equals("")){
		searchStr += " and creater='"+creater+"'  ";
	}
	if(!principal.equals("")){
		searchStr += " and principal='"+principal+"'  "; 
	}
	if(!startdate.equals("")){
		searchStr +=" and begindate >='"+startdate+"'  ";
	}
	if(!enddate.equals("")){
		searchStr +=" and enddate <='"+enddate+"'  ";
	}
  }else{
    searchStr += " and status =1";
  }
String sqlStr ="";

int departmentid=user.getUserDepartment();   //�û���������
int subCompanyid=user.getUserSubCompany1();  //�û������ֲ�
String seclevel=user.getSeclevel();          //���ڰ�ȫ�ȼ�

//��ѯ����
sqlStr="select count(*) as total from ("+
		" select t1.id,t1.name,t1.status,t1.typeid,t1.creater,t1.principal,t1.begindate,t1.enddate,t1.remark,"+
		" case when  t3.sourceid is not null then 1 when t2.cotypeid is not null then 0 end as jointype,"+
		" case when  t4.coworkid is not null then 0 else 1 end as isnew,"+
		" case when  t5.coworkid is not null then 1 else 0 end as important,"+
		" case when  t6.coworkid is not null then 1 else 0 end as ishidden"+
		(type.equals("label")?" ,case when  t7.coworkid is not null then 1 else 0 end as islabel":"")+
		" from cowork_items  t1 left join "+
		//��ע��Э��
		" (select distinct cotypeid from  cotype_sharemanager where (sharetype=1 and sharevalue like '%,"+userid+",%' )"+
		" or (sharetype=2 and sharevalue like '%,"+departmentid+",%' and "+seclevel+">=seclevel) "+
		" or (sharetype=3 and sharevalue like '%,"+subCompanyid+",%'  and "+seclevel+">=seclevel)"+
		" or (sharetype=4 and exists (select id from hrmrolemembers  where resourceid="+userid+"  and  sharevalue=Cast(roleid as varchar(100))) and "+seclevel+">=seclevel)"+
		" or (sharetype=5 and "+seclevel+">=seclevel)"+
		" )  t2 on t1.typeid=t2.cotypeid left join "+
        //ֱ�Ӳ����Э��
		" (select distinct sourceid from coworkshare where"+
		" (type=1 and  (content='"+userid+"' or content like '%,"+userid+",%') )"+
		" or (type=2 and content like '%,"+subCompanyid+",%'  and "+seclevel+">=seclevel) "+
		" or (type=3 and content like '%,"+departmentid+",%' and "+seclevel+">=seclevel)"+
		" or (type=4 and exists (select id from hrmrolemembers  where resourceid="+userid+"  and content=Cast(roleid as varchar(100))) and "+seclevel+">=seclevel)"+
		" or (type=5 and "+seclevel+">=seclevel)"+
		" )  t3 on t3.sourceid=t1.id"+
        //�Ķ�|��Ҫ|����
		" left join (select distinct coworkid,userid from cowork_read where userid="+userid+")  t4 on t1.id=t4.coworkid"+       //�Ķ�״̬
		" left join (select distinct coworkid,userid from cowork_important where userid="+userid+" )  t5 on t1.id=t5.coworkid"+ //��Ҫ��
		" left join (select distinct coworkid,userid from cowork_hidden where userid="+userid+" )  t6 on t1.id=t6.coworkid"+    //�Ƿ�����
		(type.equals("label")?" left join (select distinct coworkid from cowork_item_label where labelid="+labelid+") t7 on t1.id=t7.coworkid":"")+ 
		" ) t where 1=1 and jointype is not null "+searchStr;

		if("unread".equals(type)){
			sqlStr=sqlStr+" and isnew=1 and ishidden<>1";
		}else if("important".equals(type)){
			sqlStr=sqlStr+" and important=1 and ishidden<>1";
		}else if("hidden".equals(type)){
			sqlStr=sqlStr+" and ishidden=1";
		}else if("all".equals(type)){
			sqlStr=sqlStr+" and ishidden<>1";
		}else if("coworkArea".equals(type)){
            sqlStr=sqlStr+" and ishidden<>1 and typeid="+typeid;
        }else if("label".equals(type))
        	sqlStr=sqlStr+" and ishidden<>1 and islabel=1";
       
       String total="0";
       ConnStatement statement=new ConnStatement();
       try{ 	
	   statement.setStatementSql(sqlStr);
	   statement.executeQuery();
	   if(statement.next())
	     total=statement.getString("total");
       }catch(Exception e){
    	 e.printStackTrace();  
       }finally{
    	 statement.close();
       }
%>
<script type="text/javascript">
var index=30;           //��ʼ��ȡ�±�
var hght=0;             //��ʼ���������ܳ�
var stop=0;              //��ʼ���������ĵ�ǰλ��
var preTop=0;           //������ǰһ��λ�ã����Ϲ���ʱ����������
var pagesize=30;        //ÿһ�ζ�ȡ���ݼ�¼��
var total=<%=total%>;   //��¼����
var disdirect=true;    //�Ƿ���ʾֱ�Ӳ���Ĭ����ʾ
var disattention=true; //�Ƿ���ʾ��עĬ����ʾ
var flag=false;         //ÿ�������Ƿ���ɱ�ǣ��������ٹ���Э�������޷����� �ɹ���������Ϊtrue
$(document).ready(function(){//DOM��onload�¼�
    var paramStr="<%=paramsStr%>"+"&name="+decodeURIComponent(decodeURIComponent("<%=name%>"));
    $.post("CoworkListInit.jsp?"+paramStr,{total:<%=total%>,index:index,pagesize:index,disdirect:disdirect,disattention:disattention},function(data){//����jquery��get�����õ�table.html����
		    $("#list_body").append(data);
		    $(".loading", window.parent.document).hide(); //���ؼ���ͼƬ
		    hght=0;//�ָ��������ܳ�����Ϊ$("#mypage").scroll�¼�һ�������ֻ�õ���ֵ�����ָ��Ļ����ܻ�����жϴ�����ٴμ��ء���
		    stop=0;//ԭ��ͬ�ϡ�
		    flag=true;
	});
    
	$("#listdiv").scroll( function() {//���������λ�øı�ʱ�������¼���
	    hght=this.scrollHeight;//�õ��������ܳ�������hght����
	    stop=this.scrollTop;//�õ���������ǰֵ������top����
	});
	
	if(jQuery(window.parent.document).find("#ifmCoworkItemContent")[0]!=undefined){
	     //�����������
	    jQuery(document.body).bind("mouseup",function(){
		   parent.jQuery("html").trigger("mouseup.jsp");	
	    });
	    jQuery(document.body).bind("click",function(){
			jQuery(parent.document.body).trigger("click");		
	    });
    }
	
});

var timeid; //��ʱ��

if(total>index){ 
   timeid=setInterval("cando();",500);
}
function cando(){  
	if(stop>parseInt(hght/5)&&preTop<stop){//�жϹ�������ǰλ���Ƿ񳬹��ܳ���1/3��parseIntΪȡ������,���¹���ʱ�ż�������
	    show();
	}
    preTop=stop;//��¼��һ��λ��
}

function show(){
    if(flag){
		index=index+pagesize;
		if(index>total){                    //����ȡ������������ʱ
		   pagesize=total-(index-pagesize); 
		   index=total;                     //ҳ��������������������
		   window.clearInterval(timeid);    //�����ʱ��
		}
		flag=false;
		var paramStr="<%=paramsStr%>"+"&name="+decodeURIComponent(decodeURIComponent("<%=name%>"));         
        $("#loadingdiv").show();         
	    $.post("CoworkListInit.jsp?"+paramStr,{orderType:"<%=orderType%>",sqlStr:"<%=sqlStr%>",total:<%=total%>,index:index,pagesize:pagesize,disdirect:disdirect,disattention:disattention},function(data){
			    $("#list_body").append(data);
			    $("#loadingdiv").hide();
			    hght=0;
			    stop=0;
			    flag=true;
		});
	}
}
</script>

<div id="listdiv" style="width: 100%;height: 100%;overflow:auto">
  <table id='list' class="ListStyle" cellspacing="1" style="margin:0px;width:100%">
	 	<colgroup>
		<col width="5px">
		<col width="8px">
		<col width="*">
		</colgroup>
		<tbody id="list_body">
		
		</tbody>
  </table>
  <div id="loadingdiv" style="position:relative;width: 100%;height: 30px;margin-bottom: 15px;display: none">
      <div class='loading' style="position: absolute;top: 10px;left: 20%;">
         <img src='/images/loadingext.gif' align="absMiddle"><%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>
      </div>
  </div>		
</div>

