//Copyright (c) 2000 Microsoft Corporation.  All rights reserved.
//<script>
var g_WinDoc            =   window.document;
var g_WinDocAll         =   g_WinDoc.all;

function f_onCbMouseOut()
{
	event.cancelBubble=true;
	if( null != this.sticky )		// If it is sticky
	{
		if( true == this.buttondown )
		{
			return;
		};
	}
	this.className= (true == this.raised) ? "tbButtonRaise" : "tbButton";
	this.onmouseout=null;
}
function f_onCbMouseUp(obj)
{
	event.cancelBubble=true;
	if( null != this.sticky )
	{
		if( true == this.buttondown )
		{
			return;
		};
	}
	this.className= (true == this.raised) ? "tbButtonRaise" : "tbButton";
	this.onmouseup=null;
}
function onCbMouseDown(obj)
{
	obj.className="tbButtonDown";
	obj.onmouseout = f_onCbMouseOut;
	obj.onmouseup = f_onCbMouseUp;
}

function onCbClickEvent(obj, fNoEvent)
{
	if( null != event )
	{
		event.cancelBubble=true;
	}
	// Regular push button
	onCbClick(obj.id, true);
	return(false);
}

function onCbClick(szCommand, fState)
{
	//��ʼ����
	switch(szCommand.toUpperCase())
	{
		case "CMDFILENEW"://�½�
			mnuFileNew_click();
			break;
		case "CMDFILEOPEN"://���ļ�
			mnuFileOpen_click();
			break;
		case "CMDEXCELFILEOPEN"://��EXCEL�ļ�
			mnuExcelFileOpen_click();
			break;
		case "CMDWEBFILEOPEN"://��Զ���ļ�
			mnuFileWebOpen_click();
			break;
		case "CMDWEBXMLFILEOPEN"://��Զ��XML�ļ�
			mnuXMLFileWebOpen_click();
			break;
		case "CMDSAVEDATAASSTRING": //���Ϊ�ַ���
		    mnuSaveDataAsString_click();
			break;
		case "CMDFILESAVE"://�����ĵ�
			mnuFileSave_click();
			break;
		case "CMDFILESAVEAS"://���Ϊ
			mnuFileSaveAs_click();
			break;
		case "CMDFILEPRINTPAPERSET"://��ӡҳ�����ĵ�
			mnuPrintPaperSet_click();
			break;
		case "CMDFILEPRINTSETUP"://��ӡ�����ĵ�
			mnuFilePrintSetup_click();
			break;
		case "CMDFILEPRINT"://��ӡ�ĵ�
			mnuFilePrint_click();
			break;
		case "CMDFILEPRINTPREVIEW"://��ӡԤ���ĵ�
			mnuFilePrintPreview_click();
			break;
		case "CMDEDITCUT"://����
		 	CellWeb1.OnCut();
			//mnuEditCut_click();
			break;
		case "CMDEDITCOPY"://����
		 	CellWeb1.OnCopy();
			//mnuEditCopy_click();
			break;		
		case "CMDEDITPASTE"://ճ��
		 	CellWeb1.OnPaste();
			//mnuEditPaste_click();
			break;
		case "CMDEDITFIND"://����
		    	mnuEditFind_click();
			break;
		case "CMDEDITUNDO"://����
		    	mnuEditUndo_click();
			break;
		case "CMDEDITREDO"://����
			mnuEditRedo_click();
			break;
		case "CMDSHAPE3D"://���õ�Ԫ3ά��ʾ
		    mnuShape3D_click();
			break;
		case "CMDROWLABEL"://�����б�ͷ
		    mnuRowLabel_click();
			break;
		case "CMDCOLLABEL"://�����б�ͷ
			mnuColLabel_click();
			break;
		case "CMDSTATWIZARD"://
			CellWeb1.OnStatWebWizard();
			break;
		case "CMDSORTDESCENDING"://��������
			cmdSortDescending_click();
			break;
		case "CMDFUNCTIONLIST"://�����б�
			mnuFunctionList_click();
			break;
		case "CMDUSERFUNCTIONGUIDE"://�Զ��庯����
			mnuUserFunctionGuide_click();
			break;
		case "CMDFORMULASUMH"://ˮƽ���
			cmdFormulaSumH_click();
			break;
		case "CMDFORMULASUMV"://��ֱ���
			cmdFormulaSumV_click();
			break;
		case "CMDFORMULASUMHV"://˫�����
			cmdFormulaSumHV_click();
			break;
		case "SETCCINCELLS":	
			cmdSetCCInCells_click();
			break;
		case "CMDCHARTWZD"://ͼ����
			mnuDataWzdChart_click();
			break;
		case "CMDINSERTPIC"://����ͼƬ
			mnuFormatInsertPic_click();
			break;
		case "CMDINSERTCELLPIC"://���뵥ԪͼƬ
			mnuFormatInsertCellPic_click();
			break;
		case "CMDHYPERLINK"://��������
			mnuEditHyperlink_click();
			break;
		case "CMDFINANCEHEADERTYPE"://�����ͷ
			mnuFinanceHeader_click();
			break;		
		case "CMDFINANCETYPE"://�������
			mnuFinance_click();
			break;		
		case "CMDSHOWGRIDLINE"://��ʾ/���ر��������
			with(CellWeb1){
				ShowGrid =!ShowGrid;
			}
			break;
		case "CMDSHOWHEADER"://��ʾ/����ϵͳ��ͷ
			with(CellWeb1){
				ShowHeader = !ShowHeader;
                 	}
            		break;
		//***********************************************************			
		//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		case "CMDBOLD"://���ô���
		    	cmdBold_click();
			break;
		case "CMDITALIC"://����б��
			cmdItalic_click();
			break;
		case "CMDUNDERLINE"://�����»���
			cmdUnderline_click();
			break;
		case "CMDBACKCOLOR"://���ñ���ɫ
			cmdBackColor_click();
			break;
		case "CMDFORECOLOR"://����ǰ��ɫ
			cmdForeColor_click();
			break;
		case "CMDWORDWRAP"://�����Զ�����
			cmdWordWrap_click();
			break;	
		case "CMDALIGNLEFT"://�����
			cmdAlignLeft_click();
			break;
		case "CMDALIGNCENTER"://���ж���
			cmdAlignCenter_click();
			break;
		case "CMDALIGNRIGHT"://���Ҷ���
			cmdAlignRight_click();
			break;
		case "CMDALIGNTOP"://���϶���
			cmdAlignTop_click();
			break;
		case "CMDALIGNMIDDLE"://��ֱ���ж���
			cmdAlignMiddle_click();
			break;
		case "CMDALIGNBOTTOM"://���¶���
			cmdAlignBottom_click();
			break;
		case "CMDDRAWCOLOR":
			CellWeb1.OnSetLineStyle();
			break;
		case "CMDDRAWBORDER"://������
			cmdDrawBorder_click();
			break;
		case "CMDERASEBORDER"://Ĩ����
			cmdEraseBorder_click();
			break;
		case "CMDCURRENCY"://���ҷ���
			cmdCurrency_click();
			break;
		case "CMDPERCENT"://�ٷֺ�
			cmdPercent_click();
			break;		
		case "CMDTHOUSAND"://ǧ��λ
			cmdThousand_click();
			break;
		case "CMDABOUT"://���ڳ���������
			cmdAbout_click();
			break;
		//***********************************************************			
		//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		case "CMDINSERTCOL"://������
		    	cmdInsertCol_click();
			break;
		case "CMDINSERTROW"://������
		    	cmdInsertRow_click();
			break;
		case "CMDINSERTCELL"://���뵥Ԫ
			cmdInsertCell_click();
			break;
		case "CMDDELETECELL"://ɾ����Ԫ
		    	cmdDeleteCell_click();
			break;
		case "CMDDELETECOL"://ɾ����
			cmdDeleteCol_click();
			break;
		case "CMDDELETEROW"://ɾ����
			cmdDeleteRow_click();
			break;
		case "CMDMAXROWCOL"://���ñ��������
			mnuMaxRowCol_click();
			break;
		case "CMDMERGECELL"://�ϲ���Ԫ��
			mnuFormatMergeCell_click();
			break;
		case "CMDUNMERGECELL"://ȡ���ϲ���Ԫ��
			mnuFormatUnMergeCell_click();
			break;
		case "CMDMERGEROW"://�����
			cmdMergeRow_click();
			break;
		case "CMDMERGECOL"://�����
			cmdMergeCol_click();
			break;
		case "CMDRECALCALL"://����ȫ��
			mnuFormulaReCalc_click();
			break;
		case "CMDFORMPROTECT"://������
			mnuFormProtect_click();
			break;
		case "CMDREADONLY"://��Ԫ��ֻ��
			mnuReadOnly_click();
			break;
		
	}
}
function cellregedit(){
    MenuOcx.Login("�Ϻ���΢���缼�����޹�˾","4f203da914960b091b0d58b2cff7ec44",0);
    CellWeb1.Login("��΢���","891e490cd34e3e33975b1b7e523e8b32","�Ϻ���΢���缼�����޹�˾");
}

