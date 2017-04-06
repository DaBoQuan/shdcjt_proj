if(languageid==9){
//����	
(function (KE, undefined) {
KE.langType = 'zh_TW';
KE.lang = {
	source : 'ԭʼ�a',
	undo : '��ԭ(Ctrl+Z)',
	redo : '���}(Ctrl+Y)',
	cut : '����(Ctrl+X)',
	copy : '�}�u(Ctrl+C)',
	paste : '�N��(Ctrl+V)',
	plainpaste : '�N�鼃���ָ�ʽ',
	wordpaste : '��Word�N��',
	selectall : 'ȫ�x',
	justifyleft : '�����R',
	justifycenter : '����',
	justifyright : '���Ҍ��R',
	justifyfull : '���Ҍ��R',
	insertorderedlist : '��̖���',
	insertunorderedlist : '�Ŀ���',
	indent : '���ӿs��',
	outdent : '�p�ٿs��',
	subscript : '��',
	superscript : '�Ϙ�',
	title : '���}',
	fontname : '���w',
	fontsize : '���ִ�С',
	textcolor : '�����ɫ',
	bgcolor : '�����ɫ',
	bold : '���w',
	italic : 'б�w',
	underline : '�׾�',
	strikethrough : '�h����',
	removeformat : '�����ʽ',
	image : 'Ӱ��',
	flash : '����Flash',
	media : '�����ý�w',
	table : '������',
	hr : '����ˮƽ��',
	emoticons : '�������',
	link : '���B�Y',
	unlink : '�Ƴ����B�Y',
	fullscreen : '���',
	about : '�P�',
	print : '��ӡ',
	fileManager : '�g�[�ŷ���',
	advtable : '���',
	yes : '�_��',
	no : 'ȡ��',
	close : '�P�]',
	editImage : 'Ӱ�����',
	deleteImage : '�h��Ӱ��',
	editLink : '���B�Y����',
	deleteLink : '�Ƴ����B�Y',
	tableprop : '������',
	tableinsert : '������',
	tabledelete : '�h�����',
	tablecolinsertleft : '���������',
	tablecolinsertright : '���Ҳ�����',
	tablerowinsertabove : '���ϲ����',
	tablerowinsertbelow : '�·������',
	tablecoldelete : 'ɾ����',
	tablerowdelete : 'ɾ����',
	noColor : '�Ԅ�',
	invalidImg : "Ոݔ����Ч��URL��\nֻ���Sjpg,gif,bmp,png��ʽ��",
	invalidMedia : "Ոݔ����Ч��URL��\nֻ���Sswf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb��ʽ��",
	invalidWidth : "���ȱ���ǔ��֡�",
	invalidHeight : "�߶ȱ���ǔ��֡�",
	invalidBorder : "߅�����ǔ��֡�",
	invalidUrl : "Ոݔ����Ч��URL��",
	invalidRows : '�ڔ��Ǳ��ݔ���Ŀ��ֻ���Sݔ����0�Ĕ��֡�',
	invalidCols : '�Д��Ǳ��ݔ���Ŀ��ֻ���Sݔ����0�Ĕ��֡�',
	invalidPadding : '�Ⱦ����ǔ��֡�',
	invalidSpacing : '�g�����ǔ��֡�',
	invalidBorder : '�߿����Ϊ���֡�',
	pleaseInput : "Ոݔ����ݡ�",
	invalidJson : '�ŷ����l�����ϡ�',
	cutError : '���Ğg�[����ȫ�O�ò����Sʹ�ü��²�����Ոʹ�ÿ���I(Ctrl+X)��ɡ�',
	copyError : '���Ğg�[����ȫ�O�ò����Sʹ�ü��²�����Ոʹ�ÿ���I(Ctrl+C)��ɡ�',
	pasteError : '���Ğg�[����ȫ�O�ò����Sʹ�ü��²�����Ոʹ�ÿ���I(Ctrl+V)��ɡ�'
};

var plugins = KE.lang.plugins = {};

plugins.about = {
	version : KE.version,
	title : 'HTML��ҕ����݋��'
};

plugins.plainpaste = {
	comment : 'Ոʹ�ÿ���I(Ctrl+V)�у����N���·��^���e��'
};

plugins.wordpaste = {
	comment : 'Ոʹ�ÿ���I(Ctrl+V)�у����N���·��^���e��'
};

plugins.link = {
	url : 'URL',
	linkType : '���_���',
	newWindow : '�´���',
	selfWindow : '��퓴���'
};

plugins.flash = {
	url : 'URL',
	width : '����',
	height : '�߶�'
};

plugins.media = {
	url : 'URL',
	width : '����',
	height : '�߶�',
	autostart : '�ԄӲ���'
};

plugins.image = {
	remoteImage : 'Ӱ��URL',
	localImage : '�ς�Ӱ��',
	remoteUrl : 'Ӱ��URL',
	localUrl : 'Ӱ��URL',
	size : 'Ӱ���С',
	width : '����',
	height : '�߶�',
	resetSize : 'ԭʼ��С',
	align : '���R��ʽ',
	defaultAlign : 'δ�O��',
	leftAlign : '�����R',
	rightAlign : '���Ҍ��R',
	imgTitle : 'Ӱ���f��',
	viewServer : '�g�[...'
};

plugins.file_manager = {
	emptyFolder : '���ļ��A',
	moveup : '����һ���ļ��A',
	viewType : '�@ʾ��ʽ��',
	viewImage : '�s�ԈD',
	listImage : 'Ԕ����Ϣ',
	orderType : '����ʽ��',
	fileName : '���Q',
	fileSize : '��С',
	fileType : '���'
};

plugins.advtable = {
	cells : '�����',
	rows : '�ڔ�',
	cols : '�Д�',
	size : '����С',
	width : '����',
	height : '�߶�',
	percent : '%',
	px : 'px',
	space : '�Ⱦ��g��',
	padding : '�Ⱦ�',
	spacing : '�g��',
	align : '���R��ʽ',
	alignDefault : 'δ�O��',
	alignLeft : '�����R',
	alignCenter : '����',
	alignRight : '���Ҍ��R',
	border : '���߅��',
	borderWidth : '߅��',
	borderColor : '�ɫ',
	backgroundColor : '�����ɫ'
};

plugins.title = {
	h1 : '���} 1',
	h2 : '���} 2',
	h3 : '���} 3',
	h4 : '���} 4',
	p : 'һ��'
};

plugins.fontname = {
	fontName : {
		'MingLiU' : '�����w',
		'PMingLiU' : '�¼����w',
		'DFKai-SB' : '�˿��w',
		'SimSun' : '���w',
		'NSimSun' : '�����w',
		'FangSong' : '�����w',
		'Arial' : 'Arial',
		'Arial Black' : 'Arial Black',
		'Times New Roman' : 'Times New Roman',
		'Courier New' : 'Courier New',
		'Tahoma' : 'Tahoma',
		'Verdana' : 'Verdana'
	}
};

})(KindEditor);
//Ӣ��
}else if(languageid==8){
  	
 (function (KE, undefined) {

KE.langType = 'en';

KE.lang = {
	source : 'Source',
	undo : 'Undo(Ctrl+Z)',
	redo : 'Redo(Ctrl+Y)',
	cut : 'Cut(Ctrl+X)',
	copy : 'Copy(Ctrl+C)',
	paste : 'Paste(Ctrl+V)',
	plainpaste : 'Paste as plain text',
	wordpaste : 'Paste from Word',
	selectall : 'Select all',
	justifyleft : 'Align left',
	justifycenter : 'Align center',
	justifyright : 'Align right',
	justifyfull : 'Align full',
	insertorderedlist : 'Ordered list',
	insertunorderedlist : 'Unordered list',
	indent : 'Increase indent',
	outdent : 'Decrease indent',
	subscript : 'Subscript',
	superscript : 'Superscript',
	title : 'Paragraph format',
	fontname : 'Font family',
	fontsize : 'Font size',
	textcolor : 'Text color',
	bgcolor : 'Highlight color',
	bold : 'Bold',
	italic : 'Italic',
	underline : 'Underline',
	strikethrough : 'Strikethrough',
	removeformat : 'Remove format',
	image : 'Image',
	flash : 'Insert Flash',
	media : 'Insert embeded media',
	table : 'Insert table',
	hr : 'Insert horizontal line',
	emoticons : 'Insert emoticon',
	link : 'Link',
	unlink : 'Unlink',
	fullscreen : 'Toggle fullscreen mode',
	about : 'About',
	print : 'Print',
	fileManager : 'File Manager',
	advtable : 'Table',
	yes : 'OK',
	no : 'Cancel',
	close : 'Close',
	editImage : 'Image properties',
	deleteImage : 'Delete image',
	editLink : 'Link properties',
	deleteLink : 'Unlink',
	tableprop : 'Table properties',
	tableinsert : 'Insert table',
	tabledelete : 'Delete table',
	tablecolinsertleft : 'Insert column left',
	tablecolinsertright : 'Insert column right',
	tablerowinsertabove : 'Insert row above',
	tablerowinsertbelow : 'Insert row below',
	tablecoldelete : 'Delete column',
	tablerowdelete : 'Delete row',
	noColor : 'Default',
	invalidImg : "Please type valid URL.\nAllowed file extension: jpg,gif,bmp,png",
	invalidMedia : "Please type valid URL.\nAllowed file extension: swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb",
	invalidWidth : "The width must be number.",
	invalidHeight : "The height must be number.",
	invalidBorder : "The border must be number.",
	invalidUrl : "Please type valid URL.",
	invalidRows : 'Invalid rows.',
	invalidCols : 'Invalid columns.',
	invalidPadding : 'The padding must be number.',
	invalidSpacing : 'The spacing must be number.',
	invalidBorder : 'The border width must be number.',
	pleaseInput : "Please type content.",
	invalidJson : 'Invalid JSON string.',
	cutError : 'Currently not supported by your browser, use keyboard shortcut(Ctrl+X) instead.',
	copyError : 'Currently not supported by your browser, use keyboard shortcut(Ctrl+C) instead.',
	pasteError : 'Currently not supported by your browser, use keyboard shortcut(Ctrl+V) instead.'
};

var plugins = KE.lang.plugins = {};

plugins.about = {
	version : KE.version,
	title : 'WYSIWYG Editor'
};

plugins.plainpaste = {
	comment : 'Use keyboard shortcut(Ctrl+V) to paste the text into the window.'
};

plugins.wordpaste = {
	comment : 'Use keyboard shortcut(Ctrl+V) to paste the text into the window.'
};

plugins.link = {
	url : 'Link URL',
	linkType : 'Target',
	newWindow : 'New window',
	selfWindow : 'Same window'
};

plugins.flash = {
	url : 'Flash URL',
	width : 'Width',
	height : 'Height'
};

plugins.media = {
	url : 'Media URL',
	width : 'Width',
	height : 'Height',
	autostart : 'Auto start'
};

plugins.image = {
	remoteImage : 'Insert URL',
	localImage : 'Upload',
	remoteUrl : 'Image URL',
	localUrl : 'Image File',
	size : 'Dimensions',
	width : 'Width',
	height : 'Height',
	resetSize : 'Reset dimensions',
	align : 'Align',
	defaultAlign : 'Default',
	leftAlign : 'Left',
	rightAlign : 'Right',
	imgTitle : 'Title',
	viewServer : 'Browse'
};

plugins.file_manager = {
	emptyFolder : 'Blank',
	moveup : 'Parent folder',
	viewType : 'Display: ',
	viewImage : 'Thumbnails',
	listImage : 'List',
	orderType : 'Sorting: ',
	fileName : 'By name',
	fileSize : 'By size',
	fileType : 'By type'
};

plugins.advtable = {
	cells : 'Cells',
	rows : 'Rows',
	cols : 'Columns',
	size : 'Dimensions',
	width : 'Width',
	height : 'Height',
	percent : '%',
	px : 'px',
	space : 'Space',
	padding : 'Padding',
	spacing : 'Spacing',
	align : 'Align',
	alignDefault : 'Default',
	alignLeft : 'Left',
	alignCenter : 'Center',
	alignRight : 'Right',
	border : 'Border',
	borderWidth : 'Width',
	borderColor : 'Color',
	backgroundColor : 'Background'
};

plugins.title = {
	h1 : 'Heading 1',
	h2 : 'Heading 2',
	h3 : 'Heading 3',
	h4 : 'Heading 4',
	p : 'Normal'
};

plugins.fontname = {
	fontName : {
		'Arial' : 'Arial',
		'Arial Black' : 'Arial Black',
		'Comic Sans MS' : 'Comic Sans MS',
		'Courier New' : 'Courier New',
		'Garamond' : 'Garamond',
		'Georgia' : 'Georgia',
		'Tahoma' : 'Tahoma',
		'Times New Roman' : 'Times New Roman',
		'Trebuchet MS' : 'Trebuchet MS',
		'Verdana' : 'Verdana'
	}
};

})(KindEditor);	
	
	
}else{
//����
(function (KE, undefined) {

KE.langType = 'zh_CN';

KE.lang = {
	source : 'HTML����',
	undo : '����(Ctrl+Z)',
	redo : 'ǰ��(Ctrl+Y)',
	cut : '����(Ctrl+X)',
	copy : '����(Ctrl+C)',
	paste : 'ճ��(Ctrl+V)',
	plainpaste : 'ճ��Ϊ�޸�ʽ�ı�',
	wordpaste : '��Wordճ��',
	selectall : 'ȫѡ',
	justifyleft : '�����',
	justifycenter : '����',
	justifyright : '�Ҷ���',
	justifyfull : '���˶���',
	insertorderedlist : '���',
	insertunorderedlist : '��Ŀ����',
	indent : '��������',
	outdent : '��������',
	subscript : '�±�',
	superscript : '�ϱ�',
	title : '����',
	fontname : '����',
	fontsize : '���ִ�С',
	textcolor : '������ɫ',
	bgcolor : '���ֱ���',
	bold : '����',
	italic : 'б��',
	underline : '�»���',
	strikethrough : 'ɾ����',
	removeformat : 'ɾ����ʽ',
	image : 'ͼƬ',
	flash : '����Flash',
	media : '�����ý��',
	table : '������',
	hr : '�������',
	emoticons : '�������',
	link : '��������',
	unlink : 'ȡ����������',
	fullscreen : 'ȫ����ʾ',
	about : '����',
	print : '��ӡ',
	fileManager : '���������',
	advtable : '���',
	yes : 'ȷ��',
	no : 'ȡ��',
	close : '�ر�',
	editImage : 'ͼƬ����',
	deleteImage : 'ɾ��ͼƬ',
	editLink : '������������',
	deleteLink : 'ȡ����������',
	tableprop : '�������',
	tableinsert : '������',
	tabledelete : 'ɾ�����',
	tablecolinsertleft : '��������',
	tablecolinsertright : '�Ҳ������',
	tablerowinsertabove : '�Ϸ�������',
	tablerowinsertbelow : '�·�������',
	tablecoldelete : 'ɾ����',
	tablerowdelete : 'ɾ����',
	noColor : '����ɫ',
	invalidImg : "��������Ч��URL��ַ��\nֻ����jpg,gif,bmp,png��ʽ��",
	invalidMedia : "��������Ч��URL��ַ��\nֻ����swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb��ʽ��",
	invalidWidth : "��ȱ���Ϊ���֡�",
	invalidHeight : "�߶ȱ���Ϊ���֡�",
	invalidBorder : "�߿����Ϊ���֡�",
	invalidUrl : "��������Ч��URL��ַ��",
	invalidRows : '����Ϊ��ѡ�ֻ�����������0�����֡�',
	invalidCols : '����Ϊ��ѡ�ֻ�����������0�����֡�',
	invalidPadding : '�߾����Ϊ���֡�',
	invalidSpacing : '������Ϊ���֡�',
	invalidBorder : '�߿����Ϊ���֡�',
	pleaseInput : "���������ݡ�",
	invalidJson : '�������������ϡ�',
	cutError : '�����������ȫ���ò�����ʹ�ü��в�������ʹ�ÿ�ݼ�(Ctrl+X)����ɡ�',
	copyError : '�����������ȫ���ò�����ʹ�ø��Ʋ�������ʹ�ÿ�ݼ�(Ctrl+C)����ɡ�',
	pasteError : '�����������ȫ���ò�����ʹ��ճ����������ʹ�ÿ�ݼ�(Ctrl+V)����ɡ�'
};

var plugins = KE.lang.plugins = {};

plugins.about = {
	version : KE.version,
	title : 'HTML���ӻ��༭��'
};

plugins.plainpaste = {
	comment : '��ʹ�ÿ�ݼ�(Ctrl+V)������ճ��������ķ����'
};

plugins.wordpaste = {
	comment : '��ʹ�ÿ�ݼ�(Ctrl+V)������ճ��������ķ����'
};

plugins.link = {
	url : 'URL��ַ',
	linkType : '������',
	newWindow : '�´���',
	selfWindow : '��ǰ����'
};

plugins.flash = {
	url : 'Flash��ַ',
	width : '���',
	height : '�߶�'
};

plugins.media = {
	url : 'ý���ļ���ַ',
	width : '���',
	height : '�߶�',
	autostart : '�Զ�����'
};

plugins.image = {
	remoteImage : 'Զ��ͼƬ',
	localImage : '�����ϴ�',
	remoteUrl : 'ͼƬ��ַ',
	localUrl : 'ͼƬ��ַ',
	size : 'ͼƬ��С',
	width : '��',
	height : '��',
	resetSize : '���ô�С',
	align : '���뷽ʽ',
	defaultAlign : 'Ĭ�Ϸ�ʽ',
	leftAlign : '�����',
	rightAlign : '�Ҷ���',
	imgTitle : 'ͼƬ˵��',
	viewServer : '���...'
};

plugins.file_manager = {
	emptyFolder : '���ļ���',
	moveup : '�Ƶ���һ���ļ���',
	viewType : '��ʾ��ʽ��',
	viewImage : '����ͼ',
	listImage : '��ϸ��Ϣ',
	orderType : '����ʽ��',
	fileName : '����',
	fileSize : '��С',
	fileType : '����'
};

plugins.advtable = {
	cells : '��Ԫ����',
	rows : '����',
	cols : '����',
	size : '����С',
	width : '���',
	height : '�߶�',
	percent : '%',
	px : 'px',
	space : '�߾���',
	padding : '�߾�',
	spacing : '���',
	align : '���뷽ʽ',
	alignDefault : 'Ĭ��',
	alignLeft : '�����',
	alignCenter : '����',
	alignRight : '�Ҷ���',
	border : '���߿�',
	borderWidth : '�߿�',
	borderColor : '��ɫ',
	backgroundColor : '������ɫ'
};

plugins.title = {
	h1 : '���� 1',
	h2 : '���� 2',
	h3 : '���� 3',
	h4 : '���� 4',
	p : '�� ��'
};

plugins.fontname = {
	fontName : {
		'SimSun' : '����',
		'NSimSun' : '������',
		'FangSong_GB2312' : '����_GB2312',
		'KaiTi_GB2312' : '����_GB2312',
		'SimHei' : '����',
		'Microsoft YaHei' : '΢���ź�',
		'Arial' : 'Arial',
		'Arial Black' : 'Arial Black',
		'Times New Roman' : 'Times New Roman',
		'Courier New' : 'Courier New',
		'Tahoma' : 'Tahoma',
		'Verdana' : 'Verdana'
	}
};

})(KindEditor);	
	
}		