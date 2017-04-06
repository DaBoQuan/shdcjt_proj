'**************************************************
'		�ļ��˵�
'**************************************************
'�½�
Public Sub mnuFileNew_click()
	If CellWeb1.IsModified() Then '�ĵ��Ѿ�������
		rtn = MsgBox( "�ĵ��ѱ����ģ��Ƿ񱣴棿", vbExclamation Or vbYesNoCancel)
		If rtn = vbYes Then
			mnuFileSave_click
		ElseIf rtn = vbCancel Then
			Exit Sub
		End If
	End If
	CellWeb1.SetMaxRows(0)
	CellWeb1.SetMaxRows(18)
	CellWeb1.SetMaxCols(8)
	CellWeb1.FormProtect = false
	menu_init
End Sub

'�򿪱����ĵ�
Public Sub mnuFileOpen_click()
	CellWeb1.OnFileOpen
	menu_init
End Sub

Public Sub mnuExcelFileOpen_click()
	CellWeb1.OnOpenExcelFile
	menu_init
End Sub

'��Զ���ĵ�
Public Sub mnuFileWebOpen_click()
	strFilename = InputBox( "������Զ�̷������ϵĳ��������ļ���", "�򿪳��������ļ�", "HTTP://" )
	If strFilename <> "" Then CellWeb1.ReadHttpTabFile strFilename
	menu_init
End Sub

Public Sub mnuXMLFileWebOpen_click()
	strFilename = InputBox( "������Զ�̷������ϵ�XML���������ļ���", "��XML���������ļ�", "HTTP://" )
	If strFilename <> "" Then CellWeb1.ReadHttpXMLFile strFilename
	menu_init
End Sub

Public Sub mnuSaveDataAsString_click()
	With CellWeb1
		strValue = .SaveDataAsString()
		MsgBox strValue, vbExclamation
	End With
End Sub

'����
Public Sub mnuFileSave_click()
    strFilename = CellWeb1.FilePathName
	If strFilename <> "" then
		CellWeb1.SaveFile strFilename
	else
		CellWeb1.OnFileSave
	end if
End Sub

'���Ϊ
Public Sub mnuFileSaveAs_click()
	CellWeb1.OnFileSave
End Sub

Public Sub mnuFileSaveXMLFile_click()
	CellWeb1.OnSaveXMLFile
End Sub

'��ӡԤ��
Public Sub mnuFilePrintPreview_click()
	CellWeb1.OnFilePrintPreview
End Sub

'��ӡ����
Public Sub mnuFilePrintSetup_click()
	CellWeb1.OnPrintSetup
End Sub

'��ӡҳ����
Public Sub mnuPrintPaperSet_click()
	CellWeb1.OnPrintPaperSet
End Sub

'��ӡ
Public Sub mnuFilePrint_click()
	CellWeb1.OnFilePrint
End Sub

'�˳�
Public Sub mnuFileExit_click()
	If CellWeb1.IsModified() Then
		rtn = MsgBox( "�ĵ��ѱ����ģ��Ƿ񱣴棿", vbExclamation or vbYesNoCancel)
		If rtn = vbYes Then
			mnuFileSave_click
		ElseIf rtn = vbCancel Then
			Exit Sub
		End If
	End If
	window.parent.close
End Sub

'**************************************************
'		�༭�˵�
'**************************************************
'��������
Public Sub mnuEditUndo_click()
	CellWeb1.Undo
End Sub

'���²���
Public Sub mnuEditRedo_click()
	CellWeb1.Redo
End Sub

'���в���
Public Sub mnuEditCut_click()
 	CellWeb1.OnEditCut
End Sub

'���Ʋ���
Public Sub mnuEditCopy_click()
 	CellWeb1.OnEditCopy
End Sub

'ճ������
Public Sub mnuEditPaste_click()
 	CellWeb1.OnEditPaste
End Sub

'����
Public Sub mnuEditFind_click()
	CellWeb1.OnGoToCell
End Sub

