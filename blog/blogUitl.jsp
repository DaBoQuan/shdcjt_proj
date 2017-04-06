<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="java.text.MessageFormat"%>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<script type="text/javascript">
function saveBlogItem(datas,url){
    var data0 = eval(datas);
    var returnValue = "";
    if (typeof data0 != "object") {
        return {
            status: '-1'
        };
    }
    else {
        jQuery.ajax({
            success: function(data){
                returnValue = jQuery.trim(data);
            },
            error: function(data){
                returnValue= jQuery.trim(data);
            },
            data: data0,
            url: url + "?t=" + new Date().getTime(),
            type: "post",
            async: false
        });
    }
	return eval('('+returnValue+')');
}

function getIndex(blogid){
  jQuery.post("blogOperation.jsp?operation=getIndex&blogid="+blogid,function(data){
        var index=eval('('+data+')');
        
        if(index.work){
           jQuery("#workIndex").html(index.work.workIndex); 
           jQuery("#workIndexCount").attr("title",index.work.workIndexTitle).html(index.work.workIndexStar);
        }
        if(index.mood){
           jQuery("#moodIndex").html(""+index.mood.moodIndex); 
           jQuery("#moodIndexCount").attr("title",index.mood.moodIndexTitle).html(index.mood.moodIndexStar);
        }
        
        if(index.schedule){
           jQuery("#scheduleIndex").html(""+index.schedule.scheduleIndex); 
           jQuery("#scheduleIndexCount").attr("title",index.schedule.scheduleIndexTitle).html(index.schedule.scheduleIndexStar);
        }
    });
}

function deleteDiscuss(obj,discussid,replyid){
	  if(window.confirm("<%=SystemEnv.getHtmlLabelName(26964,user.getLanguage())%>")){ //ȷ��ɾ������
		  var backInfo=saveBlogItem({'discussid':discussid,'replyid':replyid,'action':'del'},"blogCommentOparation.jsp");
		  if(backInfo.status=="1"){
			var dotedline=jQuery("#re_"+replyid).prev(".dotedline");
			if(dotedline.length==0){
				dotedline=jQuery("#re_"+replyid).next(".dotedline");
			}
			if(jQuery("#re_"+replyid).parent().find(".sortInfo").length==1){
				jQuery("#re_"+replyid).parent().remove();
			}
			dotedline.remove();
			jQuery("#re_"+replyid).remove();
		  }else if(backInfo.status=="-1"){
	        alert("<%=SystemEnv.getHtmlLabelName(27038,user.getLanguage())%>"); //����������
	        jQuery(obj).parents(".reply").find(".deleteOperation").hide();
		  }else if(backInfo.status=="-2"){
		    <%
		    Object object[]=new Object[1];
		    object[0]="10";
		    String message=MessageFormat.format(SystemEnv.getHtmlLabelName(27040,user.getLanguage()),object);%>
		    alert("<%=message%>");
		    jQuery(obj).parents(".reply").find(".deleteOperation").hide();
		 }
	  }
	}
	
