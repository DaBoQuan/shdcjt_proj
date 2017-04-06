<%@ page import="weaver.general.*" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="RecordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="HrmTimeCardManage" class="weaver.hrm.schedule.HrmTimeCardManage" scope="page"/>

<%

char separator = Util.getSeparator() ;
String procedurepara="";

String startdate = Util.null2String(request.getParameter("startdate")) ; // ��
String enddate = Util.null2String(request.getParameter("enddate")) ; // ��

Calendar thedate = Calendar.getInstance() ; 
String currentdate = Util.add0(thedate.get(Calendar.YEAR) , 4) + "-" + 
          Util.add0(thedate.get(Calendar.MONTH) + 1 , 2) + "-" + 
          Util.add0(thedate.get(Calendar.DAY_OF_MONTH) , 2) ;

boolean initTimecardInfo = HrmTimeCardManage.initTimecardInfo(startdate,enddate) ;

if(!initTimecardInfo) {
    response.sendRedirect("HrmWorkTimeWarpList.jsp?fromdate="+startdate+"&enddate="+enddate+"&errmsg=1");
    return ;
}


// ���һ�㹤��ʱ��
String monstarttime1 = "" ; 
String monendtime1 = "" ; 
String monstarttime2 = "" ; 
String monendtime2 = "" ;  

String tuestarttime1 = "" ; 
String tueendtime1 = "" ; 
String tuestarttime2 = "" ;  
String tueendtime2 = "" ; 

String wedstarttime1 = "" ;  
String wedendtime1 = "" ; 
String wedstarttime2 = "" ; 
String wedendtime2 = "" ; 

String thustarttime1 = "" ; 
String thuendtime1 = "" ; 
String thustarttime2 = "" ; 
String thuendtime2 = "" ;  

String fristarttime1 = "" ; 
String friendtime1 = "" ; 
String fristarttime2 = "" ; 
String friendtime2 = "" ; 

String satstarttime1 = "" ; 
String satendtime1 = "" ; 
String satstarttime2 = "" ; 
String satendtime2 = "" ; 

String sunstarttime1 = "" ; 
String sunendtime1 = "" ; 
String sunstarttime2 = "" ; 
String sunendtime2 = "" ; 

RecordSet.executeProc("HrmSchedule_Select_Current" , startdate) ; 
if( RecordSet.next() ) {
    
    monstarttime1 = Util.null2String(RecordSet.getString("monstarttime1")) ;
    monendtime1 = Util.null2String(RecordSet.getString("monendtime1")) ;
    monstarttime2 = Util.null2String(RecordSet.getString("monstarttime2")) ;
    monendtime2 = Util.null2String(RecordSet.getString("monendtime2")) ;

    tuestarttime1 = Util.null2String(RecordSet.getString("tuestarttime1")) ;
    tueendtime1 = Util.null2String(RecordSet.getString("tueendtime1")) ;
    tuestarttime2 = Util.null2String(RecordSet.getString("tuestarttime2")) ;
    tueendtime2 = Util.null2String(RecordSet.getString("tueendtime2")) ;

    wedstarttime1 = Util.null2String(RecordSet.getString("wedstarttime1")) ;
    wedendtime1 = Util.null2String(RecordSet.getString("wedendtime1")) ;
    wedstarttime2 = Util.null2String(RecordSet.getString("wedstarttime2")) ;
    wedendtime2 = Util.null2String(RecordSet.getString("wedendtime2")) ;

    thustarttime1 = Util.null2String(RecordSet.getString("thustarttime1")) ;
    thuendtime1 = Util.null2String(RecordSet.getString("thuendtime1")) ;
    thustarttime2 = Util.null2String(RecordSet.getString("thustarttime2")) ;
    thuendtime2 = Util.null2String(RecordSet.getString("thuendtime2")) ;

    fristarttime1 = Util.null2String(RecordSet.getString("fristarttime1")) ;
    friendtime1 = Util.null2String(RecordSet.getString("friendtime1")) ;
    fristarttime2 = Util.null2String(RecordSet.getString("fristarttime2")) ;
    friendtime2 = Util.null2String(RecordSet.getString("friendtime2")) ;

    satstarttime1 = Util.null2String(RecordSet.getString("satstarttime1")) ;
    satendtime1 = Util.null2String(RecordSet.getString("satendtime1")) ;
    satstarttime2 = Util.null2String(RecordSet.getString("satstarttime2")) ;
    satendtime2 = Util.null2String(RecordSet.getString("satendtime2")) ; 

    sunstarttime1 = Util.null2String(RecordSet.getString("sunstarttime1")) ;
    sunendtime1 = Util.null2String(RecordSet.getString("sunendtime1")) ;
    sunstarttime2 = Util.null2String(RecordSet.getString("sunstarttime2")) ;
    sunendtime2 = Util.null2String(RecordSet.getString("sunendtime2")) ;
}

// ������ڶ�Ӧ������ , 1Ϊ�����գ� 2Ϊ����һ

ArrayList selectdates = new ArrayList() ; 
ArrayList selectweekdays = new ArrayList() ; 

int fromyear = Util.getIntValue(startdate.substring(0 , 4)) ; 
int frommonth = Util.getIntValue(startdate.substring(5 , 7)) ; 
int fromday = Util.getIntValue(startdate.substring(8 , 10)) ; 
String fromtempdate = startdate ; 

thedate.set(fromyear,frommonth - 1 , fromday) ; 