'�����Ԫ����
Public Sub mnuClearCellText_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.ClearCellText StartRow,StartCol,EndRow,EndCol
	End With
End Sub

'ѡ��������������
Public Sub mnuOnSortRowAsc_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SortCol .Col,StartRow,StartCol,EndRow,EndCol,true
	End With
End Sub

'ѡ������������
Public Sub mnuOnSortRowDec_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SortCol .Col,StartRow,StartCol,EndRow,EndCol,false
	End With
End Sub

'��������-���н���
Public Sub mnuOnSortRowAscAll_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SortCol .Col,StartRow,1,EndRow,.GetMaxCol,true
	End With
End Sub

'��������-���н���
Public Sub mnuOnSortRowAscAll_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SortCol .Col,StartRow,1,EndRow,.GetMaxCol,false
	End With
End Sub

'ѡ��������������
Public Sub mnuOnSortColAsc_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SortRow .Row,StartRow,StartCol,EndRow,EndCol,true
	End With
End Sub

'ѡ������������
Public Sub mnuOnSortColDec_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SortRow .Row,StartRow,StartCol,EndRow,EndCol,false
	End With
End Sub

'��������-���н���
Public Sub mnuOnSortColAscAll_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SortRow .Row,1,StartCol,.GetMaxRow,EndCol,true
	End With
End Sub

'��������-���н���
Public Sub mnuOnSortColDecAll_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SortRow .Row,1,StartCol,.GetMaxRow,EndCol,false
	End With
End Sub

'��������
Public Sub mnuEditHyperlink_click()
	strUrl = InputBox( "�����볬�����ӵ�ַ��", "��������", "HTTP://" )
	CellWeb1.SetCellURLType CellWeb1.Row,CellWeb1.Col,strUrl
End Sub

'���ô���
Public Sub cmdBold_click()
	CellWeb1.Bold = not CellWeb1.Bold
End Sub

'����б��
Public Sub cmdItalic_click()
	CellWeb1.Italic = not CellWeb1.Italic
End Sub

'�����»���
Public Sub cmdUnderline_click()
	CellWeb1.Underline = not CellWeb1.Underline
End Sub

'���ñ���ɫ
Public Sub cmdBackColor_click()
	CellWeb1.OnSetCellBkColor
End Sub

'����ǰ��ɫ
Public Sub cmdForeColor_click()
	CellWeb1.OnSetTextColor
End Sub

'�Զ�����
Public Sub cmdWordWrap_click()
	CellWeb1.AutoWrap = not CellWeb1.AutoWrap
	nMenuID = MenuOcx.GetMenuID("AutoWrap")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.AutoWrap
End Sub

'�������
Public Sub cmdAlignLeft_click()
	CellWeb1.HorzTextAlign = 1
End Sub

'���ж���
Public Sub cmdAlignCenter_click()
	CellWeb1.HorzTextAlign = 2
End Sub

'���Ҷ���
Public Sub cmdAlignRight_click()
	CellWeb1.HorzTextAlign = 3
End Sub

'���϶���
Public Sub cmdAlignTop_click()
	CellWeb1.VertTextAlign = 1
End Sub

'��ֱ���ж���
Public Sub cmdAlignMiddle_click()
	CellWeb1.VertTextAlign = 2
End Sub

'���¶���
Public Sub cmdAlignBottom_click()
	CellWeb1.VertTextAlign = 3
End Sub
'���߿���
Public Sub cmdDrawBorder_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	protectstr=""
	for i=StartRow to EndRow
		for j=StartCol to EndCol
			isprotect=CellWeb1.IsCellProtect(i,j)
			if protectstr="" then 
				protectstr=isprotect
			else
				protectstr=protectstr&","&isprotect
			end if
			if isprotect then
				CellWeb1.SetCellProtect i,j,i,j,false
			end if
		next
	next
	CellWeb1.DrawCellBorder  StartRow, StartCol, EndRow, EndCol, BorderTypeSelect.value,BorderColor.value,DrawTypeSelect.value
	arrayprotect=Split(protectstr,",")
	num=0
	for i=StartRow to EndRow
		for j=StartCol to EndCol
			if arrayprotect(num) then
				CellWeb1.SetCellProtect i,j,i,j,true
			end if
			num=num+1
		next
	next	