function editContent(obj){
    
    //������״̬�ж�
    if(!checkServer())
        return;
	var tid=jQuery(obj).parents(".reportItem").attr("tid");
	var item=jQuery("div[tid="+tid+"]");
	displayLoading(1,"data");
	jQuery.post("blogOperation.jsp?operation=getDiscussContent&discussid="+tid,function(data){
	    var content=jQuery.trim(data);
		var editor=item.find(".editor[tid="+tid+"]");
		
		var workdate=item.attr("forDate");
		jQuery(".editorTmp").find(".uploadDiv").attr("id","uploadDiv_"+workdate);
		var editorTmp=jQuery(".editorTmp").html();
		
		editor.html(editorTmp);
		editor.show();
		editorId="text_"+new Date().getTime();
		editor.find("textarea[name=submitText]").attr("id",editorId);
		var height=item.find(".reportContent[tid="+tid+"]").height();
		highEditor(editorId,height+60);
		
		if(jQuery("#uploadDiv_"+workdate).length>0)
		   bindUploaderDiv(jQuery("#uploadDiv_"+workdate),"relatedacc",editorId);
		   
		KE.html(editorId,content);
		item.find(".discussView").css("display","none");
		var selectedQty=item.find(".qty_items_out[val="+item.attr("appItemId")+"]");
		var inputobj=item.find(".opt_mood_title");
		var valueobj=item.find("input[name=qty_mood]");
		jQuery(inputobj).html(jQuery(selectedQty).html());
		jQuery(valueobj).attr("value",item.attr("appItemId"));
		
		displayLoading(0);
		KE.util.focus(editorId);
	});
}
function saveContent(obj){
    //������״̬�ж�
    if(!checkServer())
        return;
    var item=jQuery(obj).parents(".reportItem");                 
	var forDate=item.attr("forDate");                              //������
	var isToday=item.attr("isToday");                              //�Ƿ�Ϊ�����ύ
	var todayItem=jQuery(".reportItem:first[isTodayItem=true]");   //�����Ѿ��ύ�ļ�¼
	var unsubmit=todayItem.attr("unsubmit");                       //�����Ƿ��ύ
	var editorId=item.find("textarea[name=submitText]").attr("id");
	var discussid=item.attr("tid");                                //΢����¼id
	var type="mood";
	var appItemId=item.find("input[name=qty_mood]").val();         //΢������id
	
	if(!KE.g[editorId].wyswygMode){
	    alert("<%=SystemEnv.getHtmlLabelName(27541,user.getLanguage())%>"); //�뽫�༭���л������ӻ�ģʽ��
	    return ;
	}    
	
	if(isToday=="true"&&todayItem.find(".discussView").is(":hidden")){
	   alert("<%=SystemEnv.getHtmlLabelName(27544,user.getLanguage())%>"); //��ȡ���Խ��칤��΢���ı༭
	   return ;
	}
	
	//��ȡ������ͼƬ��С
	jQuery(KE.g[editorId].iframeDoc.body).find("img").each(function(){
	   var imgWidth=jQuery(this).width();
	   jQuery(this).attr("imgWidth",imgWidth);
	});
	var content=KE.html(editorId);
	
	if(jQuery.trim(content)==""||(content.indexOf("<img")==-1&&jQuery.trim(jQuery(KE.g[editorId].iframeDoc.body).text().replace(/&nbsp;/g,' '))=="")){
		alert("<%=SystemEnv.getHtmlLabelName(23073,user.getLanguage())+SystemEnv.getHtmlLabelName(345,user.getLanguage())%>");  //���������� 
		return;
	}
	displayLoading(1,"save");
	
	//��Ϊ�����ύ�����ڽ����¼�Ѿ��ύ�ļ�¼������׷��ʱ��Ҫ����
	var contenttemp=content;
	if(isToday=="true"&&todayItem.length>0&&unsubmit!=="true")
	   content="<br>"+content;
	var backInfo=saveBlogItem({'discussid':discussid,'content':content,'forDate':forDate,'type':type,'appItemId':appItemId,'isEditor':'1'},"saveBlogOperation.jsp");
	
	if(backInfo.status=="1"){
	  if(isToday!="true"||todayItem.length==0||(isToday=="true"&&todayItem.length>0&&unsubmit=="true")){
	    
		var topBlogItem;
		if(isToday=="true"&&todayItem.length>0&&unsubmit=="true"){
		   topBlogItem=todayItem.find(".discussView");
		   topBlogItem.attr("appItemId",appItemId);
		}else{
		   topBlogItem=item.find(".discussView");
		   item.attr("appItemId",appItemId);
		}
		   
		var topBlogItemContent="";
		//�����ڽ����ύ��¼ʱ�����һ���ύ��¼
		if(isToday=="true"&&todayItem.length==0){
		   topBlogItemContent="<div class='reportItem' userid='"+backInfo.backdata.userid+"'  id="+backInfo.backdata.id+" tid="+backInfo.backdata.id+" forDate="+backInfo.backdata.forDate+"  appItemId='"+backInfo.backdata.appItemId+"'  isTodayItem='true' isToday='false'>"
		                       +"<table width='100%' style='TABLE-LAYOUT: fixed;'><tr><td valign='top' width='75px' nowrap='nowrap'><div class='dateArea'>"
		                       +"<div class='day'><%=SystemEnv.getHtmlLabelName(15537,user.getLanguage())%></div><div class='yearAndMonth'>"+new Date(backInfo.backdata.forDate.replace(/-/g,"/")).pattern("MM��dd��")+"</div></div></td><td valign='top'><div class='discussView'>";  
		}
		topBlogItemContent=topBlogItemContent+"<div class='sortInfo' ><span style='float: left;'><span class='name'>&nbsp;<a href='viewBlog.jsp?blogid="+backInfo.backdata.userid+"' target='_blank'>"+backInfo.backdata.userName+"</a>&nbsp;</span>"
		+"<div class='state "+(backInfo.backdata.type=='1'?"after":"ok")+"' title='"+(backInfo.backdata.type=='1'?"<%=SystemEnv.getHtmlLabelName(26925,user.getLanguage())%>":"<%=SystemEnv.getHtmlLabelName(26924,user.getLanguage())%>")+"'></div><span class='datetime'>"+backInfo.backdata.createdatetime+"&nbsp;</span>"; // ������ �ύ��
		
		//�ϼ�����
		if(backInfo.backdata.isManagerScore=="1") //�����ϼ�����
		  topBlogItemContent+="<span isRaty='false' style='width: 100px' score='"+backInfo.backdata.score+"' readOnly='true' discussid='"+backInfo.backdata.id+"' target='blog_raty_keep_"+backInfo.backdata.id+"' class='blog_raty' id='blog_raty_"+backInfo.backdata.id+"'></span>";
		//����
		if(backInfo.backdata.faceImg!=undefined){
			topBlogItemContent+="<img id='moodIcon' style='margin-left: 2px;margin-right: 2px' width='16px' src='"+backInfo.backdata.faceImg+"' alt='"+backInfo.backdata.itemName+"'/>";
		}
		//΢����������
		if(backInfo.backdata.comefrom!="0"){
		    var comefrom=backInfo.backdata.comefrom;
		    var comefromTemp="";
		    if(comefrom=="1")  
		        comefromTemp="(����Iphone)";
		    else if(comefrom=="2")  
		        comefromTemp="(����Ipad)";
		    else if(comefrom=="3")  
		        comefromTemp="(����Android)";          
		    else if(comefrom=="4")  
		        comefromTemp="(����Web�ֻ���)";
		    else
		        comefromTemp="";
		    topBlogItemContent+="<span class='comefrom'>"+comefromTemp+"</span> ";	
		}
		
		topBlogItemContent+="</span><span class='sortInfoRightBar'>"
		+"	&nbsp;<span onclick=\"editContent(this)\" style='cursor:pointer'><a><%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%></a></span>" //�༭	
		+"&nbsp;<span style='cursor:pointer' onclick=\"showReplySubmitBox(this,'"+backInfo.backdata.id+"',{'uid':'"+backInfo.backdata.userid+"','level':'0'},0)\"><a><%=SystemEnv.getHtmlLabelName(675,user.getLanguage())%></a></span>"
		+"&nbsp;<span style='cursor:pointer' onclick=\"showReplySubmitBox(this,'"+backInfo.backdata.id+"',{'uid':'"+backInfo.backdata.userid+"','level':'0'},1)\"><a>˽��</a></span>"
		+"</span></div><div class='clear reportContent' tid="+backInfo.backdata.id+">"+content+"</div>"
		
		//���༭�ļ�¼�а����ظ�����ʱ������ظ����ݱ����
		if (topBlogItem.find('.reply').length > 0) {
			topBlogItem.find('.reply').prevAll().remove();
			topBlogItem.find('.reply').before(topBlogItemContent);
		}else{
			if(isToday=="true"&&todayItem.length==0){
		       topBlogItemContent=topBlogItemContent+"</div><div class='commitBox'></div><div class='editor' tid="+backInfo.backdata.id+" style='display: none;'></div></td></tr></table></div>"
		    }else
			   topBlogItem.html(topBlogItemContent);
		}
		if(isToday=="true"&&todayItem.length==0){
		   item.after(topBlogItemContent);
		   item.next().find(".reportContent img").each(function(){
			   initImg(this); 
			});
		}else{
			topBlogItem.show();
			if(isToday=="true"&&todayItem.length>0&&unsubmit=="true"){
			    todayItem.find(".editor[tid=0]").attr("tid",backInfo.backdata.id);
			    todayItem.attr("tid",backInfo.backdata.id);
			    todayItem.attr("unsubmit",false);
			}    
			else{
				item.attr("tid",backInfo.backdata.id);
				if(item.find(".editor[tid=0]").length==1) //δ���������
				     item.find(".editor[tid=0]").attr("tid",backInfo.backdata.id).hide();
				else
				     item.find(".editor[tid="+backInfo.backdata.id+"]").hide();      
				item.attr("unsubmit",false);
			}
			topBlogItem.find(".reportContent img").each(function(){
			   initImg(this);
			});
		}
		managerScore(jQuery("#blog_raty_"+backInfo.backdata.id)[0]);//�ϼ����ֳ�ʼ��
	  }else{
	    if(todayItem.length>0){
	       var tempdiv=jQuery("<div>"+contenttemp+"</div>");
	       tempdiv.find("img").each(function(){
			   initImg(this);
			});
	       todayItem.find(".reportContent:first").append(tempdiv);
	       var selectedQty=item.find(".qty_items_out[val="+appItemId+"]");
	       var imgsrc=selectedQty.find("img").attr("src");
		   todayItem.find("#moodIcon").attr("src",imgsrc);
		   todayItem.attr("appItemId",appItemId);
	    }
	  }	
	  if(isToday=="true"){
		  KE.html(editorId,"");
		  KE.create(editorId);
	  }
	  KE.util.resize(editorId, KE.g[editorId].width,"150px"); //�ָ��༭��߶�
	  msgRemind();
	}else if(backInfo.status=="2"){
		alert("<%=SystemEnv.getHtmlLabelName(27037,user.getLanguage())%>"); //��������ʱ
	}else{
	    alert("<%=SystemEnv.getHtmlLabelName(21809,user.getLanguage())%>"); //����ʧ��
	}
	displayLoading(0);
}