while( fromtempdate.compareTo(enddate) <= 0 ) {
    selectdates.add(fromtempdate) ; 
    selectweekdays.add("" + thedate.get(Calendar.DAY_OF_WEEK)) ; 

    thedate.add(Calendar.DATE , 1) ; 
    fromtempdate =  Util.add0(thedate.get(Calendar.YEAR) , 4) + "-" + 
                Util.add0(thedate.get(Calendar.MONTH) + 1 , 2) + "-" + 
                Util.add0(thedate.get(Calendar.DAY_OF_MONTH) , 2) ; 
}


// ���ڼ���, ���������� �� ������Ϣ�� 

ArrayList holidaydates = new ArrayList() ;      //���ڼ���
ArrayList changetypes = new ArrayList() ;       //��������  1������Ϊ�������� 2�� ����Ϊ������ 3�� ����Ϊ��Ϣ��
ArrayList workrelatedays = new ArrayList() ;      //����Ϊ�����ն�Ӧ������ 1: ������ 2:����һ .... 7:������ 

// "select holidaydate from HrmPubHoliday where countryid = "+countryid; ��ʱδʵ�ֹ���
RecordSet.executeSql("select holidaydate , changetype, relateweekday from HrmPubHoliday where holidaydate>='" + startdate + "' and holidaydate <= '" + enddate + "' ") ; 
while( RecordSet.next() ) {
    String holidaydate = Util.null2String(RecordSet.getString("holidaydate")) ;
    String changetype = Util.null2String(RecordSet.getString("changetype")) ;
    String relateweekday = Util.null2String(RecordSet.getString("relateweekday")) ;

    holidaydates.add(holidaydate) ; 
    changetypes.add(changetype) ; 
    workrelatedays.add(relateweekday) ; 
}



// ����Ű๤��ʱ��

ArrayList shiftids = new ArrayList() ;
ArrayList shiftbegintimes = new ArrayList() ;
ArrayList shiftendtimes = new ArrayList() ;

RecordSet.executeProc("HrmArrangeShift_Select" , "") ; 
while( RecordSet.next() ) {
    shiftids.add(Util.null2String(RecordSet.getString("id"))) ;
    shiftbegintimes.add(Util.null2String(RecordSet.getString("shiftbegintime"))) ;
    shiftendtimes.add(Util.null2String(RecordSet.getString("shiftendtime"))) ;
}

// �õ������Ű��������������Ա
ArrayList reesourceshifts = new ArrayList() ; 
RecordSet.executeSql("  select resourceid from HrmArrangeShiftSet "  ) ; 
while( RecordSet.next() ) { 
    String resourceid = Util.null2String(RecordSet.getString("resourceid")) ; 
    reesourceshifts.add( resourceid ) ; 
}


// ������е����Ű����Ϣ

ArrayList shiftresources = new ArrayList() ;
ArrayList shifttypeids = new ArrayList() ;
RecordSet.executeSql(" select distinct resourceid,shiftdate,shiftid from HrmArrangeShiftInfo where shiftdate >= '" + startdate + "' and shiftdate <= '"+ enddate + "' ") ; 
while( RecordSet.next() ) {
    String resourceid = Util.null2String(RecordSet.getString("resourceid"));
    String shiftdate =   Util.null2String(RecordSet.getString("shiftdate"));
    String shiftid =   Util.null2String(RecordSet.getString("shiftid"));

    int reesourceshiftdateindex = shiftresources.indexOf(resourceid+"_"+shiftdate) ;
    if( reesourceshiftdateindex == -1 ) {
        shiftresources.add(resourceid+"_"+shiftdate) ;
        ArrayList tempshiftids = new ArrayList() ;
        tempshiftids.add(shiftid) ;
        shifttypeids.add(tempshiftids) ;
    }
    else {
        ArrayList tempshiftids = (ArrayList) shifttypeids.get(reesourceshiftdateindex) ;
        tempshiftids.add(shiftid) ;
        shifttypeids.set(reesourceshiftdateindex ,tempshiftids) ;
    }
}

// ������е��ڵ���������Ϣ

ArrayList timecardresources = new ArrayList() ;
ArrayList intimes = new ArrayList() ;
ArrayList outtimes = new ArrayList() ;
ArrayList relateshiftids = new ArrayList() ;

RecordSet.executeSql(" select * from HrmTimecardInfo where timecarddate >= '" + startdate + "' and timecarddate <= '"+ enddate + "' and relateshiftid != -1 ") ; 

while( RecordSet.next() ) {
    String resourceid = Util.null2String(RecordSet.getString("resourceid"));
    String timecarddate =   Util.null2String(RecordSet.getString("timecarddate"));
    String intime =   Util.null2String(RecordSet.getString("intime"));
    String outtime =   Util.null2String(RecordSet.getString("outtime"));
    String relateshiftid =   Util.null2String(RecordSet.getString("relateshiftid"));

    int timecardresourceindex = timecardresources.indexOf(resourceid+"_"+timecarddate) ;
    if( timecardresourceindex == -1 ) {
        timecardresources.add(Util.null2String(RecordSet.getString("resourceid")) + "_" +  Util.null2String(RecordSet.getString("timecarddate")) ) ;
        ArrayList tempintimes = new ArrayList() ;
        ArrayList tempouttimes = new ArrayList() ;
        ArrayList temprelateshiftids = new ArrayList() ;

        tempintimes.add(intime) ;
        tempouttimes.add(outtime) ;
        temprelateshiftids.add(relateshiftid) ;

        intimes.add(tempintimes) ;
        outtimes.add(tempouttimes) ;
        relateshiftids.add(temprelateshiftids) ;
    }
    else {
        ArrayList tempintimes = (ArrayList) intimes.get(timecardresourceindex) ;
        ArrayList tempouttimes = (ArrayList) outtimes.get(timecardresourceindex) ;
        ArrayList temprelateshiftids = (ArrayList) relateshiftids.get(timecardresourceindex) ;

        tempintimes.add(intime) ;
        tempouttimes.add(outtime) ;
        temprelateshiftids.add(relateshiftid) ;

        intimes.set(timecardresourceindex ,tempintimes) ;
        outtimes.set(timecardresourceindex ,tempouttimes) ;
        relateshiftids.set(timecardresourceindex ,temprelateshiftids) ;
    }
}