End Sub

'Ĩ����
Public Sub cmdEraseBorder_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	protectstr=""
	for i=StartRow to EndRow
		for j=StartCol to EndCol
			isprotect=CellWeb1.IsCellProtect(i,j)
			if protectstr="" then 
				protectstr=isprotect
			else
				protectstr=protectstr&","&isprotect
			end if
			if isprotect then
				CellWeb1.SetCellProtect i,j,i,j,false
			end if
		next
	next
	CellWeb1.ClearCellBorder  StartRow, StartCol, EndRow, EndCol,EraseTypeSelect.value
	arrayprotect=Split(protectstr,",")
	num=0
	for i=StartRow to EndRow
		for j=StartCol to EndCol
			if arrayprotect(num) then
				CellWeb1.SetCellProtect i,j,i,j,true
			end if
			num=num+1
		next
	next
End Sub


'���ҷ���
Public Sub cmdCurrency_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SetCellDigitShowStyle StartRow, StartCol, EndRow, EndCol,2,2
    End With
End Sub

'�ٷֺ�
Public Sub cmdPercent_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SetCellDigitShowStyle StartRow, StartCol, EndRow, EndCol,4,2
	End With
End Sub

'ǧ��λ
Public Sub cmdThousand_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SetCellDigitShowStyle StartRow, StartCol, EndRow, EndCol,5,2
	End With
End Sub

'���ڳ���������
Public Sub cmdAbout_click()
	CellWeb1.AboutBox
End Sub

'������
Public Sub cmdInsertCol_click()
	CellWeb1.OnInsertBeforeCol
End Sub

'������
Public Sub cmdInsertRow_click()
	CellWeb1.OnInsertBeforeRow
End Sub

'���뵥Ԫ
Public Sub cmdInsertCell_click()
	CellWeb1.OnInsertCell
End Sub

'ɾ����Ԫ
Public Sub cmdDeleteCell_click()
	CellWeb1.OnDeleteCell
End Sub

'ɾ����
Public Sub cmdDeleteCol_click()
	CellWeb1.OnDeleteCol
End Sub

'ɾ����
Public Sub cmdDeleteRow_click()
	CellWeb1.OnDeleteRow
End Sub

'���ñ��������
Public Sub mnuMaxRowCol_click
	strValue = CellWeb1.GetMaxRow
	strRow = InputBox( "���������������", "���ñ��������", strValue )
	if strRow ="" then strRow = strValue
	strValue = CellWeb1.GetMaxCol
	strCol = InputBox( "���������������", "���ñ��������", strValue )
	if strCol ="" then strCol = strValue
	lMaxRow = strRow
	lMaxCol = strCol
	CellWeb1.SetMaxRows lMaxRow
	CellWeb1.SetMaxCols lMaxCol
	CellWeb1.FormProtect = false
End Sub

'�����и��Զ�����
public sub mnuSetRowAutoSize_click()
	with CellWeb1
		.SetRowAutoSize NOT .IsRowAutoSize
		nMenuID = MenuOcx.GetMenuID("SetRowAutoSize")
		MenuOcx.SetMenuChecked nMenuID,.IsRowAutoSize
	end with
end sub

'�Զ���ת����һ��
public sub mnuJumpNextCol_click()
	with CellWeb1
		.JumpNextCol
		nMenuID = MenuOcx.GetMenuID("JumpNextCol")
		MenuOcx.SetMenuChecked nMenuID,true
		nMenuID = MenuOcx.GetMenuID("JumpNextRow")
		MenuOcx.SetMenuChecked nMenuID,false
	end with
end sub

