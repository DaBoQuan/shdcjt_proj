<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script type="text/javascript" src="/js/jquery/jquery.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client.js"></script>
</head>

<script language="javascript1.1">
















window.onload=function()
{
  var redirectUrl = "/login/Login.jsp?logintype=1" ;
  var width = screen.width ;
  var height = screen.height ;
  if (height == 768 ) height -= 75 ;
  if (height == 600 ) height -= 60 ;
  var szFeatures = "top=0," ; 
  szFeatures +="left=0," ;
  szFeatures +="width="+width+"," ;
  szFeatures +="height="+height+"," ;
  szFeatures +="directories=no," ;
  szFeatures +="status=yes," ;
  szFeatures +="menubar=no," ;

  if (height <= 600 ) szFeatures +="scrollbars=yes," ;
  else szFeatures +="scrollbars=no," ;

  szFeatures +="resizable=yes" ; //channelmode

  /**
  * 检查窗口是否被阻止
  * updated by cyril on 2008-06-02
  */
  var newwin = window.open(redirectUrl,"",szFeatures) ;
 
  checkPopupBlocked(newwin);
	
  
}

function checkPopupBlocked(poppedWindow) {
	 setTimeout(function(){ 
		 var flag= false
		 if(jQuery.client.browser=="Chrome"){
			 flag = doCheckPopupBlocked(poppedWindow);
		 }else{
			if(poppedWindow!=null){
               flag =  false;
			}else{
               flag = true;
			}
		 }
		 
		
		 if(flag){
			  var redirectUrl = "/login/Login.jsp?logintype=1" ;
			  
			  var helpurl=getHelpUrl();
				  if(helpurl!=""){
					  var yn = confirm("弹出窗口被阻止，无法正常进入系统！\n按【确定】查看帮助，按【取消】以普通模式进入系统。");
					  if(!yn) location.href = redirectUrl;
					  if(yn) location.href = helpurl;
				  }else{
					  location.href = redirectUrl;
			      }
				 
			}else{
				
			   	 window.open('','_self');
			   	 window.close();
			}
		 },500);
}

function doCheckPopupBlocked(poppedWindow) {

	    var result = false;
		//alert(poppedWindow.closed)
	    try {
	        if (typeof poppedWindow == 'undefined') {
	            // Safari with popup blocker... leaves the popup window handle undefined
	            result = true;
	            //alert(1)
	        }
	        else if (poppedWindow && poppedWindow.closed) {
	            // This happens if the user opens and closes the client window...
	            // Confusing because the handle is still available, but it's in a "closed" state.
	            // We're not saying that the window is not being blocked, we're just saying
	            // that the window has been closed before the test could be run.
	            result = false;
	            //alert(2)
	        }
	        else if (poppedWindow && poppedWindow.outerWidth == 0) {
	            // This is usually Chrome's doing. The outerWidth (and most other size/location info)
	         // will be left at 0, EVEN THOUGH the contents of the popup will exist (including the
	         // test function we check for next). The outerWidth starts as 0, so a sufficient delay
	         // after attempting to pop is needed.
	            result = true;
	            //alert(3)
	        }
	        else if (poppedWindow && poppedWindow.test) {
	            // This is the actual test. The client window should be fine.
	            result = false;
	            //alert(4)
	        }
	        else {
	            // Else we'll assume the window is not OK
	            result = false;
	            //alert(5)
	        }

	    } catch (err) {
	        //if (console) {
	        //    console.warn("Could not access popup window", err);
	        //}
	    }

	    return result
}

function getHelpUrl()  
{  
	 
	return "/help/sys/help.html"
    
} 


</script>	
</html>