// ��ÿ����������͵���С����ʱ��
int theminouttime = 0 ;
RecordSet.executeSql(" select min(mindifftime) from HrmScheduleDiff where difftype = '0' ") ; 
if( RecordSet.next() ) {
    theminouttime = Util.getIntValue( RecordSet.getString(1) , 0 ) ;
}


// ��ÿ��ڼ������͵���С����ʱ��
ArrayList diffids = new ArrayList() ;
ArrayList diffmintimes = new ArrayList() ;

RecordSet.executeSql(" select id , mindifftime from HrmScheduleDiff where difftype = '1' ") ; 
if( RecordSet.next() ) {
    diffids.add(Util.null2String(RecordSet.getString("id"))) ;
    diffmintimes.add(Util.null2String(RecordSet.getString("mindifftime"))) ;
}

// ��ʼ�������, �������ƫ���, ������ٱ�Ĵ�ʱ���Ϊ0
RecordSet.executeSql(" delete HrmWorkTimeWarp where diffdate >= '" +startdate+ "' and diffdate <= '" +enddate+ "' " ) ; 
// RecordSet.executeSql( " update HrmScheduleMaintance set realcarddifftime = 0  " ) ; // ������



// ���ڵ�����Ӱ���������͵�ƫ��

RecordSet.executeSql(" select * from HrmTimecardInfo where timecarddate >= '" + startdate + "' and timecarddate <= '"+ enddate + "' and relateshiftid = -1 ") ; 

while( RecordSet.next() ) {
    String tempresourceid = Util.null2String(RecordSet.getString("resourceid")) ;
    String tempcarddate = Util.null2String(RecordSet.getString("timecarddate")) ;
    String tempintime = Util.null2String(RecordSet.getString("intime")) ;
    String tempouttime = Util.null2String(RecordSet.getString("outtime")) ;

    int theaps = Math.abs( Util.timediff1(tempintime,tempouttime ) ) ; 
    
    String counttime = "" + theaps ;

    if( theaps >= theminouttime ) {         // ��������������С����С����ʱ��,�ż���ƫ��
        String thediffid = "" ;
        String thedifftype = "0" ;
        String diffcounttime = "0" ;        // ���ڼ���ʱ��
        
        // �����������͵Ŀ���
        RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempcarddate +"' and enddate >= '" + tempcarddate + "' and difftype = '0' and resourceid = " + tempresourceid ) ;

        if( RecordSet2.getCounts() < 2 ) {
            if( RecordSet2.next() ) {
                thediffid = Util.null2String(RecordSet2.getString("id")) ;
                diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
            }
        }
        else {
            int theminaps = 9999999 ;

            while ( RecordSet2.next() ) {
                String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                if( thediffid.equals("") ) {
                    thediffid = tempdiffid ;
                    diffcounttime = temprealdifftime ;
                }

                if( tempstarttime.equals("") )  continue ;

                // ���빫˾ʱ��ͼӰ࿪ʼʱ��Ƚ�

                theaps = Math.abs( Util.timediff1(tempstarttime,tempintime ) ) ;

                if( theaps < theminaps ) {
                    thediffid = tempdiffid ;
                    theminaps = theaps ;
                    diffcounttime = temprealdifftime ;
                }
            }
        }

        procedurepara= thediffid + separator + tempresourceid + separator + tempcarddate + separator + thedifftype + separator + tempintime + separator + tempouttime + separator + "" + separator + "" + separator + counttime + separator + diffcounttime ; 
        RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
    }
}






// ÿ��ÿ�յ�ƫ����Ϣ ,ֻѡ���ж�Ӧ���û�������ְ���û�

RecordSet.executeSql(" select id from Hrmresource where status in (0,1,2,3) and id in (select resourceid from HrmTimecardUser where usercode is not null and usercode != '' ) ") ; 

