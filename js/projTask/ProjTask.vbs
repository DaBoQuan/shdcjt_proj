'�����Զ��岿��
sub onShowBrowser(id,url,linkurl,type1,ismand)
	if type1= 2 or type1 = 19 Then
		spanname = "customfield"+id+"span"
	    inputname = "customfield"+id
		if type1 = 2 then
		  onWorkFlowShowDate spanname,inputname,ismand
        else
	      onWorkFlowShowTime spanname,inputname,ismand
		end if
	else
		if type1 <> 17 and type1 <> 18 and type1<>27 and type1<>37 and type1<>56 and type1<>57 and type1<>65 and type1<>152 and type1<>135 then
			id1 = window.showModalDialog(url)
		else
			tmpids = document.all("customfield"+id).value
			id1 = window.showModalDialog(url&"?resourceids="&tmpids)
		end if
		if NOT isempty(id1) then
			if type1 = 17 or type1 = 18 or type1=27 or type1=37 or type1=56 or type1=57 or type1=65 or type1=152 or type1=135 then
				if id1(0)<> ""  and id1(0)<> "0" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all("customfield"+id).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					document.all("customfield"+id+"span").innerHtml = sHtml

				else
					if ismand=0 then
						document.all("customfield"+id+"span").innerHtml = empty
					else
						document.all("customfield"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.all("customfield"+id).value=""
				end if

			else
			   if  id1(0)<>""   and id1(0)<> "0"  then
			        if linkurl = "" then
						document.all("customfield"+id+"span").innerHtml = id1(1)
					else
						document.all("customfield"+id+"span").innerHtml = "<a href="&linkurl&id1(0)&">"&id1(1)&"</a>"
					end if
					document.all("customfield"+id).value=id1(0)
				else
					if ismand=0 then
						document.all("customfield"+id+"span").innerHtml = empty
					else
		:				document.all("customfield"+id+"span").innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>":
					end if
					document.all("customfield"+id).value=""
				end if
			end if
		end if
	end if

end sub


'�õ�ʱ��
sub getDate(i)
	returndate = window.showModalDialog("/systeminfo/Calendar.jsp",,"dialogHeight:320px;dialogwidth:275px")
	document.all("datespan"&i).innerHtml= returndate
	document.all("dff0"&i).value=returndate
end sub


'��Ŀ����
sub onShowPrjTypeID(txtObj,spanObj,spanImgObj,method,templetId)   
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/Maint/ProjectTypeBrowser.jsp?sqlwhere=Where wfid<>0 ")
	if (Not IsEmpty(id)) then
        if id(0)<> 0 then
            spanObj.innerHtml = id(1)
            txtObj.value=id(0)
			if method="add" then
				location = "ProjTempletAdd.jsp?txtPrjType="+id(0)
			else
				location = "ProjTempletEdit.jsp?txtPrjType="+id(0)+"&templetId="+templetId
			end if
			spanImgObj.innerHTML=""
        else 
            spanObj.innerHtml = ""           
			spanImgObj.innerHTML="<IMG src='/images/BacoError.gif' align='absMiddle'>"
            txtObj.value=""
        end if
	end if
end sub

'��������
sub onShowWorkTypeID(txtObj,spanObj)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/Maint/WorkTypeBrowser.jsp")
	if (Not IsEmpty(id)) then
        if id(0)<> 0 then
            spanObj.innerHtml = id(1)
            txtObj.value=id(0)
        else 
            spanObj.innerHtml = ""
            txtObj.value=""
        end if
	end if
end sub


'������
sub showEnvDoc(txtObj,spanObj)
	id = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if Not isempty(id) then
		txtObj.value=id(0)&""
		spanObj.innerHtml = "<a href='/docs/docs/DocDsp.jsp?id="&id(0)&"'>"&id(1)&"</a>"	
	end if	
end sub

'ȷ����
sub showConDoc(txtObj,spanObj)
	id = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if Not isempty(id) then
		txtObj.value=id(0)&""
		spanObj.innerHtml = "<a href='/docs/docs/DocDsp.jsp?id="&id(0)&"'>"&id(1)&"</a>"	
	end if	
end sub

'������
sub showProDoc(txtObj,spanObj)
	id = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if Not isempty(id) then
		txtObj.value=id(0)&""
		spanObj.innerHtml = "<a href='/docs/docs/DocDsp.jsp?id="&id(0)&"'>"&id(1)&"</a>"	
	end if	
end sub

'����
sub onShowPrjManagerID(txtObj,spanObj)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
        if id(0)<> "" then
            spanObj.innerHtml = "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
            txtObj.value=id(0)
        else 
        :    spanObj.innerHtml = ""
:            txtObj.value=""
        end if
	end if
end sub




'�ϼ���Ŀ
sub onShowParent(txtObj,spanObj)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp")
	if (Not IsEmpty(id)) then
        if id(0)<> "" then
            spanObj.innerHtml = "<A href='/proj/data/ViewProject.jsp?ProjID="&id(0)&"'>"&id(1)&"</A>"
            txtObj.value=id(0)
        else 
            spanObj.innerHtml = ""
            txtObj.value=""
        end if
	end if
end sub



'��ؿͻ�
sub onShowMCrm(inputObj,spanObj)
		tmpids = inputObj.value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/MutiCustomerBrowser.jsp?resourceids="&tmpids)
        if (Not IsEmpty(id1)) then
				if id1(0)<> "" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					inputObj.value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href=/CRM/data/ViewCustomer.jsp?CustomerID="&curid&">"&curname&"</a>&nbsp"
					wend
:					sHtml = sHtml&"<a href=/CRM/data/ViewCustomer.jsp?CustomerID="&resourceids&">"&resourcename&"</a>&nbsp"
					spanObj.innerHtml = sHtml
					
				else
					spanObj.innerHtml =""
					inputObj.value=""
				end if
        end if
end sub

'��Ŀ��Ա
sub onShowMHrm(txtObj,spanObj,spanObj1,isTemplet)
		tmpids = txtObj.value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&tmpids)
        if (Not IsEmpty(id1)) then
				if id1(0)<> "" then					
					oldSelects = getAllSelelt()
					removeAllManager
					

     				resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					sHtml1 = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					txtObj.value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&curid&">"&curname&"</a>&nbsp"
						sHtml1=sHtml1&curname&","
						'��ӵ������˶����
						addSelManager curid,curname 						
					wend
					sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&resourceids&">"&resourcename&"</a>&nbsp"					 
					sHtml1=sHtml1&resourcename
					spanObj.innerHtml = sHtml
					spanObj1.innerHtml = sHtml1
					'��ӵ������˶����
					 addSelManager resourceids,resourcename	
					 
					addSeleValue oldSelects		
				else
					removeAllManager
					if isTemplet="false" then
						spanObj.innerHtml ="<IMG src='/images/BacoError.gif' align='absMiddle'>"
					else 
						spanObj.innerHtml =""
					end if

					spanObj1.innerHtml=""
					txtObj.value=""
				end if
         end if
