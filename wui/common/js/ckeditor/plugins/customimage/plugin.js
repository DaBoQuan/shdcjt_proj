(function(){
    //Section 1 : �����Զ��尴ťʱִ�еĴ���
    var command= {
        exec:function(editor){
            CkeditorExt.show(editor);
        }
    },
    //Section 2 : �����Զ��尴ť���󶨷���
    name='customimage';
    CKEDITOR.plugins.add(name,{
        init:function(editor){
            editor.addCommand(name,command);
            editor.ui.addButton(name,{
                label:'����ͼƬ',
                icon: this.path + 'insert-image.png',
                command:name
            });
        }
    });
})();