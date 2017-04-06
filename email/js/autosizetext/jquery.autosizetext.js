(function($) {

	$.fn.autogrow = function(options) {

		var defaults = {

			minHeight : 35,

			maxHeight : 9999

		};

		var options = $.extend(defaults, options);

		return this.each(function() {

			var element = $(this);

			// ��һ���ı������ݳ��ȺͿ��

			var lastValLength, lastWidth;

			// �ı������ݳ��ȡ���Ⱥ͸߶�

			var valLength, width, height;

			// ��֤ҳ��Ԫ����textarea

			if (!element.is('textarea')) {

				return;

			}

			element.css('overflow', 'hidden');// ���ó�����Χ����������

			element.bind('keyup input propertychange', function() {
				doAutoGrow($(this),options)
			});
						
			
			

		});

	}
	function doAutoGrow(obj,options){
			
			var lastValLength, lastWidth;
	
			// �ı������ݳ��ȡ���Ⱥ͸߶�
	
			var valLength, width, height;
			// ��ȡ�ı������ݳ���

			valLength = obj.val().length;

			// ��ȡ�����Ŀ��

			// ������ʹ�õ�jquery�汾��1.8����ȡcss���Եķ����Ѿ������prop

			// ���ʹ��1.6���°汾��jquery�����´���Ҫ��Ϊ width =
			// $(this).attr('offsetWidth');

			// $(this).prop('scrollHeight')ҲҪ��Ϊ��$(this).attr('scrollHeight')

			width = obj.attr('offsetWidth');

			// ������ɾ�������������ı����ȱ仯��ʱ���Ƚ��ı���߶�����Ϊ0

			if (valLength < lastValLength || width != lastWidth) {

				obj.height(0);

			}

			// �����ʺϵ��ı���߶�

			height = Math.max(options.minHeight, Math.min(obj
					.attr('scrollHeight'), options.maxHeight));

			// �����ǰ�ı���ĸ߶ȳ���������������߶ȵ�ʱ�����ض������֣���������Ϊauto

			// $(this).prop('scrollHeight') > height
			// ֻ����heightȡ�õ�ֵ��options.maxHeight��������

			obj.css(
					'overflow',
					(obj.attr('scrollHeight') > height ? 'auto'
							: 'hidden'))

			.height(height); // �����ı���߶�

			lastValLength = valLength;

			lastWidth = width;

		
	}

})(jQuery);