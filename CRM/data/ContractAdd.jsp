<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="ContractTypeComInfo" class="weaver.crm.Maint.ContractTypeComInfo" scope="page" />
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page"/>
<jsp:useBean id="AssetUnitComInfo" class="weaver.lgc.maintenance.AssetUnitComInfo" scope="page"/>
<jsp:useBean id="AssetComInfo" class="weaver.lgc.asset.AssetComInfo" scope="page" />

<%
String CustomerID = request.getParameter("CustomerID");
int rownum=0;
int rownum1=0;
String needcheck="name";

String name = Util.fromScreen(request.getParameter("name"),user.getLanguage());//合同名称
String typeId = Util.fromScreen(request.getParameter("typeId"),user.getLanguage());//合同性质
	String Documentname = Util.null2String(request.getParameter("documentNameTemp"));//合同正文
String docId = Util.fromScreen(request.getParameter("docId"),user.getLanguage());
String price = Util.fromScreen(request.getParameter("price"),user.getLanguage());//合同金额
	String sellChanceIdSpanTemp = Util.null2String(request.getParameter("sellChanceIdSpanTemp"));//销售机会
String sellChanceId = Util.fromScreen(request.getParameter("sellChanceId"),user.getLanguage());
	String managerSpanTemp = Util.null2String(request.getParameter("managerSpanTemp"));//负责人
String manager = Util.fromScreen(request.getParameter("manager"),user.getLanguage());
	String startDateSpanTemp = Util.null2String(request.getParameter("startDateSpanTemp"));//开始日期
String startdate = Util.fromScreen(request.getParameter("startdate"),user.getLanguage());
	String endDateSpanTemp = Util.null2String(request.getParameter("endDateSpanTemp"));//结束日期
String enddate = Util.fromScreen(request.getParameter("enddate"),user.getLanguage());
	String ProjIDspanTemp = Util.null2String(request.getParameter("ProjIDspanTemp"));//相关项目
String ProjID = Util.fromScreen(request.getParameter("ProjID"),user.getLanguage());
String contacterID=Util.null2String(request.getParameter("contacterID"));//客户联系人
String contacterIDSpan=Util.null2String(request.getParameter("contacterIDSpan"));//
  
//String isremind = Util.fromScreen(request.getParameter("isremind"),user.getLanguage());//是否提醒
//System.out.println("isremind:"+isremind);

//根据选择的销售机会得到数据
if(!sellChanceId.equals("")){
	RecordSet.executeProc("CRM_SellChance_SelectByID",sellChanceId);
	if(RecordSet.next()){
		//CustomerID = RecordSet.getString("customerid");
	}
}
%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>

</HEAD>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(614,user.getLanguage()) + SystemEnv.getHtmlLabelName(82,user.getLanguage())+" : " + "<a href =/CRM/data/ViewCustomer.jsp?CustomerID=" + CustomerID + ">" +  Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(CustomerID),user.getLanguage()) + "</a>";
String needfav ="1";
String needhelp ="";
%>
<BODY onbeforeunload="protectContract()">
<!-- added by cyril on 2008-06-13 for TD:8828 -->
<script language=javascript src="/js/checkData.js"></script>
<!-- end by cyril on 2008-06-13 for TD:8828 -->
<%@ include file="/systeminfo/TopTitle.jsp" %>


<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(615,user.getLanguage())+",javascript:doSave(this),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:toBackFun(),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
%>


<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">
<FORM id=weaver name=weaver action="/CRM/data/ContractOperation.jsp" method=post  >
  <input type="hidden" name="method" value="add">