'�Զ���ת����һ��
public sub mnuJumpNextRow_click()
	with CellWeb1
		.JumpNextRow
		nMenuID = MenuOcx.GetMenuID("JumpNextCol")
		MenuOcx.SetMenuChecked nMenuID,false
		nMenuID = MenuOcx.GetMenuID("JumpNextRow")
		MenuOcx.SetMenuChecked nMenuID,true
	end with
end sub

'ͷβ��Ԫ�Զ����к���
Public Sub mnuSetAutoJumpNextRowCol_click()
	With CellWeb1
		nFlag = not .IsAutoJumpNextRowCol
		.SetAutoJumpNextRowCol nFlag
		nMenuID = MenuOcx.GetMenuID("SetAutoJumpNextRowCol")
		MenuOcx.SetMenuChecked nMenuID,.IsAutoJumpNextRowCol
	End With
End Sub

'�ڰ���ʱ�����õ�Ԫ
Public Sub mnuSetCellKeyNotFocus_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		nFlag = not .IsCellKeyNotFocus(StartRow,StartCol)
		.SetCellKeyNotFocus StartRow, StartCol, EndRow, EndCol,nFlag
		nMenuID = MenuOcx.GetMenuID("SetCellKeyNotFocus")
		MenuOcx.SetMenuChecked nMenuID,.IsCellKeyNotFocus(StartRow,StartCol)
	End With
End Sub

'�Ƿ���ʾ������ʾ
Public Sub mnuShowErrorMsgBox_Click()
	CellWeb1.ShowErrorMsgBox = not CellWeb1.ShowErrorMsgBox
	nMenuID = MenuOcx.GetMenuID("ShowErrorMsgBox")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.ShowErrorMsgBox
End Sub

'���ģʽ
Public Sub mnuDesignMode_Click()
	CellWeb1.DesignMode = not CellWeb1.DesignMode
	nMenuID = MenuOcx.GetMenuID("DesignMode")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.DesignMode
End Sub

'��ʾ�����
Public Sub mnuShowGrid_Click()
	CellWeb1.ShowGrid = not CellWeb1.ShowGrid
	nMenuID = MenuOcx.GetMenuID("ShowGrid")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.ShowGrid
End Sub

'��ʾ����ͷ
Public Sub mnuShowHeader_Click()
	CellWeb1.ShowHeader = not CellWeb1.ShowHeader
	nMenuID = MenuOcx.GetMenuID("ShowHeader")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.ShowHeader
End Sub

'����ֻ��
Public Sub mnuFormProtect_click()
	With CellWeb1
		.FormProtect = not .FormProtect
		nMenuID = MenuOcx.GetMenuID("FormProtect")
		MenuOcx.SetMenuChecked nMenuID,CellWeb1.FormProtect
		If .FormProtect Then	
			MsgBox "�����Ѿ�������.", vbExclamation
		Else
			MsgBox "�����Ѿ�ȡ��������.", vbExclamation
		End If
	End With
End Sub

'������ʱ�Ƿ���ֹ��
Public Sub mnuSetProtectFormShowCursor_Click()
	CellWeb1.SetProtectFormShowCursor not CellWeb1.GetProtectFormShowCursor
	nMenuID = MenuOcx.GetMenuID("SetProtectFormShowCursor")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.GetProtectFormShowCursor
End Sub

'�Ƿ���ʾ�����˵�
Public Sub mnuSetShowPopupMenu_Click()
	CellWeb1.SetShowPopupMenu not CellWeb1.GetShowPopupMenu
	nMenuID = MenuOcx.GetMenuID("SetShowPopupMenu")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.GetShowPopupMenu
End Sub

'�Ƿ����������и߽��е���
Public Sub mnuSetAllowRowResizing_Click()
	CellWeb1.SetAllowRowResizing not CellWeb1.IsAllowRowResizing
	nMenuID = MenuOcx.GetMenuID("SetAllowRowResizing")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.IsAllowRowResizing
End Sub

'�Ƿ����������п���е���
Public Sub mnuSetAllowColResizing_Click()
	CellWeb1.SetAllowColResizing not CellWeb1.IsAllowColResizing
	nMenuID = MenuOcx.GetMenuID("SetAllowColResizing")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.IsAllowColResizing