/*replyid ���ظ�����id relatedid���ظ������������id */
function addAply(tm,tid,replyid,relatedid){
    //������״̬�ж�
    if(!checkServer())
        return; 
	var item=jQuery(tm).parents(".reportItem");
	var content=item.find("textarea[name=replayContent]").val();
	var workdate=item.attr("forDate");
	var bediscussantid=item.attr("userid");
	var commentType=jQuery(tm).parents(".commitBox").attr("commentType");
	

	if(""==jQuery.trim(content)){
		alert("<%=SystemEnv.getHtmlLabelName(26965,user.getLanguage())%>"); //����д��������'
		return;
	}
	if(content.indexOf("relatedid=\""+relatedid+"\"")==-1){
		replyid=0;
	}
	
	displayLoading(1,"save");
	var backInfo=saveBlogItem({'content':content,'action':'add','discussid':tid,'replyid':replyid,'relatedid':relatedid,'commentType':commentType,'workdate':workdate,'bediscussantid':bediscussantid},"blogCommentOparation.jsp");
	
	if(backInfo.status=="1"){
	    item.find(".deleteOperation").hide();
		var temp="";
		temp+="<div id=\"re_"+backInfo.backdata.id+"\"><div class=\"space\"></div><div class=\"sortInfo replyTitle\">"
			 +"<span class=\"name\">&nbsp;<a href='viewBlog.jsp?blogid="+backInfo.backdata.userid+"' target='_blank'>"+backInfo.backdata.username  
			 +"</a>&nbsp;</span>"
			 +"<div class=\"state re\" title='<%=SystemEnv.getHtmlLabelName(26926,user.getLanguage())%>'></div><span class=\"datetime\">"+backInfo.backdata.createdatetime+(backInfo.backdata.commentType=="1"?"&nbsp;<span class='comefrom'>(˽��)</span>":"") //������
			 +"&nbsp;</span><span class='sortInfoRightBar'><a href='javascript:void(0)' class='deleteOperation' onclick=\"deleteDiscuss(this,"+backInfo.backdata.discussid+",'"+backInfo.backdata.id+"')\"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a>" //ɾ��
			 +"&nbsp;<a href='javascript:void(0)' onclick=\"showReplySubmitBox(this,"+backInfo.backdata.discussid+",{'uid':'"+backInfo.backdata.userid+"','name':'"+backInfo.backdata.username+"','level':'1','replyid':'"+backInfo.backdata.id+"'},0)\"><%=SystemEnv.getHtmlLabelName(675,user.getLanguage())%></a>" //����
			 +"&nbsp;<a href='javascript:void(0)' onclick=\"showReplySubmitBox(this,"+backInfo.backdata.discussid+",{'uid':'"+backInfo.backdata.userid+"','name':'"+backInfo.backdata.username+"','level':'1','replyid':'"+backInfo.backdata.id+"'},1)\">˽��</a>" //˽��
			 +"</span></div><div class=\"clear reportContent\">"+content  
			 +"</div>";
			 if (item.find(".reply").length == 0) {
					item.find(".discussView").append("<div class=\"reply\" target=\""+tid+"\"></div>");
			}else{
				temp="<div class=\"dotedline\"></div>"+temp;
			}
			temp=temp+"</div>";
		item.find(".reply").append(temp);
		
		item.find(".reportContent img").each(function(){
		   initImg(this);
		});
		
		jQuery("textarea[name="+tid+"]").html("");
		jQuery(tm).parent().parent().hide();
		item.find(".commitBox").attr("state","0");
		jQuery(document.body).focus();
		item.find(".commitBox").html("");
	}
	else if(backInfo.status=="2"){
		alert("<%=SystemEnv.getHtmlLabelName(27037,user.getLanguage())%>"); //��������ʱ
	}
	displayLoading(0);
}


