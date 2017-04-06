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
		    	//mnuEditUndo_click();
			break;
		case "CMDEDITREDO"://����
			//mnuEditRedo_click();
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

