function checkusb(){
	try{
		var returnstr = getUserPIN();
		var serialNum = getRandomKey(randLong);
		var reply = false;
		if(returnstr!=undefined && returnstr!="" && serialNum!=undefined && serialNum!=""){
			if(returnstr==usbuserloginid && serialNum==ServerEncData){
				
			}else{
				if(usblanguage == "7"){
					reply = confirm("�������ȷ��usb Key !");
				}else if(usblanguage == "8"){
					reply = confirm("Please insert the real usb key !");
				}else if(usblanguage == "9"){
					reply = confirm("Ո�������_��usb Key !");
				}
				if(reply==true){
					checkusb();
				}else{
					glbreply = false;
					window.location="/login/Logout.jsp";
					return;
				}
			}
		}else{
			if(usblanguage == "7"){
				reply = confirm("�����usb Key !");
			}else if(usblanguage == "8"){
				reply = confirm("Please insert your usb key !");
			}else if(usblanguage == "9"){
				reply = confirm("Ո����usb Key !");
			}
			if(reply==true){
				checkusb();
			}else{
				glbreply = false;
				window.location="/login/Logout.jsp";
				return;
			}
		}
	}catch(err){
		if(usblanguage == "7"){
			reply = confirm("�����usb Key !");
		}else if(usblanguage == "8"){
			reply = confirm("Please insert your usb key !");
		}else if(usblanguage == "9"){
			reply = confirm("Ո����usb Key !");
		}
		if(reply==true){
			checkusb();
		}else{
			glbreply = false;
			window.location="/login/Logout.jsp";
			return;
		}
		return;
	}
	window.setTimeout(function(){checkusb();},5000);
}