function showReplySubmitBox(obj,tid,extral,commentType){
    
	var content="";
	var item=jQuery(obj).parents(".reportItem");
	
	if(item.find(".commitBox").attr("state")== "1"){
	   alert("<%=SystemEnv.getHtmlLabelName(27543,user.getLanguage())%>");  //��ȡ�����ڱ༭������
	   return;
	}   
	
	var editorid=(new Date()).getTime();
	if(extral.level=="1"){
		//content="<a style='color:#1d76a4;' relatedid='"+extral.uid+"' unselectable='off' contenteditable='false' style='cursor:pointer'  href='javascript:void(0)' onclick='openBlog("+extral.uid+")'>@"+extral.name+"&nbsp;</a>";
	    content="<button type='button' relatedid='"+extral.uid+"' onclick='try{openBlog("+extral.uid+");}catch(e){}' style='border:medium none;padding:0px;margin:0px;;background:none;color:#1d76a4;cursor:pointer;font-family:΢���ź� !important;font-size:12px !important;font:none !important;height:18px !important;text-align:left;width:60px;' contenteditable='false'  unselectable='off'>@"+extral.name+"</button>&nbsp;";
	}
	var temp="";
	temp+="<span><%=SystemEnv.getHtmlLabelName(26965,user.getLanguage())%></span><br>"; //��������
	temp+="<textarea id='text_"+editorid+"' name='replayContent'>"+content+"</textarea>";
	temp+="<div class='appitem_bg'><input type=\"button\" class=\"commitBoxButton\" onclick=\"addAply(this,'"+tid+"'";
	if(extral.level=='1')
	  temp+=",'"+extral.replyid+"',"+extral.uid;
	else
	  temp+=",0,0";
	temp+=")\"><input type='button' class='editCancel' style='float:none'  onclick=\"replyCancel(this)\" value='<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%>'></div>"; //ȡ��
	item.find(".commitBox").append(temp);
	item.find(".commitBox").attr("state","1");
	item.find(".commitBox").attr("commentType",commentType);
	
	item.find(".commitBox").css("display","block");
	jQuery("#text_"+editorid).focus();
	highEditorForReply("text_"+editorid);
	
}

function replyCancel(obj){
    jQuery(document.body).focus(); //����ɾ��divʱ ҳ�潹�㶪ʧ
	var item=jQuery(obj).parents(".reportItem");
	item.find(".commitBox").css("display","none");
	item.find(".commitBox").attr("state","0");
	item.find(".commitBox").html("");
	
}
function editCancel(obj){
	jQuery(obj).parents(".editor").css("display", "none");
	jQuery(obj).parents(".reportItem").find(".discussView").css("display", "block");
	
}
function showAfterSubmit(obj){
	var item=jQuery(obj).parents(".reportItem");
	item.find(".discussView").css("display","none");
	var isToday=item.attr("isToday");
	var workdate=item.attr("forDate");
	var isNeedSubmit=item.attr("isNeedSubmit");
	if(isToday=="true")
	    workdate="";
	var editor=item.find(".editor");
	if(editor.find("textarea").length!=0){
		if(editor.css("display")=="none")
			editor.css("display","inline");
		else{
			//KE.html(editor.find("textarea").attr("id"),"");
		}
		return;
	}
	
	jQuery(".editorTmp").find(".uploadDiv").attr("id","uploadDiv_"+workdate);
	var editorTmp=jQuery(".editorTmp").html();
	
	editor.html(editorTmp);
	item.find(".editor").show();
	editor=item.find(".editor");
	editorId="text_"+new Date().getTime();
	editor.find("textarea[name=submitText]").attr("id",editorId);
	if(isNeedSubmit!=1&&isUsedTemp==1)
	   tempHeight=jQuery("#templatediv").height();
	jQuery("#templatediv").hide();
	highEditor(editorId,tempHeight+60);
	if(isNeedSubmit!=1&&isUsedTemp==1){
		  KE.html(editorId,jQuery("#templatediv").html());
	}
	
	if(jQuery("#uploadDiv_"+workdate).length>0)
       bindUploaderDiv(jQuery("#uploadDiv_"+workdate),"relatedacc",editorId);
    
	if(item.attr("isToday")=="false"){
		editor.find(".editCancel").css("display","inline");
	}else{
		editor.find(".editCancel").css("display","none");
	}
	//jQuery("#"+editorId).focus();
}

function showBlogNotes(){
    highEditor("notepadTextarea",240);
    if(jQuery("#uploadDiv_notes").length>0)
       bindUploaderDiv(jQuery("#uploadDiv_notes"),"relatedacc","notepadTextarea");
}

function afterSubmit(fordate){
		var item=jQuery("div[forDate="+fordate+"]");
		var content=KE.html("text_"+fordate);
		var backInfo=saveBlogItem({'content':content,'forDate':fordate},"saveBlogOperation.jsp");
		item.find(".state").removeClass("no").addClass("after");
		item.find(".state").after("<span class=\"datetime\"><%=SystemEnv.getHtmlLabelName(26925,user.getLanguage())%>:"+backInfo.backdata.curDate+" "+backInfo.backdata.curTime+"&nbsp;</span>"); //������
		item.find(".sortInfoRightBar").html("");
		item.find(".sortInfo").after("<div class=\"clear reportContent\"></div>");
		item.find(".reportContent").after("<div class=\"commitBox\"></div>");
		if(item.find(".state").hasClass("no")){
			item.find(".state").removeClass("no");
			item.find(".state").addClass("ok");
		}
		item.attr("tid",backInfo.backdata.id)
		item.find(".reportContent").html(content);
		item.find(".afterSubmit").remove();
		item.find(".unSumit").remove();
}