//��ñ�������汾
function mnuCurrentVer_click(){
    var language=readCookie("languageidweaver");
    try{
        var version=CellWeb1.GetCurrentVersion();
        if(language==8){
            alert("Your local host version number is "+version);
        }
        else if(language==9){
            alert("�����C�Ĳ���汾��"+version);
        }
        else{
            alert("�������Ĳ���汾Ϊ"+version);
        }
    }catch(e){
        if(language==8){
            alert("Your version is so old that can't support the function,please install new version!");
        }
		else if(language==9){
            alert("���İ汾̫�Ͳ�֧��ԓ���ܣ�Ո���b�°汾�����");
        }        
        else{
            alert("���İ汾̫�Ͳ�֧�ָù��ܣ��밲װ�°汾�����");
        }
    }
}

//���ģ���ļ��汾
function getTabFileVer(){
    try{
    return CellWeb1.GetCurrentFileVersion();
    }catch(e){
        return 0;
    }
}

//��ñ�������汾
function getCurrentVer(){
    try{
    return CellWeb1.GetCurrentVersion();
    }catch(e){
        return 0;
    }
}

//���ϵͳ����汾
function mnuSystemVer_click(){
    var language=readCookie("languageidweaver");
    try{
    var version=CellVersion.value;
    if(version!=""){
        if(language==8){
            alert("Server version is "+version);
        }
        else if(language==9){
            alert("�������Ĳ���汾��"+version);
        }
        else{
            alert("�������Ĳ���汾Ϊ"+version);
        }
    }else{
        if(language==8){
            alert("Your version is so old that can't support the function,please install new version!");
        }
        else if(language==9){
            alert("���İ汾̫�Ͳ�֧��ԓ���ܣ�Ո���b�°汾�����");
        }
        else{
            alert("���İ汾̫�Ͳ�֧�ָù��ܣ��밲װ�°汾�����");
        }
    }
    }catch(e){
        if(language==8){
            alert("Your version is so old that can't support the function,please install new version!");
        }
        else if(language==9){
            alert("���İ汾̫�Ͳ�֧��ԓ���ܣ�Ո���b�°汾�����");
        }
        else{
            alert("���İ汾̫�Ͳ�֧�ָù��ܣ��밲װ�°汾�����");
        }
    }
}