End Sub

'�Ƿ�����˫����ͷ��������
Public Sub mnuSetDClickLabelCanSort_Click()
	CellWeb1.SetDClickLabelCanSort not CellWeb1.GetDClickLabelCanSort
	nMenuID = MenuOcx.GetMenuID("SetDClickLabelCanSort")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.GetDClickLabelCanSort
End Sub

'��Ԫ��ֻ��������
Public Sub mnuReadOnly_click()
	CellWeb1.OnSetCellHideProtect
End Sub

'��ѡ��
Public Sub mnuSetCellCheckBoxType_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		for row = StartRow to EndRow
			for col = StartCol to EndCol
				.SetCellCheckBoxType row,col		
			next
		next
	End With
End Sub

'���ı�
Public Sub mnuSetCellLargeTextType_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SetCellLargeTextType StartRow, EndRow, .Col
	End With
End Sub

'���ó�������
Public Sub mnuSetCellUrlType_click()
	strURL = InputBox( "������URL", "��������", "HTTP://" )
	If strURL <> "" Then
		With CellWeb1
			.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
			for row = StartRow to EndRow
				for col = StartCol to EndCol
					.SetCellURLType row,col,strURL		
				next
			next
		End With
	End If
End Sub

'������������ؼ�
Public Sub mnuSetCellNumericType_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		for row = StartRow to EndRow
			for col = StartCol to EndCol
				.SetCellNumericType row,col		
			next
		next
	End With
End Sub


'���ø��ϵ�Ԫ
Public Sub mnuSetCellComplexType_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		.SetCellComplexType StartRow,StartCol,EndRow,EndCol
	End With
End Sub

'ɾ���ؼ�
Public Sub mnuSetCellNormalType_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		for row = StartRow to EndRow
			for col = StartCol to EndCol
				.SetCellNormalType row,col		
			next
		next
	End With
End Sub

'�����ͷ
Public Sub mnuFinanceHeader_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetCellFinanceHeadType StartRow, StartCol, EndRow, EndCol
End Sub

'�������
Public Sub mnuFinance_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetCellFinanceType StartRow, StartCol, EndRow, EndCol
End Sub

'�����д
Public Sub mnuFinanceDaXie_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetCellDigitShowStyle StartRow,StartCol,EndRow,EndCol,7,2
End Sub

'����/ȡ����Ԫ3ά��ʾ
Public Sub mnuShape3D_click()
	With CellWeb1
        .GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		if .IsCellShape3D(.Row,.Col) then
			.SetCellShape3D StartRow,StartCol,EndRow,EndCol,false
		else
			.SetCellShape3D StartRow,StartCol,EndRow,EndCol,true
		End if
	End With
End Sub

'����������
Public Sub mnuSetRowHide_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetRowHide StartRow,EndRow,true
End Sub

'������ȡ������
Public Sub mnuSetRowUnHide_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetRowHide StartRow,EndRow,false
End Sub

'��������ʵ��и�
Public Sub mnuAutoSizeRow_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.AutoSizeRow StartRow,EndRow,true
End Sub

'�Զ������߶�̫С���и�
Public Sub mnuAutoSizeRow1_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.AutoSizeRow StartRow,EndRow,false
End Sub

'����������
Public Sub mnuSetColHide_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetColHide StartCol,EndCol,true
End Sub

'������ȡ������
Public Sub mnuSetColUnHide_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetColHide StartCol,EndCol,false
End Sub

'��������ʵ��и�
Public Sub mnuAutoSizeCol_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.AutoSizeCol StartCol,EndCol,true
End Sub

'�Զ������߶�̫С���и�
Public Sub mnuAutoSizeCol1_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.AutoSizeCol StartCol,EndCol,false
End Sub

'�����Զ��庯��
Public Sub mnuExportUserFunctions_click()
	strFilename = InputBox( "�����뵼�����ļ�·����:", "�����Զ��庯��", "" )
	If strFilename <> "" Then CellWeb1.ExportUserFunctions strFilename
