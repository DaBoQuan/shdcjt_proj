(function(){
    //Section 1 : �����Զ��尴ťʱִ�еĴ���
    var command= {
        exec:function(editor){
    		var id1 = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp?documentids=");
    		 if(id1){
    		       var ids=id1.id;
    		       var names=id1.name;
    		       if(ids.length>500)
    		          alert("��ѡ�������̫�࣬���ݿ⽫�޷����棬������ѡ��");
    		       else if(ids.length>0){
    		          var tempids=ids.split(",");
    		          var tempnames=names.split(",");
    		          var sHtml="";
    		          for(var i=0;i<tempids.length;i++){
    		              var tempid=tempids[i];
    		              var tempname=tempnames[i];
    		              if(tempid!=''){
    		            	 var str="<a href='/docs/docs/DocDsp.jsp?id="+tempid+"' contenteditable='false' unselectable='off'  style='cursor:pointer;text-decoration:underline !important;margin-right:8px' target='_blank'>"+tempname+"</a>";
    		            	 editor.insertElement(new CKEDITOR.dom.element.createFromHtml(str, editor.document));
    		              }
    		          }
    		        
    		       
    		       }
    	       }
           
        }
    },
    //Section 2 : �����Զ��尴ť���󶨷���
    name='insertdocs';
    CKEDITOR.plugins.add(name,{
        init:function(editor){
            editor.addCommand(name,command);
            editor.ui.addButton(name,{
                label:'�����ĵ�',
                icon: this.path + 'app-doc.png',
                command:name
            });
        }
    });
})();