while( RecordSet.next() ) {
    String resourceid = Util.null2String(RecordSet.getString("id")) ;

    String tempdate = startdate ; 
    thedate.set(fromyear,frommonth - 1 , fromday) ; 
    while( tempdate.compareTo(enddate) <= 0 ) {

        // ���˸���Ӧ�õ����°�ʱ��Ͷ�Ӧ���Ű�id�� 
        ArrayList theintimes = new ArrayList() ;
        ArrayList theouttimes = new ArrayList() ;
        ArrayList theshiftids = new ArrayList() ;

        
        // �������Ƿ����Ű��������������Ա
        int shiftindex = reesourceshifts.indexOf(resourceid) ;
        if( shiftindex != -1 ) {        // �������Ű����
            int shiftdateindex = shiftresources.indexOf(resourceid+"_"+tempdate) ;
            if( shiftdateindex != -1 ) { // ���˸������Ű�
                ArrayList tempshiftids = (ArrayList) shifttypeids.get(shiftdateindex) ;
                for( int k = 0 ; k< tempshiftids.size() ; k++ ) {
                    String theshiftid = (String)tempshiftids.get(k) ;
                    int theshiftindex = shiftids.indexOf(theshiftid) ;
                    if( theshiftindex != -1 ) {
                        String theintime = (String)shiftbegintimes.get(theshiftindex) ;
                        String theouttime = (String)shiftendtimes.get(theshiftindex) ;
                        theintimes.add(theintime) ;
                        theouttimes.add(theouttime) ;
                        theshiftids.add(theshiftid) ;
                    }
                }
            }
        }
        else {                          // ������һ�㹤��ʱ�����
            int theweekday = 0 ;
            String theintime = "" ;
            String theouttime = "" ;

            int holidayindex = holidaydates.indexOf(tempdate) ;
            if( holidayindex != -1 ) {   // �е���ʱ��
                String changetype = (String) changetypes.get( holidayindex ) ; 
                String relateweekday = (String) workrelatedays.get( holidayindex ) ; 
                if( changetype.equals("2") ) theweekday = Util.getIntValue(relateweekday , 0 ) ;
            }
            else {
                int weekdayindex = selectdates.indexOf(tempdate) ; 
                theweekday = Util.getIntValue((String)selectweekdays.get(weekdayindex)) ;
            }

            if( theweekday != 0 ) {
                switch (theweekday) {
                    case 1:
                        theintime = sunstarttime1 ;
                        theouttime = sunendtime2 ;
                        theintimes.add(theintime) ;
                        theouttimes.add(theouttime) ;
                        theshiftids.add("0") ;
                        break ;
                    case 2:
                        theintime = monstarttime1 ;
                        theouttime = monendtime2 ;
                        theintimes.add(theintime) ;
                        theouttimes.add(theouttime) ;
                        theshiftids.add("0") ;
                        break ;
                    case 3:
                        theintime = tuestarttime1 ;
                        theouttime = tueendtime2 ;
                        theintimes.add(theintime) ;
                        theouttimes.add(theouttime) ;
                        theshiftids.add("0") ;
                        break ;
                    case 4:
                        theintime = wedstarttime1 ;
                        theouttime = wedendtime2 ;
                        theintimes.add(theintime) ;
                        theouttimes.add(theouttime) ;
                        theshiftids.add("0") ;
                        break ;
                    case 5:
                        theintime = thustarttime1 ;
                        theouttime = thuendtime2 ;
                        theintimes.add(theintime) ;
                        theouttimes.add(theouttime) ;
                        theshiftids.add("0") ;
                        break ;
                    case 6:
                        theintime = fristarttime1 ;
                        theouttime = friendtime2 ;
                        theintimes.add(theintime) ;
                        theouttimes.add(theouttime) ;
                        theshiftids.add("0") ;
                        break ;
                    case 7:
                        theintime = satstarttime1 ;
                        theouttime = satendtime2 ;
                        theintimes.add(theintime) ;
                        theouttimes.add(theouttime) ;
                        theshiftids.add("0") ;
                        break ;
                }
            }
        }

        // ʵ�ʵ����°��ʱ��
        ArrayList realintimes = new ArrayList() ;
        ArrayList realouttimes = new ArrayList() ;
        ArrayList realshiftids = new ArrayList() ;

        int timecardindex = timecardresources.indexOf(resourceid+"_"+tempdate) ;
        if( timecardindex != -1 ) {        // ���˸����д򿨼�¼
            realintimes = (ArrayList) intimes.get(timecardindex) ;
            realouttimes = (ArrayList) outtimes.get(timecardindex) ;
            realshiftids = (ArrayList) relateshiftids.get(timecardindex) ;
        }
        
        // ��Ӧ���ڲ���������
        String thediffid = "" ;
        String thedifftype = "" ;
        String counttime = "0" ;        // ʵ�ʼ���ʱ��
        String diffcounttime = "0" ;        // ���ڼ���ʱ��

        if( theshiftids.size() >= realshiftids.size() ) { // ��Ӧ���ϰ�������ڵ���ʵ���ϰ������ʱ�� ��Ӧ�õ���Ϊ��׼
            
            for( int k = 0 ; k< theshiftids.size() ; k++ ) {
                String theshiftid = (String) theshiftids.get(k) ;
                String theintime = (String) theintimes.get(k) ;
                String theouttime = (String) theouttimes.get(k) ;

                int realshiftidindex = realshiftids.indexOf(theshiftid) ;
                if( realshiftidindex != -1 ) {      // �ж�Ӧ�Ĵ򿨼�¼
                    String intime = (String) realintimes.get(realshiftidindex) ;
                    String outtime = (String) realouttimes.get(realshiftidindex) ;

                    // �Ƚ��ϰ�ʱ��Ĳ���

                    if( ( intime.length() < 5 || outtime.length() < 5 ) && theintime.length() == 5 && theouttime.length() == 5 ) {     // ĳһ��ʵ�ʴ�ʱ��ȱ�٣����ڼ�������
                        thediffid = "" ;
                        diffcounttime = "0" ; 
                        thedifftype = "1" ;
                        
                        RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '1' and resourceid = " + resourceid ) ;

                        if( RecordSet2.getCounts() < 2 ) {
                            if( RecordSet2.next() ) {
                                thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                            }
                        }
                        else {
                            int theminaps = 9999999 ;

                            while ( RecordSet2.next() ) {
                                String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                
                                // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                if( thediffid.equals("") ) {
                                    thediffid = tempdiffid ;
                                    diffcounttime = temprealdifftime ;
                                }


                                if( intime.equals("") && !tempstarttime.equals("") ) {              // ����빫˾��ȱʧ�����빫˾ʱ��Ƚ�
                                    int theaps = Math.abs( Util.timediff1(tempstarttime,theintime ) ) ;
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                                else if( outtime.equals("") && !tempendtime.equals("") ) {                              // �ó���˾ʱ��Ƚ�  
                                    int theaps = Math.abs( Util.timediff1(tempendtime,theouttime ) ) ;
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                            }
                        }

                        counttime = "" + Math.abs( Util.timediff1(theouttime,theintime ) ) ;  

                        procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ; 
                        RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
                    }
                    else if( ( theintime.length() < 5 || theouttime.length() < 5 ) && intime.length() == 5 && outtime.length() == 5 ) {         // ������������
                        
                        int theaps = Math.abs( Util.timediff1(outtime,intime ) ) ;   
                        counttime = "" + theaps ;

                        if( theaps >= theminouttime ) {         // ��������������С����С����ʱ��,�ż���ƫ��
                            thediffid = "" ;
                            diffcounttime = "0" ; 
                            thedifftype = "0" ;
                        
                            RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '0' and resourceid = " + resourceid ) ;

                            if( RecordSet2.getCounts() < 2 ) {
                                if( RecordSet2.next() ) {
                                    thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                    diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                }
                            }
                            else {
                                int theminaps = 9999999 ;

                                while ( RecordSet2.next() ) {
                                    String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                    String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                    String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                    String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                    String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                    String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                    // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                    if( thediffid.equals("") ) {
                                        thediffid = tempdiffid ;
                                        diffcounttime = temprealdifftime ;
                                    }

                                    if( tempstarttime.equals("") )  continue ;

                                    // ���빫˾ʱ��Ƚ�
                                    theaps = Math.abs( Util.timediff1(tempstarttime,intime ) ) ; 
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                            }

                            procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;
                            RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;

                        }
                    }
                    else {
                        if( intime.compareTo(theintime) < 0 && intime.length() == 5) {         // ������������
                            
                            int theaps = Math.abs( Util.timediff1(theintime,intime ) ) ; 
                            counttime = "" + theaps ;

                            if( theaps >= theminouttime ) {
                                thediffid = "" ;
                                diffcounttime = "0" ; 
                                thedifftype = "0" ;
                            
                                RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '0' and resourceid = " + resourceid ) ;

                                if( RecordSet2.getCounts() < 2 ) {
                                    if( RecordSet2.next() ) {
                                        thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                        diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                    }
                                }
                                else {
                                    int theminaps = 9999999 ;

                                    while ( RecordSet2.next() ) {
                                        String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                        String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                        String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                        String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                        String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                        String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                        // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                        if( thediffid.equals("") ) {
                                            thediffid = tempdiffid ;
                                            diffcounttime = temprealdifftime ;
                                        }

                                        if( tempstarttime.equals("") ) continue ;

                                        // ���빫˾ʱ��ͼӰ࿪ʼʱ��Ƚ�
                                        theaps = Math.abs( Util.timediff1(tempstarttime,intime ) ) ; 
                                        if( theaps < 0 ) theaps = -1 * theaps ;

                                        if( theaps < theminaps ) {
                                            thediffid = tempdiffid ;
                                            theminaps = theaps ;
                                            diffcounttime = temprealdifftime ;
                                        }
                                    }
                                }

                                procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;  
                                RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
                                
                            }
                        }
                        if ( intime.compareTo(theintime) > 0 ) {       // ���ڼ�������
                            thediffid = "" ;
                            diffcounttime = "0" ; 
                            thedifftype = "1" ;
                            
                            RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '1' and resourceid = " + resourceid ) ;

                            if( RecordSet2.getCounts() < 2 ) {
                                if( RecordSet2.next() ) {
                                    thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                    diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                }
                            }
                            else {
                                int theminaps = 9999999 ;

                                while ( RecordSet2.next() ) {
                                    String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                    String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                    String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                    String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                    String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                    String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                    // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                    if( thediffid.equals("") ) {
                                        thediffid = tempdiffid ;
                                        diffcounttime = temprealdifftime ;
                                    }

                                    if( tempendtime.equals("") ) continue ;

                                    // ���빫˾ʱ�����ٽ���ʱ��Ƚ�
                                    int theaps = Math.abs( Util.timediff1(tempendtime,intime ) ) ; 
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                            }

                            counttime = "" + Math.abs( Util.timediff1(theintime,intime ) ) ; 
                            
                            procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;  
                            RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;

                        }
                        if( outtime.compareTo(theouttime) < 0 && outtime.length() == 5) {      // ���ڼ�������
                            thediffid = "" ;
                            diffcounttime = "0" ; 
                            thedifftype = "1" ;
                            
                            RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '1' and resourceid = " + resourceid ) ;

                            if( RecordSet2.getCounts() < 2 ) {
                                if( RecordSet2.next() ) {
                                    thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                    diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                }
                            }
                            else {
                                int theminaps = 9999999 ;

                                while ( RecordSet2.next() ) {
                                    String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                    String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                    String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                    String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                    String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                    String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                    // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                    if( thediffid.equals("") ) {
                                        thediffid = tempdiffid ;
                                        diffcounttime = temprealdifftime ;
                                    }

                                    if( tempstarttime.equals("") ) continue ;

                                    // �ó���˾ʱ�����ٿ�ʼʱ��Ƚ�
                                    int theaps = Math.abs( Util.timediff1(tempstarttime,outtime ) ) ;
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                            }

                            counttime = "" + Math.abs( Util.timediff1(theouttime,outtime ) ) ;

                            procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;  
                            RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;

                        }
                        if( outtime.compareTo(theouttime) > 0 ) {      // ������������
                            int theaps = Math.abs( Util.timediff1(theouttime,outtime ) ) ;
                            counttime = "" + theaps ;

                            if( theaps >= theminouttime ) {
                                thediffid = "" ;
                                diffcounttime = "0" ; 
                                thedifftype = "0" ;
                            
                                RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '0' and resourceid = " + resourceid ) ;

                                if( RecordSet2.getCounts() < 2 ) {
                                    if( RecordSet2.next() ) {
                                        thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                        diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                    }
                                }
                                else {
                                    int theminaps = 9999999 ;

                                    while ( RecordSet2.next() ) {
                                        String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                        String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                        String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                        String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                        String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                        String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                        // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                        if( thediffid.equals("") ) {
                                            thediffid = tempdiffid ;
                                            diffcounttime = temprealdifftime ;
                                        }

                                        if( tempendtime.equals("") )  continue ;

                                        // �ó���˾ʱ��ͼӰ����ʱ��Ƚ�
                                        theaps = Math.abs( Util.timediff1(tempendtime,outtime ) ) ;
                                        if( theaps < 0 ) theaps = -1 * theaps ;

                                        if( theaps < theminaps ) {
                                            thediffid = tempdiffid ;
                                            theminaps = theaps ;
                                            diffcounttime = temprealdifftime ;
                                        }
                                    }
                                }

                                procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;
                                RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
                            }
                        }
                    }
                }
                else {  // Ӧ���ϰ������û�ж�Ӧ��ʵ���ϰ�, ����ȱ��
                    thediffid = "" ;
                    diffcounttime = "0" ; 
                    thedifftype = "1" ;
                            
                    RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '1' and resourceid = " + resourceid ) ;

                    if( RecordSet2.getCounts() < 2 ) {
                        if( RecordSet2.next() ) {
                            thediffid = Util.null2String(RecordSet2.getString("id")) ;
                            diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                        }
                    }
                    else {
                        int theminaps = 9999999 ;

                        while ( RecordSet2.next() ) {
                            String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                            String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                            String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                            String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                            String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                            String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                            // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                            if( thediffid.equals("") ) {
                                thediffid = tempdiffid ;
                                diffcounttime = temprealdifftime ;
                            }

                            if( tempstarttime.equals("") ) continue ;

                            // ��Ӧ���빫˾ʱ�����ٿ�ʼʱ��Ƚ�
                            int theaps = Math.abs( Util.timediff1(tempstarttime,theintime ) ) ;
                            if( theaps < 0 ) theaps = -1 * theaps ;

                            if( theaps < theminaps ) {
                                thediffid = tempdiffid ;
                                theminaps = theaps ;
                                diffcounttime = temprealdifftime ;
                            }
                        }
                    }

                    counttime = "" + Math.abs( Util.timediff1(theintime,theouttime ) ) ;

                    procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + "" + separator + "" + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;  
                    RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
                }
            }       // Ӧ���ϰ�Ĵ���ѭ�����
        }
        else { // ��ʵ���ϰ�������ڵ���Ӧ���ϰ������ʱ�� ��ʵ�ʵ���Ϊ��׼
            
            for( int k = 0 ; k< realshiftids.size() ; k++ ) {
                String realshiftid = (String) realshiftids.get(k) ;
                String intime = (String) realintimes.get(k) ;
                String outtime = (String) realouttimes.get(k) ;

                int theshiftidindex = theshiftids.indexOf(realshiftid) ;

                if( theshiftidindex != -1 ) {      // �ж�Ӧ��Ӧ���ϰ��¼
                    String theintime = (String) theintimes.get(theshiftidindex) ;
                    String theouttime = (String) theouttimes.get(theshiftidindex) ;

                    // �Ƚ��ϰ�ʱ��Ĳ���

                    if( ( intime.length() < 5 || outtime.length() < 5 ) && theintime.length() == 5 && theouttime.length() == 5 ) {     // ĳһ��ʵ�ʴ�ʱ��ȱ�٣����ڼ�������
                        thediffid = "" ;
                        diffcounttime = "0" ; 
                        thedifftype = "1" ;
                        
                        RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '1' and resourceid = " + resourceid ) ;

                        if( RecordSet2.getCounts() < 2 ) {
                            if( RecordSet2.next() ) {
                                thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                            }
                        }
                        else {
                            int theminaps = 9999999 ;

                            while ( RecordSet2.next() ) {
                                String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                
                                // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                if( thediffid.equals("") ) {
                                    thediffid = tempdiffid ;
                                    diffcounttime = temprealdifftime ;
                                }


                                if( intime.equals("") && !tempstarttime.equals("") ) {              // ����빫˾��ȱʧ�����빫˾ʱ��Ƚ�
                                    int theaps = Math.abs( Util.timediff1(tempstarttime,theintime ) ) ;
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                                else if( outtime.equals("") && !tempendtime.equals("") ) {                              // �ó���˾ʱ��Ƚ�  
                                    int theaps = Math.abs( Util.timediff1(tempendtime,theouttime ) ) ;
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                            }
                        }

                        counttime = "" + Math.abs( Util.timediff1(theouttime,theintime ) ) ;  

                        procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ; 
                        RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
                    }
                    else if( ( theintime.length() < 5 || theouttime.length() < 5 ) && intime.length() == 5 && outtime.length() == 5 ) {         // ������������
                        
                        int theaps = Math.abs( Util.timediff1(outtime,intime ) ) ; 
                        counttime = "" + theaps ;

                        if( theaps >= theminouttime ) {         // ��������������С����С����ʱ��,�ż���ƫ��
                            thediffid = "" ;
                            diffcounttime = "0" ; 
                            thedifftype = "0" ;
                        
                            RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '0' and resourceid = " + resourceid ) ;

                            if( RecordSet2.getCounts() < 2 ) {
                                if( RecordSet2.next() ) {
                                    thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                    diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                }
                            }
                            else {
                                int theminaps = 9999999 ;

                                while ( RecordSet2.next() ) {
                                    String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                    String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                    String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                    String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                    String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                    String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                    // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                    if( thediffid.equals("") ) {
                                        thediffid = tempdiffid ;
                                        diffcounttime = temprealdifftime ;
                                    }

                                    if( tempstarttime.equals("") )  continue ;

                                    // ���빫˾ʱ��Ƚ�
                                    theaps = Math.abs( Util.timediff1(tempstarttime,intime ) ) ; 
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                            }

                            procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ; 
                            RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;

                        }
                    }
                    else {
                        if( intime.compareTo(theintime) < 0 && intime.length() == 5) {         // ������������
                            
                            int theaps = Math.abs( Util.timediff1(theintime,intime ) ) ; 
                            counttime = "" + theaps ;

                            if( theaps >= theminouttime ) {
                                thediffid = "" ;
                                diffcounttime = "0" ; 
                                thedifftype = "0" ;
                            
                                RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '0' and resourceid = " + resourceid ) ;

                                if( RecordSet2.getCounts() < 2 ) {
                                    if( RecordSet2.next() ) {
                                        thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                        diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                    }
                                }
                                else {
                                    int theminaps = 9999999 ;

                                    while ( RecordSet2.next() ) {
                                        String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                        String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                        String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                        String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                        String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                        String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                        // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                        if( thediffid.equals("") ) {
                                            thediffid = tempdiffid ;
                                            diffcounttime = temprealdifftime ;
                                        }

                                        if( tempstarttime.equals("") ) continue ;

                                        // ���빫˾ʱ��ͼӰ࿪ʼʱ��Ƚ�
                                        theaps = Math.abs( Util.timediff1(tempstarttime,intime ) ) ; 
                                        if( theaps < 0 ) theaps = -1 * theaps ;

                                        if( theaps < theminaps ) {
                                            thediffid = tempdiffid ;
                                            theminaps = theaps ;
                                            diffcounttime = temprealdifftime ;
                                        }
                                    }
                                }

                                procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;  
                                RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
                                
                            }
                        }
                        if ( intime.compareTo(theintime) > 0 ) {       // ���ڼ�������
                            thediffid = "" ;
                            diffcounttime = "0" ; 
                            thedifftype = "1" ;
                            
                            RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '1' and resourceid = " + resourceid ) ;

                            if( RecordSet2.getCounts() < 2 ) {
                                if( RecordSet2.next() ) {
                                    thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                    diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                }
                            }
                            else {
                                int theminaps = 9999999 ;

                                while ( RecordSet2.next() ) {
                                    String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                    String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                    String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                    String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                    String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                    String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                    // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                    if( thediffid.equals("") ) {
                                        thediffid = tempdiffid ;
                                        diffcounttime = temprealdifftime ;
                                    }

                                    if( tempendtime.equals("") ) continue ;

                                    // ���빫˾ʱ�����ٽ���ʱ��Ƚ�
                                    int theaps = Math.abs( Util.timediff1(tempendtime,intime ) ) ; 
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                            }

                            counttime = "" + Math.abs( Util.timediff1(theintime,intime ) ) ; 
                            
                            procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;  
                            RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;

                        }
                        if( outtime.compareTo(theouttime) < 0 && outtime.length() == 5) {      // ���ڼ�������
                            thediffid = "" ;
                            diffcounttime = "0" ; 
                            thedifftype = "1" ;
                            
                            RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '1' and resourceid = " + resourceid ) ;

                            if( RecordSet2.getCounts() < 2 ) {
                                if( RecordSet2.next() ) {
                                    thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                    diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                }
                            }
                            else {
                                int theminaps = 9999999 ;

                                while ( RecordSet2.next() ) {
                                    String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                    String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                    String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                    String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                    String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                    String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                    // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                    if( thediffid.equals("") ) {
                                        thediffid = tempdiffid ;
                                        diffcounttime = temprealdifftime ;
                                    }

                                    if( tempstarttime.equals("") ) continue ;

                                    // �ó���˾ʱ�����ٿ�ʼʱ��Ƚ�
                                    int theaps = Math.abs( Util.timediff1(tempstarttime,outtime ) ) ;
                                    if( theaps < 0 ) theaps = -1 * theaps ;

                                    if( theaps < theminaps ) {
                                        thediffid = tempdiffid ;
                                        theminaps = theaps ;
                                        diffcounttime = temprealdifftime ;
                                    }
                                }
                            }

                            counttime = "" + Math.abs( Util.timediff1(theouttime,outtime ) ) ;

                            procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ;  
                            RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;

                        }
                        if( outtime.compareTo(theouttime) > 0 ) {      // ������������
                            int theaps = Math.abs( Util.timediff1(theouttime,outtime ) ) ;
                            counttime = "" + theaps ;

                            if( theaps >= theminouttime ) {
                                thediffid = "" ;
                                diffcounttime = "0" ; 
                                thedifftype = "0" ;
                            
                                RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '0' and resourceid = " + resourceid ) ;

                                if( RecordSet2.getCounts() < 2 ) {
                                    if( RecordSet2.next() ) {
                                        thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                        diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                                    }
                                }
                                else {
                                    int theminaps = 9999999 ;

                                    while ( RecordSet2.next() ) {
                                        String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                        String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                        String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                        String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                        String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                        String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                        // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                        if( thediffid.equals("") ) {
                                            thediffid = tempdiffid ;
                                            diffcounttime = temprealdifftime ;
                                        }

                                        if( tempendtime.equals("") )  continue ;

                                        // �ó���˾ʱ��ͼӰ����ʱ��Ƚ�
                                        theaps = Math.abs( Util.timediff1(tempendtime,outtime ) ) ;
                                        if( theaps < 0 ) theaps = -1 * theaps ;

                                        if( theaps < theminaps ) {
                                            thediffid = tempdiffid ;
                                            theminaps = theaps ;
                                            diffcounttime = temprealdifftime ;
                                        }
                                    }
                                }

                                procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + theintime + separator + theouttime + separator + counttime + separator + diffcounttime ; 
                                RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
                            }
                        }
                    }
                }
                else {  // ʵ���ϰ������û�ж�Ӧ��Ӧ���ϰ�, ���ڼӰ�
                    
                    int theaps = Math.abs( Util.timediff1(intime,outtime ) ) ;
                    counttime = "" + theaps ;

                    if( theaps >= theminouttime ) {
                        thediffid = "" ;
                        diffcounttime = "0" ; 
                        thedifftype = "0" ;
                    
                        RecordSet2.executeSql( " select * from HrmScheduleMaintance where startdate <= '" + tempdate +"' and enddate >= '" + tempdate + "' and difftype = '0' and resourceid = " + resourceid ) ;

                        if( RecordSet2.getCounts() < 2 ) {
                            if( RecordSet2.next() ) {
                                thediffid = Util.null2String(RecordSet2.getString("id")) ;
                                diffcounttime = Util.null2String(RecordSet2.getString("realdifftime")) ;
                            }
                        }
                        else {
                            int theminaps = 9999999 ;

                            while ( RecordSet2.next() ) {
                                String tempdiffid = Util.null2String(RecordSet2.getString("id")) ;
                                String tempstartdate = Util.null2String(RecordSet2.getString("startdate")) ;
                                String tempstarttime = Util.null2String(RecordSet2.getString("starttime")) ;
                                String tempenddate = Util.null2String(RecordSet2.getString("enddate")) ;
                                String tempendtime = Util.null2String(RecordSet2.getString("endtime")) ;
                                String temprealdifftime = Util.null2String(RecordSet2.getString("realdifftime")) ;

                                // ���г�ʼ��ֵ�� �������û��ʱ����д�����õ�һ���ҵ���ƫ��
                                if( thediffid.equals("") ) {
                                    thediffid = tempdiffid ;
                                    diffcounttime = temprealdifftime ;
                                }

                                if( tempstarttime.equals("") )  continue ;

                                // ���빫˾ʱ��ͼӰ࿪ʼʱ��Ƚ�
                                theaps = Math.abs( Util.timediff1(tempstarttime,intime ) ) ;
                                if( theaps < 0 ) theaps = -1 * theaps ;

                                if( theaps < theminaps ) {
                                    thediffid = tempdiffid ;
                                    theminaps = theaps ;
                                    diffcounttime = temprealdifftime ;
                                }
                            }
                        }

                        procedurepara= thediffid + separator + resourceid + separator + tempdate + separator + thedifftype + separator + intime + separator + outtime + separator + "" + separator + "" + separator + counttime + separator + diffcounttime ; 
                        RecordSet.executeProc("HrmWorkTimeWarp_Insert",procedurepara) ;
                    }
                }
            }       // Ӧ���ϰ�Ĵ���ѭ�����
        }
                    
        thedate.add(Calendar.DATE , 1) ; 
        tempdate =  Util.add0(thedate.get(Calendar.YEAR) , 4) + "-" + 
                    Util.add0(thedate.get(Calendar.MONTH) + 1 , 2) + "-" + 
                    Util.add0(thedate.get(Calendar.DAY_OF_MONTH) , 2) ; 
    }
}


// ���¼���򿨱��е�ƫ��
RecordSet.executeSql(" select diffid , counttime from HrmWorkTimeWarp where  diffid is not null and diffid != 0 ") ; 
while( RecordSet.next() ) {
    String tempdiffid = Util.null2String(RecordSet.getString("diffid")) ;
    String tempcounttime = Util.null2String(RecordSet.getString("counttime")) ;

    if( Util.getIntValue(tempcounttime,0) != 0 ) {
        RecordSet.executeSql(" update HrmScheduleMaintance set realcarddifftime = realcarddifftime + " + tempcounttime + " where id = " + tempdiffid ) ; 
    }
}

response.sendRedirect("HrmWorkTimeWarpList.jsp?fromdate="+startdate+"&enddate="+enddate);

%>