<TABLE class=ViewForm>
  <COLGROUP>
  <COL width="49%">
  <COL width=10>
  <COL width="49%">
  <TBODY>
  <TR>

	<TD vAlign=top style="word-break:break-all">
	
	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="20%">
  		<COL width="80%">
        <TBODY>
        <TR class=Title>
         <TH colSpan=2><%=SystemEnv.getHtmlLabelName(61,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(87,user.getLanguage())%></TH>
         </TR>
        <TR class=Spacing style="height: 1px">
          <TD class=Line1 colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(2227,user.getLanguage())%></TD>
          <TD class=Field>
          <BUTTON class=Browser type="button" id=SelectSellChanceId onClick="onShowSellChanceId()"></BUTTON>
          <span id=sellChanceIdSpan><%=sellChanceIdSpanTemp%></span>
          <INPUT class=InputStyle type=hidden name=sellChanceIdSpanTemp value="<%=sellChanceIdSpanTemp%>"></TD>
          <INPUT class=InputStyle type=hidden name="sellChanceId" value="<%=sellChanceId%>"></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(614,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=50 size=30 name="name" onchange='checkinput("name","nameimage")' value="<%=name%>"><%if(name.equals("")){%><SPAN id=nameimage><IMG src="/images/BacoError.gif" align=absMiddle><%}%></SPAN></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
				<TR>
          <TD><%=SystemEnv.getHtmlLabelName(6083,user.getLanguage())%></TD>
          <TD class=Field>
          <select class=InputStyle id=typeId 
              name=typeId>
          <% 
            while(ContractTypeComInfo.next()){ %>
            <option value=<%=ContractTypeComInfo.getContractTypeid()%> <%if(typeId.equals(ContractTypeComInfo.getContractTypeid())){%>selected<%}%>><%=ContractTypeComInfo.getContractTypename()%></option>
            <%}%>
			</select>
            </TD>
         </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>        
				<TR>
          <TD><%=SystemEnv.getHtmlLabelName(614,user.getLanguage())+SystemEnv.getHtmlLabelName(1265,user.getLanguage())%></TD>
          <TD class=Field>
		  		
        	<INPUT class="wuiBrowser" _displayTemplate="<a href=/docs/docs/DocDsp.jsp?id=#b{id}>#b{name}</a>&nbsp" 
        		_required="yes" _displayText="<%=Documentname%>"
        	_url="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp" _param="documentids" type=hidden name=docId value="<%=docId%>"></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>   	
				<TR>
		 		<TD><%=SystemEnv.getHtmlLabelName(614,user.getLanguage())+SystemEnv.getHtmlLabelName(534,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=10 size=15 name="price" value="<%=price%>" onKeyPress="ItemNum_KeyPress('price')" onBlur='checknumber("price")' onchange='checkinput("price","pricename")'><SPAN ID=pricename></SPAN></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(1268,user.getLanguage())%></TD>
          <TD class=Field>
          	  <input class="wuiBrowser" type=hidden _displayText="<a href='/CRM/data/ViewCustomer.jsp?log=n&CustomerID=<%=CustomerID%>'><%=CustomerInfoComInfo.getCustomerInfoname(CustomerID)%></a>" _displayTemplate="<A href='/CRM/data/ViewCustomer.jsp?CustomerID=#b{id}'>#b{name}</A>" _required="yes" _url="/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp" name="crmId" value="<%=CustomerID%>">
			
            </TD>
         </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>

          <TR>
          <TD><%=SystemEnv.getHtmlLabelName(136,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(572,user.getLanguage())%></TD>
          <TD class=Field>

          <INPUT type=hidden class="wuiBrowser" _required="yes" _displayTemplate="<A href='/CRM/data/ViewContacter.jsp?ContacterID=#b{id}'>#b{name}</A>" _displayText="<%=contacterIDSpan %>" _url="/systeminfo/BrowserMain.jsp?url=/CRM/data/ContactBrowser.jsp?sqlwhere=where customerid=<%=CustomerID%>" name="contacterID" value="<%=contacterID%>"></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
          
         </TBODY>
    </TABLE>
    </TD>

    <TD></TD>

    <TD vAlign=top>

    	<TABLE class=ViewForm>
        <COLGROUP>
		<COL width="20%">
  		<COL width="80%">
        <TBODY>
        <TR class=Title>
        <TH colSpan=2>&nbsp</TH>
        </TR>
        <TR class=Spacing style="height: 1px">
          <TD class=Line1 colSpan=2></TD></TR>
		<TR>
          <TD><%=SystemEnv.getHtmlLabelName(2097,user.getLanguage())%></TD>
          <TD class=Field>
          <INPUT class=wuiBrowser _required="yes" _displayTemplate="<A href='/hrm/resource/HrmResource.jsp?id=#b{id}'>#b{name}</A>" _displayText="<%=managerSpanTemp%>" _url="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp" type=hidden name="manager" <%if(manager.equals("")){%>value="<%=user.getUID()%>"<%}else{%>value="<%=manager%>"<%}%>></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(1970,user.getLanguage())%></TD>
          <TD class=Field>
          <BUTTON type="button" class=Calendar onclick="onShowDate2('startDateSpan','startdate','startDateSpanTemp')"></BUTTON>
          <SPAN id=startDateSpan ><%if(startDateSpanTemp.equals("")){%><IMG src='/images/BacoError.gif' align=absMiddle><%}%><%=startDateSpanTemp%></SPAN>
          <input type="hidden" name="startDateSpanTemp" value="<%=startDateSpanTemp%>"></TD>
          <input type="hidden" name="startdate" value="<%=startdate%>">
          </TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(614,user.getLanguage())+SystemEnv.getHtmlLabelName(741,user.getLanguage())%></TD>
          <TD class=Field> <BUTTON type="button" class=Calendar onclick="onShowDate2('endDateSpan','enddate','endDateSpanTemp')"></BUTTON>
          <SPAN id=endDateSpan ><%if(endDateSpanTemp.equals("")){%><IMG src='/images/BacoError.gif' align=absMiddle><%}%><%=endDateSpanTemp%></SPAN>
          <input type="hidden" name="endDateSpanTemp" value="<%=endDateSpanTemp%>"></TD>
          <input type="hidden" name="enddate" value="<%=enddate%>"></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
				<TR>
					<TD><%=SystemEnv.getHtmlLabelName(782,user.getLanguage())%></TD>
					<TD class=Field>
      	 	<INPUT class=wuiBrowser _displayTemplate="<A href='/proj/data/ViewProject.jsp?ProjID=#b{id}'>#b{name}</A>" _displayText="<%=ProjIDspanTemp%>" _url="/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp" type=hidden name="ProjID" value="<%=ProjID%>"></TD>
				</TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
		  	<TR>
          <TD><%=SystemEnv.getHtmlLabelName(6078,user.getLanguage())%></TD>
          <TD class=Field><INPUT type=checkbox name="isremind" value="0" checked onclick="changeDiv()"></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>
		<TR>
		<TD colspan=2>
		<div id=beforeDiv style="display:''">
		<TABLE class=ViewForm>
        <COLGROUP>
		<COL width="20%">
  		<COL width="80%">
        <TBODY>
		<TR>
		 <TD><%=SystemEnv.getHtmlLabelName(6077,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=2 size=10 name="before" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber("before")' onchange='checkinput("before","beforeimage")' value="15"><SPAN id=beforeimage></SPAN></TD>
        </TR><tr  style="height: 1px"><td class=Line colspan=2> </td></tr>

		 </TBODY>
		 </TABLE>
		</div>
		</TD>
		</TR>

         </TBODY>
    </TABLE>
    </TD>
    </TR></TBODY></TABLE>


   <TABLE class=ListStyle cellspacing=1  cols=10 id="oTable">
      <TR class=header>
       <TH colspan=2><%=SystemEnv.getHtmlLabelName(15115,user.getLanguage())%></TH>
       <Td align=right colSpan=8>
	  <BUTTON class=btnNew accessKey=A type="button" onClick="addRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(15128,user.getLanguage())%></BUTTON>
	  <BUTTON class=btnDelete accessKey=D type="button" onClick="javascript:if(isdel()){deleteRow()};"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
      </Td>       
      </TR>
    	<tr class=header>
           <td class=Field>&nbsp;</td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(15129,user.getLanguage())%></td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(1329,user.getLanguage())%></td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(649,user.getLanguage())%></td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(1330,user.getLanguage())%></td>
		   <td class=Field><%=SystemEnv.getHtmlLabelName(15130,user.getLanguage())%></td>
           <td class=Field><%=SystemEnv.getHtmlLabelName(1331,user.getLanguage())%></td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(534,user.getLanguage())%></td>
		   <td class=Field><%=SystemEnv.getHtmlLabelName(1050,user.getLanguage())%></td>
		   <td class=Field><%=SystemEnv.getHtmlLabelName(6078,user.getLanguage())%></td>
    	</tr>
<TR class=Line><TD colSpan=10 style="padding: 0"></TD></TR>
<%if(!sellChanceId.equals("")){%>
		<%
		int i=0;
		boolean isLight = true;
		RecordSet.executeProc("CRM_Product_SelectByID",sellChanceId);
		while (RecordSet.next()) {
		if (isLight) {%>
		<tr class=datalight>
		<%} else {%>
		<tr class=datadark>
		<%}%>
      <td>
      	<input type='checkbox' name='check_node' value='0' <%if (Util.getIntValue(RecordSet.getString("factnumber_n"),0)>0) {%>disabled<%}%>>
				<input type='hidden' name='canDeleteP_<%=i%>' value='<%if (Util.getIntValue(RecordSet.getString("factnumber_n"),0)==0) {%>0<%}else{%>1<%}%>' >
				<!--0为能删除-->
				<input type='hidden' name='productId_<%=i%>' value='<%=RecordSet.getString("id")%>' >
			</td>
			<td>
				<button class=Browser type="button" onClick="onGetProduct(productname_<%=i%>span,productname_<%=i%>,assetunitid_<%=i%>span,assetunitid_<%=i%>,currencyid_<%=i%>Span,currencyid_<%=i%>,productPrice_<%=i%>,productPrices_<%=i%>)"></button>
				<span class=InputStyle id="productname_<%=i%>span"><a href = "/lgc/asset/LgcAsset.jsp?paraid=<%=RecordSet.getString("productId")%>"><%=Util.toScreen(AssetComInfo.getAssetName(RecordSet.getString("productId")),user.getLanguage())%></a></span> 
				<input type="hidden" name="productname_<%=i%>"  id="productname_<%=i%>" value="<%=RecordSet.getString("productid")%>">
			</td>
			<td>			
				<span class=InputStyle id="assetunitid_<%=i%>span"><%=Util.toScreen(AssetUnitComInfo.getAssetUnitname(RecordSet.getString("assetunitid")),user.getLanguage())%></span> 
				<input type="hidden" name="assetunitid_<%=i%>"  id="assetunitid_<%=i%>" value="<%=RecordSet.getString("assetunitid")%>">
			</td>
			<td>
				 
				<input type="hidden" class="wuiBrowser" _displayText="<%=Util.toScreen(CurrencyComInfo.getCurrencyname(RecordSet.getString("currencyid")),user.getLanguage())%>" _url="/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp" name="currencyid_<%=i%>" id="currencyid_<%=i%>" value="<%=RecordSet.getString("currencyid")%>">
			</td>
			<td>
				<input type=text class='InputStyle' id="productPrice_<%=i%>"  name="productPrice_<%=i%>" onKeyPress="ItemNum_KeyPress('productPrice_<%=i%>')" onBlur="checknumber1(this);sumPrices(<%=i%>);sumTotalPrices()" size=17 value="<%=RecordSet.getString("salesprice")%>" onchange='checkinput("productPrice_<%=i%>","productPrice_<%=i%>span")' maxlength=17><span id="productPrice_<%=i%>span"></span>
			</td>
			<td>
				<input type=text class='InputStyle' id="productDepreciation_<%=i%>"  name="productDepreciation_<%=i%>" onKeyPress="ItemCount_KeyPress()" onBlur="checknumber1(this);sumPrices(<%=i%>);sumTotalPrices()" size=5 maxLength=3 value="100" onchange='checkinput("productDepreciation_<%=i%>","productDepreciation_<%=i%>span")'>%<span id="productDepreciation_<%=i%>span"></span></td>
			<td>
				<input type=text class='InputStyle' name="productNumber_<%=i%>" onKeyPress="ItemNum_KeyPress('productNumber_<%=i%>');checkProductNumber(<%=i%>)" onBlur="checknumber1(this);sumPrices(<%=i%>);sumTotalPrices()" size=10 value="<%=RecordSet.getString("salesnum")%>" onchange='checkinput("productNumber_<%=i%>","productNumber_<%=i%>span")'><span id="productNumber_<%=i%>span"></span>	
			</td>
			<td>
				<input type=text class='InputStyle' id="productPrices_<%=i%>"  name="productPrices_<%=i%>" onKeyPress="ItemNum_KeyPress('productPrices_<%=i%>')" onBlur="checknumber1(this)" size=17 value="<%=RecordSet.getString("totelprice")%>" maxlength=17>	
			</td>
			<td>
				<BUTTON class=Calendar type="button" onclick='onShowDate("productDatespan_<%=i%>","productDate_<%=i%>")'></BUTTON> 
				<SPAN id="productDatespan_<%=i%>"><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>
				<input type="hidden" name = "productDate_<%=i%>" value="">	
			</td>
			<td >
				<INPUT type=checkbox name="productIsRemind_<%=i%>" value=0 checked>	
			</td>
    	</tr>
		<%
		i++;
		}
		rownum = RecordSet.getCounts();
		%>
<%}%>
		<input type="hidden" name="rownum" value="<%=rownum%>">  

   </table>  	
	<BR><BR>
   <TABLE class=ListStyle cellspacing=1  cols=8 id="mTable">
     <input type="hidden" name="rownum1" value="0">  
      <TR class=header>
       <TH colspan=2><%=SystemEnv.getHtmlLabelName(15131,user.getLanguage())%></TH>
       <Td align=right colSpan=8>
	  <BUTTON class=btnNew accessKey=N type="button" onClick="addRow1();"><U>N</U>-<%=SystemEnv.getHtmlLabelName(15128,user.getLanguage())%></BUTTON>
	  <BUTTON class=btnDelete accessKey=R type="button" onClick="javascript:if(isdel()){deleteRow1()};"><U>R</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
      </Td>       
      </TR>
<TR class=Line><TD colSpan=8 style="padding: 0"></TD></TR>
    	<tr class=header>
           <td class=Field>&nbsp;</td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(15132,user.getLanguage())%></td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(15133,user.getLanguage())%></td>
           <td class=Field><%=SystemEnv.getHtmlLabelName(1462,user.getLanguage())%></td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(15134,user.getLanguage())%></td>
    	   <td class=Field><%=SystemEnv.getHtmlLabelName(15135,user.getLanguage())%></td>
		   <td class=Field><%=SystemEnv.getHtmlLabelName(15136,user.getLanguage())%></td>
		   <td class=Field><%=SystemEnv.getHtmlLabelName(6078,user.getLanguage())%></td>
    	</tr>
   </table>
		</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>


<SCRIPT language="javascript" src="/js/OrderValidator.js"></SCRIPT>
<%int i= 0; %>
<script language=javascript>
function onShowSellChanceId(){
	var opts={
			_dwidth:'550px',
			_dheight:'550px',
			_url:'about:blank',
			_scroll:"no",
			_dialogArguments:"",
			
			value:""
		};
	var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //获得窗口的水平位置;
	opts.top=iTop;
	opts.left=iLeft;
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/sellchance/SellChanceBrowser.jsp",
			"","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
	if (data){
		if(data.id!=""){
			sellChanceIdSpan.innerHTML = "<A href='/CRM/sellchance/ViewSellChance.jsp?id="+data.id+"'>"+data.name+"</A>"
			weaver.sellChanceId.value=data.id;
			weaver.sellChanceIdSpanTemp.value="<A href='/CRM/sellchance/ViewSellChance.jsp?id="+data.id+"'>"+data.name+"</A>"
			weaver.action="ContractAdd.jsp?CustomerID=<%=CustomerID%>"
			window.onbeforeunload=null
			weaver.submit()
		}else{ 
			sellChanceIdSpan.innerHTML = ""
			weaver.sellChanceId.value=""
		}
	}
}

function onShowBudgetType(spanname,inputename,paymethodType){
	var link="";
	if (document.all(paymethodType).value ==2){
		link="/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp?sqlwhere=where feetype='1'";
	}else{
		link="/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp?sqlwhere=where feetype='2'";
	}
	var opts={
			_dwidth:'550px',
			_dheight:'550px',
			_url:'about:blank',
			_scroll:"no",
			_dialogArguments:"",
			
			value:""
		};
	var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //获得窗口的水平位置;
	opts.top=iTop;
	opts.left=iLeft;
	data = window.showModalDialog(link,
			"","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
	
	if (data){
		if (data.id!=""){
			document.all(spanname).innerHTML = data.name
			document.all(inputename).value = data.id
		}else{
			document.all(spanname).innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			document.all(inputename).value=""
		}
	}

}


function onGetProduct(spanname1,inputename1,spanname2,inputename2,spanname3,inputename3,inputename4,inputename5){
	var opts={
			_dwidth:'550px',
			_dheight:'550px',
			_url:'about:blank',
			_scroll:"no",
			_dialogArguments:"",
			
			value:""
		};
	var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //获得窗口的水平位置;
	opts.top=iTop;
	opts.left=iLeft;
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/lgc/search/LgcProductBrowser.jsp",
			"","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
	
	if (data){
		if (data.id!=""){
			spanname1.innerHTML = "<A href='/lgc/asset/LgcAsset.jsp?paraid="+wuiUtil.getJsonValueByIndex(data,0)+"'>"+wuiUtil.getJsonValueByIndex(data,1)+"</A>"
			inputename1.value=wuiUtil.getJsonValueByIndex(data,0)
			spanname2.innerHTML = wuiUtil.getJsonValueByIndex(data,3)
			inputename2.value = wuiUtil.getJsonValueByIndex(data,2)
			spanname3.innerHTML = wuiUtil.getJsonValueByIndex(data,5)
			inputename3.value = wuiUtil.getJsonValueByIndex(data,4)
			inputename4.value = wuiUtil.getJsonValueByIndex(data,6)
			inputename5.value = wuiUtil.getJsonValueByIndex(data,6)
		}else{
			spanname1.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			inputename1.value = ""
			spanname2.innerHTML = ""
			inputename2.value = ""
			spanname3.innerHTML = ""
			inputename3.value = ""
			inputename4.value = "0"
			inputename5.value = "0"
		}
	}
	sumTotalPrices()
}



rowindex = "<%=rownum%>";
rowindex1 = "<%=rownum1%>";

sumTotalPrices();
function addRow()
{
	ncol = jQuery(oTable).attr("cols")
	
	oRow = oTable.insertRow(-1);
	
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= "#efefef";
		switch(j) {
            case 0:
                oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input type='checkbox' name='check_node' value='0' >"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;			
			case 1:
				var oDiv = document.createElement("div");
				var sHtml =  "<button class=Browser type='button' onClick=onGetProduct(productname_"+rowindex+"span,productname_"+rowindex+",assetunitid_"+rowindex+"span,assetunitid_"+rowindex+",currencyid_"+rowindex+"Span,currencyid_"+rowindex+",productPrice_"+rowindex+",productPrices_"+rowindex+")></button> " + 
        					"<span class=InputStyle id=productname_"+rowindex+"span><IMG src='/images/BacoError.gif' align=absMiddle></span> "+
        					"<input type='hidden' name='productname_"+rowindex+"'  id=productname_"+rowindex+">";
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<span class=InputStyle id=assetunitid_"+rowindex+"span></span> "+
        					"<input type='hidden' name='assetunitid_"+rowindex+"'  id=assetunitid_"+rowindex+" >";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;	
			case 3:
				var oDiv = document.createElement("div");
				var sHtml = "<input type='hidden' class='wuiBrowser' _url='/systeminfo/BrowserMain.jsp?url=/fna/maintenance/CurrencyBrowser.jsp' name='currencyid_"+rowindex+"' id=currencyid_"+rowindex+">";
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				jQuery(oDiv).find(".wuiBrowser").modalDialog();
				break;                
			case 4: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text class='InputStyle' id='productPrice_"+rowindex+"'  name='productPrice_"+rowindex+"' onKeyPress=ItemNum_KeyPress('productPrice_"+rowindex+"') onBlur='checknumber1(this);sumPrices("+rowindex+");sumTotalPrices()' size=17 onchange=checkinput('productPrice_"+rowindex+"','productPrice_"+rowindex+"span') value='0.00'><span class=InputStyle id=productPrice_"+rowindex+"span></span>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;

			case 5: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text class='InputStyle' id='productDepreciation_"+rowindex+"'  name='productDepreciation_"+rowindex+"' onKeyPress='ItemCount_KeyPress()' onBlur='checknumber1(this);sumPrices("+rowindex+");sumTotalPrices()' size=5 maxLength=3 value = 100 onchange=checkinput('productDepreciation_"+rowindex+"','productDepreciation_"+rowindex+"span')>%<span class=InputStyle id=productDepreciation_"+rowindex+"span></span>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;


			case 6: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text class='InputStyle' name='productNumber_"+rowindex+"' onKeyPress=ItemNum_KeyPress('productNumber_"+rowindex+"');checkProductNumber("+rowindex+"); onBlur='checknumber1(this);sumPrices("+rowindex+");sumTotalPrices()' size=10 value='1' onchange=checkinput('productNumber_"+rowindex+"','productNumber_"+rowindex+"span')><span class=InputStyle id=productNumber_"+rowindex+"span></span>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;               
            case 7: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text class='InputStyle' id='productPrices_"+rowindex+"'  name='productPrices_"+rowindex+"' onKeyPress=ItemNum_KeyPress('productPrices_"+rowindex+"') onBlur='checknumber1(this);sumTotalPrices()' size=17 value='0.00' onchange=checkinput('productPrices_"+rowindex+"','productPrices_"+rowindex+"span')><span class=InputStyle id=productPrices_"+rowindex+"span></span>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;	
			 case 8: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON type='button' class=Calendar onclick=onShowDate('productDatespan_" + rowindex + "','productDate_" + rowindex + "')></BUTTON> <SPAN id=productDatespan_" + rowindex + "><IMG src='/images/BacoError.gif' align=absMiddle></SPAN> <input type='hidden' name = productDate_" + rowindex + ">";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;	
			 case 9: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<INPUT type=checkbox name=productIsRemind_" + rowindex + " value=0 checked>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;	
		}
	}
	rowindex = rowindex*1 +1;
	weaver.rownum.value=rowindex;	
}

function addRow1()
{
	ncol = jQuery(mTable).attr("cols");
	oRow = mTable.insertRow(-1);
	
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= "#efefef";
		switch(j) {
            case 0:
                oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input type='checkbox' name='check_nodeM' value='0' >"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;			
			case 1:
				var oDiv = document.createElement("div");
				var sHtml =  "<input class='InputStyle' name='paymethodName_"+rowindex1+"' id='paymethodName_"+rowindex1+"' onchange=checkinput('paymethodName_"+rowindex1+"','paymethodName_"+rowindex1+"span') ><span class=InputStyle id=paymethodName_"+rowindex1+"span><IMG src='/images/BacoError.gif' align=absMiddle></span>";
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<select class=InputStyle  name=paymethodType_"+rowindex1+" onclick=onSelectStart(this,"+rowindex1+") onchange=onSelectChange(this,"+rowindex1+")><option value=1><%=SystemEnv.getHtmlLabelName(15137,user.getLanguage())%></option><option value=2><%=SystemEnv.getHtmlLabelName(15138,user.getLanguage())%></option></select>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;	
			case 3: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Browser type='button' onclick=onShowBudgetType('BudgetTypespan_" + rowindex1 + "','BudgetType_" + rowindex1 + "','paymethodType_" + rowindex1 + "')></BUTTON> <SPAN id=BudgetTypespan_" + rowindex1 + "><IMG src='/images/BacoError.gif' align=absMiddle></SPAN> <input type='hidden' name = BudgetType_" + rowindex1 + ">";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;	
			case 4:
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text class='InputStyle' id='paymethodPrice_"+rowindex1+"'  name='paymethodPrice_"+rowindex1+"' onKeyPress=ItemNum_KeyPress('paymethodPrice_"+rowindex1+"') onBlur='checknumber1(this)' size=15 onchange=checkinput('paymethodPrice_"+rowindex1+"','paymethodPrice_"+rowindex1+"span') maxlength=15><span class=InputStyle id=paymethodPrice_"+rowindex1+"span><IMG src='/images/BacoError.gif' align=absMiddle></span>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;                
			case 5: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON type='button' class=Calendar onclick=onShowDate('paymethodDatespan_" + rowindex1 + "','paymethodDate_" + rowindex1 + "')></BUTTON> <SPAN id=paymethodDatespan_" + rowindex1 + "><IMG src='/images/BacoError.gif' align=absMiddle></SPAN> <input type='hidden' name = paymethodDate_" + rowindex1 + ">";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;	

			case 6: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input type=text class='InputStyle' id='paymethodDesc_"+rowindex1+"'  name='paymethodDesc_"+rowindex1+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
				
			 case 7: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<INPUT type=checkbox name=paymethodIsRemind_" + rowindex1 + " value=0 checked>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;	
		}
	}
	rowindex1 = rowindex1*1 +1;
	weaver.rownum1.value=rowindex1;	
}


function onSelectChange(obj,index){
	if(confirm("<%=SystemEnv.getHtmlLabelName(25464,user.getLanguage())%>")) {
		document.getElementById("BudgetType_"+index).value="";
		document.all("BudgetTypespan_"+index).innerHTML= "<IMG src='/images/BacoError.gif' align=absMiddle>";
	}
}

function onSelectStart(obj,index){
	   document.getElementById("paymethodType_"+index).value=obj.options.value;
}

function deleteRow()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
    for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node')
			rowsum1 += 1;
	} 
	
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node'){
			if(document.forms[0].elements[i].checked==true) {
				oTable.deleteRow(rowsum1+2);	
			}
			rowsum1 -=1;
		}	
	}	
}


function deleteRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
    for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_nodeM')
			rowsum1 += 1;
	} 
	
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_nodeM'){
			if(document.forms[0].elements[i].checked==true) {
				mTable.deleteRow(rowsum1+2);	
			}
			rowsum1 -=1;
		}	
	}	
}
function checkProductNumber(rowval){
	count_number = document.all("productNumber_"+rowval).value;
	if(count_number.indexOf(".")!=-1 && (window.event.keyCode>=48) && (window.event.keyCode<=57)){
		
	}else{
		if(count_number==0 && window.event.keyCode==45 && window.event.keyCode==46){
			window.event.keyCode=0;
		}
		if(count_number>=10000000 && window.event.keyCode!=46){
			window.event.keyCode=0;
		}
	}
}
function sumPrices(rowval){
	count_total = 0 ;
	count_Depreciation = 0;
    count_number = 0;	

    count_total = eval(toFloat(document.all("productPrice_"+rowval).value,0));
	count_Depreciation = eval(toInt(document.all("productDepreciation_"+rowval).value,100));
	count_number = eval(toFloat(document.all("productNumber_"+rowval).value,0));
    
    count_total = toFloat(count_total/ 100)  * count_Depreciation  * count_number ;
    if(count_number>99999999.99){
    	alert("<%=SystemEnv.getHtmlLabelName(19330,user.getLanguage())%>");
    	document.all("productNumber_"+rowval).value=1;
	}
    if(count_total>999999999999999.99){
    	alert("<%=SystemEnv.getHtmlLabelName(19330,user.getLanguage())%>");
    	document.all("productNumber_"+rowval).value=1;
    }else{
		document.all("productPrices_"+rowval).value = toPrecision(count_total,2) ; 
	}
}

