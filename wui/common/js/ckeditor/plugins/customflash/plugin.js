(function(){
    //Section 1 : �����Զ��尴ťʱִ�еĴ���
    var command= {
        exec:function(editor){
            CkeditorExt.showFlashDialog();
        }
    },
    //Section 2 : �����Զ��尴ť���󶨷���
    name='customflash';
    CKEDITOR.plugins.add(name,{
        init:function(editor){
            editor.addCommand(name,command);
            editor.ui.addButton(name,{
                label:'Flash',
                icon: this.path + 'icon_flash.gif',
                command:name
            });
        }
    });
})();