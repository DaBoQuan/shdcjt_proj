var _PopTimer = 0;

//�Ҳ˲˵���
function contextMenu(){
  this.items   = new Array();
  this.addItem = function (item){
    this.items[this.items.length] = item;
  }
  this.show = function (oDoc){
    var S = "";
    var i;
  
    S = "<div id=\"rightmenu\" style=\"BACKGROUND-COLOR: #ffffff; BORDER: #000000 1px solid; LEFT: 0px; POSITION: absolute; TOP: 0px; VISIBILITY: hidden; Z-INDEX: 10\">";
    S += "<table class=\"menutable\" border=\"0\" height=\"";
    S += this.items.length * 20;
    S += "\" cellpadding=\"0\" cellspacing=\"0\">";
    S += "<tr height=\"3\"><td bgcolor=\"#d0d0ce\" width=\"2\"></td><td>";
    S += "<table class=\"menutable\" border=\"0\" width=\"100%\" height=\"100%\" cellpadding=0 cellspacing=0 bgcolor=\"#ffffff\">";
    S += "<tr><td bgcolor=\"#d0d0ce\" width=\"23\"></td><td><img src=\" \" height=\"1\" border=\"0\"></td></tr></table>";
    S += "</td><td width=\"2\"></td></tr>";
    S += "<tr><td bgcolor=\"#d0d0ce\"></td><td>";
    S += "<table class=\"menutable\" border=\"0\" width=\"100%\" height=\"100%\" cellpadding=3 cellspacing=0 bgcolor=\"#ffffff\">";
    oDoc.write(S);
    for(i=0; i<this.items.length; i++){
      this.items[i].show(oDoc);
    }
    S = "</table></td><td></td></tr>";
    S += "<tr height=\"3\"><td bgcolor=\"#d0d0ce\"></td><td>";
    S += "<table class=\"menutable\" border=\"0\" width=\"100%\" height=\"100%\" cellpadding=0 cellspacing=0 bgcolor=\"#ffffff\">";
    S += "<tr><td bgcolor=\"#d0d0ce\" width=\"23\"></td><td><img src=\" \" height=\"1\" border=\"0\"></td></tr></table>";
    S += "</td><td></td></tr>";
    S += "</table></div>\n";
    oDoc.write(S);
  }
}

//�Ҽ��˵�����
function contextItem(text, icon, cmd, type){
  this.text = text ? text : "";
  this.icon = icon ? icon : "";
  this.cmd = cmd ? cmd : "";
  this.type = type ? type : "menu";
 
  this.show = function (oDoc){
    var S = "";
  
    if(this.type == "menu"){
      S += "<tr ";
      S += "onmouseover=\"changeStyle(this, 'on');\" ";
      S += "onmouseout=\"changeStyle(this, 'out');\" ";
      S += "onclick=\"hideMenu();";
      S += this.cmd;
      S += "\">";
      S += "<td class=\"ltdexit\" width=\"16\">";
      if (this.icon == "")
        S += "&nbsp;";
      else{
        S += "<img border=\"0\" src=\"";
        S += this.icon;
        S += "\" style=\"POSITION: relative\"></img>";
      }
      S += "</td><td class=\"mtdexit\">";
      S += this.text;
      S += "</td><td class=\"rtdexit\" width=\"5\">&nbsp;</td></tr>";
    }
    else if (this.type == "separator"){
      S += "<tr><td class=\"ltdexit\">&nbsp;</td>";
      S += "<td class=\"mtdexit\" colspan=\"2\"><hr color=\"#000000\" size=\"1\"></td></tr>";
    }
    oDoc.write(S);
  }
}

//������ڲ˵������ƶ�ʱ��������ʽ����ʾXPЧ��
function changeStyle(obj, cmd){ 
  if(obj) try {
    var imgObj = obj.children(0).children(0);
    
    if(cmd == 'on'){
      obj.children(0).className = "ltdfocus";
      obj.children(1).className = "mtdfocus";
      obj.children(2).className = "rtdfocus";
      if(imgObj){
        if(imgObj.tagName.toUpperCase() == "IMG"){
          imgObj.style.left = "-1px";
          imgObj.style.top = "-1px";
        }
      }
    }
    else if(cmd == 'out') {
      obj.children(0).className = "ltdexit";
      obj.children(1).className = "mtdexit";
      obj.children(2).className = "rtdexit";
      if(imgObj){
        if(imgObj.tagName.toUpperCase() == "IMG"){
          imgObj.style.left = "0px";
          imgObj.style.top = "0px";
        }
      }
    }
  }
  catch (e) {}
}

function StopTimeout(){
  clearTimeout(_PopTimer);
}

function StartTimeout(){
  if(_PopTimer == 0)  _PopTimer = setTimeout('hideMenu()', 500);
}