/*�߼��༭��*/
function highEditorForReply(remarkid){
    if(jQuery("#"+remarkid).is(":visible")){
		
		var  items=[
						'source','justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist', 'insertunorderedlist', 
						'title', 'fontname', 'fontsize',  'textcolor', 'bold','italic',  'strikethrough', 'advtable'
				   ];
			 
	    KE.init({
					id : remarkid,
					height : '150px',
					width:'auto',
					resizeMode:1,
					imageUploadJson : '/kindeditor/jsp/upload_json.jsp',
				    allowFileManager : false,
	                newlineTag:'br',
	                items : items,
				    afterCreate : function(id) {
						KE.util.focus(id);
				    }
	   });
	   KE.create(remarkid);
	}
}

	
/*�߼��༭��*/
function highEditor(remarkid,height){
    height=!height||height<150?150:height;
    if(jQuery("#"+remarkid).is(":visible")){
		
		var  items=[
						'source','justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist', 'insertunorderedlist', 
						'title', 'fontname', 'fontsize',  'textcolor', 'bold','italic',  'strikethrough', 'image', 'advtable','remote_image'
				   ];
			 
	    KE.init({
					id : remarkid,
					height :height+'px',
					width:'auto',
					resizeMode:1,
					imageUploadJson : '/kindeditor/jsp/upload_json.jsp',
				    allowFileManager : false,
	                newlineTag:'br',
	                items : items,
				    afterCreate : function(id) {
						KE.util.focus(id);
				    }
	   });
	   KE.create(remarkid);
	}
}


 function show_select(input,option,value,type,e,obj){
      e.cancelBubble=true;
	  inputobj=document.getElementById(input);
	  inputobj=obj;
	  optionobj=jQuery(obj).next();
	  valueobj=jQuery(obj).parent().find(".qty");
	  if(optionobj.css("display")==""){
	  	 optionobj.css("display","none");
	  	 return ;
	  }else{
	  	optionobj.css("display","");
	  }
	  optionobj.onblur=function () {
	    optionobj.style.display="none";
	  }
	  if(type=="mood"){
		 jQuery(inputobj).focus();
		 jQuery(optionobj).find("div").each(function(){
			     jQuery(this).hover(
			              function(){
			                  jQuery(this).addClass("qty_items_over");
			                  jQuery(this).removeClass("qty_items_out");
			              },
			              function(){
			                  jQuery(this).addClass("qty_items_out");
			                  jQuery(this).removeClass("qty_items_over");
			              }
			      );   
		          jQuery(this).click(function(){
		          	optionobj.hide();
		          	jQuery(inputobj).html(jQuery(this).html());
					jQuery(valueobj).val(jQuery(this).attr("val"));
		          });
		  });
	 }
	}

function search(content,startdate,enddate,obj,blogid){
	var content= jQuery("#"+content).val();
	var ac=jQuery(obj).attr("from");            //����ҳ��
	var startdate=jQuery("#"+startdate).val();
	var enddate=jQuery("#"+enddate).val();
	var url="discussList.jsp?requestType=search&t="+new Date().getTime();
	
	if(ac=="gz"&&""==jQuery.trim(content)){
		window.location="myAttention.jsp?startDate="+startdate+"&endDate="+enddate;
		return; 
	}
	
	displayLoading("1","search");
	jQuery.post(url+"&content="+content,{"startDate":startdate,"endDate":enddate,'blogid':blogid,'ac':ac},function(a){
	    
	    if(ac=="myBlog"){
	       jQuery(".tabStyle2").find(".select2").removeClass("select2");
	       jQuery("#blog").addClass("select2");
	    }   
		jQuery("#reportBody").html(a.replace(/<link.*?>.*?/, ''));
		
		if(""!=jQuery.trim(content)){
		   jQuery('#reportBody .reportItem').each(function(){
		      jQuery(this).find(".reportContent:first").highlight(content, {needUnhighlight: true});
		   });
		 }
		
		//ͼƬ��ʼ������  
		jQuery('.reportContent img').each(function(){
		    initImg(this);
		});   
		
		//�ϼ����ֳ�ʼ��
		jQuery(".blog_raty").each(function(){
		   managerScore(this);
		});
		
		displayLoading("0","search");
	});
}
function reset(startdate,enddate){
	jQuery("#"+startdate).val(jQuery("#"+startdate+"_").val());
	jQuery("#"+startdate+"span").text(jQuery("#"+startdate+"_").val());
	jQuery("#"+enddate).val(jQuery("#"+enddate+"_").val());
	jQuery("#"+enddate+"span").text(jQuery("#"+enddate+"_").val());
	jQuery("#content").val("");
}
//����
function unSumitRemind(obj,remindid,discussant,workdate){
    var isRemind=jQuery(obj).attr("isRemind");
    if(isRemind!="true"){
		jQuery.post("blogOperation.jsp?operation=unsubmitRemind&remindid="+remindid+"&discussant="+discussant+"&workdate="+workdate,function(){
		   jQuery(obj).text("<%=SystemEnv.getHtmlLabelName(27085,user.getLanguage())%>");//������
		   jQuery(obj).attr("isRemind","true");
		   jQuery(obj).css({'color':'red','cursor':'normal'});
		});
	 } 
	}
//ȫ������	
function unSumitRemindAll(obj,remindid,workdate){
  jQuery(obj).parents("table:first").find(".unSumitRemind").each(function(){
     jQuery(this).click();
  });
  jQuery(obj).text("<%=SystemEnv.getHtmlLabelName(332,user.getLanguage())+SystemEnv.getHtmlLabelName(27085,user.getLanguage())%>");//ȫ���Ѿ�����
  jQuery(obj).attr("isRemind","true");
  jQuery(obj).css({'color':'red','cursor':'normal'});
} 

