alter table HrmSalaryChange add oldvalue number(15,2)
/
alter table HrmSalaryChange add newvalue number(15,2)
/
CALL MMConfig_U_ByInfoInsert (50,8)
/
CALL MMInfo_Insert (526,19599,'','/hrm/finance/salary/HrmSalaryChange.jsp','mainFrame',50,2,8,0,'',0,'Compensation:Manager',0,'','',0,'','',2)
/

INSERT INTO HtmlLabelIndex values(19599,'н����') 
/
INSERT INTO HtmlLabelInfo VALUES(19599,'н����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19599,'Salary Changed Log',8) 
/
INSERT INTO HtmlLabelIndex values(19603,'����ǰн��') 
/
INSERT INTO HtmlLabelInfo VALUES(19603,'����ǰн��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19603,'Old Salary',8) 
/
INSERT INTO HtmlLabelIndex values(19604,'������н��') 
/
INSERT INTO HtmlLabelInfo VALUES(19604,'������н��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19604,'New Salary',8) 
/