end sub

'������
sub onShowHrm(txtObj,spanObj)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
		if (id(0) <> "") then
			spanObj.innerHtml = "<a href='/hrm/resource/HrmResource.jsp?id="+id(0)+"'>"+id(1)+"</a>"
			txtObj.value = id(0)
		else
			spanObj.innerHtml = " "
			txtObj.value = ""
		end if
	end if
end sub

'�б�����ʾ��ʼʱ��
sub onShowBeginDate1(returndate,txtObj,spanObj,endDateObj,spanEndDateObj,workLongObj)
	if (not IsEmpty(returndate)) then
		if (returndate<>"") then
			endDate = endDateObj.value			
			if (endDate <> "") then
				diffDate = dateDiffForJava(returndate,endDate)
				if (diffDate<0) then
					If (readCookie("languageidweaver")=8) Then
						msgbox("The end time must be larger than the start time!")
                        spanObj.innerHtml = txtObj.value
					Else
						msgbox("����ʱ�������ڿ�ʼʱ�䣡")
						spanObj.innerHtml = txtObj.value
					End If
				else 
					spanObj.innerHtml= returndate
					txtObj.value=returndate
					workLongObj.value=diffDate
				end if
			 else 
					if  workLongObj.value<>"" then
						newDate = getAddNewDateStr1(returndate,workLongObj.value)
						spanEndDateObj.innerHtml=newDate
						endDateObj.value=newDate
					end if
					spanObj.innerHtml= returndate
	:				txtObj.value=returndate        
			 end if
		Else 
			spanObj.innerHtml= ""
			txtObj.value="" 
		end if
	end if
end sub