End Sub

'�����Զ��庯��
Public Sub mnuImportUserFunctions_click()
	strFilename = InputBox( "�����뵼����ļ�·����:", "�����Զ��庯��", "" )
	If strFilename <> "" Then CellWeb1.ImportUserFunctions strFilename
End Sub

'����ͼƬ
Public Sub mnuFormatInsertPic_click()
	CellWeb1.InsertImageFile false
End Sub

'���뵥ԪͼƬ
Public Sub mnuFormatInsertCellPic_click()
	CellWeb1.InsertImageFile true
End Sub

'���õ�Ԫ�����
Public Sub mnuFormatMergeCell_click()
	CellWeb1.OnCellCombiNation true
End Sub

'ȡ����Ԫ�����
Public Sub mnuFormatUnMergeCell_click()
	CellWeb1.OnCellCombiNation false
End Sub

'�����б�
Public Sub mnuFunctionList_click
	With CellWeb1
		.OnFunctionList
	End With	
End Sub

'�Զ��庯����
Public Sub mnuUserFunctionGuide_click()
	CellWeb1.UserFunctionGuide
End Sub

'ˮƽ���
Public Sub cmdFormulaSumH_click()
	With CellWeb1
		StartCol = 0: StartRow = 0: EndCol = 0: EndRow = 0
		.GetSelectRegionWeb StartRow,StartCol,EndRow,EndCol
		.AutoSum StartRow,StartCol,EndRow,EndCol,2
	End With
End Sub

'��ֱ���
Public Sub cmdFormulaSumV_click()
	With CellWeb1
		StartCol = 0: StartRow = 0: EndCol = 0: EndRow = 0
		.GetSelectRegionWeb StartRow,StartCol,EndRow,EndCol
		.AutoSum StartRow,StartCol,EndRow,EndCol,1
	End With
End Sub

'˫�����
Public Sub cmdFormulaSumHV_click()
	With CellWeb1
		StartCol = 0: StartRow = 0: EndCol = 0: EndRow = 0
		.GetSelectRegionWeb StartRow,StartCol,EndRow,EndCol
		.AutoSum StartRow,StartCol,EndRow,EndCol,3
	End With
End Sub


'����ȫ��
Public Sub mnuFormulaReCalc_click()
	CellWeb1.ReCalculate '����ȫ��
	MsgBox "�������", vbExclamation
End Sub

'ͼ����
Public Sub mnuDataWzdChart_click()
	CellWeb1.OnChartWizard
End Sub

'����ͼƬΪԭʼ��С
Public Sub mnuSetCellImageOriginalSize_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		for row = StartRow to EndRow
			for col = StartCol to EndCol
				.SetCellImageSize row,col,true		
			next
		next
		.Refresh
	End With
End Sub

'����ͼƬΪ��Ԫ��С
Public Sub mnuSetCellImageCellSize_click()
	With CellWeb1
		.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
		for row = StartRow to EndRow
			for col = StartCol to EndCol
				.SetCellImageSize row,col,false		
			next
		next
		.Refresh
	End With
End Sub

'ɾ��ͼƬ
Public Sub mnuDeleteCellImage_click()
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.DeleteCellImage StartRow, StartCol, EndRow, EndCol
End Sub

'����/ȡ���б�ͷ
Public Sub mnuRowLabel_click()
	with CellWeb1
		if .GetRowLabel >0 Then
			.SetRowLabel(0)
		else
			.SetRowLabel(.Row)
		End if
	End With
	nMenuID = MenuOcx.GetMenuID("SetRowLabel")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.GetRowLabel
End Sub

'����/ȡ���б�ͷ
Public Sub mnuColLabel_click()
	with CellWeb1
		if .GetColLabel >0 Then
			.SetColLabel(0)
		else
			.SetColLabel(.Col)
		End if
	End With
	nMenuID = MenuOcx.GetMenuID("SetColLabel")
	MenuOcx.SetMenuChecked nMenuID,CellWeb1.GetColLabel