function showCheckPopup(content){
    var showTableDiv  = document.getElementById('divshowCheck');
    var oIframe = document.createElement('iframe');
    showTableDiv.style.display='';
    var message_Div = document.createElement("<div>");
     message_Div.id="message_Div";
     message_Div.className="xTable_message";
     showTableDiv.appendChild(message_Div);
     var message_Div1  = document.getElementById("message_Div");
     message_Div1.style.display="inline";
     message_Div1.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_Div1.style.position="absolute"
     message_Div1.style.posTop=pTop;
     message_Div1.style.posLeft=pLeft;

     message_Div1.style.zIndex=1002;

     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     oIframe.style.position = 'absolute';
     oIframe.style.top = pTop;
     oIframe.style.left = pLeft;
     oIframe.style.zIndex = message_Div1.style.zIndex - 1;
     oIframe.style.width = parseInt(message_Div1.offsetWidth);
     oIframe.style.height = parseInt(message_Div1.offsetHeight);
     oIframe.style.display = 'block';
    return oIframe;
}

function hideCheckPopup(oIframe){
    var showTableDiv  = document.getElementById('divshowCheck');
    showTableDiv.style.display='none';
    oIframe.style.display='none';
}

//ģ���ʽ���
function mnuStyleCheck_click(){
    var language=readCookie("languageidweaver");
    var oIframe;
    if(language==8){
        oIframe=showCheckPopup("Checking templet format,Please wait...");
    }
    else if(language==9){
        oIframe=showCheckPopup("���ڙz��ģ���ʽ��Ո�Ե�...");
    }
    else{
        oIframe=showCheckPopup("���ڼ��ģ���ʽ�����Ե�...");
    }
    var endrow=CellWeb1.GetMaxRow();
    var endcol=CellWeb1.GetMaxCol();
    var hasadd=0;
    var hasdel=0;
    var hassel=0;
    var hashead=0;
    var hasend=0;
    var hasprintbegin=0;
    var hasprintend=0;
    var returnstr="";
    for(var i=0;i<=endrow;i++){
        for(var j=0;j<=endcol;j++){
            var userstring=CellWeb1.GetCellUserStringValue(i,j);
            if(userstring!=null && userstring!=""){
                //����ֶ��Ƿ���Ĺ�
                try{
                    var fieldid=parent.fieldlist.document.getElementById(userstring).id;
                }catch(e){
                    if(language==8){
                        returnstr+=i+" line of "+j+" related fields have already been deleted or change ,Please delete!\n";
                    }
                    else if(language==9){
                        returnstr+=i+"��"+j+"���P���ֶ��ѽ����h�����׃��Ո�á�X���h����\n";
                    }
                    else{
                        returnstr+=i+"��"+j+"�й������ֶ��Ѿ���ɾ����ı䣬���á�X��ɾ����\n";
                    }
                }
                if(userstring.indexOf("_add")>0){
                    hasadd+=1;
                }
                if(userstring.indexOf("_del")>0){
                    hasdel+=1;
                }
                if(userstring.indexOf("_head")>0){
                    hashead+=1;
                }
                if(userstring.indexOf("_end")>0){
                    hasend+=1;
                }
                if(userstring.indexOf("_sel")>0){
                    hassel+=1;
                }
                if(userstring.indexOf("_isprintbegin")>0){
                    hasprintbegin+=1;
                }
                if(userstring.indexOf("_isprintend")>0){
                    hasprintend+=1;
                }
            }
        }
    }
    //��ǩ�ɶԼ��
    if(hasadd!=hasdel){
        if(language==8){
            returnstr+="add,delete butten is not pairs!\n";
        }
        else if(language==9){
            returnstr+="���ӡ��h�����o���Ɍ���\n";
        }
        else{
            returnstr+="���ӡ�ɾ����ť���ɶԣ�\n";
        }
    }
    if(hashead!=hasend){
        if(language==8){
            returnstr+="��head label��,��end label�� is not pairs!\n";
        }
        else if(language==9){
            returnstr+="�����^���R��������β���R�����Ɍ���\n";
        }
        else{
            returnstr+="����ͷ��ʶ��������β��ʶ�����ɶԣ�\n";
        }
    }
    if(hasprintbegin!=hasprintend){
        if(language==8){
            returnstr+="��begining of hiding the detail which is null��,��ending of hiding the detail which is null�� is not pairs!\n";
        }
        else if(language==9){
            returnstr+="���������[�ؘ��R�^�������������[�ؘ��Rβ�����Ɍ���\n";
        }	
        else{
            returnstr+="������ϸ���ر�ʶͷ����������ϸ���ر�ʶβ�����ɶԣ�\n";
        }
    }
    if(hasadd>0 || hasdel>0){
        if((hasadd>0 && hasadd!=hashead) || (hasdel>0 && hasdel!=hashead)){
            if(language==8){
                returnstr+="Lack��head label��!\n";
            }
            else if(language==9){
                returnstr+="ȱ�١����^���R����\n";
            }
            else{
                returnstr+="ȱ�١���ͷ��ʶ����\n";
            }
        }
        if((hasadd>0 && hasadd!=hassel) || (hasdel>0 && hasdel!=hassel)){
            if(language==8){
                returnstr+="Lack��SelectCombo label��!\n";
            }
            else if(language==9){
                returnstr+="ȱ�١��x���˻`����\n";
            }
            else{
                returnstr+="ȱ�١�ѡ����ǩ����\n";
            }
        }
        if((hasadd>0 && hasadd!=hasend) || (hasdel>0 && hasdel!=hasend)){
            if(language==8){
                returnstr+="Lack��end label��!\n";
            }
            else if(language==9){
                returnstr+="ȱ�١���β���R����\n";
            }
            else{
                returnstr+="ȱ�١���β��ʶ����\n";
            }
        }
    }
    if(returnstr==""){
        if(language==8){
            returnstr="No found error format!";
        }
        else if(language==9){
            returnstr="�o�l�F�e�`��ʽ��";
        }
        else{
            returnstr="�޷��ִ����ʽ��";
        }
    }
    if(language==8){
        returnstr="Result:\n"+returnstr;
    }
    else if(language==9)
    {
    	returnstr="�z��Y��:\n"+returnstr;
    }
    else{
        returnstr="�����:\n"+returnstr;
    }
    alert(returnstr);
    hideCheckPopup(oIframe);
    CellWeb1.GetFocus();
}

