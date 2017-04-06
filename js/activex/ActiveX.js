// ���ܣ����ؼ��汾
// ������o	-- �ؼ�����
function checkActivexVersion(o,sPsrviewVer)
{
	try
	{
		var bIsSetupPsrview;
		var sLocalVersion, sPsrviewVersion;
		var arrLocalVersion, arrPsrviewVersion;
		
		bIsSetupPsrview = false;
		sLocalVersion = o.GetCurrentVersion();
		sPsrviewVersion = sPsrviewVer;
		arrLocalVersion = sLocalVersion.split(".");
		arrPsrviewVersion = sPsrviewVersion.split(".");
		for (var i = 0; i < arrPsrviewVersion.length; i++)
		{
			if (arrLocalVersion[i] < arrPsrviewVersion[i])
			{
				bIsSetupPsrview = true;
				break;
			}
			else if (arrLocalVersion[i] > arrPsrviewVersion[i])
				break;
		}
	}
	catch(e)
	{
	}
	return bIsSetupPsrview;
}

// ���ܣ���� ActiveX ���û����ȷ��װ��������װ��ʾ
function checkWeaverActiveX(language)
{
	var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
	xmlDoc.async = false;
	xmlDoc.resolveExternals = false;
	
	
	 var acceptlanguage = getOuterLanguage();
 	 if(acceptlanguage!="")
 	 	acceptlanguage = acceptlanguage.toLowerCase();
 	 if(acceptlanguage.indexOf("zh-tw")>-1||acceptlanguage.indexOf("zh-hk")>-1)
 	 {
		xmlDoc.load("/activex/ActiveXBIG5.xml");
	 }
	 else
	 {
	 	if(language==8){
			xmlDoc.load("/activex/ActiveXEN.xml");
		}else if(language==9){
			xmlDoc.load("/activex/ActiveXBIG5.xml");
		}else{
			xmlDoc.load("/activex/ActiveX.xml");
		}
	 }
	if (xmlDoc.parseError.errorCode != 0) 
	{
		var myError = xmlDoc.parseError;
		alert("Load XML Error��" + myError.reason);
	} 
	else 
	{
		var chasm = screen.availWidth;
		var mount = screen.availHeight;
		if(chasm<650) chasm=650;
		if(mount<700) mount=700;
		var xmlActveXNodes = xmlDoc.selectNodes("//activex");
		
		for (var i = 0; i < xmlActveXNodes.length; i++)
		{
			if (!Detect(xmlActveXNodes[i].selectSingleNode("progid").text))
			{
				Winopen("/weaverplugin/PluginMaintenance.jsp","PluginCheck","scrollbars=yes,resizable=no,width=690,Height=650,top="+(mount-700)/2+",left="+(chasm-650)/2);
				break;
			}
		}
	}
	delete(xmlDoc);
}

function OnCheckPage(url,w,h){
	window.location=url;
    self.resizeTo(w,h);
}

function Winopen(url,winname,nstyle){
	window.open(url,winname,nstyle);
}

// ���ܣ��ô�������ķ������ ActiveX �Ƿ�װ
function Detect(ProgID)
{
	var obj;
	var bOk=false;
	try
	{		
		obj = new ActiveXObject(ProgID);
		if(obj) bOk = true;
		delete(obj);
	} 
	catch(e) {}
	obj=null;
	return bOk;
}

//�������л�ȡ����
function GetDomain(sUrl)
{
	var re = new RegExp("^(http://|https://|)(([\\w\\-.])+)($|:|/)", "ig");
	if (re.exec(sUrl) == null) return "";

	return RegExp.$2;
}