//�����Ҽ��˵�
function showMenu(){
  //if(event.srcElement.tagName != "BODY") return false;
  var x, y, w, h, ox, oy;

  x = event.clientX;
  y = event.clientY;

  var obj = document.getElementById("rightmenu");
  if (obj == null)
  return true;

  ox = document.body.clientWidth;
  oy = document.body.clientHeight;
  if(x > ox || y > oy) return false;
  w = obj.offsetWidth;
  h = obj.offsetHeight;
  if((x + w) > ox)  x = x - w;
  if((y + h) > oy)  y = y - h;

  obj.style.posLeft = x + document.body.scrollLeft;
  obj.style.posTop = y + document.body.scrollTop;
  obj.style.visibility = "visible";

  return false;
}

//�����Ҽ��˵�
function hideMenu(){
  if(event.button == 0){
    var obj = document.getElementById("rightmenu");
    if (obj == null)  return true;
    obj.style.visibility = "hidden";
    obj.style.posLeft = 0;
    obj.style.posTop = 0;
  }
}

//Ԥѡ���ĵ������XP����˵����������ʽCSS
function writeContextStyle(){
  var S = "";

  S += "<STYLE type=text/css>";
  S += ".menutable {Font-FAMILY: \"Tahoma\",\"Verdana\",\"����\"; FONT-SIZE: 9pt}";
  S += ".mtdfocus {BACKGROUND-COLOR: #ccccff; BORDER-BOTTOM: #000000 1px solid; BORDER-TOP: #000000 1px solid; CURSOR: hand}";
  S += ".mtdexit {BACKGROUND-COLOR: #ffffff; BORDER-BOTTOM: #ffffff 1px solid; BORDER-TOP: #ffffff 1px solid}";
  S += ".ltdfocus {BACKGROUND-COLOR: #ccccff; BORDER-BOTTOM: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; CURSOR: hand}";
  S += ".ltdexit {BACKGROUND-COLOR: #d0d0ce; BORDER-BOTTOM: #d0d0ce 1px solid; BORDER-TOP: #d0d0ce 1px solid; BORDER-LEFT: #d0d0ce 1px solid}";
  S += ".rtdfocus {BACKGROUND-COLOR: #ccccff; BORDER-BOTTOM: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-RIGHT: #000000 1px solid; CURSOR: hand}";
  S += ".rtdexit {BACKGROUND-COLOR: #ffffff; BORDER-BOTTOM: #ffffff 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid}";
  S += "</STYLE>";

  document.write(S);
}

//�����Ƿ�Ҫ��ҳ���������Ҽ��˵�
function toggleMenu(isEnable){
  if(isEnable)
    document.oncontextmenu = showMenu;
  else
    document.oncontextmenu = new function() {return true;};
}

//ִ�����XP�˵���ʽ
writeContextStyle();

/*����������ʵ��Ӧ���в�Ҫ������DrawContextMenu��������*/

//����ҳ�ϴ����Ҽ��˵�
function DrawContextMenu(){
  var popmnu, item;

  popmnu = new contextMenu();

  /*item = new contextItem("�½�����ͼ", "image/new.gif", "mnuNewFlow();", "menu");
  popmnu.addItem(item);

  item = new contextItem("������ͼ", "image/open.gif", "mnuOpenFlow();", "menu");
  popmnu.addItem(item);*/

  /*item = new contextItem("��������ͼ", "image/save.gif", "mnuSaveFlow();", "menu");
  popmnu.addItem(item);

  item = new contextItem("����ͼ����", "image/edit.gif", "mnuEditFlow();", "menu");
  popmnu.addItem(item);*/

  /*item = new contextItem("������������ͼ", "image/refresh.gif", "mnuReloadFlow();", "menu");
  popmnu.addItem(item);

  item = new contextItem("", "", "", "separator");
  popmnu.addItem(item);

  item = new contextItem("�½�[����]", "image/add_proc.gif", "mnuAddProc();", "menu");
  popmnu.addItem(item);

  item = new contextItem("�½�[·��]", "image/add_step.gif", "mnuAddStep();", "menu");
  popmnu.addItem(item);

  item = new contextItem("����ѡ������", "image/copy.gif", "mnuCopyProc();", "menu");
  popmnu.addItem(item);

  item = new contextItem("�༭ѡ�ж���", "image/edit_obj.gif", "mnuEditObj();", "menu");
  popmnu.addItem(item);*/

  item = new contextItem("ɾ��ѡ�ж���", "image/del_obj.gif", "mnuDelObj();", "menu");
  popmnu.addItem(item);

  /*item = new contextItem("�Ƶ���ǰ��", "image/front.gif", "mnuSetZIndex('F');", "menu");
  popmnu.addItem(item);

  item = new contextItem("�Ƶ������", "image/back.gif", "mnuSetZIndex('B');", "menu");
  popmnu.addItem(item);*/

  popmnu.show(this.document);

  delete item;
  delete popmnu;
}

DrawContextMenu();

document.onclick = hideMenu;
document.oncontextmenu = showMenu;
