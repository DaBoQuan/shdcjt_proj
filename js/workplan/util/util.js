/**
 * ��λ����ǰ��0������λ
 */
function formatSingleDateTime(singleNumber)
{
	return (singleNumber < 10 ? "0" + singleNumber.toString() : singleNumber.toString());
}

/**
 * ȡʱ����·���ӽ�00��30������
 */
function floorTime(time)
{
	return time.split(":")[0] + ":" + (parseInt(time.split(":")[1]) < 30 ? "00" : "30");
}

/**
 * ����ʱ��֮�������
 */
function dateTimeDifference(startDate, startTime, endDate, endTime)
//���ص�λΪ����
{
	var startDateYear = startDate.split("-")[0];
	var startDateMonth = startDate.split("-")[1] - 1;
	var startDateDay = startDate.split("-")[2];
	var startDateHour = startTime.split(":")[0];
	var startDateMinute = startTime.split(":")[1];
	
	var endDateYear = endDate.split("-")[0];
	var endDateMonth = endDate.split("-")[1] - 1;
	var endDateDay = endDate.split("-")[2];
	var endDateHour = endTime.split(":")[0];
	var endDateMinute = endTime.split(":")[1];
	
	var millisecond = (new Date(endDateYear, endDateMonth, endDateDay, endDateHour, endDateMinute)).valueOf() - (new Date(startDateYear, startDateMonth, startDateDay, startDateHour, startDateMinute)).valueOf();

	return millisecond / (60 * 1000);
}

/**
 * ʱ��֮�������
 */
function timeDifference(startTime, endTime)
{
	var startDateHour = startTime.split(":")[0];
	var startDateMinute = startTime.split(":")[1];
	
	var endDateHour = endTime.split(":")[0];
	var endDateMinute = endTime.split(":")[1];

	var millisecond = (new Date().setHours(endDateHour, endDateMinute)).valueOf() - (new Date().setHours(startDateHour, startDateMinute)).valueOf();

	return millisecond / (60 * 1000);
}

/**
 * ʱ��ӷ���
 */
function dateTimeAdd(startDate, startTime, addMinute)
{
	var startDateYear = startDate.split("-")[0];
	var startDateMonth = startDate.split("-")[1] - 1;
	var startDateDay = startDate.split("-")[2];
	var startDateHour = startTime.split(":")[0];
	var startDateMinute = startTime.split(":")[1];
	
	var startDate = new Date(startDateYear, startDateMonth, startDateDay, startDateHour, startDateMinute);
	
	var finalDate = new Date(startDate.valueOf() + addMinute * 60 * 1000);
	
	return finalDate;
}

/**
 * ��ת���������ַ���
 */
function date2DateString(/*Date*/ date)
{
	return (date.getYear() + "-" + formatSingleDateTime(date.getMonth() + 1).toString() + "-" + formatSingleDateTime(date.getDate()).toString());
}

/**
 * ��ת����ʱ���ַ���
 */
function date2TimeString(/*Date*/ date)
{
	return (formatSingleDateTime(date.getHours()).toString() + ":" + formatSingleDateTime(date.getMinutes()).toString());
}

/**
 * ��ǰ�������
 */
function coordinateReport()
{
	var absoluteX = event.clientX + document.body.scrollLeft;
	var absoluteY = event.clientY + document.body.scrollTop;
	status = '������ҳ���е�X, Y���� : (' + absoluteX + ', ' + absoluteY +');' +
			 '�ڵ�ǰ�����е�X, Y���� : (' + event.clientX + ', ' + event.clientY + ')';
}

/**
 * ������־
 */
function writeLog(id, content)
{
	id.childNodes[1].innerHTML += content + "end<br>";
}

/**
 * ҳ�����
 */
function windowScroll(x, y)
{
	window.scroll(x, y);
}