function sumTotalPrices(){
    rowindex = eval(toInt(document.all("rownum").value,0));
    count_sum=0;
    for(i=0;i<rowindex;i++){
		if ((document.all("productname_"+i))!=null) {
        count_sum += toPrecision(eval(toFloat(document.all("productPrices_"+i).value,0)),2);
		}
    }
    if(count_sum>999999999999999.99){
    	alert("<%=SystemEnv.getHtmlLabelName(19330,user.getLanguage())%>");
    }
	document.all("price").value =  toPrecision(count_sum,2);
}

/**
return a number with a specified precision.
*/
function toPrecision(aNumber,precision){
	var temp1 = Math.pow(10,precision);
	var temp2 = new Number(aNumber);

	return isNaN(Math.round(temp1*temp2) /temp1)?0:Math.round(temp1*temp2) /temp1 ;
}

function toFloat(str , def) {
	if(isNaN(parseFloat(str))) return def ;
	else return str ;
}
function toInt(str , def) {
	if(isNaN(parseInt(str))) return def ;
	else return str ;
}

function doSave(obj){
	window.onbeforeunload=null;
	var parastr = "<%=needcheck%>" ;	
	parastr +=",docId,price,crmId,contacterID,manager,startdate,enddate,before";
	for(i=0; i<document.all("rownum").value ; i++) {
		parastr += ",productname_"+i ;
		parastr += ",productPrice_"+i ;
		parastr += ",productDepreciation_"+i ;
		parastr += ",productNumber_"+i ;
		parastr += ",productPrices_"+i ;
		parastr += ",productDate_"+i ;
	}

	for(i=0; i<document.all("rownum1").value ; i++) {
		parastr += ",paymethodName_"+i ;
		parastr += ",paymethodPrice_"+i ;
		parastr += ",paymethodDate_"+i ;
		parastr += ",BudgetType_"+i ;
	}
	if (check_form(document.weaver,parastr)) {
		//added by lupeng 2004.05.21 for TD461.
		if (!checkOrderValid("startdate", "enddate")) {
			alert("<%=SystemEnv.getHtmlNoteName(54,user.getLanguage())%>");
			return;
		}
		//end
    
    	obj.disabled = true; // added by 徐蔚绛 for td:1551 on 2005-03-14
		document.weaver.submit();
	}
}

function protectContract(){
	if(!checkDataChange())//added by cyril on 2008-06-13 for TD:8828
		event.returnValue="<%=SystemEnv.getHtmlLabelName(18957,user.getLanguage())%>";
}

function toBackFun(){
  onbeforeunload = "";
  if(!checkDataChange()){
    if(window.confirm("<%=SystemEnv.getHtmlLabelName(18957,user.getLanguage())%>")){
	    window.location="/CRM/data/ContractList.jsp?CustomerID="+<%=CustomerID%>;
	}
  }else{
      window.location="/CRM/data/ContractList.jsp?CustomerID="+<%=CustomerID%>;
  }
}

function changeDiv(){
	if (document.all("beforeDiv").style.display == "")
	document.all("beforeDiv").style.display = 'none' ;
	else 
	document.all("beforeDiv").style.display = ''	;
}
createTags();//added by cyril on 2008-06-13 for TD:8828
</SCRIPT>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>