//����
function mnuShowHelp_click(){
    var redirectUrl = "CellHelp.html" ;
    var szFeatures = "directories=no," ;
    szFeatures +="status=yes," ;
    szFeatures +="menubar=no," ;
    szFeatures +="scrollbars=yes," ;
    szFeatures +="resizable=yes" ; //channelmode
    var popWin=window.open(redirectUrl,"CellHelp",szFeatures) ;
    CellWeb1.GetFocus();
    popWin.focus();
}

function showRightMenu(){
    var startrow=CellWeb1.GetSelectRegionStartRow();
    var endrow=CellWeb1.GetSelectRegionEndRow();
    var startcol=CellWeb1.GetSelectRegionStartCol();
    var endcol=CellWeb1.GetSelectRegionEndCol();
    for(var i=startrow;i<=endrow;i++){
        for(var j=startcol;j<=endcol;j++){
            var userstring=CellWeb1.GetCellUserStringValue(i,j);
            if(userstring!=null && userstring!="" && userstring.indexOf("_add")<0 && userstring.indexOf("_del")<0 && userstring.indexOf("_head")<0 && userstring.indexOf("_end")<0 && userstring.indexOf("_sel")<0&& userstring.indexOf("_showKeyword")<0&& userstring.indexOf("_isprintbegin")<0&& userstring.indexOf("_isprintend")<0&& userstring.indexOf("_createCodeAgain")<0){
                showPopup();
                break;
            }
        }
    }
}