//�ύ�ظ�ʱ���ύ�ȴ�
function displayLoading(state,flag){
  if(state==1){
        //���մ�
        var bgHeight=document.body.scrollHeight; 
        var bgWidth=window.parent.document.body.offsetWidth;
        jQuery("#bg").css("height",bgHeight,"width",bgWidth);
        jQuery("#bg").show();
        
        if(flag=="save")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(23278,user.getLanguage())%>");   //���ڱ��棬���Ե�...
        else if(flag=="page")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(19945,user.getLanguage())%>");   //ҳ������У����Ժ�...
        else if(flag=="data"||flag=="search")
           jQuery("#loadingMsg").html("<%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>");   //���ڻ�ȡ����,���Ե�...  
              
        //��ʾloading
	    var loadingHeight=jQuery("#loading").height();
	    var loadingWidth=jQuery("#loading").width();
	    jQuery("#loading").css({"top":document.body.scrollTop + document.body.clientHeight/2 - loadingHeight/2,"left":document.body.scrollLeft + document.body.clientWidth/2 - loadingWidth/2});
	    jQuery("#loading").show();
    }else{
        jQuery("#loading").hide();
        jQuery("#bg").hide(); //���չر�
    }
}

 /*chartType ��������  blog ΢�� mood���� 
  value��Ҫ�鿴����Ա���߲��š��ֲ�id 
  year ��� 
  type 1��Ա 2 �ֲ� 3 ���� 
  title�������
*/
function openChart(chartType,value,year,type,title){

    var diag = new Dialog();
    diag.Modal = true;
    diag.Drag=true;
	diag.Width = 680;
	diag.Height = 420;
	diag.ShowButtonRow=false;
	diag.Title = title;

	diag.URL = "blogChart.jsp?chartType="+chartType+"&value="+value+"&type="+type+"&year="+year+"&title="+title;
    diag.show();
 }
 
 //��ʼ��ͼƬ
 function initImg(obj){
       var imgWidth=jQuery(obj).attr("imgWidth");
	   if(imgWidth>400)
	      jQuery(obj).width(400);
	   else if(imgWidth==0)
	      jQuery(obj).width(400);   
	   else{
	      if(jQuery(obj).width()>400)
	         jQuery(obj).width(400);
	   }  
	   
	
	   jQuery(obj).coomixPic({
			path: 'js/weaverImgZoom/images',	// ����coomixPicͼƬ�ļ���·��
			preload: true,		// �����Ƿ���ǰ������Ұ�ڵĴ�ͼƬ
			blur: true,			// ���ü��ش�ͼ�Ƿ���ģ����������Ч��
			
			// ��������
		    left: '<%=SystemEnv.getHtmlLabelName(26921,user.getLanguage())%>',		// ����ת��ť����
		    right: '<%=SystemEnv.getHtmlLabelName(26922,user.getLanguage())%>',		// ����ת��ť����
		    source: '<%=SystemEnv.getHtmlLabelName(26923,user.getLanguage())%>',    // �鿴ԭͼ��ť����
			hide:'<%=SystemEnv.getHtmlLabelName(26985,user.getLanguage())%>'       //����
	   });
	
 }
 
  //�ϼ�����
 function managerScore(obj){
        if(jQuery(obj).attr("isRaty")=="true")
           return ;
           
        jQuery(obj).attr("isRaty","true"); 			       
	    var blog_raty_id=jQuery(obj).attr("id");
	    var score=jQuery(obj).attr("score");
	    var discussid=jQuery(obj).attr("discussid");
	    var readOnly=jQuery(obj).attr("readOnly");
	    var isReadOnly=false;
	    if(readOnly=="true")
	        isReadOnly=true;
	        
	    jQuery('#'+blog_raty_id).raty({
	       path:'js/raty/img/',
	       hintList:['1��', '2��', '3��', '4��', '5��'], //��
	       readOnly:isReadOnly,
	       start:score,
	       noRatedMsg:'<%=SystemEnv.getHtmlLabelName(27542,user.getLanguage())%>', //�ϼ�û������
	       click: function(score, evt) {
               jQuery.post("blogOperation.jsp?operation=managerScore&discussid="+discussid+"&score="+score)
           }
	    });
 }

   //��Ӧ�ó���
   function openApp(obj,type){
	   var editorId=jQuery(obj).parents(".editor").find("textarea[name=submitText]").attr("id");
	   var htmlstr=onShowApp(type);
	   if(htmlstr){      
	     if(KE.g[editorId].wyswygMode)
	        KE.insertHtml(editorId,htmlstr);
	     else
	        alert("<%=SystemEnv.getHtmlLabelName(27541,user.getLanguage())%>"); //�뽫�༭���л������ӻ�ģʽ��
	   }  
	}
  
  function onShowApp(type){
	   var id1;
       if(type=='doc')
	      id1 = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp?documentids=");
	   else if(type=='project')   
	      id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/MultiProjectBrowser.jsp?projectids=");
	   else if(type=='task')   
	      id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/MultiTaskBrowser.jsp?resourceids=");
	   else if(type=='crm')   
	      id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/MutiCustomerBrowser.jsp?resourceids=");
	   else if(type=='workflow')   
	      id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/request/MultiRequestBrowser.jsp?resourceids="); 
	   else if(type=="workplan")
		  id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workplan/data/WorkplanEventsBrowser.jsp");    
       if(id1){
	       var ids=id1.id;
	       var names=id1.name;
	       var desc=id1.resourcedesc
	       if(ids.length>500)
	          alert("��ѡ�������̫�࣬���ݿ⽫�޷����棬������ѡ��");
	       else if(ids.length>0){
	          var tempids=ids.split(",");
	          var tempnames=names.split(",");
	          var description=(true&&desc)?desc.split("\7"):"";
	          var sHtml="";
	          for(var i=0;i<tempids.length;i++){
	              var tempid=tempids[i];
	              var tempname=tempnames[i];
	              if(tempid!=''){
						if(type=="workplan"){
							var desc_i=description[i];
							sHtml = sHtml+"<br/><b><a style='' href='javascript:void(0)'  linkid="+tempid+" linkType='"+type+"' onclick='try{return openAppLink(this,"+tempid+");}catch(e){}' ondblclick='return false;'  unselectable='off' contenteditable='false' style='cursor:pointer;text-decoration:underline !important;margin-right:8px'>"+tempname+"</a></b>&nbsp<br/>"+
									"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+decodeURIComponent(desc_i);
						}else{
		                	sHtml = sHtml+"<a href='javascript:void(0)'  linkid="+tempid+" linkType='"+type+"' onclick='try{return openAppLink(this,"+tempid+");}catch(e){}' ondblclick='return false;'  unselectable='off' contenteditable='false' style='cursor:pointer;text-decoration:underline !important;margin-right:8px'>"+tempname+"</a>&nbsp";
						}
			        }
	          }
	          return sHtml;
	       }
       }
}
  
  
  //�Ķ���¼
  function readDiscuss(obj,discussid,blogid){
      var isRead=jQuery(obj).attr("isRead");
      jQuery(obj).css("background","#F5F5F5");
      if(isRead=="false"){
        jQuery(obj).attr("isRead","true");
        jQuery.post("blogOperation.jsp?operation=readDiscuss&discussid="+discussid+"&blogid="+blogid,function(){
            jQuery("#new_"+discussid).hide();
	        var count=jQuery("#homepage").find(".count").text();
	        count=count-1;
	        if(count>0)
	           jQuery("#homepage").find(".count").text(count);
	        else
	           jQuery("#homepage").find(".msg-count").hide();   
	        });
      }  
   }
   
   function moveout(obj){
     jQuery(obj).css("background","#fff");
   }
   
   //��Ӧ������
   function openAppLink(obj,linkid){
     
     var linkType=jQuery(obj).attr("linkType");
     var discussid=jQuery(obj).parents(".reportItem").attr("id");
     if(linkType=="doc")
        window.open("/docs/docs/DocDsp.jsp?id="+linkid+"&blogDiscussid="+discussid);
     else if(linkType=="task")   
        window.open("/proj/process/ViewTask.jsp?taskrecordid="+linkid+"&blogDiscussid="+discussid);
     else if(linkType=="crm")   
        window.open("/CRM/data/ViewCustomer.jsp?CustomerID="+linkid+"&blogDiscussid="+discussid);   
     else if(linkType=="workflow")   
        window.open("/workflow/request/ViewRequest.jsp?requestid="+linkid+"&blogDiscussid="+discussid);   
     else if(linkType=="project")   
        window.open("/proj/data/ViewProject.jsp?ProjID="+linkid+"&blogDiscussid="+discussid);   
     else if(linkType=="workplan")
    	 window.open("/workplan/data/WorkPlanDetail.jsp?workid="+linkid+"&from="+discussid);    
     return false;   
   }
 
    //�򿪸���
	function opendoc(showid,versionid,docImagefileid,obj){
	    var discussid=jQuery(obj).parents(".reportItem").attr("id");
	    openFullWindowHaveBar("/docs/docs/DocDsp.jsp?id="+showid+"&imagefileId="+docImagefileid+"&blogDiscussid="+discussid+"&isFromAccessory=true&isfromcoworkdoc=1");
	}
	//�򿪸���
	function opendoc1(showid,obj){
	   var discussid=jQuery(obj).parents(".reportItem").attr("id");
	   openFullWindowHaveBar("/docs/docs/DocDsp.jsp?id="+showid+"&isOpenFirstAss=0&blogDiscussid="+discussid);
	}
	//���ظ���
	function downloads(files,obj){
	    var discussid=jQuery(obj).parents(".reportItem").attr("id");
	   jQuery("#downloadFrame").attr("src","/weaver/weaver.file.FileDownload?fileid="+files+"&download=1&blogDiscussid="+discussid);
	}
    
    //ʱ�����ڸ�ʽ��
    Date.prototype.pattern=function(fmt) {     
	    var o = {     
	    "M+" : this.getMonth()+1, //�·�     
	    "d+" : this.getDate(), //��     
	    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //Сʱ     
	    "H+" : this.getHours(), //Сʱ     
	    "m+" : this.getMinutes(), //��     
	    "s+" : this.getSeconds(), //��     
	    "q+" : Math.floor((this.getMonth()+3)/3), //����     
	    "S" : this.getMilliseconds() //����     
	    };     
	    var week = {     
	    "0" : "\u65e5",     
	    "1" : "\u4e00",     
	    "2" : "\u4e8c",     
	    "3" : "\u4e09",     
	    "4" : "\u56db",     
	    "5" : "\u4e94",     
	    "6" : "\u516d"    
	    };     
	    if(/(y+)/.test(fmt)){     
	        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));     
	    }     
	    if(/(E+)/.test(fmt)){     
	        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "\u661f\u671f" : "\u5468") : "")+week[this.getDay()+""]);     
	    }     
	    for(var k in o){     
	        if(new RegExp("("+ k +")").test(fmt)){     
	            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));     
	        }     
	    }     
    return fmt;     
   }
   
   	//�򿪱���
	function openReport(){
		jQuery(".menuItem").each(function(){
		   jQuery(this).removeClass("selected");
		});
	    jQuery("#myBlog").addClass("selected");
	    jQuery("#report").click();                     //���ر���
	    jQuery("#myBlogMenu").show();                  //��ʾ�˵�
		jQuery("#searchBtn").attr("from","myBlog");    //�޸�������Դҳ
	}
	
	function doAttention(obj,attentionid,islower,eve){
        var itemName=jQuery(obj).parent().parent().find(".title").text();
        var status=jQuery(obj).attr("status");
        if(status=="cancel"){
           jQuery.post("blogOperation.jsp?operation=cancelAttention&islower="+islower+"&attentionid="+attentionid);
           jQuery(obj).attr("status","add");
           jQuery(obj).find("#btnLabel").html("<span class='add'>+</span><%=SystemEnv.getHtmlLabelName(26939,user.getLanguage())%></span>");  
        }
        if(status=="add"){
           jQuery.post("blogOperation.jsp?operation=addAttention&islower="+islower+"&attentionid="+attentionid);
           jQuery(obj).attr("status","cancel");
           jQuery(obj).find("#btnLabel").html("<span class='add'>-</span><%=SystemEnv.getHtmlLabelName(24957,user.getLanguage())%></span>");  
        }
        if(status=="apply"){
          if(jQuery(obj).attr("isApply")!=="true"){
            jQuery.post("blogOperation.jsp?operation=requestAttention&islower="+islower+"&attentionid="+attentionid,function(){
               alert("<%=SystemEnv.getHtmlLabelName(129,user.getLanguage())+SystemEnv.getHtmlLabelName(19558,user.getLanguage())%>"); //�����Ѿ�����
               jQuery(obj).find("#btnLabel").html("<span class='apply'>��</span><%=SystemEnv.getHtmlLabelName(18659,user.getLanguage())%></span>");
               jQuery(obj).attr("isApply","true");
            });
          }else {
              alert("<%=SystemEnv.getHtmlLabelName(129,user.getLanguage())+SystemEnv.getHtmlLabelName(19558,user.getLanguage())%>"); //�����Ѿ�����
          }  
        }
        eve.cancelBubble=true;
      }
	
	//��������״̬
	function checkServer(){
	    var xmlhttp;
	    if (window.XMLHttpRequest) {
	    	xmlhttp = new XMLHttpRequest();
	    }  
	    else if (window.ActiveXObject) {
	    	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");  
	    }
	    var URL = "/systeminfo/CheckConn.jsp?userid=<%=user.getUID()%>&time="+new Date();
	    var flag=true;
	    jQuery.ajax({
            url: URL,
            type: "post",
            async: false,
            success: function(data){
               if(data=='1') {
	    			var diag = new Dialog();
					diag.Width = 300;
					diag.Height = 180;
					diag.ShowCloseButton=false;
					diag.Title = "<%=SystemEnv.getHtmlLabelName(26263,user.getLanguage())%>";
					//diag.InvokeElementId="pageOverlay"
					diag.URL = "/wui/theme/ecology7/page/loginSmall.jsp?username=<%=user.getLoginid()%>";
					diag.show();
			        flag=false;
	    		}
	    		else if(data=='2') {
	    			var flag_msg = '<%=SystemEnv.getHtmlLabelName(21403,user.getLanguage())%>';
	    			Dialog.alert(flag_msg);
	    			flag=false;
	    		}else{
	    		    flag=true;
	    		}
            }
        });
        return flag;
	}
	
 function openBlog(blogid){
	var url="viewBlog.jsp?blogid="+blogid;
	window.open(url);
 }
 //��ø���
 function getMore(obj,url,requestType,content){
       displayLoading(1,"data");
       jQuery.post(url,function(data){
           jQuery(obj).remove();
		    var tempdiv=jQuery("<div>"+data+"</div>");
		    //��ʼ������ͼƬ
	        tempdiv.find('.reportContent img').each(function(){
				initImg(this);
		    });
		    
		    if(requestType=="search"&&""!=jQuery.trim(content)){
		      tempdiv.find('.reportItem').each(function(){
		         jQuery(this).find(".reportContent:first").highlight(content, {needUnhighlight: true});
		      });
		      //tempdiv.highlight(content, {needUnhighlight: true});
		    }  
		     
		      
		      
		     jQuery("#reportBody").append(tempdiv); 
            
		    //�ϼ����ִ���
		    jQuery(".blog_raty").each(function(){
		       if(jQuery(this).attr("isRaty")!="true"){
			       managerScore(this);
			       jQuery(this).attr("isRaty","true"); 
			   }    
			});
		    displayLoading(0);
		});
    } 
    
  //��Ϣ����
  function msgRemind(msg){
    msg=msg?msg:"<%=SystemEnv.getHtmlLabelName(26759,user.getLanguage())+SystemEnv.getHtmlLabelName(86,user.getLanguage())+SystemEnv.getHtmlLabelName(15242,user.getLanguage())%>"
    var diag = new Dialog();
    diag.Title = "<%=SystemEnv.getHtmlLabelName(19085,user.getLanguage())%>";//��Ϣ����
    diag.Width = 180;
	diag.Height = 80;   
	diag.Modal = false;
	diag.AutoClose=3;
	diag.InnerHtml='<div style="color:#1d76a4;font-size:14px;vertical-align: middle;padding-top:15px">'+msg+'</div>';//����΢������ɹ�  
	diag.show();
  }
   //����΢����ǩ
  	function saveNotepad(obj){
	    var editorId="notepadTextarea";
        //��ȡ������ͼƬ��С
		jQuery(KE.g[editorId].iframeDoc.body).find("img").each(function(){
		   var imgWidth=jQuery(this).width();
		   jQuery(this).attr("imgWidth",imgWidth);
		});
		var content=KE.html(editorId);	  
		beforerequest(1);
	    jQuery.post("blogOperation.jsp",{'operation':'saveNotepad','content':content,'saveType':'edit'},function(data){
	        afterrequest(1);
	    });
	  }
	  //��΢����ǩ����Ϊ΢��
	  function saveAsBlog(obj){
	     var editorId="notepadTextarea";
	     var workdate=jQuery(obj).parents(".reportItem:first").attr("forDate");
         //��ȡ������ͼƬ��С
		 jQuery(KE.g[editorId].iframeDoc.body).find("img").each(function(){
		    var imgWidth=jQuery(this).width();
		    jQuery(this).attr("imgWidth",imgWidth);
		 });
		var content=KE.html(editorId);
		if(content==""||(content.indexOf("<img")==-1&&jQuery.trim(jQuery(KE.g[editorId].iframeDoc.body).text().replace(/&nbsp;/g,' '))=="")){
		   alert("����΢�����ݲ���Ϊ�գ�");
		   return false;
		 } 
		  content="<br>"+content;
		 jQuery(obj).attr("disabled","true");
		 beforerequest(2); 
	     var backInfo=saveBlogItem({'discussid':0,'content':content,'forDate':workdate,'appItemId':1},"saveBlogOperation.jsp");
	     if(backInfo.status=="1"){
	        afterrequest(2);
	        jQuery(obj).attr("disabled","");
	     }   
	  }
	  //����֮ǰ����
	  function beforerequest(type){
                var t="Loading data...";
                switch(type)
                {
                    case 1:
                        t="<%=SystemEnv.getHtmlLabelName(23278,user.getLanguage())%>"; //���ڱ��棬���Ե�...
                        break;
                    case 2:   
                        t="���ڷ���΢�������Եȡ���"; //���ڷ���΢�������Եȡ���
                        break;                   
                    case 3:  
                        t="����ɾ�������Ե�..."; //����ɾ�������Ե�...
                        break;   
                    case 4:    
                        t="<%=SystemEnv.getHtmlLabelName(25008,user.getLanguage())%>";                                   
                        break;
                }
                $("#remindSpan").html(t).show();    
        }
        //������ɺ�����
	    function afterrequest(type){
                switch(type)
                {
                    case 1:
                        $("#remindSpan").html("<%=SystemEnv.getHtmlLabelName(18758,user.getLanguage())%>!"); //����ɹ���
                        window.setTimeout(function(){ $("#remindSpan").hide();},3000);
                        break;
                    case 2:
                        $("#remindSpan").html("����ɹ�!");
                        window.setTimeout(function(){ $("#remindSpan").hide();},3000);
                    case 3:
                    case 4:
                        $("#remindSpan").html("<%=SystemEnv.getHtmlLabelName(15242,user.getLanguage())%>!");
                        window.setTimeout(function(){ $("#remindSpan").hide();},3000);
                    break;
                }              
               
         }
	
 </script>
 
 