End Sub

'���ô�ӡҳǰ������
Public Sub mnuSetPagePreFooterRows_click()
	nPagePreFooterRows = CellWeb1.GetPagePreFooterRows
	nRow = InputBox( "˵����ҳǰ�ŵ����Ǵӱ���ҳ��ǰһ�п�ʼ��������,���û��ҳ��,������һ�п�ʼ�� ��:������20��,���õ�ҳ��������0��,���õ�ҳǰ����2��,������ҳǰ�ŵ��ǵ�19,20�У���:������20��,���õ�ҳ��������2��,���õ�ҳǰ����2��,������ҳ�ŵ��ǵ�19,20��,����ҳǰ�ŵ��ǵ�17,18�С�         ����������Ϊ��ӡҳǰ��������", "���ô�ӡҳǰ������", nPagePreFooterRows )
	If nRow <> "" Then CellWeb1.SetPagePreFooterRows nRow
End Sub

'���ô�ӡҳ������
Public Sub mnuSetPageFooterRows_click()
	nPageFooterRows = CellWeb1.GetPageFooterRows()
	nRow = InputBox( "˵����ҳ�ŵ��дӱ������һ����������   ��:������20��,����ҳ��������2��,������ҳ�ŵ��ǵ�19,20�С�                 ����������Ϊ��ӡҳ��������", "���ô�ӡҳ������", nPageFooterRows )
	If nRow <> "" Then CellWeb1.SetPageFooterRows nRow
End Sub

'����ÿҳ��ӡ������
Public Sub mnuSetOnePrintPageDetailZoneRows_click()
	nPageRows = CellWeb1.GetOnePrintPageDetailZoneRows()
	nRow = InputBox( "˵������ӡʱÿҳ��ʾ������,��������ͷ�ͱ�βҳ�š�ҳǰ�ŵ�����(���Ϊ0��,���ʾû������ÿҳ��ӡ������,ϵͳ��ȱʡ���з�ҳ)�� ������ÿҳ��ӡ��������", "����ÿҳ��ӡ������", nPageRows )
	If nRow <> "" Then CellWeb1.SetOnePrintPageDetailZoneRows nRow
End Sub

'���ò���ӡ��Ԫ��
Public Sub mnuSetCellCanPrint_click()
	bPrint = not CellWeb1.IsCellCanPrint(CellWeb1.Row,CellWeb1.Col)
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetCellCanPrint StartRow, StartCol, EndRow, EndCol,bPrint
	bPrint = CellWeb1.IsCellCanPrint(CellWeb1.Row,CellWeb1.Col)
	nMenuID = MenuOcx.GetMenuID("SetCellCanPrint")
	MenuOcx.SetMenuChecked nMenuID,bPrint
End Sub

'����ֻ��ӡ��Ԫ������
Public Sub mnuSetCellOnlyPrintText_click()
	bPrint = not CellWeb1.IsCellOnlyPrintText(CellWeb1.Row,CellWeb1.Col)
	CellWeb1.GetSelectRegionWeb StartRow, StartCol, EndRow, EndCol
	CellWeb1.SetCellOnlyPrintText StartRow, StartCol, EndRow, EndCol,bPrint
	bPrint = CellWeb1.IsCellOnlyPrintText(CellWeb1.Row,CellWeb1.Col)
	nMenuID = MenuOcx.GetMenuID("SetCellOnlyPrintText")
	MenuOcx.SetMenuChecked nMenuID,bPrint
End Sub

'*****************************************************************
'**********      �����б���е��¼�
'*****************************************************************
'��������
Public Sub changeFontName( ByVal value )
    With CellWeb1
        lFontName = value
        .CellFontName = lFontName
    End With
End Sub

'�����ֺ�
Public Sub changeFontSize( ByVal value )
    With CellWeb1
        lFontSize = value
		.CellFontSize = lFontSize
    End With

End Sub

