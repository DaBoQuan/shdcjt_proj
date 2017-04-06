$(document).ready(function(){
	$("#outputTD").height($(document).height()-195);
});

/**
	���ø�����Ϣ
*/
function setTrackType1(obj){
	$("#tracktype").val('var');
	$(obj).children("img").attr("src", "images/radio_true.png");
	$(obj).next().children("img").attr("src","images/radio_false.png");
	updataStatus();
}

function setTrackType2(obj){
	$("#tracktype").val('all');
	$(obj).children("img").attr("src", "images/radio_true.png");
	$(obj).prev().children("img").attr("src","images/radio_false.png");
	updataStatus();
}

/**
 ���ø��ٹ���
*/
function setTrackSeq(obj){
	if($("#trackseq").val()=="trackseq"){
		$("#trackseq").remove();
		$(obj).children("img").attr("src","images/checkbox_false.png");
	}else{
		$("#trackseqspan").html("<input type='hidden' name='trackseq' id='trackseq' value='trackseq' />");
		$(obj).children("img").attr("src","images/checkbox_true.png");
	}
	updataStatus();
}

/**
�ύ�������ñ�
*/
function updataStatus(){
   $("#statusForm").submit();
}

/**
��ʼ��ֹͣ����
*/
function startOrStop(obj){
	if($("#flag").val()=="0"){
		$(obj).text("��������");
		/*$("#flag").val("1");
		$("#sos").attr("src", "images/stop.png");
		*/
		window.location="/debug/debug.jsp?action=start";
	}else{
		$(obj).text("����ֹͣ");
		/*$("#flag").val("0");
		$("#sos").attr("src", "images/start.png");
		*/
		window.location="/debug/debug.jsp?action=stop";
	}
}