'�б�����ʾ����ʱ��
sub onShowEndDate1(returndate,txtObj,spanObj,beginDateObj,spanBeginDateObj,workLongObj)
		if (not IsEmpty(returndate)) then
		if (returndate<>"") then
			beginDate = beginDateObj.value
			diffDate = dateDiffForJava(beginDate,returndate)
			if (beginDate <> "") then
				if (diffDate<0) Then
					If (readCookie("languageidweaver")=8) Then
						msgbox("The end time must be larger than the start time!")
						spanObj.innerHtml = txtObj.value
					Else
						msgbox("����ʱ�������ڿ�ʼʱ�䣡")
						spanObj.innerHtml = txtObj.value
					End If
				 else 
					spanObj.innerHtml= returndate
					txtObj.value=returndate    
					workLongObj.value=diffDate
				end if   
			else :
					if  workLongObj.value<>"" then
						newDate = getSubtrNewDateStr(returndate,workLongObj.value)
						spanBeginDateObj.innerHtml=newDate
						beginDateObj.value=newDate
					end if

					spanObj.innerHtml= returndate
					txtObj.value=returndate    
			end if
		Else
			spanObj.innerHtml= ""
			txtObj.value="" 
		end if
	end if
end sub

'���ı乤��ʱ�����²���
sub onWorkLongChange(workLongObj,beginDateObj,spanBeginDateObj,endDateObj,spanEndDateObj)
	workLong = workLongObj.value
	beginDate = beginDateObj.value
	endDate = endDateObj.value

	if workLong<>"" and beginDate<>"" then
		newDate = getAddNewDateStr1(beginDate,workLong)
		spanEndDateObj.innerHTML=newDate
		endDateObj.value=newDate
		exit sub
	end if

	if workLong<>"" and endDate<>""  then
		newDate = getSubtrNewDateStr(endDate,workLong)
		spanBeginDateObj.innerHTML=newDate
		beginDateObj.value=newDate
		exit sub
	end if

end sub


'���µ�ʱ��ķ��� �ӷ�
	function getAddNewDateStr(strDate,addDay)
       if strDate=""  then 
			getAddNewDateStr="" 	
			exit function
		end if
        
		strDateArray = Split(strDate,"-",-1,1)
		strYear = strDateArray(0)
		strMonth = strDateArray(1)
		strDay = strDateArray(2)
		MyDate2 = DateSerial(CInt(strYear), CInt(strMonth), CInt(strDay)+addDay-1)   		
		myYear = Year(MyDate2) 
		myMonth= Month(MyDate2)
		myDay = Day(MyDate2)

		if myMonth<10 then newMonth = "0"+ CStr(myMonth) else newMonth = CStr(myMonth)
		if myDay<10 then newDay = "0"+ CStr(myDay) else newDay = CStr(myDay)
		getAddNewDateStr = CStr(myYear)+"-"+newMonth+"-"+newDay
	end function
'���µ�ʱ��ķ��� �ӷ�  TD18989
function getAddNewDateStr1(strDate,addDay)
       if strDate=""  then 
			getAddNewDateStr1="" 	
			exit function
		end if
        
		strDateArray = Split(strDate,"-",-1,1)
		strYear = strDateArray(0)
		strMonth = strDateArray(1)
		strDay = strDateArray(2)

		If Int(addDay)>0 And (CStr(Int(addDay))=addDay or CStr(Int(addDay))+".0"=addDay) then
		   MyDate2 = DateSerial(CInt(strYear), CInt(strMonth), CInt(strDay)+Int(addDay)-1) 
        Else 
		   MyDate2 = DateSerial(CInt(strYear), CInt(strMonth), CInt(strDay)+Int(addDay))
		End if   
		myYear = Year(MyDate2) 
		myMonth= Month(MyDate2)
		myDay = Day(MyDate2)

		if myMonth<10 then newMonth = "0"+ CStr(myMonth) else newMonth = CStr(myMonth)
		if myDay<10 then newDay = "0"+ CStr(myDay) else newDay = CStr(myDay)
		getAddNewDateStr1 = CStr(myYear)+"-"+newMonth+"-"+newDay
	end function


'���µ�ʱ��ķ��� ����
	function getSubtrNewDateStr(strDate,addDay)
       if strDate=""  then 
			getSubtrNewDateStr="" 	
			exit function
		end if
        
		strDateArray = Split(strDate,"-",-1,1)
		strYear = strDateArray(0)
		strMonth = strDateArray(1)
		strDay = strDateArray(2)
		MyDate2 = DateSerial(CInt(strYear), CInt(strMonth), CInt(strDay)-addDay+1)   		
		myYear = Year(MyDate2) 
		myMonth= Month(MyDate2)
		myDay = Day(MyDate2)

		if myMonth<10 then newMonth = "0"+ CStr(myMonth) else newMonth = CStr(myMonth)
		if myDay<10 then newDay = "0"+ CStr(myDay) else newDay = CStr(myDay)
		getSubtrNewDateStr = CStr(myYear)+"-"+newMonth+"-"+newDay
	end function