delete HtmlLabelIndex where id < 16639
GO

delete HtmlLabelInfo where indexid < 16639 
GO

alter table HtmlLabelIndex Alter column indexdesc varchar(255)
GO

alter table HtmlLabelInfo Alter column labelname varchar(255)
GO

/* ֻ��Ҫ�� sqlserver �ϸ��� */
alter PROCEDURE HtmlLabelInfo_Insert 
	@id		int,
        @labelname	varchar(255),
	@langid		int,
	@flag		int	output, 
	@msg		varchar(80) output
as
	insert into HtmlLabelInfo 
	(indexid,labelname,languageid)
	values
	(@id,@labelname,@langid)
GO




ALTER TABLE HtmlLabelIndex
	DROP CONSTRAINT PK__HtmlLabelIndex__77BFCB91
GO

ALTER TABLE HtmlLabelIndex
	DROP CONSTRAINT UQ__HtmlLabelIndex__78B3EFCA
GO


insert into HtmlLabelIndex values(57,'���ŵ���') 
GO
insert into HtmlLabelIndex values(58,'�ĵ�') 
GO
insert into HtmlLabelIndex values(60,'ά��') 
GO
insert into HtmlLabelIndex values(61,'����') 
GO
insert into HtmlLabelIndex values(63,'����') 
GO
insert into HtmlLabelIndex values(64,'ģ��') 
GO
insert into HtmlLabelIndex values(65,'��Ŀ¼') 
GO
insert into HtmlLabelIndex values(66,'��Ŀ¼') 
GO
insert into HtmlLabelIndex values(67,'��Ŀ¼') 
GO
insert into HtmlLabelIndex values(68,'����') 
GO
insert into HtmlLabelIndex values(70,'����ҳ') 
GO
insert into HtmlLabelIndex values(71,'�ʼ�') 
GO
insert into HtmlLabelIndex values(72,'���ù���') 
GO
insert into HtmlLabelIndex values(73,'�û��Զ���') 
GO
insert into HtmlLabelIndex values(74,'ͼƬ') 
GO
insert into HtmlLabelIndex values(75,'�ϴ�') 
GO
insert into HtmlLabelIndex values(76,'��վ') 
GO
insert into HtmlLabelIndex values(77,'����') 
GO
insert into HtmlLabelIndex values(78,'�ƶ�') 
GO
insert into HtmlLabelIndex values(79,'������') 
GO
insert into HtmlLabelIndex values(80,'ת��') 
GO
insert into HtmlLabelIndex values(81,'��װ') 
GO
insert into HtmlLabelIndex values(82,'�½�') 
GO
insert into HtmlLabelIndex values(83,'��־') 
GO
insert into HtmlLabelIndex values(84,'��ʶ') 
GO
insert into HtmlLabelIndex values(85,'˵��') 
GO
insert into HtmlLabelIndex values(86,'����') 
GO
insert into HtmlLabelIndex values(87,'��Ϣ') 
GO
insert into HtmlLabelIndex values(88,'˳��') 
GO
insert into HtmlLabelIndex values(89,'��ʾ') 
GO
insert into HtmlLabelIndex values(91,'ɾ��') 
GO
insert into HtmlLabelIndex values(92,'Ŀ¼') 
GO
insert into HtmlLabelIndex values(93,'�༭') 
GO
insert into HtmlLabelIndex values(95,'ϸ��') 
GO
insert into HtmlLabelIndex values(97,'����') 
GO
insert into HtmlLabelIndex values(99,'������') 
GO
insert into HtmlLabelIndex values(101,'��Ŀ') 
GO
insert into HtmlLabelIndex values(103,'�޸�') 
GO
insert into HtmlLabelIndex values(104,'����') 
GO
insert into HtmlLabelIndex values(106,'����') 
GO
insert into HtmlLabelIndex values(108,'�ͻ���') 
GO
insert into HtmlLabelIndex values(110,'��ַ') 
GO
insert into HtmlLabelIndex values(112,'�趨') 
GO
insert into HtmlLabelIndex values(114,'����') 
GO
insert into HtmlLabelIndex values(115,'����') 
GO
insert into HtmlLabelIndex values(117,'�ظ�') 
GO
insert into HtmlLabelIndex values(119,'����') 
GO
insert into HtmlLabelIndex values(120,'��ȫ') 
GO
insert into HtmlLabelIndex values(122,'��ɫ') 
GO
insert into HtmlLabelIndex values(124,'����') 
GO
insert into HtmlLabelIndex values(125,'����') 
GO
insert into HtmlLabelIndex values(127,'��') 
GO
insert into HtmlLabelIndex values(129,'����') 
GO
insert into HtmlLabelIndex values(130,'�а���') 
GO
insert into HtmlLabelIndex values(131,'��Ա') 
GO
insert into HtmlLabelIndex values(132,'������') 
GO
insert into HtmlLabelIndex values(134,'ѧ��') 
GO
insert into HtmlLabelIndex values(136,'�ͻ�') 
GO
insert into HtmlLabelIndex values(138,'��Ӧ��') 
GO
insert into HtmlLabelIndex values(139,'����') 
GO
insert into HtmlLabelIndex values(140,'�ܲ�') 
GO
insert into HtmlLabelIndex values(141,'�ֲ�') 
GO
insert into HtmlLabelIndex values(142,'��׼') 
GO
insert into HtmlLabelIndex values(144,'����') 
GO
insert into HtmlLabelIndex values(145,'��Ʒ') 
GO
insert into HtmlLabelIndex values(147,'CRM') 
GO
insert into HtmlLabelIndex values(149,'Ĭ��') 
GO
insert into HtmlLabelIndex values(151,'���') 
GO
insert into HtmlLabelIndex values(154,'һ��') 
GO
insert into HtmlLabelIndex values(155,'��Ծ') 
GO
insert into HtmlLabelIndex values(156,'����') 
GO
insert into HtmlLabelIndex values(158,'��Ŀ') 
GO
insert into HtmlLabelIndex values(160,'ʹ��') 
GO
insert into HtmlLabelIndex values(161,'��') 
GO
insert into HtmlLabelIndex values(163,'��') 
GO
insert into HtmlLabelIndex values(165,'δʹ��') 
GO
insert into HtmlLabelIndex values(166,'��ѡ��') 
GO
insert into HtmlLabelIndex values(168,'ǿ����') 
GO
insert into HtmlLabelIndex values(169,'״��') 
GO
insert into HtmlLabelIndex values(170,'����') 
GO
insert into HtmlLabelIndex values(172,'ѡ��') 
GO
insert into HtmlLabelIndex values(174,'����') 
GO
insert into HtmlLabelIndex values(176,'��ǩ') 
GO
insert into HtmlLabelIndex values(178,'���') 
GO
insert into HtmlLabelIndex values(179,'������Դ') 
GO
insert into HtmlLabelIndex values(181,'����') 
GO
insert into HtmlLabelIndex values(182,'�ϻ���') 
GO
insert into HtmlLabelIndex values(183,'prospect') 
GO
insert into HtmlLabelIndex values(185,'����') 
GO
insert into HtmlLabelIndex values(187,'����') 
GO
insert into HtmlLabelIndex values(189,'����') 
GO
insert into HtmlLabelIndex values(191,'�ο�') 
GO
insert into HtmlLabelIndex values(193,'����') 
GO
insert into HtmlLabelIndex values(195,'����') 
GO
insert into HtmlLabelIndex values(197,'����') 
GO
insert into HtmlLabelIndex values(199,'��������') 
GO
insert into HtmlLabelIndex values(201,'ȡ��') 
GO
insert into HtmlLabelIndex values(203,'���') 
GO
insert into HtmlLabelIndex values(207,'�߶�') 
GO
insert into HtmlLabelIndex values(209,'������С') 
GO
insert into HtmlLabelIndex values(211,'����ͼƬ����1') 
GO
insert into HtmlLabelIndex values(212,'����ͼƬ����2') 
GO
insert into HtmlLabelIndex values(213,'����ͼƬ����3') 
GO
insert into HtmlLabelIndex values(214,'����ͼƬ����4') 
GO
insert into HtmlLabelIndex values(216,'�ϲ�') 
GO
insert into HtmlLabelIndex values(218,'����') 
GO
insert into HtmlLabelIndex values(219,'�ֽ�') 
GO
insert into HtmlLabelIndex values(220,'�ݸ�') 
GO
insert into HtmlLabelIndex values(221,'Ԥ��') 
GO
insert into HtmlLabelIndex values(222,'Html') 
GO
insert into HtmlLabelIndex values(224,'ҳü') 
GO
insert into HtmlLabelIndex values(225,'����') 
GO
insert into HtmlLabelIndex values(227,'��ҳ') 
GO
insert into HtmlLabelIndex values(229,'����') 
GO
insert into HtmlLabelIndex values(231,'����') 
GO
insert into HtmlLabelIndex values(233,'��') 
GO
insert into HtmlLabelIndex values(235,'����') 
GO
insert into HtmlLabelIndex values(236,'�˻�') 
GO
insert into HtmlLabelIndex values(244,'���´�') 
GO
insert into HtmlLabelIndex values(251,'�鵵') 
GO
insert into HtmlLabelIndex values(256,'����') 
GO
insert into HtmlLabelIndex values(257,'��ӡ') 
GO
insert into HtmlLabelIndex values(258,'����') 
GO
insert into HtmlLabelIndex values(259,'������') 
GO
insert into HtmlLabelIndex values(260,'�Ķ�') 
GO
insert into HtmlLabelIndex values(261,'�ֶ�') 
GO
insert into HtmlLabelIndex values(264,'��¼') 
GO
insert into HtmlLabelIndex values(265,'ÿҳ') 
GO
insert into HtmlLabelIndex values(271,'������') 
GO
insert into HtmlLabelIndex values(275,'����') 
GO
insert into HtmlLabelIndex values(277,'ʱ��') 
GO
insert into HtmlLabelIndex values(280,'�ߴ�') 
GO
insert into HtmlLabelIndex values(293,'����') 
GO
insert into HtmlLabelIndex values(309,'�ر�') 
GO
insert into HtmlLabelIndex values(311,'���') 
GO
insert into HtmlLabelIndex values(316,'����') 
GO
insert into HtmlLabelIndex values(320,'�б�') 
GO
insert into HtmlLabelIndex values(321,'ÿҳ��¼') 
GO
insert into HtmlLabelIndex values(322,'Ҫ��') 
GO
insert into HtmlLabelIndex values(323,'ҳ��') 
GO
insert into HtmlLabelIndex values(324,'��׼') 
GO
insert into HtmlLabelIndex values(325,'���ڻ����') 
GO
insert into HtmlLabelIndex values(326,'С�ڻ����') 
GO
insert into HtmlLabelIndex values(327,'����') 
GO
insert into HtmlLabelIndex values(328,'����') 
GO
insert into HtmlLabelIndex values(329,'������') 
GO
insert into HtmlLabelIndex values(330,'Ŀ��') 
GO
insert into HtmlLabelIndex values(331,'Դ') 
GO
insert into HtmlLabelIndex values(332,'ȫ��') 
GO
insert into HtmlLabelIndex values(333,'��ť') 
GO
insert into HtmlLabelIndex values(334,'����') 
GO
insert into HtmlLabelIndex values(335,'LOGO') 
GO
insert into HtmlLabelIndex values(336,'����') 
GO
insert into HtmlLabelIndex values(337,'KB') 
GO
insert into HtmlLabelIndex values(338,'����') 
GO
insert into HtmlLabelIndex values(339,'����') 
GO
insert into HtmlLabelIndex values(340,'����') 
GO
insert into HtmlLabelIndex values(341,'ժҪ') 
GO
insert into HtmlLabelIndex values(342,'��') 
GO
insert into HtmlLabelIndex values(343,'����') 
GO
insert into HtmlLabelIndex values(344,'����') 
GO
insert into HtmlLabelIndex values(345,'����') 
GO
insert into HtmlLabelIndex values(346,'����') 
GO
insert into HtmlLabelIndex values(347,'�߼�') 
GO
insert into HtmlLabelIndex values(348,'��') 
GO
insert into HtmlLabelIndex values(349,'��') 
GO
insert into HtmlLabelIndex values(350,'���Ϊ') 
GO
insert into HtmlLabelIndex values(351,'����') 
GO
insert into HtmlLabelIndex values(352,'ͳ��') 
GO
insert into HtmlLabelIndex values(353,'����') 
GO
insert into HtmlLabelIndex values(354,'ˢ��') 
GO
insert into HtmlLabelIndex values(355,'����') 
GO
insert into HtmlLabelIndex values(356,'���') 
GO
insert into HtmlLabelIndex values(357,'ְλ') 
GO
insert into HtmlLabelIndex values(358,'�ϼ�') 
GO
insert into HtmlLabelIndex values(359,'����') 
GO
insert into HtmlLabelIndex values(360,'��') 
GO
insert into HtmlLabelIndex values(361,'��ϸ') 
GO
insert into HtmlLabelIndex values(362,'Ա��') 
GO
insert into HtmlLabelIndex values(363,'����') 
GO
insert into HtmlLabelIndex values(364,'��������') 
GO
insert into HtmlLabelIndex values(365,'��') 
GO
insert into HtmlLabelIndex values(366,'��Ƹ��Ϣ') 
GO
insert into HtmlLabelIndex values(367,'�鿴') 
GO
insert into HtmlLabelIndex values(368,'������') 
GO
insert into HtmlLabelIndex values(369,'ʱ���') 
GO
insert into HtmlLabelIndex values(370,'����') 
GO
insert into HtmlLabelIndex values(371,'����') 
GO
insert into HtmlLabelIndex values(372,'��һ��') 
GO
insert into HtmlLabelIndex values(374,'�����ڼ�') 
GO
insert into HtmlLabelIndex values(375,'����') 
GO
insert into HtmlLabelIndex values(376,'��֯') 
GO
insert into HtmlLabelIndex values(377,'����') 
GO
insert into HtmlLabelIndex values(378,'λ��') 
GO
insert into HtmlLabelIndex values(380,'����') 
GO
insert into HtmlLabelIndex values(381,'�ṹ') 
GO
insert into HtmlLabelIndex values(382,'ְ��') 
GO
insert into HtmlLabelIndex values(383,'ְ��') 
GO
insert into HtmlLabelIndex values(384,'����') 
GO
insert into HtmlLabelIndex values(385,'Ȩ��') 
GO
insert into HtmlLabelIndex values(386,'Ԥ��') 
GO
insert into HtmlLabelIndex values(387,'Ҫ��') 
GO
insert into HtmlLabelIndex values(388,'����') 
GO
insert into HtmlLabelIndex values(389,'�����ʻ�') 
GO
insert into HtmlLabelIndex values(390,'��') 
GO
insert into HtmlLabelIndex values(391,'Сʱ') 
GO
insert into HtmlLabelIndex values(392,'����һ') 
GO
insert into HtmlLabelIndex values(393,'���ڶ�') 
GO
insert into HtmlLabelIndex values(394,'������') 
GO
insert into HtmlLabelIndex values(395,'������') 
GO
insert into HtmlLabelIndex values(396,'������') 
GO
insert into HtmlLabelIndex values(397,'������') 
GO
insert into HtmlLabelIndex values(398,'������') 
GO
insert into HtmlLabelIndex values(399,'���') 
GO
insert into HtmlLabelIndex values(400,'δ����') 
GO
insert into HtmlLabelIndex values(401,'����') 
GO
insert into HtmlLabelIndex values(402,'��ֵ˰') 
GO
insert into HtmlLabelIndex values(403,'����') 
GO
insert into HtmlLabelIndex values(404,'��ʼ') 
GO
insert into HtmlLabelIndex values(405,'����') 
GO
insert into HtmlLabelIndex values(406,'����') 
GO
insert into HtmlLabelIndex values(407,'�ƻ�') 
GO
insert into HtmlLabelIndex values(408,'����') 
GO
insert into HtmlLabelIndex values(409,'����') 
GO
insert into HtmlLabelIndex values(410,'������Ϣ') 
GO
insert into HtmlLabelIndex values(411,'��������') 
GO
insert into HtmlLabelIndex values(412,'��¼��') 
GO
insert into HtmlLabelIndex values(413,'����') 
GO
insert into HtmlLabelIndex values(415,'����Ծ') 
GO
insert into HtmlLabelIndex values(416,'�Ա�') 
GO
insert into HtmlLabelIndex values(417,'����') 
GO
insert into HtmlLabelIndex values(418,'Ů��') 
GO
insert into HtmlLabelIndex values(419,'������ַ') 
GO
insert into HtmlLabelIndex values(420,'�칫��') 
GO
insert into HtmlLabelIndex values(421,'�绰') 
GO
insert into HtmlLabelIndex values(422,'�ֻ�') 
GO
insert into HtmlLabelIndex values(423,'����') 
GO
insert into HtmlLabelIndex values(424,'�޸���') 
GO
insert into HtmlLabelIndex values(425,'�ɱ�') 
GO
insert into HtmlLabelIndex values(426,'����') 
GO
insert into HtmlLabelIndex values(427,'����') 
GO
insert into HtmlLabelIndex values(428,'��֧') 
GO
insert into HtmlLabelIndex values(430,'����') 
GO
insert into HtmlLabelIndex values(431,'��Ա') 
GO
insert into HtmlLabelIndex values(432,'��������') 
GO
insert into HtmlLabelIndex values(433,'����') 
GO
insert into HtmlLabelIndex values(434,'�漰') 
GO
insert into HtmlLabelIndex values(436,'��׼��') 
GO
insert into HtmlLabelIndex values(437,'ʵ����') 
GO
insert into HtmlLabelIndex values(438,'������') 
GO
insert into HtmlLabelIndex values(439,'������') 
GO
insert into HtmlLabelIndex values(440,'Ȩ����') 
GO
insert into HtmlLabelIndex values(441,'����') 
GO
insert into HtmlLabelIndex values(442,'����') 
GO
insert into HtmlLabelIndex values(443,'����¼����') 
GO
insert into HtmlLabelIndex values(444,'Ѱ��') 
GO
insert into HtmlLabelIndex values(445,'��') 
GO
insert into HtmlLabelIndex values(446,'�ڼ�') 
GO
insert into HtmlLabelIndex values(447,'�䶯') 
GO
insert into HtmlLabelIndex values(448,'н��') 
GO
insert into HtmlLabelIndex values(449,'����') 
GO
insert into HtmlLabelIndex values(450,'���ʱ��') 
GO
insert into HtmlLabelIndex values(451,'��С') 
GO
insert into HtmlLabelIndex values(452,'����') 
GO
insert into HtmlLabelIndex values(453,'�̶�ֵ') 
GO
insert into HtmlLabelIndex values(454,'��ע') 
GO
insert into HtmlLabelIndex values(455,'����') 
GO
insert into HtmlLabelIndex values(456,'����') 
GO
insert into HtmlLabelIndex values(457,'����') 
GO
insert into HtmlLabelIndex values(458,'��Ϣ��') 
GO
insert into HtmlLabelIndex values(459,'�̶�') 
GO
insert into HtmlLabelIndex values(460,'����') 
GO
insert into HtmlLabelIndex values(461,'��') 
GO
insert into HtmlLabelIndex values(462,'�ƺ�') 
GO
insert into HtmlLabelIndex values(463,'δ֪') 
GO
insert into HtmlLabelIndex values(464,'��������') 
GO
insert into HtmlLabelIndex values(465,'����') 
GO
insert into HtmlLabelIndex values(466,'P&amp;L') 
GO
insert into HtmlLabelIndex values(467,'����') 
GO
insert into HtmlLabelIndex values(468,'ϵͳ') 
GO
insert into HtmlLabelIndex values(469,'����״��') 
GO
insert into HtmlLabelIndex values(470,'δ��') 
GO
insert into HtmlLabelIndex values(471,'�ѻ�') 
GO
insert into HtmlLabelIndex values(472,'����') 
GO
insert into HtmlLabelIndex values(473,'ͬ��') 
GO
insert into HtmlLabelIndex values(474,'�������') 
GO
insert into HtmlLabelIndex values(475,'����') 
GO
insert into HtmlLabelIndex values(476,'�칫��Ϣ') 
GO
insert into HtmlLabelIndex values(477,'�����ʼ�') 
GO
insert into HtmlLabelIndex values(478,'��ͥ��Ϣ') 
GO
insert into HtmlLabelIndex values(479,'��������') 
GO
insert into HtmlLabelIndex values(480,'��ʱ') 
GO
insert into HtmlLabelIndex values(481,'��ʼ��') 
GO
insert into HtmlLabelIndex values(482,'��ͬ��ֹ����') 
GO
insert into HtmlLabelIndex values(483,'ϵͳֹͣ����') 
GO
insert into HtmlLabelIndex values(484,'��������') 
GO
insert into HtmlLabelIndex values(485,'�ɹ�����') 
GO
insert into HtmlLabelIndex values(486,'��ᰲȫ��') 
GO
insert into HtmlLabelIndex values(487,'���ÿ�') 
GO
insert into HtmlLabelIndex values(488,'������') 
GO
insert into HtmlLabelIndex values(490,'����') 
GO
insert into HtmlLabelIndex values(491,'�嵥') 
GO
insert into HtmlLabelIndex values(492,'Ȩ����') 
GO
insert into HtmlLabelIndex values(493,'����') 
GO
insert into HtmlLabelIndex values(494,'����') 
GO
insert into HtmlLabelIndex values(495,'��ɫ') 
GO
insert into HtmlLabelIndex values(496,'����') 
GO
insert into HtmlLabelIndex values(497,'���') 
GO
insert into HtmlLabelIndex values(498,'ʧ��') 
GO
insert into HtmlLabelIndex values(499,'ǰ��') 
GO
insert into HtmlLabelIndex values(500,'����') 
GO
insert into HtmlLabelIndex values(501,'ȷ������') 
GO
insert into HtmlLabelIndex values(502,'��') 
GO
insert into HtmlLabelIndex values(503,'���ʵ�') 
GO
insert into HtmlLabelIndex values(504,'���') 
GO
insert into HtmlLabelIndex values(505,'�ĵ�����') 
GO
insert into HtmlLabelIndex values(506,'�ĵ�ģ��') 
GO
insert into HtmlLabelIndex values(507,'ͼƬ�ϴ�') 
GO
insert into HtmlLabelIndex values(508,'�ĵ�����ת��') 
GO
insert into HtmlLabelIndex values(509,'Ĭ��ʱ���') 
GO
insert into HtmlLabelIndex values(510,'����ʱ���') 
GO
insert into HtmlLabelIndex values(511,'������Դʱ���') 
GO
insert into HtmlLabelIndex values(512,'��һ�¹���ʱ��') 
GO
insert into HtmlLabelIndex values(513,'�ɱ�������Ŀ¼') 
GO
insert into HtmlLabelIndex values(514,'�ɱ����ķ�Ŀ¼') 
GO
insert into HtmlLabelIndex values(515,'�ɱ�����') 
GO
insert into HtmlLabelIndex values(516,'��������') 
GO
insert into HtmlLabelIndex values(517,'����') 
GO
insert into HtmlLabelIndex values(518,'����ְ��') 
GO
insert into HtmlLabelIndex values(519,'����ְ��') 
GO
insert into HtmlLabelIndex values(520,'��������') 
GO
insert into HtmlLabelIndex values(521,'����Ҫ������') 
GO
insert into HtmlLabelIndex values(522,'���') 
GO
insert into HtmlLabelIndex values(523,'�ܼ�') 
GO
insert into HtmlLabelIndex values(524,'��ǰ') 
GO
insert into HtmlLabelIndex values(525,'ǰһ��') 
GO
insert into HtmlLabelIndex values(526,'ƽ��') 
GO
insert into HtmlLabelIndex values(527,'��ѯ') 
GO
insert into HtmlLabelIndex values(528,'����') 
GO
insert into HtmlLabelIndex values(529,'ȫ��') 
GO
insert into HtmlLabelIndex values(530,'��ʼ') 
GO
insert into HtmlLabelIndex values(531,'��ݷ�ʽ') 
GO
insert into HtmlLabelIndex values(532,'��ѵ') 
GO
insert into HtmlLabelIndex values(533,'����Ҫ��') 
GO
insert into HtmlLabelIndex values(534,'���') 
GO
insert into HtmlLabelIndex values(535,'�ʲ�') 
GO
insert into HtmlLabelIndex values(536,'����') 
GO
insert into HtmlLabelIndex values(537,'����') 
GO
insert into HtmlLabelIndex values(538,'ÿ����') 
GO
insert into HtmlLabelIndex values(539,'ÿ��') 
GO
insert into HtmlLabelIndex values(540,'ÿСʱ') 
GO
insert into HtmlLabelIndex values(541,'ÿ��') 
GO
insert into HtmlLabelIndex values(542,'ֻһ��') 
GO
insert into HtmlLabelIndex values(543,'ÿ����') 
GO
insert into HtmlLabelIndex values(544,'ÿ����') 
GO
insert into HtmlLabelIndex values(545,'ÿ��') 
GO
insert into HtmlLabelIndex values(546,'ÿ��') 
GO
insert into HtmlLabelIndex values(547,'����') 
GO
insert into HtmlLabelIndex values(548,'��˰') 
GO
insert into HtmlLabelIndex values(549,'˰��') 
GO
insert into HtmlLabelIndex values(550,'�����ʻ�') 
GO
insert into HtmlLabelIndex values(551,'����һ��') 
GO
insert into HtmlLabelIndex values(552,'˽��') 
GO
insert into HtmlLabelIndex values(553,'����') 
GO
insert into HtmlLabelIndex values(554,'����') 
GO
insert into HtmlLabelIndex values(555,'���') 
GO
insert into HtmlLabelIndex values(556,'ȫѡ') 
GO
insert into HtmlLabelIndex values(557,'��') 
GO
insert into HtmlLabelIndex values(558,'��ʾ') 
GO
insert into HtmlLabelIndex values(559,'���μ��') 
GO
insert into HtmlLabelIndex values(560,'������Ϣ����') 
GO
insert into HtmlLabelIndex values(561,'����') 
GO
insert into HtmlLabelIndex values(562,'��֯ͼ��') 
GO
insert into HtmlLabelIndex values(563,'����') 
GO
insert into HtmlLabelIndex values(564,'ָʾ��') 
GO
insert into HtmlLabelIndex values(565,'����ʱ�����') 
GO
insert into HtmlLabelIndex values(566,'����') 
GO
insert into HtmlLabelIndex values(567,'�汾') 
GO
insert into HtmlLabelIndex values(568,'��д') 
GO
insert into HtmlLabelIndex values(569,'��ϵ����') 
GO
insert into HtmlLabelIndex values(570,'�����ֶ�') 
GO
insert into HtmlLabelIndex values(571,'�ʻ�') 
GO
insert into HtmlLabelIndex values(572,'��ϵ��') 
GO
insert into HtmlLabelIndex values(573,'Delivery Methods') 
GO
insert into HtmlLabelIndex values(574,'�г�����') 
GO
insert into HtmlLabelIndex values(575,'��ҵ') 
GO
insert into HtmlLabelIndex values(576,'��ģ') 
GO
insert into HtmlLabelIndex values(577,'֧����ʽ') 
GO
insert into HtmlLabelIndex values(578,'�ּ�') 
GO
insert into HtmlLabelIndex values(579,'����') 
GO
insert into HtmlLabelIndex values(580,'���õȼ�') 
GO
insert into HtmlLabelIndex values(581,'�ۼƺ�ͬ���') 
GO
insert into HtmlLabelIndex values(582,'�Ż�') 
GO
insert into HtmlLabelIndex values(583,'ǰ׺') 
GO
insert into HtmlLabelIndex values(584,'��׺') 
GO
insert into HtmlLabelIndex values(585,'��Ŀ') 
GO
insert into HtmlLabelIndex values(586,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(587,'��Ŀ״̬') 
GO
insert into HtmlLabelIndex values(588,'����') 
GO
insert into HtmlLabelIndex values(589,'��ԭ') 
GO
insert into HtmlLabelIndex values(590,'����') 
GO
insert into HtmlLabelIndex values(591,'�ϼ��ͻ�') 
GO
insert into HtmlLabelIndex values(593,'�ȼ�����') 
GO
insert into HtmlLabelIndex values(594,'����') 
GO
insert into HtmlLabelIndex values(595,'����') 
GO
insert into HtmlLabelIndex values(596,'�ϼ�') 
GO
insert into HtmlLabelIndex values(597,'�ͻ�') 
GO
insert into HtmlLabelIndex values(598,'����') 
GO
insert into HtmlLabelIndex values(599,'��ʽ') 
GO
insert into HtmlLabelIndex values(600,'�˻�') 
GO
insert into HtmlLabelIndex values(601,'�ջ�') 
GO
insert into HtmlLabelIndex values(602,'״̬') 
GO
insert into HtmlLabelIndex values(603,'�ȼ�') 
GO
insert into HtmlLabelIndex values(604,'����') 
GO
insert into HtmlLabelIndex values(605,'����ҵ') 
GO
insert into HtmlLabelIndex values(606,'��ʾ��') 
GO
insert into HtmlLabelIndex values(607,'����') 
GO
insert into HtmlLabelIndex values(608,'�ı�') 
GO
insert into HtmlLabelIndex values(609,'�ж�') 
GO
insert into HtmlLabelIndex values(610,'��Ŀ��') 
GO
insert into HtmlLabelIndex values(611,'���') 
GO
insert into HtmlLabelIndex values(612,'��') 
GO
insert into HtmlLabelIndex values(613,'ԭʼ') 
GO
insert into HtmlLabelIndex values(614,'��ͬ') 
GO
insert into HtmlLabelIndex values(615,'�ύ') 
GO
insert into HtmlLabelIndex values(616,'�ύ��') 
GO
insert into HtmlLabelIndex values(617,'��ֹ��') 
GO
insert into HtmlLabelIndex values(618,'�޸ļ�¼') 
GO
insert into HtmlLabelIndex values(619,'סլ') 
GO
insert into HtmlLabelIndex values(620,'�ƶ��绰') 
GO
insert into HtmlLabelIndex values(621,'��ϵ') 
GO
insert into HtmlLabelIndex values(622,'���') 
GO
insert into HtmlLabelIndex values(623,'��') 
GO
insert into HtmlLabelIndex values(624,'��Ա�ɼ�') 
GO
insert into HtmlLabelIndex values(625,'�Ƿ�ͻ�����') 
GO
insert into HtmlLabelIndex values(626,'��Ա�ϼ��ɼ�') 
GO
insert into HtmlLabelIndex values(627,'�ϼ���Ա�ɼ�') 
GO
insert into HtmlLabelIndex values(628,'ʵ��') 
GO
insert into HtmlLabelIndex values(629,'֧��') 
GO
insert into HtmlLabelIndex values(630,'ҵ��') 
GO
insert into HtmlLabelIndex values(631,'��Թ') 
GO
insert into HtmlLabelIndex values(632,'��ʱ') 
GO
insert into HtmlLabelIndex values(633,'����') 
GO
insert into HtmlLabelIndex values(634,'����') 
GO
insert into HtmlLabelIndex values(635,'����') 
GO
insert into HtmlLabelIndex values(636,'�ϼ���Ŀ') 
GO
insert into HtmlLabelIndex values(637,'������') 
GO
insert into HtmlLabelIndex values(638,'ȷ����') 
GO
insert into HtmlLabelIndex values(639,'������') 
GO
insert into HtmlLabelIndex values(640,'����ͷ��') 
GO
insert into HtmlLabelIndex values(642,'Ӣ��') 
GO
insert into HtmlLabelIndex values(643,'ʡ') 
GO
insert into HtmlLabelIndex values(644,'�� ') 
GO
insert into HtmlLabelIndex values(645,'���;��') 
GO
insert into HtmlLabelIndex values(646,'����ȷ����') 
GO
insert into HtmlLabelIndex values(647,'��') 
GO
insert into HtmlLabelIndex values(648,'����') 
GO
insert into HtmlLabelIndex values(649,'����') 
GO
insert into HtmlLabelIndex values(650,'���ý������') 
GO
insert into HtmlLabelIndex values(651,'�ۿ���') 
GO
insert into HtmlLabelIndex values(652,'֧������') 
GO
insert into HtmlLabelIndex values(653,'��ֵ˰����') 
GO
insert into HtmlLabelIndex values(655,'��Ʊ�ͻ�') 
GO
insert into HtmlLabelIndex values(657,'��������') 
GO
insert into HtmlLabelIndex values(658,'֧������') 
GO
insert into HtmlLabelIndex values(659,'���ʹ�') 
GO
insert into HtmlLabelIndex values(660,'ȫ��') 
GO
insert into HtmlLabelIndex values(661,'�칫�ҵ绰') 
GO
insert into HtmlLabelIndex values(662,'סլ�绰') 
GO
insert into HtmlLabelIndex values(663,'��¼') 
GO
insert into HtmlLabelIndex values(664,'����') 
GO
insert into HtmlLabelIndex values(665,'���') 
GO
insert into HtmlLabelIndex values(666,'�ܷ�����') 
GO
insert into HtmlLabelIndex values(667,'��ϸ��') 
GO
insert into HtmlLabelIndex values(668,'����') 
GO
insert into HtmlLabelIndex values(669,'���') 
GO
insert into HtmlLabelIndex values(670,'���') 
GO
insert into HtmlLabelIndex values(671,'����') 
GO
insert into HtmlLabelIndex values(672,'����') 
GO
insert into HtmlLabelIndex values(673,'����') 
GO
insert into HtmlLabelIndex values(674,'��¼') 
GO
insert into HtmlLabelIndex values(675,'����') 
GO
insert into HtmlLabelIndex values(676,'�����ͼ��') 
GO
insert into HtmlLabelIndex values(677,'�ʼ��ϲ�') 
GO
insert into HtmlLabelIndex values(678,'�') 
GO
insert into HtmlLabelIndex values(679,'����') 
GO
insert into HtmlLabelIndex values(680,'��Ȩ') 
GO
insert into HtmlLabelIndex values(681,'����ͼƬ') 
GO
insert into HtmlLabelIndex values(682,'����') 
GO
insert into HtmlLabelIndex values(683,'��ȫ����') 
GO
insert into HtmlLabelIndex values(684,'�ֶι���') 
GO
insert into HtmlLabelIndex values(685,'�ֶ�����') 
GO
insert into HtmlLabelIndex values(686,'�ֶ�����') 
GO
insert into HtmlLabelIndex values(687,'������ʽ') 
GO
insert into HtmlLabelIndex values(688,'�����ı���') 
GO
insert into HtmlLabelIndex values(689,'�����ı���') 
GO
insert into HtmlLabelIndex values(690,'ѡ���') 
GO
insert into HtmlLabelIndex values(691,'Check��') 
GO
insert into HtmlLabelIndex values(694,'ȫ��ѡ��') 
GO
insert into HtmlLabelIndex values(695,'�����ť') 
GO
insert into HtmlLabelIndex values(696,'����') 
GO
insert into HtmlLabelIndex values(697,'������') 
GO
insert into HtmlLabelIndex values(698,'�ı�����') 
GO
insert into HtmlLabelIndex values(699,'������') 
GO
insert into HtmlLabelIndex values(700,'��') 
GO
insert into HtmlLabelIndex values(701,'�����ֶ�') 
GO
insert into HtmlLabelIndex values(702,'ɾ���ֶ�') 
GO
insert into HtmlLabelIndex values(703,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(704,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(705,'������λ') 
GO
insert into HtmlLabelIndex values(706,'��������') 
GO
insert into HtmlLabelIndex values(707,'���㷽��') 
GO
insert into HtmlLabelIndex values(708,'������') 
GO
insert into HtmlLabelIndex values(709,'������') 
GO
insert into HtmlLabelIndex values(710,'�ո��ʽ') 
GO
insert into HtmlLabelIndex values(711,'�ֿ�') 
GO
insert into HtmlLabelIndex values(712,'�����ⷽʽ') 
GO
insert into HtmlLabelIndex values(713,'����') 
GO
insert into HtmlLabelIndex values(714,'���') 
GO
insert into HtmlLabelIndex values(715,'���±��') 
GO
insert into HtmlLabelIndex values(716,'����') 
GO
insert into HtmlLabelIndex values(717,'��Ч��') 
GO
insert into HtmlLabelIndex values(718,'��Ч��') 
GO
insert into HtmlLabelIndex values(719,'�ɱ��۸�') 
GO
insert into HtmlLabelIndex values(720,'�ɹ���') 
GO
insert into HtmlLabelIndex values(721,'���ۼ�') 
GO
insert into HtmlLabelIndex values(722,'��������') 
GO
insert into HtmlLabelIndex values(723,'�޸�����') 
GO
insert into HtmlLabelIndex values(724,'����') 
GO
insert into HtmlLabelIndex values(725,'ʵ��') 
GO
insert into HtmlLabelIndex values(726,'�۸�') 
GO
insert into HtmlLabelIndex values(727,'���ﳵ') 
GO
insert into HtmlLabelIndex values(728,'����') 
GO
insert into HtmlLabelIndex values(729,'��ϵ') 
GO
insert into HtmlLabelIndex values(730,'��ȡ') 
GO
insert into HtmlLabelIndex values(731,'�û���Ϣ') 
GO
insert into HtmlLabelIndex values(732,'δ���') 
GO
insert into HtmlLabelIndex values(733,'������') 
GO
insert into HtmlLabelIndex values(734,'��������') 
GO
insert into HtmlLabelIndex values(735,'���϶���') 
GO
insert into HtmlLabelIndex values(736,'�ʲ���ծ��') 
GO
insert into HtmlLabelIndex values(737,'����') 
GO
insert into HtmlLabelIndex values(738,'�ʲ����üƻ�') 
GO
insert into HtmlLabelIndex values(739,'�����Ϣ') 
GO
insert into HtmlLabelIndex values(740,'��ʼ����') 
GO
insert into HtmlLabelIndex values(741,'��������') 
GO
insert into HtmlLabelIndex values(742,'��ʼʱ��') 
GO
insert into HtmlLabelIndex values(743,'����ʱ��') 
GO
insert into HtmlLabelIndex values(744,'�����') 
GO
insert into HtmlLabelIndex values(745,'��') 
GO
insert into HtmlLabelIndex values(746,'����') 
GO
insert into HtmlLabelIndex values(747,'���') 
GO
insert into HtmlLabelIndex values(748,'�������ϸ') 
GO
insert into HtmlLabelIndex values(749,'����ⵥ��') 
GO
insert into HtmlLabelIndex values(750,'���ⵥ') 
GO
insert into HtmlLabelIndex values(751,'��ⵥ') 
GO
insert into HtmlLabelIndex values(752,'��ⵥ���') 
GO
insert into HtmlLabelIndex values(753,'�������') 
GO
insert into HtmlLabelIndex values(754,'��ⷽʽ') 
GO
insert into HtmlLabelIndex values(755,'��ⵥ��') 
GO
insert into HtmlLabelIndex values(756,'���ⵥ��� ') 
GO
insert into HtmlLabelIndex values(757,'Ĭ�ϱ���') 
GO
insert into HtmlLabelIndex values(758,'Ĭ�ϱ��ֽ����ܼ�') 
GO
insert into HtmlLabelIndex values(759,'Ĭ�ϱ��ֽ�����˰��') 
GO
insert into HtmlLabelIndex values(760,'�����ܼ�') 
GO
insert into HtmlLabelIndex values(761,'������˰��') 
GO
insert into HtmlLabelIndex values(762,'���ⷽʽ ') 
GO
insert into HtmlLabelIndex values(763,'����') 
GO
insert into HtmlLabelIndex values(764,'����') 
GO
insert into HtmlLabelIndex values(765,'��ר') 
GO
insert into HtmlLabelIndex values(766,'��ר') 
GO
insert into HtmlLabelIndex values(767,'����') 
GO
insert into HtmlLabelIndex values(768,'˶ʿ�о���') 
GO
insert into HtmlLabelIndex values(769,'��ʿ�о���') 
GO
insert into HtmlLabelIndex values(770,'��������') 
GO
insert into HtmlLabelIndex values(771,'��ͬ��� ') 
GO
insert into HtmlLabelIndex values(772,'�ĵ��ƶ�') 
GO
insert into HtmlLabelIndex values(773,'ӦƸ��Ϣ') 
GO
insert into HtmlLabelIndex values(774,'ϵͳ����') 
GO
insert into HtmlLabelIndex values(775,'ϵͳ��־') 
GO
insert into HtmlLabelIndex values(776,'�ؽ����ݿ�') 
GO
insert into HtmlLabelIndex values(777,'��Ŀ��ȫ��') 
GO
insert into HtmlLabelIndex values(778,'��Ŀ����ϸ') 
GO
insert into HtmlLabelIndex values(779,'��������ϵ��') 
GO
insert into HtmlLabelIndex values(780,'������') 
GO
insert into HtmlLabelIndex values(781,'��������') 
GO
insert into HtmlLabelIndex values(782,'�����Ŀ') 
GO
insert into HtmlLabelIndex values(783,'��ؿͻ�') 
GO
insert into HtmlLabelIndex values(784,'��������') 
GO
insert into HtmlLabelIndex values(785,'����ʱ��') 
GO
insert into HtmlLabelIndex values(786,'���˼ƻ�') 
GO
insert into HtmlLabelIndex values(787,'�ƻ���') 
GO
insert into HtmlLabelIndex values(788,'���ñ�����') 
GO
insert into HtmlLabelIndex values(789,'������') 
GO
insert into HtmlLabelIndex values(790,'��������') 
GO
insert into HtmlLabelIndex values(791,'����') 
GO
insert into HtmlLabelIndex values(792,'�����Ա') 
GO
insert into HtmlLabelIndex values(793,'�������') 
GO
insert into HtmlLabelIndex values(794,'�����ܽ��') 
GO
insert into HtmlLabelIndex values(795,'��������') 
GO
insert into HtmlLabelIndex values(796,'�跽��Ŀ') 
GO
insert into HtmlLabelIndex values(797,'�跽ժҪ') 
GO
insert into HtmlLabelIndex values(798,'������Ŀ') 
GO
insert into HtmlLabelIndex values(799,'����ժҪ') 
GO
insert into HtmlLabelIndex values(800,'ʡ��') 
GO
insert into HtmlLabelIndex values(801,'����') 
GO
insert into HtmlLabelIndex values(802,'γ��') 
GO
insert into HtmlLabelIndex values(803,'רҵ') 
GO
insert into HtmlLabelIndex values(804,'�ù�����') 
GO
insert into HtmlLabelIndex values(805,'ְ�����') 
GO
insert into HtmlLabelIndex values(806,'ְ��') 
GO
insert into HtmlLabelIndex values(807,'��ѵ����') 
GO
insert into HtmlLabelIndex values(808,'��������') 
GO
insert into HtmlLabelIndex values(809,'����') 
GO
insert into HtmlLabelIndex values(810,'�ͷ�') 
GO
insert into HtmlLabelIndex values(811,'����') 
GO
insert into HtmlLabelIndex values(812,'��������') 
GO
insert into HtmlLabelIndex values(813,'�������') 
GO
insert into HtmlLabelIndex values(814,'��ͥ���') 
GO
insert into HtmlLabelIndex values(815,'��������') 
GO
insert into HtmlLabelIndex values(816,'��ѵ��¼') 
GO
insert into HtmlLabelIndex values(817,'���ͼ�¼') 
GO
insert into HtmlLabelIndex values(818,'ѧ��') 
GO
insert into HtmlLabelIndex values(819,'����') 
GO
insert into HtmlLabelIndex values(820,'�м�') 
GO
insert into HtmlLabelIndex values(821,'����') 
GO
insert into HtmlLabelIndex values(822,'����') 
GO
insert into HtmlLabelIndex values(823,'��ͨ') 
GO
insert into HtmlLabelIndex values(824,'����') 
GO
insert into HtmlLabelIndex values(825,'�ϲ�') 
GO
insert into HtmlLabelIndex values(826,'ȷ��') 
GO
insert into HtmlLabelIndex values(827,'�����') 
GO
insert into HtmlLabelIndex values(828,'�������') 
GO
insert into HtmlLabelIndex values(829,'��ٵ�') 
GO
insert into HtmlLabelIndex values(830,'�ʲ�״̬') 
GO
insert into HtmlLabelIndex values(831,'�ʲ���') 
GO
insert into HtmlLabelIndex values(832,'���ʲ���') 
GO
insert into HtmlLabelIndex values(833,'��ѵѧʱ') 
GO
insert into HtmlLabelIndex values(834,'��ѵ����') 
GO
insert into HtmlLabelIndex values(835,'�۾ɷ�һ') 
GO
insert into HtmlLabelIndex values(836,'�۾ɷ���') 
GO
insert into HtmlLabelIndex values(837,'�ʲ��۾ɷ�') 
GO
insert into HtmlLabelIndex values(838,'��ϵʵʩ��') 
GO
insert into HtmlLabelIndex values(839,'��������Դ') 
GO
insert into HtmlLabelIndex values(840,'��ͻ�') 
GO
insert into HtmlLabelIndex values(841,'��Ŀ�ƻ�') 
GO
insert into HtmlLabelIndex values(842,'�ƻ�����') 
GO
insert into HtmlLabelIndex values(843,'�ƻ�����') 
GO
insert into HtmlLabelIndex values(844,'�ο��ĵ�') 
GO
insert into HtmlLabelIndex values(845,'Ԥ����') 
GO
insert into HtmlLabelIndex values(846,'����Ŀ') 
GO
insert into HtmlLabelIndex values(847,'����') 
GO
insert into HtmlLabelIndex values(848,'��Ҫ��') 
GO
insert into HtmlLabelIndex values(849,'�Ӱ�����') 
GO
insert into HtmlLabelIndex values(850,'�Ӱ���') 
GO
insert into HtmlLabelIndex values(851,'�Ӱ�ԭ��') 
GO
insert into HtmlLabelIndex values(852,'������') 
GO
insert into HtmlLabelIndex values(853,'��Сʱ��') 
GO
insert into HtmlLabelIndex values(854,'������������') 
GO
insert into HtmlLabelIndex values(855,'��������') 
GO
insert into HtmlLabelIndex values(856,'������') 
GO
insert into HtmlLabelIndex values(857,'����ĵ�') 
GO
insert into HtmlLabelIndex values(858,'����ʲ�') 
GO
insert into HtmlLabelIndex values(859,'����ԭ��') 
GO
insert into HtmlLabelIndex values(860,'��������') 
GO
insert into HtmlLabelIndex values(861,'ԭ��') 
GO
insert into HtmlLabelIndex values(862,'˽�˽��') 
GO
insert into HtmlLabelIndex values(863,'������') 
GO
insert into HtmlLabelIndex values(864,'�ƻ�����') 
GO
insert into HtmlLabelIndex values(865,'�ƻ���Ա') 
GO
insert into HtmlLabelIndex values(866,'�ܼƻ����') 
GO
insert into HtmlLabelIndex values(867,'��ؿͻ�2') 
GO
insert into HtmlLabelIndex values(868,'����ĵ�2') 
GO
insert into HtmlLabelIndex values(869,'�깺����') 
GO
insert into HtmlLabelIndex values(870,'�깺��Ա') 
GO
insert into HtmlLabelIndex values(871,'��;') 
GO
insert into HtmlLabelIndex values(872,'�ʲ��깺��') 
GO
insert into HtmlLabelIndex values(873,'������') 
GO
insert into HtmlLabelIndex values(874,'ƾ֤��') 
GO
insert into HtmlLabelIndex values(875,'һ�ܹ��������') 
GO
insert into HtmlLabelIndex values(876,'�¹����ƻ���') 
GO
insert into HtmlLabelIndex values(877,'�¹����ܽᵥ') 
GO
insert into HtmlLabelIndex values(878,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(879,'�깻����') 
GO
insert into HtmlLabelIndex values(880,'��������') 
GO
insert into HtmlLabelIndex values(881,'���ø���') 
GO
insert into HtmlLabelIndex values(882,'������') 
GO
insert into HtmlLabelIndex values(883,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(884,'ԭ������') 
GO
insert into HtmlLabelIndex values(885,'ԭ�����ž���') 
GO
insert into HtmlLabelIndex values(886,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(887,'�·�') 
GO
insert into HtmlLabelIndex values(888,'ԭ�����') 
GO
insert into HtmlLabelIndex values(889,'���������') 
GO
insert into HtmlLabelIndex values(890,'¼��֪ͨ��') 
GO
insert into HtmlLabelIndex values(891,'��ְ֪ͨ��') 
GO
insert into HtmlLabelIndex values(892,'�ܲ�Ԥ�㶨�Ƶ�') 
GO
insert into HtmlLabelIndex values(893,'��¼����') 
GO
insert into HtmlLabelIndex values(894,'���˲���') 
GO
insert into HtmlLabelIndex values(895,'��ְ�ʸ�') 
GO
insert into HtmlLabelIndex values(896,'������') 
GO
insert into HtmlLabelIndex values(897,'��ְ��') 
GO
insert into HtmlLabelIndex values(898,'��ְʱ��') 
GO
insert into HtmlLabelIndex values(899,'��ְ˵��') 
GO
insert into HtmlLabelIndex values(900,'��Ʊ����') 
GO
insert into HtmlLabelIndex values(901,'������') 
GO
insert into HtmlLabelIndex values(902,'���ղֿ�') 
GO
insert into HtmlLabelIndex values(903,'�ʲ����') 
GO
insert into HtmlLabelIndex values(904,'����ͺ�') 
GO
insert into HtmlLabelIndex values(905,'Ӧ������') 
GO
insert into HtmlLabelIndex values(906,'ʵ������') 
GO
insert into HtmlLabelIndex values(907,'�ƻ��۸�') 
GO
insert into HtmlLabelIndex values(908,'ʵ�ʼ۸�') 
GO
insert into HtmlLabelIndex values(909,'�ƻ����') 
GO
insert into HtmlLabelIndex values(910,'ʵ�ʽ��') 
GO
insert into HtmlLabelIndex values(911,'�۸����') 
GO
insert into HtmlLabelIndex values(912,'�������') 
GO
insert into HtmlLabelIndex values(913,'�ɹ���') 
GO
insert into HtmlLabelIndex values(914,'������λ����') 
GO
insert into HtmlLabelIndex values(915,'�ʲ��̵�') 
GO
insert into HtmlLabelIndex values(916,'�̵���Ա') 
GO
insert into HtmlLabelIndex values(917,'�̵���Ա2') 
GO
insert into HtmlLabelIndex values(918,'�̵㲿��') 
GO
insert into HtmlLabelIndex values(919,'�̵�ʱ��') 
GO
insert into HtmlLabelIndex values(920,'����') 
GO
insert into HtmlLabelIndex values(921,'������¼') 
GO
insert into HtmlLabelIndex values(922,'�������ñ���') 
GO
insert into HtmlLabelIndex values(923,'��������') 
GO
insert into HtmlLabelIndex values(924,'����ά��') 
GO
insert into HtmlLabelIndex values(925,'�칫��Ʒ����') 
GO
insert into HtmlLabelIndex values(926,'��ػ���') 
GO
insert into HtmlLabelIndex values(1000,'ָ���´���') 
GO
insert into HtmlLabelIndex values(1001,'ָ���´ﲿ��') 
GO
insert into HtmlLabelIndex values(1002,'���ָ��') 
GO
insert into HtmlLabelIndex values(1003,'��׼������') 
GO
insert into HtmlLabelIndex values(1004,'������ת��') 
GO
insert into HtmlLabelIndex values(1005,'��עͨ��') 
GO
insert into HtmlLabelIndex values(1006,'��ע') 
GO
insert into HtmlLabelIndex values(1007,'ǩ��') 
GO
insert into HtmlLabelIndex values(1008,'�������') 
GO
insert into HtmlLabelIndex values(1009,'����ͨ��') 
GO
insert into HtmlLabelIndex values(1010,'�����˻�') 
GO
insert into HtmlLabelIndex values(1011,'Ԥ���������') 
GO
insert into HtmlLabelIndex values(1012,'�����ŷ���Ԥ���') 
GO
insert into HtmlLabelIndex values(1013,'ȫ��') 
GO
insert into HtmlLabelIndex values(1014,'��ʽ') 
GO
insert into HtmlLabelIndex values(1015,'������ͳ��') 
GO
insert into HtmlLabelIndex values(1016,'��Ԥ�����ͳ��') 
GO
insert into HtmlLabelIndex values(1017,'�����ʲ��б�') 
GO
insert into HtmlLabelIndex values(1018,'�����ʲ����') 
GO
insert into HtmlLabelIndex values(1019,'�����ʲ�����') 
GO
insert into HtmlLabelIndex values(1020,'��������') 
GO
insert into HtmlLabelIndex values(1021,'�����ʻ�����Ӣ�Ļ�ƴ����') 
GO
insert into HtmlLabelIndex values(1022,'��ŵЭ��') 
GO
insert into HtmlLabelIndex values(1023,'��Ƭӡ��') 
GO
insert into HtmlLabelIndex values(1024,'ӡ�ƺ���') 
GO
insert into HtmlLabelIndex values(1025,'ѡ��') 
GO
insert into HtmlLabelIndex values(1026,'�ܷ���') 
GO
insert into HtmlLabelIndex values(1027,'����Ԥ��') 
GO
insert into HtmlLabelIndex values(1028,'��סʱ��') 
GO
insert into HtmlLabelIndex values(1029,'�˷�ʱ��') 
GO
insert into HtmlLabelIndex values(1030,'ס����') 
GO
insert into HtmlLabelIndex values(1031,'������׼') 
GO
insert into HtmlLabelIndex values(1032,'�����׼') 
GO
insert into HtmlLabelIndex values(1033,'������ܲ�ȷ��') 
GO
insert into HtmlLabelIndex values(1034,'�Ƿ񳬱�') 
GO
insert into HtmlLabelIndex values(1035,'�������') 
GO
insert into HtmlLabelIndex values(1036,'���ʱ��') 
GO
insert into HtmlLabelIndex values(1037,'��������') 
GO
insert into HtmlLabelIndex values(1038,'�����ճ�') 
GO
insert into HtmlLabelIndex values(1039,'�����¹������ܱ�') 
GO
insert into HtmlLabelIndex values(1040,'�����') 
GO
insert into HtmlLabelIndex values(1041,'��Ҫʱ��') 
GO
insert into HtmlLabelIndex values(1042,'Ԥ�ƻ���ʱ��') 
GO
insert into HtmlLabelIndex values(1043,'�����') 
GO
insert into HtmlLabelIndex values(1044,'�������') 
GO
insert into HtmlLabelIndex values(1045,'�����ʻ���') 
GO
insert into HtmlLabelIndex values(1046,'����ʱ��') 
GO
insert into HtmlLabelIndex values(1047,'������') 
GO
insert into HtmlLabelIndex values(1048,'ӡˢ��λ') 
GO
insert into HtmlLabelIndex values(1049,'����') 
GO
insert into HtmlLabelIndex values(1050,'��������') 
GO
insert into HtmlLabelIndex values(1051,'Ԥ����˾') 
GO
insert into HtmlLabelIndex values(1052,'���˲�������') 
GO
insert into HtmlLabelIndex values(1053,'����������ϸ') 
GO
insert into HtmlLabelIndex values(1054,'ҵ���д��ѱ���') 
GO
insert into HtmlLabelIndex values(1055,'�д�����') 
GO
insert into HtmlLabelIndex values(1056,'�д�����') 
GO
insert into HtmlLabelIndex values(1057,'�д�����') 
GO
insert into HtmlLabelIndex values(1058,'������ʽ') 
GO
insert into HtmlLabelIndex values(1059,'���ѵص�') 
GO
insert into HtmlLabelIndex values(1060,'����Ŀ��') 
GO
insert into HtmlLabelIndex values(1201,'���Ϻ�') 
GO
insert into HtmlLabelIndex values(1202,'�����') 
GO
insert into HtmlLabelIndex values(1203,'�����') 
GO
insert into HtmlLabelIndex values(1204,'�����') 
GO
insert into HtmlLabelIndex values(1205,'�˳�') 
GO
insert into HtmlLabelIndex values(1207,'��������') 
GO
insert into HtmlLabelIndex values(1208,'�ҵ�CRM') 
GO
insert into HtmlLabelIndex values(1209,'�ҵ��ʲ�') 
GO
insert into HtmlLabelIndex values(1210,'�ҵ�����') 
GO
insert into HtmlLabelIndex values(1211,'�ҵ���Ŀ') 
GO
insert into HtmlLabelIndex values(1212,'�ҵ��ĵ�') 
GO
insert into HtmlLabelIndex values(1213,'�ҵ��ʼ�') 
GO
insert into HtmlLabelIndex values(1214,'�ĵ� - ����') 
GO
insert into HtmlLabelIndex values(1215,'�ĵ� - Ŀ¼') 
GO
insert into HtmlLabelIndex values(1216,'ͳ�� - ������Ϣ') 
GO
insert into HtmlLabelIndex values(1217,'ͳ�� - ����') 
GO
insert into HtmlLabelIndex values(1218,'ͳ�� - �ͻ���Ϣ') 
GO
insert into HtmlLabelIndex values(1219,'��÷�ʽ') 
GO
insert into HtmlLabelIndex values(1220,'����ֲ�') 
GO
insert into HtmlLabelIndex values(1221,'�ͻ���ϵ���') 
GO
insert into HtmlLabelIndex values(1222,'�ͻ��������') 
GO
insert into HtmlLabelIndex values(1223,'��¼ - ����') 
GO
insert into HtmlLabelIndex values(1224,'�޸� - ����') 
GO
insert into HtmlLabelIndex values(1225,'��ȡ - ����') 
GO
insert into HtmlLabelIndex values(1226,'�ʼ�����') 
GO
insert into HtmlLabelIndex values(1227,'��׼->�����ͻ�') 
GO
insert into HtmlLabelIndex values(1228,'��׼->Ǳ�ڿͻ�') 
GO
insert into HtmlLabelIndex values(1229,'��׼->�ɹ��ͻ�') 
GO
insert into HtmlLabelIndex values(1230,'��׼->�Ե�ͻ�') 
GO
insert into HtmlLabelIndex values(1231,'��׼->���Ϳͻ�') 
GO
insert into HtmlLabelIndex values(1232,'����') 
GO
insert into HtmlLabelIndex values(1233,'�ⶳ') 
GO
insert into HtmlLabelIndex values(1234,'�Ż�����') 
GO
insert into HtmlLabelIndex values(1235,'�Ż���׼') 
GO
insert into HtmlLabelIndex values(1236,'�Ż�����') 
GO
insert into HtmlLabelIndex values(1237,'�Ż�����') 
GO
insert into HtmlLabelIndex values(1238,'�Ż�����������') 
GO
insert into HtmlLabelIndex values(1239,'�½�������') 
GO
insert into HtmlLabelIndex values(1240,'�Ż�״̬') 
GO
insert into HtmlLabelIndex values(1241,'δ��ͨ') 
GO
insert into HtmlLabelIndex values(1242,'������') 
GO
insert into HtmlLabelIndex values(1243,'ֱ��ת���տ') 
GO
insert into HtmlLabelIndex values(1244,'����ֱ�ӻ�Ʊ') 
GO
insert into HtmlLabelIndex values(1245,'��CHF����ҵ�֧��') 
GO
insert into HtmlLabelIndex values(1246,'֧Ʊ') 
GO
insert into HtmlLabelIndex values(1247,'ֱ��ת��') 
GO
insert into HtmlLabelIndex values(1248,'�տ�') 
GO
insert into HtmlLabelIndex values(1249,'�ֽ�') 
GO
insert into HtmlLabelIndex values(1250,'ָ������') 
GO
insert into HtmlLabelIndex values(1251,'ESR֧��') 
GO
insert into HtmlLabelIndex values(1252,'��Ʊ') 
GO
insert into HtmlLabelIndex values(1253,'ES֧��') 
GO
insert into HtmlLabelIndex values(1254,'����֧Ʊ') 
GO
insert into HtmlLabelIndex values(1255,'�����ͻ���ϵ���') 
GO
insert into HtmlLabelIndex values(1256,'����') 
GO
insert into HtmlLabelIndex values(1258,'��һҳ') 
GO
insert into HtmlLabelIndex values(1259,'��һҳ') 
GO
insert into HtmlLabelIndex values(1260,'������Email��ַ') 
GO
insert into HtmlLabelIndex values(1261,'���͵�') 
GO
insert into HtmlLabelIndex values(1262,'����ϵ��') 
GO
insert into HtmlLabelIndex values(1263,'������ϵ��') 
GO
insert into HtmlLabelIndex values(1264,'��ʽ') 
GO
insert into HtmlLabelIndex values(1265,'����') 
GO
insert into HtmlLabelIndex values(1266,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(1267,'���׷�ʽ') 
GO
insert into HtmlLabelIndex values(1268,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(1269,'�ͻ�û�п�Ŀ��Ϣ') 
GO
insert into HtmlLabelIndex values(1270,'���޽��') 
GO
insert into HtmlLabelIndex values(1271,'���޽��') 
GO
insert into HtmlLabelIndex values(1272,'��ȡʱ��') 
GO
insert into HtmlLabelIndex values(1273,'��ȡ��') 
GO
insert into HtmlLabelIndex values(1275,'��ϵʱ��') 
GO
insert into HtmlLabelIndex values(1276,'��¼ʱ��') 
GO
insert into HtmlLabelIndex values(1278,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(1279,'������Ϣ') 
GO
insert into HtmlLabelIndex values(1280,'��ͨ') 
GO
insert into HtmlLabelIndex values(1281,'�ӷ���') 
GO
insert into HtmlLabelIndex values(1282,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(1283,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(1284,'�ͻ�״��') 
GO
insert into HtmlLabelIndex values(1285,'�ͻ���ģ') 
GO
insert into HtmlLabelIndex values(1286,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(1287,'��Ŀ��֯') 
GO
insert into HtmlLabelIndex values(1288,'CRM ����') 
GO
insert into HtmlLabelIndex values(1289,'CRM ��֯') 
GO
insert into HtmlLabelIndex values(1290,'����') 
GO
insert into HtmlLabelIndex values(1291,'��ĿȨ��') 
GO
insert into HtmlLabelIndex values(1292,'�鿴������Ϣ') 
GO
insert into HtmlLabelIndex values(1293,'�鿴��ϸ��Ϣ') 
GO
insert into HtmlLabelIndex values(1294,'��Ŀ��') 
GO
insert into HtmlLabelIndex values(1295,'�ƻ�&����') 
GO
insert into HtmlLabelIndex values(1296,'����&���') 
GO
insert into HtmlLabelIndex values(1297,'��������') 
GO
insert into HtmlLabelIndex values(1298,'����') 
GO
insert into HtmlLabelIndex values(1299,'�����ɱ�') 
GO
insert into HtmlLabelIndex values(1300,'�豸�ɱ�') 
GO
insert into HtmlLabelIndex values(1301,'���ϳɱ�') 
GO
insert into HtmlLabelIndex values(1302,'�̶��ʲ��������ܱ�') 
GO
insert into HtmlLabelIndex values(1303,'���Ź̶��ʲ�����һ����') 
GO
insert into HtmlLabelIndex values(1304,'���Ź̶��ʲ�����һ����') 
GO
insert into HtmlLabelIndex values(1305,'�����Ź̶��ʲ��ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1306,'��˾�̶��ʲ��ɹ���ϸ��') 
GO
insert into HtmlLabelIndex values(1307,'���¸���������ɹ�һ����') 
GO
insert into HtmlLabelIndex values(1308,'����һ�ܹ������ܱ�') 
GO
insert into HtmlLabelIndex values(1309,'�����Ű칫��Ʒ�ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1310,'��������Ʒ�ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1311,'�����ŵ�ֵ�׺�Ʒ�ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1312,'������IT�豸�ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1313,'�����żҾ߲ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1314,'������ͼ��ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1315,'��˾�칫��Ʒ�ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1316,'��˾��Ʒ�ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1317,'��˾��ֵ�׺�Ʒ�ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1318,'��˾IT�豸�ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1319,'��˾�Ҿ߲ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1320,'��˾ͼ��ɹ��ƻ���') 
GO
insert into HtmlLabelIndex values(1321,'����') 
GO
insert into HtmlLabelIndex values(1322,'��ʼ����') 
GO
insert into HtmlLabelIndex values(1325,'�̶��ɱ�') 
GO
insert into HtmlLabelIndex values(1326,'�豸') 
GO
insert into HtmlLabelIndex values(1327,'�ɱ�/��') 
GO
insert into HtmlLabelIndex values(1328,'����') 
GO
insert into HtmlLabelIndex values(1329,'��λ') 
GO
insert into HtmlLabelIndex values(1330,'����') 
GO
insert into HtmlLabelIndex values(1331,'����') 
GO
insert into HtmlLabelIndex values(1332,'����') 
GO
insert into HtmlLabelIndex values(1333,'�ƻ��汾') 
GO
insert into HtmlLabelIndex values(1334,'����˵��') 
GO
insert into HtmlLabelIndex values(1335,'��ǰ״��') 
GO
insert into HtmlLabelIndex values(1337,'��Ŀ�ƻ�֪ͨ') 
GO
insert into HtmlLabelIndex values(1338,'ִ��') 
GO
insert into HtmlLabelIndex values(1339,'����ʱ��') 
GO
insert into HtmlLabelIndex values(1340,'������') 
GO
insert into HtmlLabelIndex values(1341,'�ĵ�����') 
GO
insert into HtmlLabelIndex values(1342,'�������') 
GO
insert into HtmlLabelIndex values(1343,'�ύ��׼') 
GO
insert into HtmlLabelIndex values(1344,'�ƻ���׼') 
GO
insert into HtmlLabelIndex values(1345,'�ƻ����') 
GO
insert into HtmlLabelIndex values(1346,'�ƻ�ɾ��') 
GO
insert into HtmlLabelIndex values(1347,'�ƻ�����') 
GO
insert into HtmlLabelIndex values(1348,'֪ͨ��Ա') 
GO
insert into HtmlLabelIndex values(1349,'����ʹ��') 
GO
insert into HtmlLabelIndex values(1350,'�豸ʹ��') 
GO
insert into HtmlLabelIndex values(1351,'����ʹ��') 
GO
insert into HtmlLabelIndex values(1352,'��������') 
GO
insert into HtmlLabelIndex values(1353,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(1354,'�Ƚ϶���') 
GO
insert into HtmlLabelIndex values(1355,'��׼�ƻ�') 
GO
insert into HtmlLabelIndex values(1356,'��ǰ�ƻ�') 
GO
insert into HtmlLabelIndex values(1357,'��ֵ(��׼)') 
GO
insert into HtmlLabelIndex values(1358,'��ֵ(��ǰ)') 
GO
insert into HtmlLabelIndex values(1359,'�۾ɷ���') 
GO
insert into HtmlLabelIndex values(1360,'�������') 
GO
insert into HtmlLabelIndex values(1361,'������Ϣ') 
GO
insert into HtmlLabelIndex values(1362,'������') 
GO
insert into HtmlLabelIndex values(1363,'��������') 
GO
insert into HtmlLabelIndex values(1364,'���쳧��') 
GO
insert into HtmlLabelIndex values(1365,'��������') 
GO
insert into HtmlLabelIndex values(1366,'����') 
GO
insert into HtmlLabelIndex values(1367,'�ɹ�') 
GO
insert into HtmlLabelIndex values(1368,'����') 
GO
insert into HtmlLabelIndex values(1369,'����') 
GO
insert into HtmlLabelIndex values(1370,'����') 
GO
insert into HtmlLabelIndex values(1371,'���') 
GO
insert into HtmlLabelIndex values(1372,'��ʼ�۸�') 
GO
insert into HtmlLabelIndex values(1373,'�۾ɵ׼�') 
GO
insert into HtmlLabelIndex values(1374,'�۾���Ϣ') 
GO
insert into HtmlLabelIndex values(1375,'���') 
GO
insert into HtmlLabelIndex values(1376,'����') 
GO
insert into HtmlLabelIndex values(1377,'����') 
GO
insert into HtmlLabelIndex values(1378,'����') 
GO
insert into HtmlLabelIndex values(1379,'���') 
GO
insert into HtmlLabelIndex values(1380,'��ת') 
GO
insert into HtmlLabelIndex values(1381,'�ƽ�') 
GO
insert into HtmlLabelIndex values(1382,'ά��') 
GO
insert into HtmlLabelIndex values(1384,'�黹') 
GO
insert into HtmlLabelIndex values(1385,'��ʧ') 
GO
insert into HtmlLabelIndex values(1386,'����') 
GO
insert into HtmlLabelIndex values(1387,'��ŵص�') 
GO
insert into HtmlLabelIndex values(1388,'�������ޣ��·�') 
GO
insert into HtmlLabelIndex values(1389,'��ǰ��ֵ') 
GO
insert into HtmlLabelIndex values(1390,'��ֵ��') 
GO
insert into HtmlLabelIndex values(1391,'���۾���') 
GO
insert into HtmlLabelIndex values(1392,'��������') 
GO
insert into HtmlLabelIndex values(1393,'��ط���') 
GO
insert into HtmlLabelIndex values(1394,'��ת����') 
GO
insert into HtmlLabelIndex values(1395,'�ص�') 
GO
insert into HtmlLabelIndex values(1396,'����') 
GO
insert into HtmlLabelIndex values(1397,'�̿�') 
GO
insert into HtmlLabelIndex values(1398,'��ӯ') 
GO
insert into HtmlLabelIndex values(1399,'ά�޵�λ') 
GO
insert into HtmlLabelIndex values(1400,'����') 
GO
insert into HtmlLabelIndex values(1401,'�ƽ�����') 
GO
insert into HtmlLabelIndex values(1402,'��һ��') 
GO
insert into HtmlLabelIndex values(1404,'�������') 
GO
insert into HtmlLabelIndex values(1405,'��������') 
GO
insert into HtmlLabelIndex values(1406,'��ʧ����') 
GO
insert into HtmlLabelIndex values(1408,'��ʧ��״̬') 
GO
insert into HtmlLabelIndex values(1409,'ά������') 
GO
insert into HtmlLabelIndex values(1410,'��������') 
GO
insert into HtmlLabelIndex values(1411,'��������') 
GO
insert into HtmlLabelIndex values(1412,'��������') 
GO
insert into HtmlLabelIndex values(1413,'�黹����') 
GO
insert into HtmlLabelIndex values(1414,'�黹��״̬') 
GO
insert into HtmlLabelIndex values(1415,'�̵�����') 
GO
insert into HtmlLabelIndex values(1416,'�̵���') 
GO
insert into HtmlLabelIndex values(1417,'��������') 
GO
insert into HtmlLabelIndex values(1418,'ʵ������') 
GO
insert into HtmlLabelIndex values(1419,'ӯ������') 
GO
insert into HtmlLabelIndex values(1420,'ӯ�����') 
GO
insert into HtmlLabelIndex values(1421,'����') 
GO
insert into HtmlLabelIndex values(1422,'δ����') 
GO
insert into HtmlLabelIndex values(1423,'������') 
GO
insert into HtmlLabelIndex values(1425,'��������') 
GO
insert into HtmlLabelIndex values(1426,'ѡ��') 
GO
insert into HtmlLabelIndex values(1427,'ʱ��(��)') 
GO
insert into HtmlLabelIndex values(1428,'�����') 
GO
insert into HtmlLabelIndex values(1429,'ɾ����') 
GO
insert into HtmlLabelIndex values(1430,'ʱ��(��)') 
GO
insert into HtmlLabelIndex values(1431,'��ʼ����') 
GO
insert into HtmlLabelIndex values(1432,'��������') 
GO
insert into HtmlLabelIndex values(1433,'�۾ɺ���(t)') 
GO
insert into HtmlLabelIndex values(1434,'ԭ����') 
GO
insert into HtmlLabelIndex values(1435,'��ת������') 
GO
insert into HtmlLabelIndex values(1436,'��ת����') 
GO
insert into HtmlLabelIndex values(1437,'����') 
GO
insert into HtmlLabelIndex values(1438,'�ʲ��ܱ�') 
GO
insert into HtmlLabelIndex values(1439,'�ʲ����') 
GO
insert into HtmlLabelIndex values(1440,'�ܱ���') 
GO
insert into HtmlLabelIndex values(1441,'�۾ɱ���') 
GO
insert into HtmlLabelIndex values(1442,'������ �� ͳ�Ʊ���') 
GO
insert into HtmlLabelIndex values(1443,'����') 
GO
insert into HtmlLabelIndex values(1444,'С��') 
GO
insert into HtmlLabelIndex values(1445,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(1446,'�������') 
GO
insert into HtmlLabelIndex values(1447,'�ܽ��') 
GO
insert into HtmlLabelIndex values(1448,'Ŀǰ״̬') 
GO
insert into HtmlLabelIndex values(1449,'˭��ʹ��') 
GO
insert into HtmlLabelIndex values(1450,'��ֵ') 
GO
insert into HtmlLabelIndex values(1451,'��ǰ����') 
GO
insert into HtmlLabelIndex values(1452,'���ʿ�Ŀ') 
GO
insert into HtmlLabelIndex values(1453,'�����ڼ�') 
GO
insert into HtmlLabelIndex values(1454,'�Ѵ���') 
GO
insert into HtmlLabelIndex values(1455,'��������') 
GO
insert into HtmlLabelIndex values(1456,'��������') 
GO
insert into HtmlLabelIndex values(1457,'����������������') 
GO
insert into HtmlLabelIndex values(1458,'����������������') 
GO
insert into HtmlLabelIndex values(1459,'�ڼ� �� , ��') 
GO
insert into HtmlLabelIndex values(1460,'��ĩ') 
GO
insert into HtmlLabelIndex values(1461,'����') 
GO
insert into HtmlLabelIndex values(1462,'��������') 
GO
insert into HtmlLabelIndex values(1463,'����') 
GO
insert into HtmlLabelIndex values(1464,'�ٷֱ�') 
GO
insert into HtmlLabelIndex values(1465,'�跽') 
GO
insert into HtmlLabelIndex values(1466,'����') 
GO
insert into HtmlLabelIndex values(1467,'�Զ���ϸ') 
GO
insert into HtmlLabelIndex values(1468,'�ͻ�:Ԥ��') 
GO
insert into HtmlLabelIndex values(1469,'�ͻ�:Ӧ��') 
GO
insert into HtmlLabelIndex values(1470,'��Ӧ��:Ԥ��') 
GO
insert into HtmlLabelIndex values(1471,'��Ӧ��:Ӧ��') 
GO
insert into HtmlLabelIndex values(1472,'����, ����:') 
GO
insert into HtmlLabelIndex values(1473,'��ծ') 
GO
insert into HtmlLabelIndex values(1474,'������Ȩ��') 
GO
insert into HtmlLabelIndex values(1475,'����') 
GO
insert into HtmlLabelIndex values(1476,'���Ҷһ�') 
GO
insert into HtmlLabelIndex values(1477,'��ʷ') 
GO
insert into HtmlLabelIndex values(1478,'Ŀ¼��Ϣ') 
GO
insert into HtmlLabelIndex values(1479,'Ȩ����ϸ��Ϣ') 
GO
insert into HtmlLabelIndex values(1480,'�ڳ�') 
GO
insert into HtmlLabelIndex values(1481,'ѡ��') 
GO
insert into HtmlLabelIndex values(1482,'�ڳ���') 
GO
insert into HtmlLabelIndex values(1483,'��ĩ��') 
GO
insert into HtmlLabelIndex values(1484,'�ʲ��ܼ�') 
GO
insert into HtmlLabelIndex values(1485,'��ծ��������Ȩ��') 
GO
insert into HtmlLabelIndex values(1486,'�д�') 
GO
insert into HtmlLabelIndex values(1487,'��ծ�ܼ�') 
GO
insert into HtmlLabelIndex values(1488,'������Ȩ���ܼ�') 
GO
insert into HtmlLabelIndex values(1489,'��ծ��������Ȩ���ܼ�') 
GO
insert into HtmlLabelIndex values(1490,'���ŷ���Ԥ���') 
GO
insert into HtmlLabelIndex values(1491,'����') 
GO
insert into HtmlLabelIndex values(1492,'һ��') 
GO
insert into HtmlLabelIndex values(1493,'����') 
GO
insert into HtmlLabelIndex values(1494,'����') 
GO
insert into HtmlLabelIndex values(1495,'����') 
GO
insert into HtmlLabelIndex values(1496,'����') 
GO
insert into HtmlLabelIndex values(1497,'����') 
GO
insert into HtmlLabelIndex values(1498,'����') 
GO
insert into HtmlLabelIndex values(1499,'����') 
GO
insert into HtmlLabelIndex values(1500,'��ҳ') 
GO
insert into HtmlLabelIndex values(1501,'��ת���') 
GO
insert into HtmlLabelIndex values(1502,'�ʸ�֤��') 
GO
insert into HtmlLabelIndex values(1503,'��ְ����') 
GO
insert into HtmlLabelIndex values(1504,'н�긣��') 
GO
insert into HtmlLabelIndex values(1505,'���ݼټ�¼') 
GO
insert into HtmlLabelIndex values(1506,'�̵�') 
GO
insert into HtmlLabelIndex values(1507,'����Ա') 
GO
insert into HtmlLabelIndex values(1508,'ʹ����') 
GO
insert into HtmlLabelIndex values(1509,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(1510,'�ʲ����ܱ�') 
GO
insert into HtmlLabelIndex values(1511,'���÷�̯') 
GO
insert into HtmlLabelIndex values(1512,'������') 
GO
insert into HtmlLabelIndex values(1513,'�ճ��칫��Ʒһ����') 
GO
insert into HtmlLabelIndex values(1514,'����') 
GO
insert into HtmlLabelIndex values(1515,'ͨѶ¼') 
GO
insert into HtmlLabelIndex values(1516,'��ְ����') 
GO
insert into HtmlLabelIndex values(1517,'����סַ') 
GO
insert into HtmlLabelIndex values(1518,'��ҵѧУ') 
GO
insert into HtmlLabelIndex values(1519,'��ҵ����') 
GO
insert into HtmlLabelIndex values(1520,'�����̴���') 
GO
insert into HtmlLabelIndex values(1521,'���½�����') 
GO
insert into HtmlLabelIndex values(1522,'����������') 
GO
insert into HtmlLabelIndex values(1523,'�����ܼ�') 
GO
insert into HtmlLabelIndex values(1524,'��ĩ���') 
GO
insert into HtmlLabelIndex values(1800,'����') 
GO
insert into HtmlLabelIndex values(1801,'ʮ��') 
GO
insert into HtmlLabelIndex values(1802,'ʮһ��') 
GO
insert into HtmlLabelIndex values(1803,'ʮ����') 
GO
insert into HtmlLabelIndex values(1804,'����') 
GO
insert into HtmlLabelIndex values(1805,'������') 
GO
insert into HtmlLabelIndex values(1806,'�����ۼ���') 
GO
insert into HtmlLabelIndex values(1807,'�����ۼ���') 
GO
insert into HtmlLabelIndex values(1808,'���汨��') 
GO
insert into HtmlLabelIndex values(1809,'��ϸ������') 
GO
insert into HtmlLabelIndex values(1810,'�ڳ����') 
GO
insert into HtmlLabelIndex values(1811,'���') 
GO
insert into HtmlLabelIndex values(1812,'�ڼ�,��') 
GO
insert into HtmlLabelIndex values(1813,'�ڼ�,��') 
GO
insert into HtmlLabelIndex values(1814,'��, �ڼ�') 
GO
insert into HtmlLabelIndex values(1815,'�ѵ���') 
GO
insert into HtmlLabelIndex values(1816,'����') 
GO
insert into HtmlLabelIndex values(1817,'����') 
GO
insert into HtmlLabelIndex values(1818,'����') 
GO
insert into HtmlLabelIndex values(1819,'��¼����') 
GO
insert into HtmlLabelIndex values(1820,'�跽���') 
GO
insert into HtmlLabelIndex values(1821,'�������') 
GO
insert into HtmlLabelIndex values(1822,'��¼��') 
GO
insert into HtmlLabelIndex values(1823,'����') 
GO
insert into HtmlLabelIndex values(1824,'��/�ڼ�') 
GO
insert into HtmlLabelIndex values(1825,'��:������Դ��') 
GO
insert into HtmlLabelIndex values(1826,'���(cm)') 
GO
insert into HtmlLabelIndex values(1827,'����״��') 
GO
insert into HtmlLabelIndex values(1828,'�������ڵ�') 
GO
insert into HtmlLabelIndex values(1829,'�־�ס��') 
GO
insert into HtmlLabelIndex values(1830,'Ӧ��') 
GO
insert into HtmlLabelIndex values(1831,'��ְ') 
GO
insert into HtmlLabelIndex values(1832,'��ҵ') 
GO
insert into HtmlLabelIndex values(1833,'ѧλ') 
GO
insert into HtmlLabelIndex values(1834,'��������') 
GO
insert into HtmlLabelIndex values(1835,'�뵳����') 
GO
insert into HtmlLabelIndex values(1836,'��������') 
GO
insert into HtmlLabelIndex values(1837,'������ò') 
GO
insert into HtmlLabelIndex values(1838,'֤�����') 
GO
insert into HtmlLabelIndex values(1839,'֤������') 
GO
insert into HtmlLabelIndex values(1840,'����') 
GO
insert into HtmlLabelIndex values(1841,'��ѵ������֤��') 
GO
insert into HtmlLabelIndex values(1842,'��ְ����') 
GO
insert into HtmlLabelIndex values(1843,'Ŀǰ��н') 
GO
insert into HtmlLabelIndex values(1844,'��������(��)') 
GO
insert into HtmlLabelIndex values(1845,'��н����') 
GO
insert into HtmlLabelIndex values(1846,'��������') 
GO
insert into HtmlLabelIndex values(1847,'����Ҫ��') 
GO
insert into HtmlLabelIndex values(1848,'������ҳ') 
GO
insert into HtmlLabelIndex values(1849,'�Լ���') 
GO
insert into HtmlLabelIndex values(1850,'ѧУ') 
GO
insert into HtmlLabelIndex values(1851,'��˾') 
GO
insert into HtmlLabelIndex values(1852,'����') 
GO
insert into HtmlLabelIndex values(1853,'¼��') 
GO
insert into HtmlLabelIndex values(1854,'ӦƸ�ظ�(�ʼ�)') 
GO
insert into HtmlLabelIndex values(1855,'ӦƸ����') 
GO
insert into HtmlLabelIndex values(1856,'ӦƸְλ') 
GO
insert into HtmlLabelIndex values(1857,'��������') 
GO
insert into HtmlLabelIndex values(1858,'ְλ����') 
GO
insert into HtmlLabelIndex values(1859,'����') 
GO
insert into HtmlLabelIndex values(1860,'���ѧ��') 
GO
insert into HtmlLabelIndex values(1861,'������') 
GO
insert into HtmlLabelIndex values(1862,'����ʱ��') 
GO
insert into HtmlLabelIndex values(1863,'ӦƸ') 
GO
insert into HtmlLabelIndex values(1864,'��������') 
GO
insert into HtmlLabelIndex values(1865,'ְλ����') 
GO
insert into HtmlLabelIndex values(1866,'�ù���ʽ') 
GO
insert into HtmlLabelIndex values(1867,'��Ա') 
GO
insert into HtmlLabelIndex values(1868,'��ԱҪ��') 
GO
insert into HtmlLabelIndex values(1869,'���ò�ѯ����') 
GO
insert into HtmlLabelIndex values(1870,'���Ͷ�ѧУ') 
GO
insert into HtmlLabelIndex values(1871,'����ҵ��˾') 
GO
insert into HtmlLabelIndex values(1872,'�꣬�ڼ�') 
GO
insert into HtmlLabelIndex values(1873,'ָʾ��,�ɱ�����') 
GO
insert into HtmlLabelIndex values(1874,'����, ����') 
GO
insert into HtmlLabelIndex values(1875,'�Ƚ�, �汾') 
GO
insert into HtmlLabelIndex values(1876,'��һ��') 
GO
insert into HtmlLabelIndex values(1877,'��û�м�����ϱ�׼�����ݡ�') 
GO
insert into HtmlLabelIndex values(1878,'�ֲ�����') 
GO
insert into HtmlLabelIndex values(1879,'�ֲ�����') 
GO
insert into HtmlLabelIndex values(1880,'�����ܲ�') 
GO
insert into HtmlLabelIndex values(1881,'�������') 
GO
insert into HtmlLabelIndex values(1882,'�γ�') 
GO
insert into HtmlLabelIndex values(1883,'������-ͳ�Ʊ���') 
GO
insert into HtmlLabelIndex values(1884,'��������') 
GO
insert into HtmlLabelIndex values(1885,'������') 
GO
insert into HtmlLabelIndex values(1886,'����') 
GO
insert into HtmlLabelIndex values(1887,'���֤����') 
GO
insert into HtmlLabelIndex values(1888,'������') 
GO
insert into HtmlLabelIndex values(1889,'�߼���ѯ����') 
GO
insert into HtmlLabelIndex values(1890,'����(Сʱ)') 
GO
insert into HtmlLabelIndex values(1891,'����-������Դ') 
GO
insert into HtmlLabelIndex values(1892,'�˴�') 
GO
insert into HtmlLabelIndex values(1893,'��������') 
GO
insert into HtmlLabelIndex values(1894,'����') 
GO
insert into HtmlLabelIndex values(1895,'����') 
GO
insert into HtmlLabelIndex values(1896,'����') 
GO
insert into HtmlLabelIndex values(1897,'����ԭ��') 
GO
insert into HtmlLabelIndex values(1898,'��Ҫѧ��') 
GO
insert into HtmlLabelIndex values(1899,'�ʱ�') 
GO
insert into HtmlLabelIndex values(1900,'����סַ') 
GO
insert into HtmlLabelIndex values(1901,'�������') 
GO
insert into HtmlLabelIndex values(1903,'ѧУ����') 
GO
insert into HtmlLabelIndex values(1904,'��ѧרҵ') 
GO
insert into HtmlLabelIndex values(1905,'�䷢����') 
GO
insert into HtmlLabelIndex values(1906,'��ְǰ��������') 
GO
insert into HtmlLabelIndex values(1907,'��ְ��������') 
GO
insert into HtmlLabelIndex values(1908,'��ְʱ��') 
GO
insert into HtmlLabelIndex values(1909,'ְ��') 
GO
insert into HtmlLabelIndex values(1910,'�ɾͺ�����') 
GO
insert into HtmlLabelIndex values(1911,'���ܵ����ֽ���������') 
GO
insert into HtmlLabelIndex values(1912,'��Ҫ��ͥ��Ա') 
GO
insert into HtmlLabelIndex values(1913,'�뱾�˹�ϵ') 
GO
insert into HtmlLabelIndex values(1914,'������λ') 
GO
insert into HtmlLabelIndex values(1915,'ְ��') 
GO
insert into HtmlLabelIndex values(1916,'��ϵ�绰') 
GO
insert into HtmlLabelIndex values(1917,'��˾�ڲ����ͼ�¼') 
GO
insert into HtmlLabelIndex values(1918,'н�긣������') 
GO
insert into HtmlLabelIndex values(1919,'����') 
GO
insert into HtmlLabelIndex values(1920,'�¼�') 
GO
insert into HtmlLabelIndex values(1921,'����') 
GO
insert into HtmlLabelIndex values(1922,'��ɥ��') 
GO
insert into HtmlLabelIndex values(1923,'�ݼ�') 
GO
insert into HtmlLabelIndex values(1924,'ȱ��') 
GO
insert into HtmlLabelIndex values(1925,'��') 
GO
insert into HtmlLabelIndex values(1926,'��') 
GO
insert into HtmlLabelIndex values(1927,'ͼʾ') 
GO
insert into HtmlLabelIndex values(1928,'��Ч������') 
GO
insert into HtmlLabelIndex values(1929,'��ǰ״̬') 
GO
insert into HtmlLabelIndex values(1930,'�־�ס�ص绰') 
GO
insert into HtmlLabelIndex values(1931,'�־�ס���ʱ�') 
GO
insert into HtmlLabelIndex values(1932,'ӦƸ��') 
GO
insert into HtmlLabelIndex values(1933,'����') 
GO
insert into HtmlLabelIndex values(1934,'����') 
GO
insert into HtmlLabelIndex values(1935,'������ʼ����') 
GO
insert into HtmlLabelIndex values(1936,'��ͬ��ʼʱ��') 
GO
insert into HtmlLabelIndex values(1937,'��ְ��') 
GO
insert into HtmlLabelIndex values(1938,'����Ȩ��') 
GO
insert into HtmlLabelIndex values(1939,'�������ʺ�') 
GO
insert into HtmlLabelIndex values(1940,'������ʼʱ��') 
GO
insert into HtmlLabelIndex values(1941,'֧������') 
GO
insert into HtmlLabelIndex values(1942,'��ϸ����') 
GO
insert into HtmlLabelIndex values(1943,'��ͥ��Ա') 
GO
insert into HtmlLabelIndex values(1944,'��ν') 
GO
insert into HtmlLabelIndex values(1945,'������') 
GO
insert into HtmlLabelIndex values(1946,'������') 
GO
insert into HtmlLabelIndex values(1947,'��˽����') 
GO
insert into HtmlLabelIndex values(1948,'��˽����') 
GO
insert into HtmlLabelIndex values(1949,'���ñ���') 
GO
insert into HtmlLabelIndex values(1950,'��ͨ��������') 
GO
insert into HtmlLabelIndex values(1951,'�����������') 
GO
insert into HtmlLabelIndex values(1952,'˽�˻���') 
GO
insert into HtmlLabelIndex values(1953,'˽�˽��') 
GO
insert into HtmlLabelIndex values(1954,'����') 
GO
insert into HtmlLabelIndex values(1955,'��Ŀ���') 
GO
insert into HtmlLabelIndex values(1956,'ȱ�����') 
GO
insert into HtmlLabelIndex values(1957,'�Ӱ����') 
GO
insert into HtmlLabelIndex values(1958,'��ͨ�Ӱ�') 
GO
insert into HtmlLabelIndex values(1959,'�ڼ��ռӰ�') 
GO
insert into HtmlLabelIndex values(1960,'������') 
GO
insert into HtmlLabelIndex values(1961,'�����') 
GO
insert into HtmlLabelIndex values(1962,'��������') 
GO
insert into HtmlLabelIndex values(1963,'¼��Ա') 
GO
insert into HtmlLabelIndex values(1964,'����') 
GO
insert into HtmlLabelIndex values(1966,'����,�뵳����') 
GO
insert into HtmlLabelIndex values(1967,'��ͥ��ַ') 
GO
insert into HtmlLabelIndex values(1968,'��ͥ�ʱ�') 
GO
insert into HtmlLabelIndex values(1969,'��ͥ�绰') 
GO
insert into HtmlLabelIndex values(1970,'��ͬ��ʼ����') 
GO
insert into HtmlLabelIndex values(1971,'��ѵ��ʼʱ��') 
GO
insert into HtmlLabelIndex values(1972,'��ѵ����ʱ��') 
GO
insert into HtmlLabelIndex values(1973,'ѧʱ(Сʱ)') 
GO
insert into HtmlLabelIndex values(1974,'��ѵ��λ') 
GO
insert into HtmlLabelIndex values(1975,'��˾����') 
GO
insert into HtmlLabelIndex values(1976,'��˾����') 
GO
insert into HtmlLabelIndex values(1977,'��������') 
GO
insert into HtmlLabelIndex values(1978,'��ְԭ��') 
GO
insert into HtmlLabelIndex values(1979,'δ��ʼ') 
GO
insert into HtmlLabelIndex values(1980,'�ȴ�����') 
GO
insert into HtmlLabelIndex values(1981,'�ѳ���') 
GO
insert into HtmlLabelIndex values(1982,'����') 
GO
insert into HtmlLabelIndex values(1983,'�ĵ������ƶ�') 
GO
insert into HtmlLabelIndex values(1984,'������') 
GO
insert into HtmlLabelIndex values(1985,'�ĵ�����') 
GO
insert into HtmlLabelIndex values(1986,'�½��ĵ�') 
GO
insert into HtmlLabelIndex values(1988,'��������') 
GO
insert into HtmlLabelIndex values(1989,'��������') 
GO
insert into HtmlLabelIndex values(1990,'������') 
GO
insert into HtmlLabelIndex values(1991,'��Ԫ������') 
GO
insert into HtmlLabelIndex values(1992,'�ڲ��趨') 
GO
insert into HtmlLabelIndex values(1993,'��������') 
GO
insert into HtmlLabelIndex values(1994,'�ڲ�') 
GO
insert into HtmlLabelIndex values(1995,'�ⲿ') 
GO
insert into HtmlLabelIndex values(1996,'��ʾ����') 
GO
insert into HtmlLabelIndex values(1997,'����') 
GO
insert into HtmlLabelIndex values(1999,'����ҳ�ĸ�����ʾ����.����') 
GO
insert into HtmlLabelIndex values(2000,'�ĵ�ժҪ') 
GO
insert into HtmlLabelIndex values(2001,'�ظ��ĵ���') 
GO
insert into HtmlLabelIndex values(2002,'������') 
GO
insert into HtmlLabelIndex values(2003,'�ĵ�����Ϊ') 
GO
insert into HtmlLabelIndex values(2004,'���зǻظ�') 
GO
insert into HtmlLabelIndex values(2005,'�ؽ���') 
GO
insert into HtmlLabelIndex values(2006,'��ʾ�ظ�����') 
GO
insert into HtmlLabelIndex values(2007,'��ʾ��������') 
GO
insert into HtmlLabelIndex values(2008,'Ĭ���ĵ���ʾģ��') 
GO
insert into HtmlLabelIndex values(2009,'����ҳ�ĵ�') 
GO
insert into HtmlLabelIndex values(2010,'����ҳ����') 
GO
insert into HtmlLabelIndex values(2011,'û��Ȩ��') 
GO
insert into HtmlLabelIndex values(2012,'��û�з��ʵ�ǰҳ���Ȩ��') 
GO
insert into HtmlLabelIndex values(2013,'�뷵�ػ��߽��벻ͬ��ҳ��') 
GO
insert into HtmlLabelIndex values(2014,'�ܼ�: ��Ŀ') 
GO
insert into HtmlLabelIndex values(2015,'�ܼ�: �ʲ�') 
GO
insert into HtmlLabelIndex values(2016,'������Դ: ʵ��') 
GO
insert into HtmlLabelIndex values(2017,'��֯ͼ��:�ɱ�����') 
GO
insert into HtmlLabelIndex values(2018,'�ܼ�: �ͻ�') 
GO
insert into HtmlLabelIndex values(2019,'�ܼ�') 
GO
insert into HtmlLabelIndex values(2020,'ʣ���ܼ�') 
GO
insert into HtmlLabelIndex values(2021,'�ܼ�: �ĵ�') 
GO
insert into HtmlLabelIndex values(2022,'����') 
GO
insert into HtmlLabelIndex values(2023,'��¼��Ϣ') 
GO
insert into HtmlLabelIndex values(2024,'�ʺ�') 
GO
insert into HtmlLabelIndex values(2025,'��������') 
GO
insert into HtmlLabelIndex values(2026,'��') 
GO
insert into HtmlLabelIndex values(2027,'>�ʼ��û����Ѵ��ڣ���������������') 
GO
insert into HtmlLabelIndex values(2028,'�û��Ѵ����ʼ��û��飬����ѡ���û���') 
GO
insert into HtmlLabelIndex values(2029,'�½��ʼ�') 
GO
insert into HtmlLabelIndex values(2030,'ɾ���ʼ�') 
GO
insert into HtmlLabelIndex values(2031,'����ɾ��') 
GO
insert into HtmlLabelIndex values(2032,'�ʼ��˵�') 
GO
insert into HtmlLabelIndex values(2033,'�ʼ���') 
GO
insert into HtmlLabelIndex values(2034,'������') 
GO
insert into HtmlLabelIndex values(2035,'����ʱ��') 
GO
insert into HtmlLabelIndex values(2036,'��С') 
GO
insert into HtmlLabelIndex values(2037,'�����ʼ�') 
GO
insert into HtmlLabelIndex values(2038,'������') 
GO
insert into HtmlLabelIndex values(2039,'�ݸ���') 
GO
insert into HtmlLabelIndex values(2040,'������') 
GO
insert into HtmlLabelIndex values(2042,'�����ʼ���') 
GO
insert into HtmlLabelIndex values(2043,'�ʼ���') 
GO
insert into HtmlLabelIndex values(2044,'�ʼ����ͳɹ�') 
GO
insert into HtmlLabelIndex values(2045,'�ʼ�����ʧ��') 
GO
insert into HtmlLabelIndex values(2046,'�ռ���') 
GO
insert into HtmlLabelIndex values(2047,'��������') 
GO
insert into HtmlLabelIndex values(2048,'����������') 
GO
insert into HtmlLabelIndex values(2049,'�����ݸ���') 
GO
insert into HtmlLabelIndex values(2050,'��������') 
GO
insert into HtmlLabelIndex values(2051,'�����ʼ�') 
GO
insert into HtmlLabelIndex values(2052,'ת���ʼ�') 
GO
insert into HtmlLabelIndex values(2053,'�ظ�ȫ��') 
GO
insert into HtmlLabelIndex values(2054,'�ظ��ʼ�') 
GO
insert into HtmlLabelIndex values(2056,'�ƶ�������') 
GO
insert into HtmlLabelIndex values(2057,'���Ƶ�����') 
GO
insert into HtmlLabelIndex values(2058,'�ʼ�������') 
GO
insert into HtmlLabelIndex values(2059,'��¼��־') 
GO
insert into HtmlLabelIndex values(2060,'������') 
GO
insert into HtmlLabelIndex values(2061,'��־����') 
GO
insert into HtmlLabelIndex values(2062,'�ͻ���ϵ�ƻ�') 
GO
insert into HtmlLabelIndex values(2063,'�µĹ���������:��') 
GO
insert into HtmlLabelIndex values(2064,'�µĹ���������:����������') 
GO
insert into HtmlLabelIndex values(2065,'�µĹ���������:����') 
GO
insert into HtmlLabelIndex values(2066,'���������') 
GO
insert into HtmlLabelIndex values(2067,'���������(������)') 
GO
insert into HtmlLabelIndex values(2068,'�ڵ㳬ʱ') 
GO
insert into HtmlLabelIndex values(2069,'�����ĵ�') 
GO
insert into HtmlLabelIndex values(2070,'�����ĵ�') 
GO
insert into HtmlLabelIndex values(2071,'���ݿ������') 
GO
insert into HtmlLabelIndex values(2072,'�û���') 
GO
insert into HtmlLabelIndex values(2073,'����') 
GO
insert into HtmlLabelIndex values(2074,'��������') 
GO
insert into HtmlLabelIndex values(2075,'�ƶ��ٶ�') 
GO
insert into HtmlLabelIndex values(2076,'������ɫ') 
GO
insert into HtmlLabelIndex values(2077,'������ɫ') 
GO
insert into HtmlLabelIndex values(2078,'������ʱ��') 
GO
insert into HtmlLabelIndex values(2079,'����������') 
GO
insert into HtmlLabelIndex values(2080,'�������') 
GO
insert into HtmlLabelIndex values(2081,'�ղؼ�') 
GO
insert into HtmlLabelIndex values(2082,'����ʱ��') 
GO
insert into HtmlLabelIndex values(2083,'����') 
GO
insert into HtmlLabelIndex values(2084,'����') 
GO
insert into HtmlLabelIndex values(2085,'����') 
GO
insert into HtmlLabelIndex values(2086,'��ͨ') 
GO
insert into HtmlLabelIndex values(2087,'����') 
GO
insert into HtmlLabelIndex values(2088,'����Ҫ') 
GO
insert into HtmlLabelIndex values(2089,'���ռ������ö��ŷָ�') 
GO
insert into HtmlLabelIndex values(2090,'�೭�������ö��ŷָ�') 
GO
insert into HtmlLabelIndex values(2091,'�����������ö��ŷָ�') 
GO
insert into HtmlLabelIndex values(2092,'���浽������') 
GO
insert into HtmlLabelIndex values(2093,'���ȼ���') 
GO
insert into HtmlLabelIndex values(2094,'�ĵ�������') 
GO
insert into HtmlLabelIndex values(2095,'���I��') 
GO
insert into HtmlLabelIndex values(2096,'��������') 
GO
insert into HtmlLabelIndex values(2097,'������') 
GO
insert into HtmlLabelIndex values(2098,'������') 
GO
insert into HtmlLabelIndex values(2099,'����չ��') 
GO
insert into HtmlLabelIndex values(2100,'����Ϊ�ƻ�') 
GO
insert into HtmlLabelIndex values(2101,'�ҵļƻ�') 
GO
insert into HtmlLabelIndex values(2102,'�ҵĻ���') 
GO
insert into HtmlLabelIndex values(2103,'����') 
GO
insert into HtmlLabelIndex values(2104,'��������') 
GO
insert into HtmlLabelIndex values(2105,'����ص�') 
GO
insert into HtmlLabelIndex values(2106,'�λ���Ա') 
GO
insert into HtmlLabelIndex values(2107,'�������') 
GO
insert into HtmlLabelIndex values(2108,'��ִ') 
GO
insert into HtmlLabelIndex values(2109,'��¼��') 
GO
insert into HtmlLabelIndex values(2110,'��ǰҳ��') 
GO
insert into HtmlLabelIndex values(2111,'���м�¼') 
GO
insert into HtmlLabelIndex values(2112,'��������') 
GO
insert into HtmlLabelIndex values(2113,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(2114,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(2115,'֪ʶ����') 
GO
insert into HtmlLabelIndex values(2116,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(2117,'�������') 
GO
insert into HtmlLabelIndex values(2118,'��������') 
GO
insert into HtmlLabelIndex values(2119,'��ʿ��') 
GO
insert into HtmlLabelIndex values(2120,'ֱ����˾') 
GO
insert into HtmlLabelIndex values(2121,'��ϸ��Ϣ') 
GO
insert into HtmlLabelIndex values(2151,'��������') 
GO
insert into HtmlLabelIndex values(2152,'�ټ���') 
GO
insert into HtmlLabelIndex values(2153,'��׼��') 
GO
insert into HtmlLabelIndex values(2154,'�����ص�') 
GO
insert into HtmlLabelIndex values(2155,'��������') 
GO
insert into HtmlLabelIndex values(2156,'������Ա') 
GO
insert into HtmlLabelIndex values(2157,'������Ŀ') 
GO
insert into HtmlLabelIndex values(2158,'���������Ŀ֮������Ӣ�Ķ���,�ָ�') 
GO
insert into HtmlLabelIndex values(2159,'�ָ�') 
GO
insert into HtmlLabelIndex values(2160,'�����ִ') 
GO
insert into HtmlLabelIndex values(2161,'����') 
GO
insert into HtmlLabelIndex values(2162,'��������') 
GO
insert into HtmlLabelIndex values(2163,'�������') 
GO
insert into HtmlLabelIndex values(2164,'С������') 
GO
insert into HtmlLabelIndex values(2165,'�鿴������ʹ��״��') 
GO
insert into HtmlLabelIndex values(2166,'Ӧ������') 
GO
insert into HtmlLabelIndex values(2167,'�λ�ͻ�') 
GO
insert into HtmlLabelIndex values(2168,'������Ա') 
GO
insert into HtmlLabelIndex values(2169,'���') 
GO
insert into HtmlLabelIndex values(2170,'�������') 
GO
insert into HtmlLabelIndex values(2171,'����') 
GO
insert into HtmlLabelIndex values(2172,'ִ����') 
GO
insert into HtmlLabelIndex values(2173,'�����') 
GO
insert into HtmlLabelIndex values(2174,'ͷ�Ȳ�') 
GO
insert into HtmlLabelIndex values(2175,'�����') 
GO
insert into HtmlLabelIndex values(2176,'���ò�') 
GO
insert into HtmlLabelIndex values(2177,'����') 
GO
insert into HtmlLabelIndex values(2178,'Ӳ��') 
GO
insert into HtmlLabelIndex values(2179,'Ӳ��') 
GO
insert into HtmlLabelIndex values(2180,'�ɻ�') 
GO
insert into HtmlLabelIndex values(2181,'��') 
GO
insert into HtmlLabelIndex values(2182,'��ͨ����') 
GO
insert into HtmlLabelIndex values(2183,'�س�����.ʱ��') 
GO
insert into HtmlLabelIndex values(2184,'�Ƿ��趩�س�Ʊ') 
GO
insert into HtmlLabelIndex values(2185,'�Ƿ��趩��(��׼)') 
GO
insert into HtmlLabelIndex values(2186,'Ԥ�Ƶ�������.ʱ��') 
GO
insert into HtmlLabelIndex values(2187,'�Ƿ�μ�') 
GO
insert into HtmlLabelIndex values(2188,'�����˲μ�') 
GO
insert into HtmlLabelIndex values(2189,'�����λ���Ա') 
GO
insert into HtmlLabelIndex values(2190,'�������') 
GO
insert into HtmlLabelIndex values(2191,'����') 
GO
insert into HtmlLabelIndex values(2192,'�ճ̰���') 
GO
insert into HtmlLabelIndex values(2193,'�鿴������ʹ�����') 
GO
insert into HtmlLabelIndex values(2194,'�������') 
GO
insert into HtmlLabelIndex values(2195,'�μ�') 
GO
insert into HtmlLabelIndex values(2196,'����ʱ��') 
GO
insert into HtmlLabelIndex values(2197,'����') 
GO
insert into HtmlLabelIndex values(2198,'������׼') 
GO
insert into HtmlLabelIndex values(2199,'���س�Ʊ') 
GO
insert into HtmlLabelIndex values(2200,'�س�ʱ��') 
GO
insert into HtmlLabelIndex values(2201,'�ɻ�ͷ�Ȳ�') 
GO
insert into HtmlLabelIndex values(2202,'�ɻ������') 
GO
insert into HtmlLabelIndex values(2203,'�ɻ����ò�') 
GO
insert into HtmlLabelIndex values(2204,'������') 
GO
insert into HtmlLabelIndex values(2205,'��Ӳ��') 
GO
insert into HtmlLabelIndex values(2206,'��Ӳ��') 
GO
insert into HtmlLabelIndex values(2207,'��ȷ���λ���Ա�ܼ�') 
GO
insert into HtmlLabelIndex values(2208,'���й�˾Ա��') 
GO
insert into HtmlLabelIndex values(2209,'�ⲿ��Ա') 
GO
insert into HtmlLabelIndex values(2210,'����') 
GO
insert into HtmlLabelIndex values(2211,'�ճ�') 
GO
insert into HtmlLabelIndex values(2212,'����') 
GO
insert into HtmlLabelIndex values(2213,'��ʵ��') 
GO
insert into HtmlLabelIndex values(2214,'��������˰˰�ʱ�') 
GO
insert into HtmlLabelIndex values(2215,'���շ���') 
GO
insert into HtmlLabelIndex values(2216,'��׼�ȼ�') 
GO
insert into HtmlLabelIndex values(2217,'������Ŀ��') 
GO
insert into HtmlLabelIndex values(2218,'���˹�������') 
GO
insert into HtmlLabelIndex values(2219,'���˹��ʱ䶯��ʷ��¼') 
GO
insert into HtmlLabelIndex values(2220,'���ŷ���') 
GO
insert into HtmlLabelIndex values(2221,'���ŷ������') 
GO
insert into HtmlLabelIndex values(2222,'���ŷ�������û��Ա����ͳ��') 
GO
insert into HtmlLabelIndex values(2223,'���ŷ������ϵͳ���Ͷ���ͳ��') 
GO
insert into HtmlLabelIndex values(2224,'����ְԱ��') 
GO
insert into HtmlLabelIndex values(2225,'��ְ��Ŀ��') 
GO
insert into HtmlLabelIndex values(2226,'����ְԱ����Ŀ����') 
GO
insert into HtmlLabelIndex values(2227,'���ۻ���') 
GO
insert into HtmlLabelIndex values(2228,'��Ŀ״̬������') 
GO
insert into HtmlLabelIndex values(2229,'��Ŀ״̬������') 
GO
insert into HtmlLabelIndex values(2230,'��Ŀ״̬�����') 
GO
insert into HtmlLabelIndex values(2231,'��Ŀ״̬������') 
GO
insert into HtmlLabelIndex values(2232,'��̱�����') 
GO
insert into HtmlLabelIndex values(2233,'ǰ������') 
GO
insert into HtmlLabelIndex values(2234,'��������״̬') 
GO
insert into HtmlLabelIndex values(2235,'δ��׼') 
GO
insert into HtmlLabelIndex values(2236,'�Ѿ�����') 
GO
insert into HtmlLabelIndex values(2237,'����ͼ��') 
GO
insert into HtmlLabelIndex values(2238,'������/�ĵ�') 
GO
insert into HtmlLabelIndex values(2239,'�������') 
GO
insert into HtmlLabelIndex values(2240,'����˵��') 
GO
insert into HtmlLabelIndex values(2241,'ȫ��ѡ��') 
GO
insert into HtmlLabelIndex values(2242,'������') 
GO
insert into HtmlLabelIndex values(2243,'������׼') 
GO
insert into HtmlLabelIndex values(2244,'����') 
GO
insert into HtmlLabelIndex values(2245,'��Ч') 
GO
insert into HtmlLabelIndex values(2246,'��Ч') 
GO
insert into HtmlLabelIndex values(2247,'����Ԥ��') 
GO
insert into HtmlLabelIndex values(2248,'Ԥ������') 
GO
insert into HtmlLabelIndex values(2249,'������') 
GO
insert into HtmlLabelIndex values(2250,'����״̬') 
GO
insert into HtmlLabelIndex values(2251,'�鿴����ؽ���') 
GO
insert into HtmlLabelIndex values(2252,'�ɹ��ؼ�����') 
GO
insert into HtmlLabelIndex values(2253,'ʧ�ܹؼ�����') 
GO
insert into HtmlLabelIndex values(3000,'�鵵����') 
GO
insert into HtmlLabelIndex values(3001,'���������') 
GO
insert into HtmlLabelIndex values(3002,'����޸���') 
GO
insert into HtmlLabelIndex values(3003,'�鵵��') 
GO
insert into HtmlLabelIndex values(3004,'�ĵ�������������') 
GO
insert into HtmlLabelIndex values(3005,'������') 
GO
insert into HtmlLabelIndex values(5000,'����Ԥ��') 
GO
insert into HtmlLabelIndex values(5001,'�¶�') 
GO
insert into HtmlLabelIndex values(6001,'��һ��') 
GO
insert into HtmlLabelIndex values(6002,'��ʾ��Ŀ') 
GO
insert into HtmlLabelIndex values(6003,'����������') 
GO
insert into HtmlLabelIndex values(6004,'���µ�֪ͨ���淢��') 
GO
insert into HtmlLabelIndex values(6005,'�ֻ�����') 
GO
insert into HtmlLabelIndex values(6006,'�����µĹ��淢��') 
GO
insert into HtmlLabelIndex values(6007,'�µĹ���') 
GO
insert into HtmlLabelIndex values(6008,'����') 
GO
insert into HtmlLabelIndex values(6009,'���۽���') 
GO
insert into HtmlLabelIndex values(6010,'������') 
GO
insert into HtmlLabelIndex values(6011,'ת��') 
GO
insert into HtmlLabelIndex values(6012,'�Ƿ��跨�ɲ����') 
GO
insert into HtmlLabelIndex values(6013,'�ܲ�') 
GO
insert into HtmlLabelIndex values(6014,'������ʽ') 
GO
insert into HtmlLabelIndex values(6015,'�ҵı���') 
GO
insert into HtmlLabelIndex values(6016,'ʵ�����') 
GO
insert into HtmlLabelIndex values(6050,'�ʲ��������') 
GO
insert into HtmlLabelIndex values(6051,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(6052,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(6053,'�ʲ�ά��') 
GO
insert into HtmlLabelIndex values(6054,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(6055,'�ʲ����') 
GO
insert into HtmlLabelIndex values(6056,'ԭֵ') 
GO
insert into HtmlLabelIndex values(6057,'���չ���') 
GO
insert into HtmlLabelIndex values(6058,'�鿴�����Ĺ�������') 
GO
insert into HtmlLabelIndex values(6059,'�ҵĿͻ�') 
GO
insert into HtmlLabelIndex values(6060,'�鿴�����Ŀͻ�') 
GO
insert into HtmlLabelIndex values(6061,'�ͻ���ϵ����') 
GO
insert into HtmlLabelIndex values(6062,'��ҳ����') 
GO
insert into HtmlLabelIndex values(6063,'����->��Ч�ͻ�') 
GO
insert into HtmlLabelIndex values(6064,'����->�����ͻ�') 
GO
insert into HtmlLabelIndex values(6066,'��Ȥ') 
GO
insert into HtmlLabelIndex values(6067,'����') 
GO
insert into HtmlLabelIndex values(6068,'ר��') 
GO
insert into HtmlLabelIndex values(6069,'��������') 
GO
insert into HtmlLabelIndex values(6070,'�ͻ���ֵ����') 
GO
insert into HtmlLabelIndex values(6071,'Ȩ��') 
GO
insert into HtmlLabelIndex values(6072,'���') 
GO
insert into HtmlLabelIndex values(6073,'�ͻ���ֵ') 
GO
insert into HtmlLabelIndex values(6074,'��') 
GO
insert into HtmlLabelIndex values(6076,'��') 
GO
insert into HtmlLabelIndex values(6077,'��ǰʱ��') 
GO
insert into HtmlLabelIndex values(6078,'�Ƿ�����') 
GO
insert into HtmlLabelIndex values(6079,'�ͻ��ػ�') 
GO
insert into HtmlLabelIndex values(6080,'�ͻ�Ͷ��') 
GO
insert into HtmlLabelIndex values(6081,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(6082,'�ͻ���ϵ') 
GO
insert into HtmlLabelIndex values(6083,'��ͬ����') 
GO
insert into HtmlLabelIndex values(6084,'�ֳɱ�����') 
GO
insert into HtmlLabelIndex values(6086,'��λ') 
GO
insert into HtmlLabelIndex values(6087,'����') 
GO
insert into HtmlLabelIndex values(6088,'ת��') 
GO
insert into HtmlLabelIndex values(6089,'��ǩ') 
GO
insert into HtmlLabelIndex values(6090,'����') 
GO
insert into HtmlLabelIndex values(6091,'��ְ') 
GO
insert into HtmlLabelIndex values(6092,'����') 
GO
insert into HtmlLabelIndex values(6093,'��Ƹ') 
GO
insert into HtmlLabelIndex values(6094,'��Ƹ') 
GO
insert into HtmlLabelIndex values(6095,'ǩ��') 
GO
insert into HtmlLabelIndex values(6096,'�ܳɱ�����') 
GO
insert into HtmlLabelIndex values(6097,'���ö��') 
GO
insert into HtmlLabelIndex values(6098,'�����ڼ�') 
GO
insert into HtmlLabelIndex values(6099,'��������') 
GO
insert into HtmlLabelIndex values(6100,'���͹���') 
GO
insert into HtmlLabelIndex values(6101,'�滮') 
GO
insert into HtmlLabelIndex values(6102,'����') 
GO
insert into HtmlLabelIndex values(6103,'����') 
GO
insert into HtmlLabelIndex values(6104,'������Χ') 
GO
insert into HtmlLabelIndex values(6105,'��Դ') 
GO
insert into HtmlLabelIndex values(6106,'����') 
GO
insert into HtmlLabelIndex values(6107,'��������') 
GO
insert into HtmlLabelIndex values(6109,'��������') 
GO
insert into HtmlLabelIndex values(6110,'ְλ����') 
GO
insert into HtmlLabelIndex values(6111,'��������') 
GO
insert into HtmlLabelIndex values(6112,'ԭ��λ') 
GO
insert into HtmlLabelIndex values(6113,'�¸�λ') 
GO
insert into HtmlLabelIndex values(6114,'ԭְ��') 
GO
insert into HtmlLabelIndex values(6115,'��ְ��') 
GO
insert into HtmlLabelIndex values(6116,'����ԭ��') 
GO
insert into HtmlLabelIndex values(6119,'��ְ����') 
GO
insert into HtmlLabelIndex values(6120,'��ְ��ͬ') 
GO
insert into HtmlLabelIndex values(6121,'ת������') 
GO
insert into HtmlLabelIndex values(6122,'ת������') 
GO
insert into HtmlLabelIndex values(6123,'ת����ע') 
GO
insert into HtmlLabelIndex values(6124,'����ʵʩ') 
GO
insert into HtmlLabelIndex values(6125,'���˱���') 
GO
insert into HtmlLabelIndex values(6126,'ʵ���ܽ��') 
GO
insert into HtmlLabelIndex values(6128,'��ѵ�滮') 
GO
insert into HtmlLabelIndex values(6130,'��ѵ����') 
GO
insert into HtmlLabelIndex values(6131,'�ù�����') 
GO
insert into HtmlLabelIndex values(6132,'��Ƹ�ƻ�') 
GO
insert into HtmlLabelIndex values(6133,'��Ƹ����') 
GO
insert into HtmlLabelIndex values(6134,'����') 
GO
insert into HtmlLabelIndex values(6135,'������Ϣ') 
GO
insert into HtmlLabelIndex values(6136,'��ѵ�') 
GO
insert into HtmlLabelIndex values(6137,'��ְά��') 
GO
insert into HtmlLabelIndex values(6138,'����ά��') 
GO
insert into HtmlLabelIndex values(6139,'��������') 
GO
insert into HtmlLabelIndex values(6140,'������Դ����') 
GO
insert into HtmlLabelIndex values(6150,'��������') 
GO
insert into HtmlLabelIndex values(6151,'�Ӱ�') 
GO
insert into HtmlLabelIndex values(6152,'����') 
GO
insert into HtmlLabelIndex values(6153,'��λʱ��') 
GO
insert into HtmlLabelIndex values(6155,'��ѵ����') 
GO
insert into HtmlLabelIndex values(6156,'��ѵ����') 
GO
insert into HtmlLabelIndex values(6157,'�Ƿ��������û�׼����') 
GO
insert into HtmlLabelIndex values(6158,'��ͬ����') 
GO
insert into HtmlLabelIndex values(6159,'�Ӱ�����') 
GO
insert into HtmlLabelIndex values(6160,'ҵ���ͬ') 
GO
insert into HtmlLabelIndex values(6161,'��غ�ͬ') 
GO
insert into HtmlLabelIndex values(6162,'��ͬ�ĵ�') 
GO
insert into HtmlLabelIndex values(6163,'���ĵ�') 
GO
insert into HtmlLabelIndex values(6164,'��ǩ��') 
GO
insert into HtmlLabelIndex values(6165,'���ø���') 
GO
insert into HtmlLabelIndex values(6117,'������Ŀ') 
GO
insert into HtmlLabelIndex values(6118,'��������') 
GO
insert into HtmlLabelIndex values(7172,'���ͱ���') 
GO
insert into HtmlLabelIndex values(7173,'������Աͳ��') 
GO
insert into HtmlLabelIndex values(7174,'��������ͼ') 
GO
insert into HtmlLabelIndex values(7171,'��΢�������') 
GO
insert into HtmlLabelIndex values(7175,'���ţ���ȫ����') 
GO
insert into HtmlLabelIndex values(7176,'��ɫ����ȫ���𣫼���') 
GO
insert into HtmlLabelIndex values(7178,'�û����ͣ���ȫ����') 
GO
insert into HtmlLabelIndex values(7179,'�û�����') 
GO
insert into HtmlLabelIndex values(7180,'��ʱ��') 
GO
insert into HtmlLabelIndex values(7181,'�ⲿϵͳ�û�') 
GO
insert into HtmlLabelIndex values(6141,'���벿��') 
GO
insert into HtmlLabelIndex values(6146,'��ͬ���') 
GO
insert into HtmlLabelIndex values(6141,'���벿��') 
GO
insert into HtmlLabelIndex values(6146,'��ͬ���') 
GO
insert into HtmlLabelIndex values(6166,'��ز�Ʒ') 
GO
insert into HtmlLabelIndex values(6166,'��ز�Ʒ') 
GO
insert into HtmlLabelIndex values(6167,'�¹����ܽ���ƻ�') 
GO
insert into HtmlLabelIndex values(16356,'��������') 
GO
insert into HtmlLabelIndex values(16357,'�ĵ�: ������') 
GO
insert into HtmlLabelIndex values(16358,'�ĵ�: ����') 
GO
insert into HtmlLabelIndex values(16359,'�ĵ�: �Ķ�') 
GO
insert into HtmlLabelIndex values(16360,'��� 50: ���Ķ�') 
GO
insert into HtmlLabelIndex values(16361,'��� 20: ������') 
GO
insert into HtmlLabelIndex values(16362,'��� 20: ����') 
GO
insert into HtmlLabelIndex values(16363,'��� 20: CRM') 
GO
insert into HtmlLabelIndex values(16364,'��� 20: ������Դ') 
GO
insert into HtmlLabelIndex values(16365,'��� 20: ��Ŀ') 
GO
insert into HtmlLabelIndex values(16366,'��� 20: ����') 
GO
insert into HtmlLabelIndex values(16367,'ģ������') 
GO
insert into HtmlLabelIndex values(16368,'����ҳ����') 
GO
insert into HtmlLabelIndex values(16369,'�ĵ��༭ģ��') 
GO
insert into HtmlLabelIndex values(16370,'�ĵ���ʾģ��') 
GO
insert into HtmlLabelIndex values(16371,'��������') 
GO
insert into HtmlLabelIndex values(16372,'��������') 
GO
insert into HtmlLabelIndex values(16373,'��������') 
GO
insert into HtmlLabelIndex values(16374,'���� - ����') 
GO
insert into HtmlLabelIndex values(16375,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(16376,'�ͻ���ֵ������׼') 
GO
insert into HtmlLabelIndex values(16377,'�ͻ���ֵ������Ŀ') 
GO
insert into HtmlLabelIndex values(16378,'������Ϣ') 
GO
insert into HtmlLabelIndex values(16379,'Ȩ��ת��') 
GO
insert into HtmlLabelIndex values(16380,'�����˵�') 
GO
insert into HtmlLabelIndex values(16381,'�򿪱����ļ�') 
GO
insert into HtmlLabelIndex values(16382,'��Ϊ�����ļ�') 
GO
insert into HtmlLabelIndex values(16383,'ǩ��ӡ��') 
GO
insert into HtmlLabelIndex values(16384,'�򿪰汾') 
GO
insert into HtmlLabelIndex values(16385,'��ʾ/���غۼ�') 
GO
insert into HtmlLabelIndex values(16386,'��Ϊ�°汾') 
GO
insert into HtmlLabelIndex values(16387,'�½�ǩ��') 
GO
insert into HtmlLabelIndex values(16388,'�½�ģ��') 
GO
insert into HtmlLabelIndex values(15000,'�ⲿϵͳ�ӿ�') 
GO
insert into HtmlLabelIndex values(15001,'������') 
GO
insert into HtmlLabelIndex values(16390,'��������') 
GO
insert into HtmlLabelIndex values(16391,'�ҵ�����') 
GO
insert into HtmlLabelIndex values(16393,'��ѯ����') 
GO
insert into HtmlLabelIndex values(16396,'����֪ʶ') 
GO
insert into HtmlLabelIndex values(16397,'�����ĵ�') 
GO
insert into HtmlLabelIndex values(16398,'�ĵ�Ŀ¼') 
GO
insert into HtmlLabelIndex values(16399,'��ѯ�ĵ�') 
GO
insert into HtmlLabelIndex values(16403,'��ϵ����') 
GO
insert into HtmlLabelIndex values(16405,'��ϵ���') 
GO
insert into HtmlLabelIndex values(16407,'��ѯ�ͻ�') 
GO
insert into HtmlLabelIndex values(16409,'������Ŀ') 
GO
insert into HtmlLabelIndex values(16410,'��������') 
GO
insert into HtmlLabelIndex values(16412,'��������') 
GO
insert into HtmlLabelIndex values(16419,'��������') 
GO
insert into HtmlLabelIndex values(16423,'�����ұ���') 
GO
insert into HtmlLabelIndex values(16424,'��ѯ����') 
GO
insert into HtmlLabelIndex values(16425,'��ѯ�ʲ�') 
GO
insert into HtmlLabelIndex values(16426,'�½��ƻ�') 
GO
insert into HtmlLabelIndex values(16427,'��ѯ�ƻ�') 
GO
insert into HtmlLabelIndex values(16428,'�ҵ��ձ�') 
GO
insert into HtmlLabelIndex values(16429,'�ҵ��ܱ�') 
GO
insert into HtmlLabelIndex values(16431,'�ҵļ���') 
GO
insert into HtmlLabelIndex values(16432,'�ҵ��걨') 
GO
insert into HtmlLabelIndex values(16433,'��̬����') 
GO
insert into HtmlLabelIndex values(16434,'��Ч����') 
GO
insert into HtmlLabelIndex values(16437,'�ݸ�����') 
GO
insert into HtmlLabelIndex values(16438,'��������') 
GO
insert into HtmlLabelIndex values(16439,'��������') 
GO
insert into HtmlLabelIndex values(16446,'�汾����') 
GO
insert into HtmlLabelIndex values(16447,'Ŀ¼����') 
GO
insert into HtmlLabelIndex values(16448,'ģ������') 
GO
insert into HtmlLabelIndex values(16449,'�༭ģ��') 
GO
insert into HtmlLabelIndex values(16452,'�û�����') 
GO
insert into HtmlLabelIndex values(16453,'�����ƶ�') 
GO
insert into HtmlLabelIndex values(16454,'��΢���') 
GO
insert into HtmlLabelIndex values(16461,'��λ����') 
GO
insert into HtmlLabelIndex values(16463,'רҵ����') 
GO
insert into HtmlLabelIndex values(16465,'��Ա��ְ') 
GO
insert into HtmlLabelIndex values(16466,'��Աת��') 
GO
insert into HtmlLabelIndex values(16468,'��Ա����') 
GO
insert into HtmlLabelIndex values(16470,'��Ա����') 
GO
insert into HtmlLabelIndex values(16471,'��Ա��Ƹ') 
GO
insert into HtmlLabelIndex values(16472,'��Ա��Ƹ') 
GO
insert into HtmlLabelIndex values(16473,'ǩ������') 
GO
insert into HtmlLabelIndex values(16474,'��������') 
GO
insert into HtmlLabelIndex values(16475,'��˾ʱ��') 
GO
insert into HtmlLabelIndex values(16476,'����ʱ��') 
GO
insert into HtmlLabelIndex values(16477,'��Աʱ��') 
GO
insert into HtmlLabelIndex values(16479,'��ͬģ��') 
GO
insert into HtmlLabelIndex values(16480,'���ʸ���') 
GO
insert into HtmlLabelIndex values(16482,'��������') 
GO
insert into HtmlLabelIndex values(16490,'��������') 
GO
insert into HtmlLabelIndex values(16491,'��ҵ����') 
GO
insert into HtmlLabelIndex values(16492,'��ģ����') 
GO
insert into HtmlLabelIndex values(16493,'�������') 
GO
insert into HtmlLabelIndex values(16494,'��������') 
GO
insert into HtmlLabelIndex values(16495,'״̬����') 
GO
insert into HtmlLabelIndex values(16497,'������Ŀ') 
GO
insert into HtmlLabelIndex values(16501,'��ͬ����') 
GO
insert into HtmlLabelIndex values(16502,'����ڼ�') 
GO
insert into HtmlLabelIndex values(16503,'�ֶζ���') 
GO
insert into HtmlLabelIndex values(16504,'�ڼ�����') 
GO
insert into HtmlLabelIndex values(16506,'��������') 
GO
insert into HtmlLabelIndex values(16508,'���Ͷ���') 
GO
insert into HtmlLabelIndex values(16509,'�½�����') 
GO
insert into HtmlLabelIndex values(16510,'��������') 
GO
insert into HtmlLabelIndex values(16511,'��λ����') 
GO
insert into HtmlLabelIndex values(16512,'��Ʒ����') 
GO
insert into HtmlLabelIndex values(16521,'�û�����') 
GO
insert into HtmlLabelIndex values(16523,'ʡ������') 
GO
insert into HtmlLabelIndex values(16529,'�ʼ����ļ�') 
GO
insert into HtmlLabelIndex values(16530,'���±���') 
GO
insert into HtmlLabelIndex values(16535,'�ʲ�����') 
GO
insert into HtmlLabelIndex values(16537,'ͨѶ¼��') 
GO
insert into HtmlLabelIndex values(16538,'ͳ�Ʊ���') 
GO
insert into HtmlLabelIndex values(16539,'�ƻ�����') 
GO
insert into HtmlLabelIndex values(16540,'��������') 
GO
insert into HtmlLabelIndex values(16541,'����ͳ��') 
GO
insert into HtmlLabelIndex values(16542,'���̱���') 
GO
insert into HtmlLabelIndex values(16546,'ְ������') 
GO
insert into HtmlLabelIndex values(16550,'ѧ������') 
GO
insert into HtmlLabelIndex values(16551,'���ű���') 
GO
insert into HtmlLabelIndex values(16552,'��λ����') 
GO
insert into HtmlLabelIndex values(16553,'ְ�񱨱�') 
GO
insert into HtmlLabelIndex values(16554,'ְ�Ʊ���') 
GO
insert into HtmlLabelIndex values(16555,'״̬����') 
GO
insert into HtmlLabelIndex values(16556,'��ѵ���') 
GO
insert into HtmlLabelIndex values(16559,'���ڱ���') 
GO
insert into HtmlLabelIndex values(16560,'н��ͳ��') 
GO
insert into HtmlLabelIndex values(16561,'���ʲ���') 
GO
insert into HtmlLabelIndex values(16564,'�������') 
GO
insert into HtmlLabelIndex values(16565,'�������') 
GO
insert into HtmlLabelIndex values(16568,'��Ƹ���') 
GO
insert into HtmlLabelIndex values(16569,'�������') 
GO
insert into HtmlLabelIndex values(16570,'��ְ���') 
GO
insert into HtmlLabelIndex values(16571,'��Ƹ���') 
GO
insert into HtmlLabelIndex values(16572,'��ͬ���') 
GO
insert into HtmlLabelIndex values(16573,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(16575,'�����޸�') 
GO
insert into HtmlLabelIndex values(16576,'���ڶ�ȡ') 
GO
insert into HtmlLabelIndex values(16577,'δ������') 
GO
insert into HtmlLabelIndex values(16579,'��������') 
GO
insert into HtmlLabelIndex values(16583,'�ͻ���ҵ') 
GO
insert into HtmlLabelIndex values(16584,'�������') 
GO
insert into HtmlLabelIndex values(16585,'�����б�') 
GO
insert into HtmlLabelIndex values(16588,'Ӧ��Ӧ��') 
GO
insert into HtmlLabelIndex values(16589,'��ͬ��Ʒ') 
GO
insert into HtmlLabelIndex values(16590,'������') 
GO
insert into HtmlLabelIndex values(16591,'��Ʒ���') 
GO
insert into HtmlLabelIndex values(16594,'�ۼƽ��') 
GO
insert into HtmlLabelIndex values(16595,'��־����') 
GO
insert into HtmlLabelIndex values(16596,'���ڵ�¼') 
GO
insert into HtmlLabelIndex values(16597,'���ͱ���') 
GO
insert into HtmlLabelIndex values(16598,'��Ա�ʲ�') 
GO
insert into HtmlLabelIndex values(16600,'�����ĵ�����') 
GO
insert into HtmlLabelIndex values(16601,'�����ĵ����� ') 
GO
insert into HtmlLabelIndex values(16602,'����Ķ���־') 
GO
insert into HtmlLabelIndex values(16603,'֪ʶ��������') 
GO
insert into HtmlLabelIndex values(16604,'�ĵ����ı���') 
GO
insert into HtmlLabelIndex values(16607,'����ĵ�����') 
GO
insert into HtmlLabelIndex values(16610,'��������Ա') 
GO
insert into HtmlLabelIndex values(16611,'����ĵ���Ŀ') 
GO
insert into HtmlLabelIndex values(16612,'����ĵ�����') 
GO
insert into HtmlLabelIndex values(16613,'���鱨��') 
GO
insert into HtmlLabelIndex values(16614,'�����ұ���') 
GO
insert into HtmlLabelIndex values(16615,'����������') 
GO
insert into HtmlLabelIndex values(16616,'������������') 
GO
insert into HtmlLabelIndex values(16618,'������������') 
GO
insert into HtmlLabelIndex values(16619,'�ر�Ԥ������') 
GO
insert into HtmlLabelIndex values(16620,'��������') 
GO
insert into HtmlLabelIndex values(16621,'��������') 
GO
insert into HtmlLabelIndex values(16625,'��������') 
GO
insert into HtmlLabelIndex values(16627,'ǩ�¹���') 
GO
insert into HtmlLabelIndex values(16629,'��������') 
GO
insert into HtmlLabelIndex values(16630,'��������') 
GO
insert into HtmlLabelIndex values(16632,'�̵�') 
GO
insert into HtmlLabelIndex values(16634,'ȷ��') 
GO
insert into HtmlLabelIndex values(16638,'�������') 
GO
insert into HtmlLabelIndex values(16640,'���Ƶ�������') 
GO
insert into HtmlLabelIndex values(15002,'����ϵͳ') 
GO
insert into HtmlLabelIndex values(15003,'�½�����') 
GO
insert into HtmlLabelIndex values(15004,'�½�����') 
GO
insert into HtmlLabelIndex values(15005,'�½���Ա') 
GO
insert into HtmlLabelIndex values(15006,'�½��ͻ�') 
GO
insert into HtmlLabelIndex values(15007,'�½���Ŀ') 
GO
insert into HtmlLabelIndex values(15008,'�½�����') 
GO
insert into HtmlLabelIndex values(15009,'�½��ʲ�') 
GO
insert into HtmlLabelIndex values(15010,'�ҵĹ�������') 
GO
insert into HtmlLabelIndex values(15011,'֪ʶ�ĵ�') 
GO
insert into HtmlLabelIndex values(15012,'ϵͳ����') 
GO
insert into HtmlLabelIndex values(15013,'ƪ�ĵ�') 
GO
insert into HtmlLabelIndex values(15014,'������') 
GO
insert into HtmlLabelIndex values(15015,'ƪ') 
GO
insert into HtmlLabelIndex values(15016,'����δ��') 
GO
insert into HtmlLabelIndex values(15017,'�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�') 
GO
insert into HtmlLabelIndex values(15018,'licence�ļ�') 
GO
insert into HtmlLabelIndex values(15019,'ʶ����') 
GO
insert into HtmlLabelIndex values(15020,'�ᡡʾ') 
GO
insert into HtmlLabelIndex values(15021,'�뽫') 
GO
insert into HtmlLabelIndex values(15022,'��') 
GO
insert into HtmlLabelIndex values(15023,'�ύ�������Ӧ��,�Ի�ȡLicense') 
GO
insert into HtmlLabelIndex values(15024,'���ݿ�') 
GO
insert into HtmlLabelIndex values(15025,'���ݿ�����') 
GO
insert into HtmlLabelIndex values(15026,'���ݿ�����') 
GO
insert into HtmlLabelIndex values(15027,'ʹ���������ݿ�') 
GO
insert into HtmlLabelIndex values(15028,'�������') 
GO
insert into HtmlLabelIndex values(15029,'�û���') 
GO
insert into HtmlLabelIndex values(15030,'��Ч��') 
GO
insert into HtmlLabelIndex values(15031,'�����µĹ�������Ҫ����') 
GO
insert into HtmlLabelIndex values(15032,'�������Ĺ������Ѿ����') 
GO
insert into HtmlLabelIndex values(15033,'�رմ���') 
GO
insert into HtmlLabelIndex values(15034,'�������ڴ�����') 
GO
insert into HtmlLabelIndex values(15035,'�������ڲ鿴��') 
GO
insert into HtmlLabelIndex values(15036,'���յ����ѹ�����') 
GO
insert into HtmlLabelIndex values(15037,'�ʼ�ϵͳ����') 
GO
insert into HtmlLabelIndex values(15038,'������') 
GO
insert into HtmlLabelIndex values(15039,'�Ƿ���Ҫ������֤') 
GO
insert into HtmlLabelIndex values(15040,'Ⱥ��SMTP������') 
GO
insert into HtmlLabelIndex values(15041,'Ⱥ��Ĭ�Ϸ����˵�ַ') 
GO
insert into HtmlLabelIndex values(15042,'Ⱥ��Ĭ����֤�û���') 
GO
insert into HtmlLabelIndex values(15043,'Ⱥ��Ĭ����֤�û�����') 
GO
insert into HtmlLabelIndex values(15044,'Ⱥ���������Ƿ���Ҫ������֤') 
GO
insert into HtmlLabelIndex values(15045,'�ļ�ϵͳ����') 
GO
insert into HtmlLabelIndex values(15046,'�ļ����Ŀ¼') 
GO
insert into HtmlLabelIndex values(15047,'�ļ�����Ŀ¼') 
GO
insert into HtmlLabelIndex values(15048,'�ļ���������') 
GO
insert into HtmlLabelIndex values(15049,'����') 
GO
insert into HtmlLabelIndex values(15050,'�Ƿ�ѹ�����') 
GO
insert into HtmlLabelIndex values(15051,'�������ݱ���') 
GO
insert into HtmlLabelIndex values(15052,'ϵͳ��ɫ') 
GO
insert into HtmlLabelIndex values(15053,'��Ա��ɫ') 
GO
insert into HtmlLabelIndex values(15054,'�ʲ������������') 
GO
insert into HtmlLabelIndex values(15055,'�ͻ������������') 
GO
insert into HtmlLabelIndex values(15056,'֪ʶ�����������') 
GO
insert into HtmlLabelIndex values(15057,'����������') 
GO
insert into HtmlLabelIndex values(15058,'��������') 
GO
insert into HtmlLabelIndex values(15059,'Ĭ�Ϲ���') 
GO
insert into HtmlLabelIndex values(15060,'��') 
GO
insert into HtmlLabelIndex values(15061,'��ͻ�') 
GO
insert into HtmlLabelIndex values(15062,'���ż�') 
GO
insert into HtmlLabelIndex values(15063,'�ֲ���') 
GO
insert into HtmlLabelIndex values(15064,'�ܲ���') 
GO
insert into HtmlLabelIndex values(15065,'������Դ��������') 
GO
insert into HtmlLabelIndex values(15066,'��Ա��ɫ��������') 
GO
insert into HtmlLabelIndex values(15067,'ϵͳ��ɫ��������') 
GO
insert into HtmlLabelIndex values(15068,'��ɫ����') 
GO
insert into HtmlLabelIndex values(15069,'�������̻�������') 
GO
insert into HtmlLabelIndex values(15070,'�ڵ�����') 
GO
insert into HtmlLabelIndex values(15071,'�޴�����') 
GO
insert into HtmlLabelIndex values(15072,'������') 
GO
insert into HtmlLabelIndex values(15073,'�����鶨��') 
GO
insert into HtmlLabelIndex values(15074,'Ŀ��ڵ�') 
GO
insert into HtmlLabelIndex values(15075,'�Ƿ��˻�') 
GO
insert into HtmlLabelIndex values(15076,'�˻ؽڵ�') 
GO
insert into HtmlLabelIndex values(15077,'�����漰�����Ա') 
GO
insert into HtmlLabelIndex values(15078,'�ͻ�״̬') 
GO
insert into HtmlLabelIndex values(15079,'�����˱���') 
GO
insert into HtmlLabelIndex values(15080,'�����˾���') 
GO
insert into HtmlLabelIndex values(15081,'�����˱�����') 
GO
insert into HtmlLabelIndex values(15082,'���˻�') 
GO
insert into HtmlLabelIndex values(15083,'�����˻�') 
GO
insert into HtmlLabelIndex values(15084,'����') 
GO
insert into HtmlLabelIndex values(15085,'����') 
GO
insert into HtmlLabelIndex values(15086,'��') 
GO
insert into HtmlLabelIndex values(15087,'���ʼ�����') 
GO
insert into HtmlLabelIndex values(15088,'�����빫��') 
GO
insert into HtmlLabelIndex values(15089,'�ҵ�����') 
GO
insert into HtmlLabelIndex values(15090,'��������') 
GO
insert into HtmlLabelIndex values(15091,'���鰲��') 
GO
insert into HtmlLabelIndex values(15092,'��������') 
GO
insert into HtmlLabelIndex values(15093,'���Ź���') 
GO
insert into HtmlLabelIndex values(15094,'��¼����ͻ') 
GO
insert into HtmlLabelIndex values(15095,'��ϵͳ��½��') 
GO
insert into HtmlLabelIndex values(15096,'�ⲿϵͳ��½��') 
GO
insert into HtmlLabelIndex values(15097,'ȷ��Ҫɾ����?') 
GO
insert into HtmlLabelIndex values(15098,'�����б�') 
GO
insert into HtmlLabelIndex values(15099,'��ӿͻ�') 
GO
insert into HtmlLabelIndex values(15100,'����') 
GO
insert into HtmlLabelIndex values(15101,'����') 
GO
insert into HtmlLabelIndex values(15102,'���ۻ���ʱ��ֲ�����') 
GO
insert into HtmlLabelIndex values(15103,'�ɹ��ؼ�����') 
GO
insert into HtmlLabelIndex values(15104,'ʧ�ܹؼ�����') 
GO
insert into HtmlLabelIndex values(15105,'��Ʒ������') 
GO
insert into HtmlLabelIndex values(15106,'��Ʒ���') 
GO
insert into HtmlLabelIndex values(15107,'��Ʒά��') 
GO
insert into HtmlLabelIndex values(15108,'��Ʒ�б�') 
GO
insert into HtmlLabelIndex values(15109,'����') 
GO
insert into HtmlLabelIndex values(15110,'�½�����') 
GO
insert into HtmlLabelIndex values(15111,'��̨����') 
GO
insert into HtmlLabelIndex values(15112,'�鵵״̬') 
GO
insert into HtmlLabelIndex values(15113,'ʱ��ֲ�') 
GO
insert into HtmlLabelIndex values(15114,'����') 
GO
insert into HtmlLabelIndex values(15115,'��Ʒ') 
GO
insert into HtmlLabelIndex values(15116,'������Ա') 
GO
insert into HtmlLabelIndex values(15117,'��ͬӦ��Ӧ��') 
GO
insert into HtmlLabelIndex values(15118,'��ͬ��ز�Ʒ') 
GO
insert into HtmlLabelIndex values(15119,'���ݿ����') 
GO
insert into HtmlLabelIndex values(15120,'�����ֲ�') 
GO
insert into HtmlLabelIndex values(15121,'�ͻ���ϵ����') 
GO
insert into HtmlLabelIndex values(15122,'����') 
GO
insert into HtmlLabelIndex values(15123,'ǰ��') 
GO
insert into HtmlLabelIndex values(15124,'�ͻ���Ƭ���') 
GO
insert into HtmlLabelIndex values(15125,'����') 
GO
insert into HtmlLabelIndex values(15126,'�����ؼ��ֲ�����ȷ') 
GO
insert into HtmlLabelIndex values(15127,'��δ���') 
GO
insert into HtmlLabelIndex values(15128,'���һ��') 
GO
insert into HtmlLabelIndex values(15129,'��Ʒ����') 
GO
insert into HtmlLabelIndex values(15130,'�ۿ�') 
GO
insert into HtmlLabelIndex values(15131,'���ʽ') 
GO
insert into HtmlLabelIndex values(15132,'������Ŀ') 
GO
insert into HtmlLabelIndex values(15133,'��������') 
GO
insert into HtmlLabelIndex values(15134,'������') 
GO
insert into HtmlLabelIndex values(15135,'��������') 
GO
insert into HtmlLabelIndex values(15136,'��������') 
GO
insert into HtmlLabelIndex values(15137,'Ӧ��') 
GO
insert into HtmlLabelIndex values(15138,'Ӧ��') 
GO
insert into HtmlLabelIndex values(15139,'�½��ͻ���ͬ') 
GO
insert into HtmlLabelIndex values(15140,'�ͻ���ͬ') 
GO
insert into HtmlLabelIndex values(15141,'��') 
GO
insert into HtmlLabelIndex values(15142,'��ͬ����') 
GO
insert into HtmlLabelIndex values(15143,'�ύ����') 
GO
insert into HtmlLabelIndex values(15144,'ִ�����') 
GO
insert into HtmlLabelIndex values(15145,'ʵ�ʽ�������') 
GO
insert into HtmlLabelIndex values(15146,'ʵ�ʽ�������') 
GO
insert into HtmlLabelIndex values(15147,'�����') 
GO
insert into HtmlLabelIndex values(15148,'����') 
GO
insert into HtmlLabelIndex values(15149,'����') 
GO
insert into HtmlLabelIndex values(15150,'ʵ�ʸ�������') 
GO
insert into HtmlLabelIndex values(15151,'���տ�') 
GO
insert into HtmlLabelIndex values(15152,'�Ѹ���') 
GO
insert into HtmlLabelIndex values(15153,'��ؽ���') 
GO
insert into HtmlLabelIndex values(15154,'����') 
GO
insert into HtmlLabelIndex values(15155,'�ͻ��Ż�����') 
GO
insert into HtmlLabelIndex values(15156,'�Ż�״̬���') 
GO
insert into HtmlLabelIndex values(15157,'�ͻ�״̬���') 
GO
insert into HtmlLabelIndex values(15158,'�ͻ�������') 
GO
insert into HtmlLabelIndex values(15159,'�ͻ�������') 
GO
insert into HtmlLabelIndex values(15160,'ȷ��Ҫ�ϲ���') 
GO
insert into HtmlLabelIndex values(15161,'����') 
GO
insert into HtmlLabelIndex values(15162,'Ӧ���ܶ�') 
GO
insert into HtmlLabelIndex values(15163,'��һ��Ӧ�տ�ʱ��') 
GO
insert into HtmlLabelIndex values(15164,'����ͻ���ͬ') 
GO
insert into HtmlLabelIndex values(15165,'�������HTML�ļ�') 
GO
insert into HtmlLabelIndex values(15166,'����㲻ϣ���ٴ��յ������ʼ�������') 
GO
insert into HtmlLabelIndex values(15167,'�˶�') 
GO
insert into HtmlLabelIndex values(15168,'ע') 
GO
insert into HtmlLabelIndex values(15169,'��������HTML����ճ�����ʼ�ģ����') 
GO
insert into HtmlLabelIndex values(15170,'ϵͳ��ʾ���Բ��𣬿ռ�¼���ܽ���ת��') 
GO
insert into HtmlLabelIndex values(15171,'�˶�ʧ��') 
GO
insert into HtmlLabelIndex values(15172,'ϵͳ��ʾ') 
GO
insert into HtmlLabelIndex values(15173,'�ύʧ��') 
GO
insert into HtmlLabelIndex values(15174,'���ύ�Ŀͻ�') 
GO
insert into HtmlLabelIndex values(15175,'�ύ����') 
GO
insert into HtmlLabelIndex values(15176,'���ύ') 
GO
insert into HtmlLabelIndex values(15177,'δ�ύ�Ŀͻ�') 
GO
insert into HtmlLabelIndex values(15178,'δ�ύ') 
GO
insert into HtmlLabelIndex values(15179,'�˶��Ŀͻ�') 
GO
insert into HtmlLabelIndex values(15180,'�˶�����') 
GO
insert into HtmlLabelIndex values(15181,'���������') 
GO
insert into HtmlLabelIndex values(15182,'������Ϣ') 
GO
insert into HtmlLabelIndex values(15183,'���������') 
GO
insert into HtmlLabelIndex values(15184,'���뱨��') 
GO
insert into HtmlLabelIndex values(15185,'���뱨������') 
GO
insert into HtmlLabelIndex values(15186,'���ݱ���') 
GO
insert into HtmlLabelIndex values(15187,'���鱨��') 
GO
insert into HtmlLabelIndex values(15188,'������Ϣ') 
GO
insert into HtmlLabelIndex values(15189,'���������') 
GO
insert into HtmlLabelIndex values(15190,'���ݿ����') 
GO
insert into HtmlLabelIndex values(15191,'��ʽΪ') 
GO
insert into HtmlLabelIndex values(15192,'����������ظ�') 
GO
insert into HtmlLabelIndex values(15193,'������������Ҫ���ӵĵ�ַ') 
GO
insert into HtmlLabelIndex values(15194,'��') 
GO
insert into HtmlLabelIndex values(15195,'�ʼ���ʽ') 
GO
insert into HtmlLabelIndex values(15196,'��ʽ') 
GO
insert into HtmlLabelIndex values(15197,'�������Ϣ') 
GO
insert into HtmlLabelIndex values(15198,'�ʼ�ģ����') 
GO
insert into HtmlLabelIndex values(15199,'��������Ϣ') 
GO
insert into HtmlLabelIndex values(15200,'������') 
GO
insert into HtmlLabelIndex values(15201,'�����ı���') 
GO
insert into HtmlLabelIndex values(15202,'������') 
GO
insert into HtmlLabelIndex values(15203,'������') 
GO
insert into HtmlLabelIndex values(15204,'��ѡ��') 
GO
insert into HtmlLabelIndex values(15205,'��ѡ��') 
GO
insert into HtmlLabelIndex values(15206,'�����ı���') 
GO
insert into HtmlLabelIndex values(15207,'����������') 
GO
insert into HtmlLabelIndex values(15208,'����������') 
GO
insert into HtmlLabelIndex values(15209,'�������ֶ���') 
GO
insert into HtmlLabelIndex values(15210,'���ֶ��������ظ�') 
GO
insert into HtmlLabelIndex values(15211,'�ı��ֶο��') 
GO
insert into HtmlLabelIndex values(15212,'С��λ��') 
GO
insert into HtmlLabelIndex values(15213,'�������������Ϣ') 
GO
insert into HtmlLabelIndex values(15214,'ѡ������ϸֵ') 
GO
insert into HtmlLabelIndex values(15215,'ѡ����ʾֵ�����ݱ�ֵӦһ��') 
GO
insert into HtmlLabelIndex values(15216,'ѡ����ʾֵ') 
GO
insert into HtmlLabelIndex values(15217,'���ݱ�ֵ') 
GO
insert into HtmlLabelIndex values(15218,'�����') 
GO
insert into HtmlLabelIndex values(15219,'���յ�������') 
GO
insert into HtmlLabelIndex values(15220,'Ӧ�ύ���ܿͻ�') 
GO
insert into HtmlLabelIndex values(15221,'ʵ���ύ���ܿͻ�') 
GO
insert into HtmlLabelIndex values(15222,'�˶����ܿͻ�') 
GO
insert into HtmlLabelIndex values(15223,'��Ȩ��ָ�����ܴ���') 
GO
insert into HtmlLabelIndex values(15224,'����') 
GO
insert into HtmlLabelIndex values(15225,'δ��') 
GO
insert into HtmlLabelIndex values(15226,'�Ѹ�') 
GO
insert into HtmlLabelIndex values(15227,'δ��') 
GO
insert into HtmlLabelIndex values(15228,'Ӧ����') 
GO
insert into HtmlLabelIndex values(15229,'�ѽ���') 
GO
insert into HtmlLabelIndex values(15230,'δ����') 
GO
insert into HtmlLabelIndex values(15231,'�ͻ���') 
GO
insert into HtmlLabelIndex values(15232,'�ϴ���ϵʱ��') 
GO
insert into HtmlLabelIndex values(15233,'��������') 
GO
insert into HtmlLabelIndex values(15234,'��������') 
GO
insert into HtmlLabelIndex values(15235,'�ͻ���ͬ��������') 
GO
insert into HtmlLabelIndex values(15236,'��ͬ��������') 
GO
insert into HtmlLabelIndex values(15237,'�������������') 
GO
insert into HtmlLabelIndex values(15238,'�����������Ŀ') 
GO
insert into HtmlLabelIndex values(15239,'�н����') 
GO
insert into HtmlLabelIndex values(15240,'��Դ') 
GO
insert into HtmlLabelIndex values(15241,'������0��1֮�����') 
GO
insert into HtmlLabelIndex values(15242,'�ɹ�') 
GO
insert into HtmlLabelIndex values(15243,'��������ȷ����������') 
GO
insert into HtmlLabelIndex values(15244,'���ۻ���ʱ��') 
GO
insert into HtmlLabelIndex values(15245,'����ҵ��ͳ��') 
GO
insert into HtmlLabelIndex values(15246,'��������') 
GO
insert into HtmlLabelIndex values(15247,'����ҵ��') 
GO
insert into HtmlLabelIndex values(15248,'ʡ��ҵ��ͳ��') 
GO
insert into HtmlLabelIndex values(15249,'�½����ۻ���') 
GO
insert into HtmlLabelIndex values(15250,'�༭���ۻ���') 
GO
insert into HtmlLabelIndex values(15251,'Ԥ������ϼ�') 
GO
insert into HtmlLabelIndex values(15252,'����') 
GO
insert into HtmlLabelIndex values(15253,'��ǩ����ͬ') 
GO
insert into HtmlLabelIndex values(15254,'��������ȷ�ĺ�ͬ�������') 
GO
insert into HtmlLabelIndex values(15255,'���۾���') 
GO
insert into HtmlLabelIndex values(15256,'����') 
GO
insert into HtmlLabelIndex values(15257,'���ۻ���ͳ��') 
GO
insert into HtmlLabelIndex values(15258,'�������') 
GO
insert into HtmlLabelIndex values(15259,'���ۻ�����') 
GO
insert into HtmlLabelIndex values(15260,'���ٷֱ�') 
GO
insert into HtmlLabelIndex values(15261,'��Ŀ�����б�') 
GO
insert into HtmlLabelIndex values(15262,'�����Ŀ') 
GO
insert into HtmlLabelIndex values(15263,'�ͻ��ɼ�') 
GO
insert into HtmlLabelIndex values(15264,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(15265,'ʵ������') 
GO
insert into HtmlLabelIndex values(15266,'�½�����') 
GO
insert into HtmlLabelIndex values(15267,'�½�����ִ�У�') 
GO
insert into HtmlLabelIndex values(15268,'�༭����ִ�У�') 
GO
insert into HtmlLabelIndex values(15269,'�½����񣨼ƻ���') 
GO
insert into HtmlLabelIndex values(15270,'�༭���񣨼ƻ���') 
GO
insert into HtmlLabelIndex values(15271,'ɾ������ִ�У�') 
GO
insert into HtmlLabelIndex values(15272,'ɾ�����񣨼ƻ���') 
GO
insert into HtmlLabelIndex values(15273,'����ʱ�䲻��С����ʼʱ��') 
GO
insert into HtmlLabelIndex values(15274,'��ĿԤ��') 
GO
insert into HtmlLabelIndex values(15275,'�޸���־') 
GO
insert into HtmlLabelIndex values(15276,'��Ŀ֪ͨ') 
GO
insert into HtmlLabelIndex values(15277,'ǰ������δ���') 
GO
insert into HtmlLabelIndex values(15278,'������ 0��100 ֮�������') 
GO
insert into HtmlLabelIndex values(15279,'Ԫ') 
GO
insert into HtmlLabelIndex values(15280,'֪ͨ����') 
GO
insert into HtmlLabelIndex values(15281,'֪ͨ���⣺') 
GO
insert into HtmlLabelIndex values(15282,'֪ͨ���ݣ�') 
GO
insert into HtmlLabelIndex values(15283,'�½���Ŀ����') 
GO
insert into HtmlLabelIndex values(15284,'�༭����') 
GO
insert into HtmlLabelIndex values(15285,'��������') 
GO
insert into HtmlLabelIndex values(15286,'����Ƚ�') 
GO
insert into HtmlLabelIndex values(15287,'δ��ʼ����') 
GO
insert into HtmlLabelIndex values(15288,'����������') 
GO
insert into HtmlLabelIndex values(15289,'���������') 
GO
insert into HtmlLabelIndex values(15290,'����δ��ʼ����') 
GO
insert into HtmlLabelIndex values(15291,'����δ�������') 
GO
insert into HtmlLabelIndex values(15292,'(ʵ��/�ƻ�)') 
GO
insert into HtmlLabelIndex values(15293,'������') 
GO
insert into HtmlLabelIndex values(15294,'��������') 
GO
insert into HtmlLabelIndex values(15295,'��ع�����') 
GO
insert into HtmlLabelIndex values(15296,'ͳ�Ʊ���') 
GO
insert into HtmlLabelIndex values(15297,'���ڻ�����') 
GO
insert into HtmlLabelIndex values(15298,'����') 
GO
insert into HtmlLabelIndex values(15299,'����') 
GO
insert into HtmlLabelIndex values(15300,'���ϵ��ʲ�') 
GO
insert into HtmlLabelIndex values(15301,'��ⲿ��') 
GO
insert into HtmlLabelIndex values(15302,'�������') 
GO
insert into HtmlLabelIndex values(15303,'��������') 
GO
insert into HtmlLabelIndex values(15304,'���õ��ʲ�') 
GO
insert into HtmlLabelIndex values(15305,'�ʲ��黹') 
GO
insert into HtmlLabelIndex values(15306,'�������') 
GO
insert into HtmlLabelIndex values(15307,'�������') 
GO
insert into HtmlLabelIndex values(15308,'ά�޵��ʲ�') 
GO
insert into HtmlLabelIndex values(15309,'�����ʲ�') 
GO
insert into HtmlLabelIndex values(15310,'����������') 
GO
insert into HtmlLabelIndex values(15311,'��������') 
GO
insert into HtmlLabelIndex values(15312,'���õ��ʲ�') 
GO
insert into HtmlLabelIndex values(15313,'���õ�����') 
GO
insert into HtmlLabelIndex values(15314,'������;') 
GO
insert into HtmlLabelIndex values(15315,'չ��') 
GO
insert into HtmlLabelIndex values(15316,'�ʲ������б�') 
GO
insert into HtmlLabelIndex values(15317,'��һ��') 
GO
insert into HtmlLabelIndex values(15318,'����ȫ��Ϊ��') 
GO
insert into HtmlLabelIndex values(15319,'����У���') 
GO
insert into HtmlLabelIndex values(15320,'�̶��ʲ�') 
GO
insert into HtmlLabelIndex values(15321,'��ֵ�׺�Ʒ') 
GO
insert into HtmlLabelIndex values(15322,'��') 
GO
insert into HtmlLabelIndex values(15323,'��') 
GO
insert into HtmlLabelIndex values(15324,'��') 
GO
insert into HtmlLabelIndex values(15325,'����') 
GO
insert into HtmlLabelIndex values(15326,'ͳ����') 
GO
insert into HtmlLabelIndex values(15327,'ͳ������') 
GO
insert into HtmlLabelIndex values(15328,'��ʻԱͳ�Ʊ�') 
GO
insert into HtmlLabelIndex values(15329,'���ɱ���') 
GO
insert into HtmlLabelIndex values(15330,'��ʻԱ') 
GO
insert into HtmlLabelIndex values(15331,'��¡����ս��Ͷ�����޹�˾����������ʻԱͳ�Ʊ�') 
GO
insert into HtmlLabelIndex values(15332,'�Ʊ���') 
GO
insert into HtmlLabelIndex values(15333,'�յ�') 
GO
insert into HtmlLabelIndex values(15334,'����ʱ���������') 
GO
insert into HtmlLabelIndex values(15335,'ƽʱ����������') 
GO
insert into HtmlLabelIndex values(15336,'��Ϣ�ճ�������') 
GO
insert into HtmlLabelIndex values(15337,'��س�������') 
GO
insert into HtmlLabelIndex values(15338,'��ʻ������') 
GO
insert into HtmlLabelIndex values(15339,'ȼ�ͷ�') 
GO
insert into HtmlLabelIndex values(15340,'ͣ����·��') 
GO
insert into HtmlLabelIndex values(15341,'�����') 
GO
insert into HtmlLabelIndex values(15342,'�绰��') 
GO
insert into HtmlLabelIndex values(15343,'�Ӱಹ��') 
GO
insert into HtmlLabelIndex values(15344,'�������ܷ���') 
GO
insert into HtmlLabelIndex values(15345,'����ͳ�Ʊ�') 
GO
insert into HtmlLabelIndex values(15346,'��¡����ս��Ͷ�����޹�˾������������ͳ�Ʊ�') 
GO
insert into HtmlLabelIndex values(15347,'�������') 
GO
insert into HtmlLabelIndex values(15348,'��ʻ�ܹ�����') 
GO
insert into HtmlLabelIndex values(15349,'�������ü�ʱ��') 
GO
insert into HtmlLabelIndex values(15350,'ά�޷��ü�ʱ��') 
GO
insert into HtmlLabelIndex values(15351,'������') 
GO
insert into HtmlLabelIndex values(15352,'�ƻ�ʵ�ʱȽϱ�') 
GO
insert into HtmlLabelIndex values(15353,'����ͼ��') 
GO
insert into HtmlLabelIndex values(15354,'�����ŷ��üƻ�ʵ�ʱȽϱ�') 
GO
insert into HtmlLabelIndex values(15355,'��������ͳ�Ʊ�') 
GO
insert into HtmlLabelIndex values(15356,'���üƻ�ʵ�ʱȽϱ�') 
GO
insert into HtmlLabelIndex values(15357,'��֤') 
GO
insert into HtmlLabelIndex values(15358,'����') 
GO
insert into HtmlLabelIndex values(15359,'��֤���') 
GO
insert into HtmlLabelIndex values(15360,'�б���ʾ') 
GO
insert into HtmlLabelIndex values(15361,'�ʲ�������') 
GO
insert into HtmlLabelIndex values(15362,'�ּ���ʾ') 
GO
insert into HtmlLabelIndex values(15363,'Ԥ�����') 
GO
insert into HtmlLabelIndex values(15364,'����') 
GO
insert into HtmlLabelIndex values(15365,'Ԥ�����') 
GO
insert into HtmlLabelIndex values(15366,'�걨') 
GO
insert into HtmlLabelIndex values(15367,'��׼') 
GO
insert into HtmlLabelIndex values(15368,'ƫ��') 
GO
insert into HtmlLabelIndex values(15369,'�����걨ֵ') 
GO
insert into HtmlLabelIndex values(15370,'�¶�Ԥ��') 
GO
insert into HtmlLabelIndex values(15371,'Ԥ������') 
GO
insert into HtmlLabelIndex values(15372,'��') 
GO
insert into HtmlLabelIndex values(15373,'����Ԥ��') 
GO
insert into HtmlLabelIndex values(15374,'����Ԥ��') 
GO
insert into HtmlLabelIndex values(15375,'���Ԥ��') 
GO
insert into HtmlLabelIndex values(15376,'ͨ��') 
GO
insert into HtmlLabelIndex values(15377,'��׼�༭') 
GO
insert into HtmlLabelIndex values(15378,'����״̬') 
GO
insert into HtmlLabelIndex values(15379,'1�����ŵ�Ԥ���걨�ĸ�������ֵ������ڻ���ں�׼ֵ(����û�к�׼ֵ)����������ͨ����') 
GO
insert into HtmlLabelIndex values(15380,'2�����ŵ�Ԥ���걨�ĸ���֧��ֵ����С�ڻ���ں�׼ֵ(����û�к�׼ֵ)����������ͨ����') 
GO
insert into HtmlLabelIndex values(15381,'3������ͨ���󣬸ò��ű����Ԥ���걨ֵ�ͺ�׼ֵ�㲻�ܸĶ���') 
GO
insert into HtmlLabelIndex values(15382,'�Ƿ������') 
GO
insert into HtmlLabelIndex values(15383,'�в��������������������걨���ڣ���������ͨ����') 
GO
insert into HtmlLabelIndex values(15384,'����') 
GO
insert into HtmlLabelIndex values(15385,'��֧����') 
GO
insert into HtmlLabelIndex values(15386,'����') 
GO
insert into HtmlLabelIndex values(15387,'ƫ������') 
GO
insert into HtmlLabelIndex values(15388,'Ԥ������') 
GO
insert into HtmlLabelIndex values(15389,'����ƫ��') 
GO
insert into HtmlLabelIndex values(15390,'��������') 
GO
insert into HtmlLabelIndex values(15391,'���ű��') 
GO
insert into HtmlLabelIndex values(15392,'������') 
GO
insert into HtmlLabelIndex values(15393,'��������') 
GO
insert into HtmlLabelIndex values(15394,'��������') 
GO
insert into HtmlLabelIndex values(15395,'���ʽ��') 
GO
insert into HtmlLabelIndex values(15396,'������������') 
GO
insert into HtmlLabelIndex values(15397,'��������') 
GO
insert into HtmlLabelIndex values(15398,'�������') 
GO
insert into HtmlLabelIndex values(15399,'��������') 
GO
insert into HtmlLabelIndex values(15400,'����Ƿ���ۼ�') 
GO
insert into HtmlLabelIndex values(15401,'����Ԥ��') 
GO
insert into HtmlLabelIndex values(15402,'����Ԥ��') 
GO
insert into HtmlLabelIndex values(15403,'������֧') 
GO
insert into HtmlLabelIndex values(15404,'������֧') 
GO
insert into HtmlLabelIndex values(15405,'�ͻ���֧') 
GO
insert into HtmlLabelIndex values(15406,'��Ŀ��֧') 
GO
insert into HtmlLabelIndex values(15407,'���������ϸ����') 
GO
insert into HtmlLabelIndex values(15408,'����') 
GO
insert into HtmlLabelIndex values(15409,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(15410,'���ڷ���') 
GO
insert into HtmlLabelIndex values(15411,'�����ۼ�') 
GO
insert into HtmlLabelIndex values(15412,'��ĩ���') 
GO
insert into HtmlLabelIndex values(15413,'����') 
GO
insert into HtmlLabelIndex values(15414,'��ʾ���Ϊ��ļ�¼') 
GO
insert into HtmlLabelIndex values(15415,'��ʾ������Ϊ��ļ�¼') 
GO
insert into HtmlLabelIndex values(15416,'��ʾ����δ����ƾ֤') 
GO
insert into HtmlLabelIndex values(15417,'��Ԫ��') 
GO
insert into HtmlLabelIndex values(15418,'�����ʽ𱨱�') 
GO
insert into HtmlLabelIndex values(15419,'�������') 
GO
insert into HtmlLabelIndex values(15420,'���ڽ跽����') 
GO
insert into HtmlLabelIndex values(15421,'���ڴ�������') 
GO
insert into HtmlLabelIndex values(15422,'�������') 
GO
insert into HtmlLabelIndex values(15423,'�跽����') 
GO
insert into HtmlLabelIndex values(15424,'��������') 
GO
insert into HtmlLabelIndex values(15425,'������������') 
GO
insert into HtmlLabelIndex values(15426,'�������') 
GO
insert into HtmlLabelIndex values(15427,'Ԥ������״̬') 
GO
insert into HtmlLabelIndex values(15428,'�¶���֧') 
GO
insert into HtmlLabelIndex values(15429,'������֧') 
GO
insert into HtmlLabelIndex values(15430,'������֧') 
GO
insert into HtmlLabelIndex values(15431,'�����֧') 
GO
insert into HtmlLabelIndex values(15432,'��ش���') 
GO
insert into HtmlLabelIndex values(15433,'����������') 
GO
insert into HtmlLabelIndex values(15434,'��������') 
GO
insert into HtmlLabelIndex values(15435,'������') 
GO
insert into HtmlLabelIndex values(15436,'�̶�����') 
GO
insert into HtmlLabelIndex values(15437,'����������') 
GO
insert into HtmlLabelIndex values(15438,'����ͼ�༭') 
GO
insert into HtmlLabelIndex values(15439,'Ĭ���ܽ��') 
GO
insert into HtmlLabelIndex values(15440,'���ֶ����Ѿ���ʹ��') 
GO
insert into HtmlLabelIndex values(15441,'�ֶ�������������,���ұ�����Ӣ����ĸ��ͷ(��f4)') 
GO
insert into HtmlLabelIndex values(15442,'��ѡ������') 
GO
insert into HtmlLabelIndex values(15443,'�������') 
GO
insert into HtmlLabelIndex values(15444,'ɾ������') 
GO
insert into HtmlLabelIndex values(15445,'û��ѡ��һ��ɾ����') 
GO
insert into HtmlLabelIndex values(15446,'ѡ����ֶ�') 
GO
insert into HtmlLabelIndex values(15447,'��ѡ�ֶ�') 
GO
insert into HtmlLabelIndex values(15448,'��ѡ�ֶ�') 
GO
insert into HtmlLabelIndex values(15449,'�༭�ֶ�') 
GO
insert into HtmlLabelIndex values(15450,'�༭��ʾ��') 
GO
insert into HtmlLabelIndex values(15451,'������') 
GO
insert into HtmlLabelIndex values(15452,'������') 
GO
insert into HtmlLabelIndex values(15453,'ȫ���ֶ�') 
GO
insert into HtmlLabelIndex values(15454,'��û���ֶ���Ϣ') 
GO
insert into HtmlLabelIndex values(15455,'ȱʡ') 
GO
insert into HtmlLabelIndex values(15456,'�ֶ���ʾ��') 
GO
insert into HtmlLabelIndex values(15457,'������ѡ��һ������') 
GO
insert into HtmlLabelIndex values(15458,'���������Ѿ�����,������ѡ��һ��') 
GO
insert into HtmlLabelIndex values(15459,'ȷ��ɾ��ѡ������Ϣ��') 
GO
insert into HtmlLabelIndex values(15460,'���к�') 
GO
insert into HtmlLabelIndex values(15461,'�������') 
GO
insert into HtmlLabelIndex values(15462,'��������') 
GO
insert into HtmlLabelIndex values(15463,'û��ѡ��һ�����嵥��') 
GO
insert into HtmlLabelIndex values(15464,'�����½�') 
GO
insert into HtmlLabelIndex values(15465,'���ݺ�') 
GO
insert into HtmlLabelIndex values(15466,'ӡˢ��˾') 
GO
insert into HtmlLabelIndex values(15467,'��Ʊ��˾') 
GO
insert into HtmlLabelIndex values(15468,'��Ʊ��') 
GO
insert into HtmlLabelIndex values(15469,'��Ʊ����') 
GO
insert into HtmlLabelIndex values(15470,'���ڿ��') 
GO
insert into HtmlLabelIndex values(15471,'��ݹ�˾') 
GO
insert into HtmlLabelIndex values(15472,'�ؿ�ר��') 
GO
insert into HtmlLabelIndex values(15473,'��ƱԤ��') 
GO
insert into HtmlLabelIndex values(15474,'���ý��') 
GO
insert into HtmlLabelIndex values(15475,'������;') 
GO
insert into HtmlLabelIndex values(15476,'Ҫ��ʱ��') 
GO
insert into HtmlLabelIndex values(15477,'������˾�ϼ�') 
GO
insert into HtmlLabelIndex values(15478,'�̶��ʲ�����') 
GO
insert into HtmlLabelIndex values(15479,'Ԥ���ܽ��') 
GO
insert into HtmlLabelIndex values(15480,'���벿��') 
GO
insert into HtmlLabelIndex values(15481,'��������') 
GO
insert into HtmlLabelIndex values(15482,'ԭ��') 
GO
insert into HtmlLabelIndex values(15483,'�ʲ�״��') 
GO
insert into HtmlLabelIndex values(15484,'����ԭ��') 
GO
insert into HtmlLabelIndex values(15485,'���¹���С��') 
GO
insert into HtmlLabelIndex values(15486,'���') 
GO
insert into HtmlLabelIndex values(15487,'����������') 
GO
insert into HtmlLabelIndex values(15488,'Ȩ��ָ��') 
GO
insert into HtmlLabelIndex values(15489,'��������') 
GO
insert into HtmlLabelIndex values(15490,'���¹����ƻ�') 
GO
insert into HtmlLabelIndex values(15491,'���¹���Ŀ��') 
GO
insert into HtmlLabelIndex values(15492,'��ɽ��') 
GO
insert into HtmlLabelIndex values(15493,'���ܹ���С��') 
GO
insert into HtmlLabelIndex values(15494,'��Ҫ����') 
GO
insert into HtmlLabelIndex values(15495,'��ɵĽ��') 
GO
insert into HtmlLabelIndex values(15496,'û�������') 
GO
insert into HtmlLabelIndex values(15497,'ԭ���Ľ���ʩ') 
GO
insert into HtmlLabelIndex values(15498,'���ܹ����ƻ�') 
GO
insert into HtmlLabelIndex values(15499,'��Ҫ�ƻ�����') 
GO
insert into HtmlLabelIndex values(15500,'Ԥ�����ʱ��') 
GO
insert into HtmlLabelIndex values(15501,'�ؼ�����') 
GO
insert into HtmlLabelIndex values(15502,'����ʱ��') 
GO
insert into HtmlLabelIndex values(15503,'��������') 
GO
insert into HtmlLabelIndex values(15504,'���') 
GO
insert into HtmlLabelIndex values(15505,'��������') 
GO
insert into HtmlLabelIndex values(15506,'������') 
GO
insert into HtmlLabelIndex values(15507,'������') 
GO
insert into HtmlLabelIndex values(15508,'����') 
GO
insert into HtmlLabelIndex values(15509,'С��') 
GO
insert into HtmlLabelIndex values(15510,'������ʾ��') 
GO
insert into HtmlLabelIndex values(15511,'�Ƿ�ͳ��') 
GO
insert into HtmlLabelIndex values(15512,'�����ֶ�') 
GO
insert into HtmlLabelIndex values(15513,'��ʾ˳��') 
GO
insert into HtmlLabelIndex values(15514,'�������') 
GO
insert into HtmlLabelIndex values(15515,'��ʾ��') 
GO
insert into HtmlLabelIndex values(15516,'�Ƿ������ֶ�') 
GO
insert into HtmlLabelIndex values(15517,'��������') 
GO
insert into HtmlLabelIndex values(15518,'���²�ѯ') 
GO
insert into HtmlLabelIndex values(15519,'�����������') 
GO
insert into HtmlLabelIndex values(15520,'��������') 
GO
insert into HtmlLabelIndex values(15521,'��������') 
GO
insert into HtmlLabelIndex values(15522,'��������') 
GO
insert into HtmlLabelIndex values(15523,'���ʱ��') 
GO
insert into HtmlLabelIndex values(15524,'�ƻ����ͳ��') 
GO
insert into HtmlLabelIndex values(15525,'������') 
GO
insert into HtmlLabelIndex values(15526,'Ա���������ͳ��ͼ') 
GO
insert into HtmlLabelIndex values(15527,'�̶��������') 
GO
insert into HtmlLabelIndex values(15528,'ҳ������') 
GO
insert into HtmlLabelIndex values(15529,'��Ӧģ��') 
GO
insert into HtmlLabelIndex values(15530,'��ȡ��') 
GO
insert into HtmlLabelIndex values(15531,'��������') 
GO
insert into HtmlLabelIndex values(15532,'�̶�') 
GO
insert into HtmlLabelIndex values(15533,'��Ҫ') 
GO
insert into HtmlLabelIndex values(15534,'�����̶�') 
GO
insert into HtmlLabelIndex values(15535,'û����ع�����') 
GO
insert into HtmlLabelIndex values(15536,'�ڵ�����') 
GO
insert into HtmlLabelIndex values(15537,'����') 
GO
insert into HtmlLabelIndex values(15538,'���24Сʱ') 
GO
insert into HtmlLabelIndex values(15539,'����') 
GO
insert into HtmlLabelIndex values(15540,'�������') 
GO
insert into HtmlLabelIndex values(15541,'����') 
GO
insert into HtmlLabelIndex values(15542,'�����') 
GO
insert into HtmlLabelIndex values(15543,'����ѡ����Ҫɾ������Ϣ') 
GO
insert into HtmlLabelIndex values(15544,'��������') 
GO
insert into HtmlLabelIndex values(15545,'����������') 
GO
insert into HtmlLabelIndex values(15546,'���͵Ľڵ�ֻ����һ��') 
GO
insert into HtmlLabelIndex values(15547,'�ܷ�ȫ�̸���') 
GO
insert into HtmlLabelIndex values(15548,'����������') 
GO
insert into HtmlLabelIndex values(15549,'������Դ�ֶ�') 
GO
insert into HtmlLabelIndex values(15550,'�ĵ��ֶ�') 
GO
insert into HtmlLabelIndex values(15551,'��Ŀ�ֶ�') 
GO
insert into HtmlLabelIndex values(15552,'�ʲ��ֶ�') 
GO
insert into HtmlLabelIndex values(15553,'�ͻ��ֶ�') 
GO
insert into HtmlLabelIndex values(15554,'�Ż����') 
GO
insert into HtmlLabelIndex values(15555,'������Դ�ֶα���') 
GO
insert into HtmlLabelIndex values(15556,'�ǻ�ǩ') 
GO
insert into HtmlLabelIndex values(15557,'��ǩ') 
GO
insert into HtmlLabelIndex values(15558,'�����������') 
GO
insert into HtmlLabelIndex values(15559,'������Դ�ֶξ���') 
GO
insert into HtmlLabelIndex values(15560,'������Դ�ֶ�����') 
GO
insert into HtmlLabelIndex values(15561,'������Դ�ֶα��ֲ�') 
GO
insert into HtmlLabelIndex values(15562,'������Դ�ֶα�����') 
GO
insert into HtmlLabelIndex values(15563,'������Դ�ֶ��ϼ�����') 
GO
insert into HtmlLabelIndex values(15564,'�ĵ��ֶ�������') 
GO
insert into HtmlLabelIndex values(15565,'�ĵ��ֶηֲ�') 
GO
insert into HtmlLabelIndex values(15566,'�ĵ��ֶβ���') 
GO
insert into HtmlLabelIndex values(15567,'��Ŀ�ֶξ���') 
GO
insert into HtmlLabelIndex values(15568,'��Ŀ�ֶηֲ�') 
GO
insert into HtmlLabelIndex values(15569,'��Ŀ�ֶβ���') 
GO
insert into HtmlLabelIndex values(15570,'��Ŀ�ֶγ�Ա') 
GO
insert into HtmlLabelIndex values(15571,'�ʲ��ֶι���Ա') 
GO
insert into HtmlLabelIndex values(15572,'�ʲ��ֶηֲ�') 
GO
insert into HtmlLabelIndex values(15573,'�ʲ��ֶβ���') 
GO
insert into HtmlLabelIndex values(15574,'�ͻ��ֶξ���') 
GO
insert into HtmlLabelIndex values(15575,'�ͻ��ֶ���ϵ�˾���') 
GO
insert into HtmlLabelIndex values(15576,'����������') 
GO
insert into HtmlLabelIndex values(15577,'�����˱��ֲ�') 
GO
insert into HtmlLabelIndex values(15578,'�������ϼ�����') 
GO
insert into HtmlLabelIndex values(15579,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(15580,'�ͻ��ֶα���') 
GO
insert into HtmlLabelIndex values(15581,'���пͻ�') 
GO
insert into HtmlLabelIndex values(15582,'�������') 
GO
insert into HtmlLabelIndex values(15583,'ɾ������') 
GO
insert into HtmlLabelIndex values(15584,'����ѡ����������ֵ') 
GO
insert into HtmlLabelIndex values(15585,'����ǩ') 
GO
insert into HtmlLabelIndex values(15586,'�ڵ�') 
GO
insert into HtmlLabelIndex values(15587,'����') 
GO
insert into HtmlLabelIndex values(15588,'�Ƿ��Ż����') 
GO
insert into HtmlLabelIndex values(15589,'���Ż����') 
GO
insert into HtmlLabelIndex values(15590,'����') 
GO
insert into HtmlLabelIndex values(15591,'�Ƿ���Ч') 
GO
insert into HtmlLabelIndex values(15592,'�Ƿ���') 
GO
insert into HtmlLabelIndex values(15593,'�����ĵ�') 
GO
insert into HtmlLabelIndex values(15594,'����������') 
GO
insert into HtmlLabelIndex values(15595,'���͵Ľڵ�����ֻ����һ��') 
GO
insert into HtmlLabelIndex values(15596,'�������ڵ�') 
GO
insert into HtmlLabelIndex values(15597,'��ѡ��ڵ�����') 
GO
insert into HtmlLabelIndex values(15598,'��ӽڵ�') 
GO
insert into HtmlLabelIndex values(15599,'ɾ���ڵ�') 
GO
insert into HtmlLabelIndex values(15600,'��Ӧ��') 
GO
insert into HtmlLabelIndex values(15601,'�ֶ���Ϣ') 
GO
insert into HtmlLabelIndex values(15602,'��ѡ��ǰ�ڵ�') 
GO
insert into HtmlLabelIndex values(15603,'�Ƿ���ʾ') 
GO
insert into HtmlLabelIndex values(15604,'�Ƿ�ɱ༭') 
GO
insert into HtmlLabelIndex values(15605,'�Ƿ��������') 
GO
insert into HtmlLabelIndex values(15606,'������Ϣ') 
GO
insert into HtmlLabelIndex values(15607,'��ӳ���') 
GO
insert into HtmlLabelIndex values(15608,'ɾ������') 
GO
insert into HtmlLabelIndex values(15609,'�Ƿ�reject') 
GO
insert into HtmlLabelIndex values(15610,'���ӹ���') 
GO
insert into HtmlLabelIndex values(15611,'��������') 
GO
insert into HtmlLabelIndex values(15612,'��ѡ��Ŀ��ڵ�') 
GO
insert into HtmlLabelIndex values(15613,'���ȱ����²���Ľڵ����') 
GO
insert into HtmlLabelIndex values(15614,'����ҳʹ���˿�ܣ��������������֧�ֿ�ܡ�') 
GO
insert into HtmlLabelIndex values(15615,'�ڵ���Ϣ') 
GO
insert into HtmlLabelIndex values(15616,'���Ӳ���') 
GO
insert into HtmlLabelIndex values(15617,'ɾ����������ɾ���ù������µ���������,�����ܵ���ϵͳ�������Щ��������ӳ��ִ���!') 
GO
insert into HtmlLabelIndex values(15618,'��һ�ֶ�') 
GO
insert into HtmlLabelIndex values(15619,'�ڶ��ֶ�') 
GO
insert into HtmlLabelIndex values(15620,'Ŀ���ֶ�') 
GO
insert into HtmlLabelIndex values(15621,'��') 
GO
insert into HtmlLabelIndex values(15622,'��') 
GO
insert into HtmlLabelIndex values(15623,'��') 
GO
insert into HtmlLabelIndex values(15624,'��') 
GO
insert into HtmlLabelIndex values(15625,'��ǰ����') 
GO
insert into HtmlLabelIndex values(15626,'��ǰʱ��') 
GO
insert into HtmlLabelIndex values(15627,'��ʱʱ�����') 
GO
insert into HtmlLabelIndex values(15628,'��ʱ���ڱ���') 
GO
insert into HtmlLabelIndex values(15629,'��ʱ�ı�����') 
GO
insert into HtmlLabelIndex values(15630,'��ʱ���ͱ���') 
GO
insert into HtmlLabelIndex values(15631,'��ʱ�����ͱ���') 
GO
insert into HtmlLabelIndex values(15632,'�Զ���ֵ') 
GO
insert into HtmlLabelIndex values(15633,'�Ƿ�������ĩ') 
GO
insert into HtmlLabelIndex values(15634,'�Ƿ�������������') 
GO
insert into HtmlLabelIndex values(15635,'���㷨��') 
GO
insert into HtmlLabelIndex values(15636,'���ʽ') 
GO
insert into HtmlLabelIndex values(15637,'��������') 
GO
insert into HtmlLabelIndex values(15638,'������ĩ') 
GO
insert into HtmlLabelIndex values(15639,'������������') 
GO
insert into HtmlLabelIndex values(15640,'����ѡ���һ���ֶ�') 
GO
insert into HtmlLabelIndex values(15641,'����ѡ���������') 
GO
insert into HtmlLabelIndex values(15642,'Ŀ���ֶβ���Ϊ��') 
GO
insert into HtmlLabelIndex values(15643,'�������Ͳ�ƥ��') 
GO
insert into HtmlLabelIndex values(15644,'���������Ͳ�ƥ��') 
GO
insert into HtmlLabelIndex values(15645,'�������Ͳ�ƥ��') 
GO
insert into HtmlLabelIndex values(15646,'ʱ�����Ͳ�ƥ��') 
GO
insert into HtmlLabelIndex values(15647,'����������Ϣ') 
GO
insert into HtmlLabelIndex values(15648,'��������') 
GO
insert into HtmlLabelIndex values(15649,'�ܳɼ�') 
GO
insert into HtmlLabelIndex values(15650,'�ܿ�����') 
GO
insert into HtmlLabelIndex values(15651,'�ѿ�����') 
GO
insert into HtmlLabelIndex values(15652,'��ǰ����') 
GO
insert into HtmlLabelIndex values(15653,'��������') 
GO
insert into HtmlLabelIndex values(15654,'�ܵı�������') 
GO
insert into HtmlLabelIndex values(15655,'�ܵĿ�����') 
GO
insert into HtmlLabelIndex values(15656,'����ɿ���') 
GO
insert into HtmlLabelIndex values(15657,'�ɼ�') 
GO
insert into HtmlLabelIndex values(15658,'����') 
GO
insert into HtmlLabelIndex values(15659,'�ϸ�') 
GO
insert into HtmlLabelIndex values(15660,'��') 
GO
insert into HtmlLabelIndex values(15661,'����') 
GO
insert into HtmlLabelIndex values(15662,'������') 
GO
insert into HtmlLabelIndex values(15663,'�ܷ�') 
GO
insert into HtmlLabelIndex values(15664,'������Ա') 
GO
insert into HtmlLabelIndex values(15665,'���ͱ���') 
GO
insert into HtmlLabelIndex values(15666,'��������') 
GO
insert into HtmlLabelIndex values(15667,'�������') 
GO
insert into HtmlLabelIndex values(15668,'��Ƹ����') 
GO
insert into HtmlLabelIndex values(15669,'֪ͨ��') 
GO
insert into HtmlLabelIndex values(15670,'��Ա����ְ����') 
GO
insert into HtmlLabelIndex values(15671,'ӦƸ��λ') 
GO
insert into HtmlLabelIndex values(15672,'���θ�λ') 
GO
insert into HtmlLabelIndex values(15673,'��н����') 
GO
insert into HtmlLabelIndex values(15674,'����') 
GO
insert into HtmlLabelIndex values(15675,'ӦƸ�����') 
GO
insert into HtmlLabelIndex values(15676,'�뿪ԭ��') 
GO
insert into HtmlLabelIndex values(15677,'��ѵ���') 
GO
insert into HtmlLabelIndex values(15678,'��ѵ����') 
GO
insert into HtmlLabelIndex values(15679,'��ѵ��ʼ����') 
GO
insert into HtmlLabelIndex values(15680,'��ѵ��������') 
GO
insert into HtmlLabelIndex values(15681,'�䷢��λ') 
GO
insert into HtmlLabelIndex values(15682,'�������') 
GO
insert into HtmlLabelIndex values(15683,'����') 
GO
insert into HtmlLabelIndex values(15684,'�����Ա') 
GO
insert into HtmlLabelIndex values(15685,'��ס֤����') 
GO
insert into HtmlLabelIndex values(15686,'��ͥ״��') 
GO
insert into HtmlLabelIndex values(15687,'������Ϣ') 
GO
insert into HtmlLabelIndex values(15688,'������Ϣ') 
GO
insert into HtmlLabelIndex values(15689,'����') 
GO
insert into HtmlLabelIndex values(15690,'��̭') 
GO
insert into HtmlLabelIndex values(15691,'�ʼ�֪ͨ') 
GO
insert into HtmlLabelIndex values(15692,'��Ƹ��Ϣ����ʱ��') 
GO
insert into HtmlLabelIndex values(15693,'���п���') 
GO
insert into HtmlLabelIndex values(15694,'��������') 
GO
insert into HtmlLabelIndex values(15695,'������') 
GO
insert into HtmlLabelIndex values(15696,'��������') 
GO
insert into HtmlLabelIndex values(15697,'�������') 
GO
insert into HtmlLabelIndex values(15698,'����') 
GO
insert into HtmlLabelIndex values(15699,'���ϸ�') 
GO
insert into HtmlLabelIndex values(15700,'��') 
GO
insert into HtmlLabelIndex values(15701,'���п���') 
GO
insert into HtmlLabelIndex values(15702,'��������') 
GO
insert into HtmlLabelIndex values(15703,'���˽��') 
GO
insert into HtmlLabelIndex values(15704,'����') 
GO
insert into HtmlLabelIndex values(15705,'�Ƿ���֪ͨ') 
GO
insert into HtmlLabelIndex values(15706,'δ����') 
GO
insert into HtmlLabelIndex values(15707,'��Ƭ') 
GO
insert into HtmlLabelIndex values(15708,'ְ������') 
GO
insert into HtmlLabelIndex values(15709,'ֱ���ϼ�') 
GO
insert into HtmlLabelIndex values(15710,'����') 
GO
insert into HtmlLabelIndex values(15711,'��ʽ') 
GO
insert into HtmlLabelIndex values(15712,'�칫�ص�') 
GO
insert into HtmlLabelIndex values(15713,'�칫�绰') 
GO
insert into HtmlLabelIndex values(15714,'�����绰') 
GO
insert into HtmlLabelIndex values(15715,'ˮƽ') 
GO
insert into HtmlLabelIndex values(15716,'��ְǰ��������') 
GO
insert into HtmlLabelIndex values(15717,'��ְǰ��ѵ') 
GO
insert into HtmlLabelIndex values(15718,'��ְǰ����') 
GO
insert into HtmlLabelIndex values(15719,'���Ϸ���') 
GO
insert into HtmlLabelIndex values(15720,'��Ƹ�ճ�') 
GO
insert into HtmlLabelIndex values(15721,'�����') 
GO
insert into HtmlLabelIndex values(15722,'��˿�ʼ����') 
GO
insert into HtmlLabelIndex values(15723,'��˽�������') 
GO
insert into HtmlLabelIndex values(15724,'֪ͨ����') 
GO
insert into HtmlLabelIndex values(15725,'֪ͨ����') 
GO
insert into HtmlLabelIndex values(15726,'ȷ��Ҫ֪ͨ�������?') 
GO
insert into HtmlLabelIndex values(15727,'���Կ���֪ͨ') 
GO
insert into HtmlLabelIndex values(15728,'�ܽὨ��') 
GO
insert into HtmlLabelIndex values(15729,'������Ϣ') 
GO
insert into HtmlLabelIndex values(15730,'��������') 
GO
insert into HtmlLabelIndex values(15731,'���Բ���') 
GO
insert into HtmlLabelIndex values(15732,'��������') 
GO
insert into HtmlLabelIndex values(15733,'��������') 
GO
insert into HtmlLabelIndex values(15734,'����ʱ��') 
GO
insert into HtmlLabelIndex values(15735,'���Եص�') 
GO
insert into HtmlLabelIndex values(15736,'ע������') 
GO
insert into HtmlLabelIndex values(15737,'���Խ��') 
GO
insert into HtmlLabelIndex values(15738,'�������') 
GO
insert into HtmlLabelIndex values(15739,'������') 
GO
insert into HtmlLabelIndex values(15740,'ȷ��Ҫ��̭��') 
GO
insert into HtmlLabelIndex values(15741,'ȷ��Ҫͨ����') 
GO
insert into HtmlLabelIndex values(15742,'ȷ��Ҫת�뱸�ÿ���') 
GO
insert into HtmlLabelIndex values(15743,'��Ƹ����֪ͨ') 
GO
insert into HtmlLabelIndex values(15744,'��Ƹʱ��') 
GO
insert into HtmlLabelIndex values(15745,'��Ƹ����') 
GO
insert into HtmlLabelIndex values(15746,'δ����') 
GO
insert into HtmlLabelIndex values(15747,'������Ƹ') 
GO
insert into HtmlLabelIndex values(15748,'������') 
GO
insert into HtmlLabelIndex values(15749,'����') 
GO
insert into HtmlLabelIndex values(15750,'ʧЧ') 
GO
insert into HtmlLabelIndex values(15751,'ȷ��Ҫ�ر���') 
GO
insert into HtmlLabelIndex values(15752,'����˵��') 
GO
insert into HtmlLabelIndex values(15753,'����������') 
GO
insert into HtmlLabelIndex values(15754,'������˵��') 
GO
insert into HtmlLabelIndex values(15755,'������������') 
GO
insert into HtmlLabelIndex values(15756,'��������') 
GO
insert into HtmlLabelIndex values(15757,'������') 
GO
insert into HtmlLabelIndex values(15758,'���˿�ʼ����') 
GO
insert into HtmlLabelIndex values(15759,'��������') 
GO
insert into HtmlLabelIndex values(15760,'���˲�����') 
GO
insert into HtmlLabelIndex values(15761,'������') 
GO
insert into HtmlLabelIndex values(15762,'�����ϼ�') 
GO
insert into HtmlLabelIndex values(15763,'����') 
GO
insert into HtmlLabelIndex values(15764,'ֱ���¼�') 
GO
insert into HtmlLabelIndex values(15765,'�����¼�') 
GO
insert into HtmlLabelIndex values(15766,'������������') 
GO
insert into HtmlLabelIndex values(15767,'ȫ��') 
GO
insert into HtmlLabelIndex values(15768,'��˾��վ') 
GO
insert into HtmlLabelIndex values(15769,'�����ֳɱ�����') 
GO
insert into HtmlLabelIndex values(15770,'�½��ɱ�����') 
GO
insert into HtmlLabelIndex values(15771,'���Ʋ��Žṹͼ����') 
GO
insert into HtmlLabelIndex values(15772,'�ϼ�����') 
GO
insert into HtmlLabelIndex values(15773,'�ϼ����Ų���Ϊ������!') 
GO
insert into HtmlLabelIndex values(15774,'��������') 
GO
insert into HtmlLabelIndex values(15775,'��ͬ����') 
GO
insert into HtmlLabelIndex values(15776,'��ͬ��') 
GO
insert into HtmlLabelIndex values(15777,'��ͬ��ֹ����') 
GO
insert into HtmlLabelIndex values(15778,'�����ڽ�������') 
GO
insert into HtmlLabelIndex values(15779,'�������ͬ�ˣ���') 
GO
insert into HtmlLabelIndex values(15780,'��ͬ���') 
GO
insert into HtmlLabelIndex values(15781,'֪ͨ') 
GO
insert into HtmlLabelIndex values(15782,'ȷ��Ҫ֪ͨ��') 
GO
insert into HtmlLabelIndex values(15783,'������Դ��ͬ����֪ͨ') 
GO
insert into HtmlLabelIndex values(15784,'�����ڵ���֪ͨ') 
GO
insert into HtmlLabelIndex values(15785,'ѡ���ͬ���') 
GO
insert into HtmlLabelIndex values(15786,'��ͬģ��') 
GO
insert into HtmlLabelIndex values(15787,'���Ŀ¼') 
GO
insert into HtmlLabelIndex values(15788,'��ְ��ͬ') 
GO
insert into HtmlLabelIndex values(15789,'������ǰ������') 
GO
insert into HtmlLabelIndex values(15790,'��Ӧģ��') 
GO
insert into HtmlLabelIndex values(15791,'�Ƿ�Ϊ��ְ��ͬ') 
GO
insert into HtmlLabelIndex values(15792,'������ǰ����') 
GO
insert into HtmlLabelIndex values(15793,'������') 
GO
insert into HtmlLabelIndex values(15794,'�������ͬģ��') 
GO
insert into HtmlLabelIndex values(15795,'��������') 
GO
insert into HtmlLabelIndex values(15796,'�鿴��Ա��') 
GO
insert into HtmlLabelIndex values(15797,'��ְ����') 
GO
insert into HtmlLabelIndex values(15798,'������ְ�趨') 
GO
insert into HtmlLabelIndex values(15799,'�ʼ��ʻ�') 
GO
insert into HtmlLabelIndex values(15800,'һ��ͨ') 
GO
insert into HtmlLabelIndex values(15801,'��λ��') 
GO
insert into HtmlLabelIndex values(15802,'�ֻ�ֱ��') 
GO
insert into HtmlLabelIndex values(15803,'������ȷ�����벻����') 
GO
insert into HtmlLabelIndex values(15804,'ϵͳ��Ϣ') 
GO
insert into HtmlLabelIndex values(15805,'������Ϣ') 
GO
insert into HtmlLabelIndex values(15806,'�ʲ���Ϣ') 
GO
insert into HtmlLabelIndex values(15807,'��������Ա') 
GO
insert into HtmlLabelIndex values(15808,'δ����') 
GO
insert into HtmlLabelIndex values(15809,'������') 
GO
insert into HtmlLabelIndex values(15810,'ȷ��Ҫ�����Ա��������') 
GO
insert into HtmlLabelIndex values(15811,'��һЩ����û����ɣ�ȷ��Ҫǿ�������Ա��������') 
GO
insert into HtmlLabelIndex values(15812,'��������') 
GO
insert into HtmlLabelIndex values(15813,'��������Դ�����ʻ�ʹ�ø�����,�����в���ɾ��') 
GO
insert into HtmlLabelIndex values(15814,'н�����') 
GO
insert into HtmlLabelIndex values(15815,'������Ŀ') 
GO
insert into HtmlLabelIndex values(15816,'�ı�Ϊ') 
GO
insert into HtmlLabelIndex values(15817,'������ʷ') 
GO
insert into HtmlLabelIndex values(15818,'��������') 
GO
insert into HtmlLabelIndex values(15819,'������Ŀ') 
GO
insert into HtmlLabelIndex values(15820,'��������') 
GO
insert into HtmlLabelIndex values(15821,'��������') 
GO
insert into HtmlLabelIndex values(15822,'����н��') 
GO
insert into HtmlLabelIndex values(15823,'������') 
GO
insert into HtmlLabelIndex values(15824,'���ʱ���ʾ') 
GO
insert into HtmlLabelIndex values(15825,'����') 
GO
insert into HtmlLabelIndex values(15826,'˰��') 
GO
insert into HtmlLabelIndex values(15827,'˰�ջ�׼��Ŀ') 
GO
insert into HtmlLabelIndex values(15828,'���㹫ʽ') 
GO
insert into HtmlLabelIndex values(15829,'�����������') 
GO
insert into HtmlLabelIndex values(15830,'ע�⣺ ����ֻ��ΪӢ����ĸ�Ͱ�������ֵ��Ӣ����ĸ��Сд���У�') 
GO
insert into HtmlLabelIndex values(15831,'ְ����') 
GO
insert into HtmlLabelIndex values(15832,'ְ����') 
GO
insert into HtmlLabelIndex values(15833,'����') 
GO
insert into HtmlLabelIndex values(15834,'˰��') 
GO
insert into HtmlLabelIndex values(15835,'˰�ջ���') 
GO
insert into HtmlLabelIndex values(15836,'����') 
GO
insert into HtmlLabelIndex values(15837,'��˰����(��)') 
GO
insert into HtmlLabelIndex values(15838,'��˰����(��)') 
GO
insert into HtmlLabelIndex values(15839,'������') 
GO
insert into HtmlLabelIndex values(15840,'���������ո������õĹ�����������������Դ���ʱ�,') 
GO
insert into HtmlLabelIndex values(15841,'��ǰ���������иĶ������ı�,�Ƿ����') 
GO
insert into HtmlLabelIndex values(15842,'������Դ״̬') 
GO
insert into HtmlLabelIndex values(15843,'��׼����') 
GO
insert into HtmlLabelIndex values(15844,'��������') 
GO
insert into HtmlLabelIndex values(15845,'���ɹ��ʵ�') 
GO
insert into HtmlLabelIndex values(15846,'��������') 
GO
insert into HtmlLabelIndex values(15847,'�޸Ĺ��ʵ�') 
GO
insert into HtmlLabelIndex values(15848,'���͹��ʵ�') 
GO
insert into HtmlLabelIndex values(15849,'���ʵ�����') 
GO
insert into HtmlLabelIndex values(15850,'δ���ɵ�ǰ�¹��ʵ�') 
GO
insert into HtmlLabelIndex values(15851,'�������ɹ��ʵ�����ʧ�Ըù��ʵ��������޸���Ϣ���Ƿ������') 
GO
insert into HtmlLabelIndex values(15852,'���ʵ����ͽ�ʹϵͳ��Ա�����Լ����µĹ��ʣ��Ƿ������') 
GO
insert into HtmlLabelIndex values(15853,'�Ƿ���Ҫ���¼���˰����ͼ����') 
GO
insert into HtmlLabelIndex values(15854,'ְ������') 
GO
insert into HtmlLabelIndex values(15855,'����ְ��') 
GO
insert into HtmlLabelIndex values(15856,'��λְ��') 
GO
insert into HtmlLabelIndex values(15857,'�������� /����') 
GO
insert into HtmlLabelIndex values(15858,'��ϵ��ʽ') 
GO
insert into HtmlLabelIndex values(15859,'��Ҫ��Ϣ��������') 
GO
insert into HtmlLabelIndex values(15860,'��������') 
GO
insert into HtmlLabelIndex values(15861,'������') 
GO
insert into HtmlLabelIndex values(15862,'��Ա����ͳ��') 
GO
insert into HtmlLabelIndex values(15863,'��') 
GO
insert into HtmlLabelIndex values(15864,'��') 
GO
insert into HtmlLabelIndex values(15865,'��Ա�ɱ�����ͳ��') 
GO
insert into HtmlLabelIndex values(15866,'��Ա����ͳ��') 
GO
insert into HtmlLabelIndex values(15867,'��Աѧ��ͳ��') 
GO
insert into HtmlLabelIndex values(15868,'��Աְ��ͳ��') 
GO
insert into HtmlLabelIndex values(15869,'��Աְ��ͳ��') 
GO
insert into HtmlLabelIndex values(15870,'��Աְ�����ͳ��') 
GO
insert into HtmlLabelIndex values(15871,'ְ������') 
GO
insert into HtmlLabelIndex values(15872,'��') 
GO
insert into HtmlLabelIndex values(15873,'��Աְ��ͳ��') 
GO
insert into HtmlLabelIndex values(15874,'��Ա��λͳ��') 
GO
insert into HtmlLabelIndex values(15875,'��Ա����״��ͳ��') 
GO
insert into HtmlLabelIndex values(15876,'�������ͳ��') 
GO
insert into HtmlLabelIndex values(15877,'������Դ״��') 
GO
insert into HtmlLabelIndex values(15878,'����') 
GO
insert into HtmlLabelIndex values(15879,'��ѵ��Դ') 
GO
insert into HtmlLabelIndex values(15880,'����') 
GO
insert into HtmlLabelIndex values(15881,'������ʹ�����') 
GO
insert into HtmlLabelIndex values(15882,'���¹���') 
GO
insert into HtmlLabelIndex values(15883,'������Ա') 
GO
insert into HtmlLabelIndex values(15884,'��Ƹ') 
GO
insert into HtmlLabelIndex values(15885,'ӦƸ��Ա') 
GO
insert into HtmlLabelIndex values(15886,'��¡����ս��Ͷ�����޹�˾') 
GO
insert into HtmlLabelIndex values(15887,'������ͳ��ͼ') 
GO
insert into HtmlLabelIndex values(15888,'��Ա��ȫ����ͳ��') 
GO
insert into HtmlLabelIndex values(15889,'��Ա�Ա�ͳ��') 
GO
insert into HtmlLabelIndex values(15890,'Ա��״̬') 
GO
insert into HtmlLabelIndex values(15891,'��Ա״̬ͳ��') 
GO
insert into HtmlLabelIndex values(15892,'�滮����') 
GO
insert into HtmlLabelIndex values(15893,'�滮������') 
GO
insert into HtmlLabelIndex values(15894,'�滮����ʱ��') 
GO
insert into HtmlLabelIndex values(15895,'�滮��ʼʱ��') 
GO
insert into HtmlLabelIndex values(15896,'�滮����ʱ��') 
GO
insert into HtmlLabelIndex values(15897,'�滮����') 
GO
insert into HtmlLabelIndex values(15898,'�滮Ŀ��') 
GO
insert into HtmlLabelIndex values(15899,'�μ���') 
GO
insert into HtmlLabelIndex values(15900,'��ѵ�滮����') 
GO
insert into HtmlLabelIndex values(15901,'��ػ�������') 
GO
insert into HtmlLabelIndex values(15902,'��ػ�������') 
GO
insert into HtmlLabelIndex values(15903,'�����ѵ��') 
GO
insert into HtmlLabelIndex values(15904,'���������') 
GO
insert into HtmlLabelIndex values(15905,'���������') 
GO
insert into HtmlLabelIndex values(15906,'������') 
GO
insert into HtmlLabelIndex values(15907,'����') 
GO
insert into HtmlLabelIndex values(15908,'һ����') 
GO
insert into HtmlLabelIndex values(15909,'����') 
GO
insert into HtmlLabelIndex values(15910,'�ܺ���') 
GO
insert into HtmlLabelIndex values(15911,'��������') 
GO
insert into HtmlLabelIndex values(15912,'������') 
GO
insert into HtmlLabelIndex values(15913,'������') 
GO
insert into HtmlLabelIndex values(15914,'������') 
GO
insert into HtmlLabelIndex values(15915,'��ѵ��֯��') 
GO
insert into HtmlLabelIndex values(15916,'��ѵ����') 
GO
insert into HtmlLabelIndex values(15917,'��ѵĿ��') 
GO
insert into HtmlLabelIndex values(15918,'��ѵ�ص�') 
GO
insert into HtmlLabelIndex values(15919,'�����') 
GO
insert into HtmlLabelIndex values(15920,'�������') 
GO
insert into HtmlLabelIndex values(15921,'��ѵ�滮������') 
GO
insert into HtmlLabelIndex values(15922,'��ѵ�������') 
GO
insert into HtmlLabelIndex values(15923,'��ѵ��Դ����') 
GO
insert into HtmlLabelIndex values(15924,'��Դ����') 
GO
insert into HtmlLabelIndex values(15925,'��ѵ��Դ�������') 
GO
insert into HtmlLabelIndex values(15926,'��Ա�ù�����ͳ��') 
GO
insert into HtmlLabelIndex values(15927,'��������') 
GO
insert into HtmlLabelIndex values(15928,'��Ա����ͳ��') 
GO
insert into HtmlLabelIndex values(15929,'������Դ����') 
GO
insert into HtmlLabelIndex values(15930,'����') 
GO
insert into HtmlLabelIndex values(15931,'ӦƸ����') 
GO
insert into HtmlLabelIndex values(15932,'���') 
GO
insert into HtmlLabelIndex values(15933,'���') 
GO
insert into HtmlLabelIndex values(15934,'��λ����') 
GO
insert into HtmlLabelIndex values(15935,'��ʾ����') 
GO
insert into HtmlLabelIndex values(15936,'ӦƸ��Ա����ͳ��') 
GO
insert into HtmlLabelIndex values(15937,'ӦƸ���') 
GO
insert into HtmlLabelIndex values(15938,'����ͳ��') 
GO
insert into HtmlLabelIndex values(15939,'��ͬ����') 
GO
insert into HtmlLabelIndex values(15940,'���ͬ����') 
GO
insert into HtmlLabelIndex values(15941,'���ź�ͬͳ��') 
GO
insert into HtmlLabelIndex values(15942,'��ͬ���ͳ��') 
GO
insert into HtmlLabelIndex values(15943,'��ͬʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(15944,'��ͬ����ʱ��') 
GO
insert into HtmlLabelIndex values(15945,'���˴�') 
GO
insert into HtmlLabelIndex values(15946,'��ͬ��') 
GO
insert into HtmlLabelIndex values(15947,'��ͬ����ͳ��') 
GO
insert into HtmlLabelIndex values(15948,'��ͬͳ��') 
GO
insert into HtmlLabelIndex values(15949,'��ͬ������Ϣ����') 
GO
insert into HtmlLabelIndex values(15950,'��ͬ����') 
GO
insert into HtmlLabelIndex values(15951,'��ͬ��λ') 
GO
insert into HtmlLabelIndex values(15952,'��ͬʱ��') 
GO
insert into HtmlLabelIndex values(15953,'��ͬ����') 
GO
insert into HtmlLabelIndex values(15954,'��ǩʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(15955,'��ְ����') 
GO
insert into HtmlLabelIndex values(15956,'����ְ����') 
GO
insert into HtmlLabelIndex values(15957,'������ְͳ��') 
GO
insert into HtmlLabelIndex values(15958,'��ְʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(15959,'��ְ����ͳ��') 
GO
insert into HtmlLabelIndex values(15960,'��ְ������Ϣ����') 
GO
insert into HtmlLabelIndex values(15961,'��ְ����') 
GO
insert into HtmlLabelIndex values(15962,'��ǩ����') 
GO
insert into HtmlLabelIndex values(15963,'����ǩ����') 
GO
insert into HtmlLabelIndex values(15964,'������ǩͳ��') 
GO
insert into HtmlLabelIndex values(15965,'��ǩʱ��') 
GO
insert into HtmlLabelIndex values(15966,'��ǩ����ʱ��') 
GO
insert into HtmlLabelIndex values(15967,'��ǩ����ͳ��') 
GO
insert into HtmlLabelIndex values(15968,'��ǩͳ��') 
GO
insert into HtmlLabelIndex values(15969,'��ǩ������Ϣ����') 
GO
insert into HtmlLabelIndex values(15970,'��ǩ����') 
GO
insert into HtmlLabelIndex values(15971,'��ǩ��������') 
GO
insert into HtmlLabelIndex values(15972,'��Ƹ����') 
GO
insert into HtmlLabelIndex values(15973,'���Ƹ����') 
GO
insert into HtmlLabelIndex values(15974,'���Ž�Ƹͳ��') 
GO
insert into HtmlLabelIndex values(15975,'��Ƹʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(15976,'��Ƹʱ��') 
GO
insert into HtmlLabelIndex values(15977,'��Ƹ����ͳ��') 
GO
insert into HtmlLabelIndex values(15978,'��Ƹͳ��') 
GO
insert into HtmlLabelIndex values(15979,'��Ƹ������Ϣ����') 
GO
insert into HtmlLabelIndex values(15980,'��Ƹ����') 
GO
insert into HtmlLabelIndex values(15981,'ת������') 
GO
insert into HtmlLabelIndex values(15982,'��ת������') 
GO
insert into HtmlLabelIndex values(15983,'����ת��ͳ��') 
GO
insert into HtmlLabelIndex values(15984,'ת��ʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(15985,'ת��ʱ��') 
GO
insert into HtmlLabelIndex values(15986,'ת������ͳ��') 
GO
insert into HtmlLabelIndex values(15987,'ת��ͳ��') 
GO
insert into HtmlLabelIndex values(15988,'ת��������Ϣ����') 
GO
insert into HtmlLabelIndex values(15989,'��������') 
GO
insert into HtmlLabelIndex values(15990,'���������') 
GO
insert into HtmlLabelIndex values(15991,'���ŵ���ͳ��') 
GO
insert into HtmlLabelIndex values(15992,'����ʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(15993,'����ʱ��') 
GO
insert into HtmlLabelIndex values(15994,'����ǰְ��') 
GO
insert into HtmlLabelIndex values(15995,'������ְ��') 
GO
insert into HtmlLabelIndex values(15996,'��������ͳ��') 
GO
insert into HtmlLabelIndex values(15997,'����ͳ��') 
GO
insert into HtmlLabelIndex values(15998,'����������Ϣ����') 
GO
insert into HtmlLabelIndex values(15999,'������λ') 
GO
insert into HtmlLabelIndex values(16000,'�����λ') 
GO
insert into HtmlLabelIndex values(16001,'��������') 
GO
insert into HtmlLabelIndex values(16002,'��Ƹ����') 
GO
insert into HtmlLabelIndex values(16003,'�귵Ƹ����') 
GO
insert into HtmlLabelIndex values(16004,'��Ƹʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(16005,'��Ƹʱ��') 
GO
insert into HtmlLabelIndex values(16006,'��Ƹ����ʱ��') 
GO
insert into HtmlLabelIndex values(16007,'��Ƹ����ͳ��') 
GO
insert into HtmlLabelIndex values(16008,'��Ƹͳ��') 
GO
insert into HtmlLabelIndex values(16009,'��Ƹ������Ϣ����') 
GO
insert into HtmlLabelIndex values(16010,'��Ƹ����') 
GO
insert into HtmlLabelIndex values(16011,'��Ƹ��λ') 
GO
insert into HtmlLabelIndex values(16012,'��Ƹ����') 
GO
insert into HtmlLabelIndex values(16013,'��Ƹ��������') 
GO
insert into HtmlLabelIndex values(16014,'���ŷ�Ƹͳ��') 
GO
insert into HtmlLabelIndex values(16015,'��ͥ��ϵ����') 
GO
insert into HtmlLabelIndex values(16016,'�����ʺ�') 
GO
insert into HtmlLabelIndex values(16017,'��½�ʺ�') 
GO
insert into HtmlLabelIndex values(16018,'��ͥ��ϵ��ʽ') 
GO
insert into HtmlLabelIndex values(16019,'����ͳ��') 
GO
insert into HtmlLabelIndex values(16020,'����ʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(16021,'���벿��ͳ��') 
GO
insert into HtmlLabelIndex values(16022,'������Ա����') 
GO
insert into HtmlLabelIndex values(16023,'��������Ա����') 
GO
insert into HtmlLabelIndex values(16024,'����ʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(16025,'���ݱ���') 
GO
insert into HtmlLabelIndex values(16026,'�����ݱ���') 
GO
insert into HtmlLabelIndex values(16027,'��������ͳ��') 
GO
insert into HtmlLabelIndex values(16028,'����ʱ��ͳ��') 
GO
insert into HtmlLabelIndex values(16029,'����ʱ��') 
GO
insert into HtmlLabelIndex values(16030,'���ݲ���ͳ��') 
GO
insert into HtmlLabelIndex values(16031,'����ͳ��') 
GO
insert into HtmlLabelIndex values(16032,'���ݾ�����Ϣ����') 
GO
insert into HtmlLabelIndex values(16033,'���ݲ���') 
GO
insert into HtmlLabelIndex values(16034,'���ݸ�λ') 
GO
insert into HtmlLabelIndex values(16035,'��������') 
GO
insert into HtmlLabelIndex values(16036,'�˴�ͳ��') 
GO
insert into HtmlLabelIndex values(16037,'���ڿ�ʼ����') 
GO
insert into HtmlLabelIndex values(16038,'���ڽ�������') 
GO
insert into HtmlLabelIndex values(16039,'���ڿ�ʼʱ��') 
GO
insert into HtmlLabelIndex values(16040,'���ڽ���ʱ��') 
GO
insert into HtmlLabelIndex values(16041,'�䶯����') 
GO
insert into HtmlLabelIndex values(16042,'���ڲ���ͳ��') 
GO
insert into HtmlLabelIndex values(16043,'����ͳ��') 
GO
insert into HtmlLabelIndex values(16044,'�������') 
GO
insert into HtmlLabelIndex values(16045,'���ڲ���') 
GO
insert into HtmlLabelIndex values(16046,'���౨��') 
GO
insert into HtmlLabelIndex values(16047,'������������') 
GO
insert into HtmlLabelIndex values(16048,'������Ա') 
GO
insert into HtmlLabelIndex values(16049,'�·ݱ���') 
GO
insert into HtmlLabelIndex values(16050,'�����ڲ���') 
GO
insert into HtmlLabelIndex values(16051,'����Ա') 
GO
insert into HtmlLabelIndex values(16052,'�·��˴α���') 
GO
insert into HtmlLabelIndex values(16053,'�·���������') 
GO
insert into HtmlLabelIndex values(16054,'���ھ�����Ϣ����') 
GO
insert into HtmlLabelIndex values(16055,'��������') 
GO
insert into HtmlLabelIndex values(16056,'ʵ�ʼ���ʱ��') 
GO
insert into HtmlLabelIndex values(16057,'ʵ�ʼ�������') 
GO
insert into HtmlLabelIndex values(16058,'�����˴α���') 
GO
insert into HtmlLabelIndex values(16059,'�꿼������') 
GO
insert into HtmlLabelIndex values(16060,'������Դ�ù�����') 
GO
insert into HtmlLabelIndex values(16061,'�ù���������ͳ��') 
GO
insert into HtmlLabelIndex values(16062,'�ù����������Ϣ����') 
GO
insert into HtmlLabelIndex values(16063,'��������') 
GO
insert into HtmlLabelIndex values(16064,'���ù����󱨱�') 
GO
insert into HtmlLabelIndex values(16065,'���Ϳ���') 
GO
insert into HtmlLabelIndex values(16066,'ϵͳ����') 
GO
insert into HtmlLabelIndex values(16067,'����½����') 
GO
insert into HtmlLabelIndex values(16068,'���ڲμӵ���ѵ�') 
GO
insert into HtmlLabelIndex values(16069,'���Բμӵ���ѵ����') 
GO
insert into HtmlLabelIndex values(16070,'��������') 
GO
insert into HtmlLabelIndex values(16071,'��ʾ��ɫ') 
GO
insert into HtmlLabelIndex values(16072,'��Ա����û������ֱ���ϼ���ȷ����������') 
GO
insert into HtmlLabelIndex values(16073,'��ͬ��ʼ���ڲ��ܴ��ں�ͬ�������ڣ�') 
GO
insert into HtmlLabelIndex values(16074,'�����ص�') 
GO
insert into HtmlLabelIndex values(16075,'ɾ��ͼƬ') 
GO
insert into HtmlLabelIndex values(16076,'��ϵ��Ϣ') 
GO
insert into HtmlLabelIndex values(16077,'��ְ֪ͨ��') 
GO
insert into HtmlLabelIndex values(16078,'��Ч�û����ѵ�license���ޣ�') 
GO
insert into HtmlLabelIndex values(16079,'����ǩ��') 
GO
insert into HtmlLabelIndex values(16080,'��ǩ״̬') 
GO
insert into HtmlLabelIndex values(16081,'��ǩ��ע') 
GO
insert into HtmlLabelIndex values(16082,'��ǩ��ͬ') 
GO
insert into HtmlLabelIndex values(16083,'��ǩ֪ͨ��') 
GO
insert into HtmlLabelIndex values(16084,'�����ʻ�') 
GO
insert into HtmlLabelIndex values(16085,'�������ʻ�') 
GO
insert into HtmlLabelIndex values(16086,'����Ƹ��') 
GO
insert into HtmlLabelIndex values(16087,'��Ƹԭ��') 
GO
insert into HtmlLabelIndex values(16088,'��Ƹ��ͬ') 
GO
insert into HtmlLabelIndex values(16089,'��Ƹ֪ͨ��') 
GO
insert into HtmlLabelIndex values(16090,'��ת����') 
GO
insert into HtmlLabelIndex values(16091,'ת��֪ͨ��') 
GO
insert into HtmlLabelIndex values(16092,'�����޸ĳɹ�') 
GO
insert into HtmlLabelIndex values(16093,'�����ճ�') 
GO
insert into HtmlLabelIndex values(16094,'�ճ�����') 
GO
insert into HtmlLabelIndex values(16095,'��Ŀ�ճ�') 
GO
insert into HtmlLabelIndex values(16096,'���ճ�') 
GO
insert into HtmlLabelIndex values(16097,'���ճ�') 
GO
insert into HtmlLabelIndex values(16098,'���ճ�') 
GO
insert into HtmlLabelIndex values(16099,'�����ճ�') 
GO
insert into HtmlLabelIndex values(16100,'��һ') 
GO
insert into HtmlLabelIndex values(16101,'�ܶ�') 
GO
insert into HtmlLabelIndex values(16102,'����') 
GO
insert into HtmlLabelIndex values(16103,'����') 
GO
insert into HtmlLabelIndex values(16104,'����') 
GO
insert into HtmlLabelIndex values(16105,'����') 
GO
insert into HtmlLabelIndex values(16106,'����') 
GO
insert into HtmlLabelIndex values(16107,'�ָ�λ') 
GO
insert into HtmlLabelIndex values(16108,'����֪ͨ��') 
GO
insert into HtmlLabelIndex values(16109,'����Ƹ��') 
GO
insert into HtmlLabelIndex values(16110,'��Ƹ��ʼ����') 
GO
insert into HtmlLabelIndex values(16111,'��Ƹ��������') 
GO
insert into HtmlLabelIndex values(16112,'��Ƹԭ��') 
GO
insert into HtmlLabelIndex values(16113,'��Ƹ��ͬ') 
GO
insert into HtmlLabelIndex values(16114,'��Ƹ֪ͨ��') 
GO
insert into HtmlLabelIndex values(16115,'������') 
GO
insert into HtmlLabelIndex values(16116,'���ݱ�ע') 
GO
insert into HtmlLabelIndex values(16117,'���ݺ�ͬ') 
GO
insert into HtmlLabelIndex values(16118,'����֪ͨ��') 
GO
insert into HtmlLabelIndex values(16119,'Ա����Ƹ֪ͨ') 
GO
insert into HtmlLabelIndex values(16120,'Ա��ת��֪ͨ') 
GO
insert into HtmlLabelIndex values(16121,'Ա����ǩ֪ͨ') 
GO
insert into HtmlLabelIndex values(16122,'Ա������֪ͨ') 
GO
insert into HtmlLabelIndex values(16123,'Ա����ְ֪ͨ') 
GO
insert into HtmlLabelIndex values(16124,'Ա������֪ͨ') 
GO
insert into HtmlLabelIndex values(16125,'Ա����Ƹ֪ͨ') 
GO
insert into HtmlLabelIndex values(16126,'��½��') 
GO
insert into HtmlLabelIndex values(16127,'����ȷ��') 
GO
insert into HtmlLabelIndex values(16128,'��¼����ͻ������') 
GO
insert into HtmlLabelIndex values(16129,'��¼�û����ѵ�license����,�����������µ��û���¼��Ϣ��') 
GO
insert into HtmlLabelIndex values(16130,'������') 
GO
insert into HtmlLabelIndex values(16131,'����') 
GO
insert into HtmlLabelIndex values(16132,'�ܺ�') 
GO
insert into HtmlLabelIndex values(16133,'�������') 
GO
insert into HtmlLabelIndex values(16134,'�ճ�����') 
GO
insert into HtmlLabelIndex values(16135,'δ�μ�') 
GO
insert into HtmlLabelIndex values(16136,'������¼') 
GO
insert into HtmlLabelIndex values(16137,'�䶯ԭ��') 
GO
insert into HtmlLabelIndex values(16138,'�ܹ�˾') 
GO
insert into HtmlLabelIndex values(16139,'ϵͳ����Ա') 
GO
insert into HtmlLabelIndex values(16140,'�μ���Ա') 
GO
insert into HtmlLabelIndex values(16141,'��֯��') 
GO
insert into HtmlLabelIndex values(16142,'Ŀ��') 
GO
insert into HtmlLabelIndex values(16143,'��ѵ����') 
GO
insert into HtmlLabelIndex values(16144,'��ѵ����') 
GO
insert into HtmlLabelIndex values(16145,'Ч��') 
GO
insert into HtmlLabelIndex values(16146,'��ѵ��Ա') 
GO
insert into HtmlLabelIndex values(16147,'������ѵ��Ѿ���ɾ������') 
GO
insert into HtmlLabelIndex values(16148,'������ѵ��') 
GO
insert into HtmlLabelIndex values(16149,'֪ͨ����') 
GO
insert into HtmlLabelIndex values(16150,'��ѵ�ճ�') 
GO
insert into HtmlLabelIndex values(16151,'������ѵ�ճ�') 
GO
insert into HtmlLabelIndex values(16152,'��ѵ��ܽ�') 
GO
insert into HtmlLabelIndex values(16153,'ʵ����ѵ����') 
GO
insert into HtmlLabelIndex values(16154,'�ܽ���') 
GO
insert into HtmlLabelIndex values(16155,'�ܽ�����') 
GO
insert into HtmlLabelIndex values(16156,'��ѵ����֪ͨ') 
GO
insert into HtmlLabelIndex values(16157,'������ѵ�滮�Ѿ���ɾ������') 
GO
insert into HtmlLabelIndex values(16158,'ʵʩ���') 
GO
insert into HtmlLabelIndex values(16159,'����') 
GO
insert into HtmlLabelIndex values(16160,'�Ϻ�') 
GO
insert into HtmlLabelIndex values(16161,'�¿���') 
GO
insert into HtmlLabelIndex values(16162,'��ѵ�滮����֪ͨ') 
GO
insert into HtmlLabelIndex values(16163,'�Բ�������Ȩ����������ѵ������') 
GO
insert into HtmlLabelIndex values(16164,'��ѵ֪ͨ') 
GO
insert into HtmlLabelIndex values(16165,'�ⲿ��Դ') 
GO
insert into HtmlLabelIndex values(16166,'�ڲ���Դ') 
GO
insert into HtmlLabelIndex values(16167,'����Ȩ����') 
GO
insert into HtmlLabelIndex values(16168,'���ſ�ݷ�ʽ') 
GO
insert into HtmlLabelIndex values(16169,'������Ϣ') 
GO
insert into HtmlLabelIndex values(16170,'��΢�������') 
GO
insert into HtmlLabelIndex values(16171,'�ĵ�ģ������') 
GO
insert into HtmlLabelIndex values(16172,'�޸Ĺ���') 
GO
insert into HtmlLabelIndex values(16173,'�ʲ�ʹ��') 
GO
insert into HtmlLabelIndex values(16174,'�ǣ���ѡ��') 
GO
insert into HtmlLabelIndex values(16175,'��δʹ�ã�') 
GO
insert into HtmlLabelIndex values(16176,'�ǣ�ǿ���ԣ�') 
GO
insert into HtmlLabelIndex values(16177,'������Դʹ��') 
GO
insert into HtmlLabelIndex values(16178,'��Ŀʹ��') 
GO
insert into HtmlLabelIndex values(16179,'����') 
GO
insert into HtmlLabelIndex values(16180,'ճ��') 
GO
insert into HtmlLabelIndex values(16181,'������') 
GO
insert into HtmlLabelIndex values(16182,'ɾ����') 
GO
insert into HtmlLabelIndex values(16183,'ɾ����') 
GO
insert into HtmlLabelIndex values(16184,'���뵥Ԫ��') 
GO
insert into HtmlLabelIndex values(16185,'ɾ����Ԫ��') 
GO
insert into HtmlLabelIndex values(16186,'�ϲ���Ԫ��') 
GO
insert into HtmlLabelIndex values(16187,'��ֵ�Ԫ��') 
GO
insert into HtmlLabelIndex values(16188,'����ѡ�������ͼƬ') 
GO
insert into HtmlLabelIndex values(16189,'����') 
GO
insert into HtmlLabelIndex values(16190,'����') 
GO
insert into HtmlLabelIndex values(16191,'������') 
GO
insert into HtmlLabelIndex values(16192,'����') 
GO
insert into HtmlLabelIndex values(16193,'����') 
GO
insert into HtmlLabelIndex values(16194,'��԰') 
GO
insert into HtmlLabelIndex values(16195,'����') 
GO
insert into HtmlLabelIndex values(16196,'����') 
GO
insert into HtmlLabelIndex values(16197,'�ֺ�') 
GO
insert into HtmlLabelIndex values(16198,'�Ӵ�') 
GO
insert into HtmlLabelIndex values(16199,'��б') 
GO
insert into HtmlLabelIndex values(16200,'�»���') 
GO
insert into HtmlLabelIndex values(16201,'ͻ����ʾ') 
GO
insert into HtmlLabelIndex values(16202,'�����') 
GO
insert into HtmlLabelIndex values(16203,'����') 
GO
insert into HtmlLabelIndex values(16204,'�Ҷ���') 
GO
insert into HtmlLabelIndex values(16205,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(16206,'����������') 
GO
insert into HtmlLabelIndex values(16207,'����������') 
GO
insert into HtmlLabelIndex values(16208,'��������') 
GO
insert into HtmlLabelIndex values(16209,'����ͼ��') 
GO
insert into HtmlLabelIndex values(16210,'����') 
GO
insert into HtmlLabelIndex values(16211,'�ָ�') 
GO
insert into HtmlLabelIndex values(16212,'����λ��') 
GO
insert into HtmlLabelIndex values(16213,'����') 
GO
insert into HtmlLabelIndex values(16214,'����') 
GO
insert into HtmlLabelIndex values(16215,'�������ĵ����') 
GO
insert into HtmlLabelIndex values(16216,'ȫ��չ��') 
GO
insert into HtmlLabelIndex values(16217,'ѡ����ɫ') 
GO
insert into HtmlLabelIndex values(16218,'�ʼ�ģ��') 
GO
insert into HtmlLabelIndex values(16219,'����HTML�����е�NAME����Ӧ�����ݱ��еĸ��ֶ�����һ��.') 
GO
insert into HtmlLabelIndex values(16220,'����') 
GO
insert into HtmlLabelIndex values(16221,'��������') 
GO
insert into HtmlLabelIndex values(16222,'ϵͳ��������') 
GO
insert into HtmlLabelIndex values(16223,'�������') 
GO
insert into HtmlLabelIndex values(16224,'�����ɱ�����') 
GO
insert into HtmlLabelIndex values(16225,'��Ʒ���') 
GO
insert into HtmlLabelIndex values(16226,'��˾����') 
GO
insert into HtmlLabelIndex values(16227,'�����˲���,��ο�HRM(����-��-����)') 
GO
insert into HtmlLabelIndex values(16228,'�ĵ�����') 
GO
insert into HtmlLabelIndex values(16229,'����������') 
GO
insert into HtmlLabelIndex values(16230,'���������ƺ�����') 
GO
insert into HtmlLabelIndex values(16231,'�����޸���') 
GO
insert into HtmlLabelIndex values(16232,'�����޸�����') 
GO
insert into HtmlLabelIndex values(16233,'ʹ�õ�����') 
GO
insert into HtmlLabelIndex values(16234,'�ظ��ĵ������ĵ�') 
GO
insert into HtmlLabelIndex values(16235,'�ĵ���״̬(�ݸ�,��,����,�鵵)') 
GO
insert into HtmlLabelIndex values(16236,'�ĵ�����') 
GO
insert into HtmlLabelIndex values(16237,'����״̬(����,����,��������)') 
GO
insert into HtmlLabelIndex values(16238,'���鿴����') 
GO
insert into HtmlLabelIndex values(16239,'�ĵ��İ�ȫ����') 
GO
insert into HtmlLabelIndex values(16240,'�ĵ�����') 
GO
insert into HtmlLabelIndex values(16241,'��������Ŀ��') 
GO
insert into HtmlLabelIndex values(16242,'��������') 
GO
insert into HtmlLabelIndex values(16243,'���Ķ�') 
GO
insert into HtmlLabelIndex values(16244,'ȫ���ĵ�:�����Ķ�����(����)') 
GO
insert into HtmlLabelIndex values(16245,'������������') 
GO
insert into HtmlLabelIndex values(16246,'��������') 
GO
insert into HtmlLabelIndex values(16247,'�˶��ɹ�') 
GO
insert into HtmlLabelIndex values(16248,'�ύ�ɹ�') 
GO
insert into HtmlLabelIndex values(16249,'����ͼ�α༭') 
GO
insert into HtmlLabelIndex values(16250,'��ְ') 
GO
insert into HtmlLabelIndex values(16251,'ӦƸ��') 
GO
insert into HtmlLabelIndex values(16252,'���ڹ���') 
GO
insert into HtmlLabelIndex values(16253,'����ʱ��') 
GO
insert into HtmlLabelIndex values(16254,'һ�㹤��ʱ��') 
GO
insert into HtmlLabelIndex values(16255,'�Ű�����') 
GO
insert into HtmlLabelIndex values(16256,'�Ű�ά��') 
GO
insert into HtmlLabelIndex values(16257,'���û��ӿ�') 
GO
insert into HtmlLabelIndex values(16258,'�����ݵ���') 
GO
insert into HtmlLabelIndex values(16259,'�����ݵ���') 
GO
insert into HtmlLabelIndex values(16260,'��ͬ����') 
GO
insert into HtmlLabelIndex values(16261,'��������') 
GO
insert into HtmlLabelIndex values(16262,'���ʸ���˰����Ŀ') 
GO
insert into HtmlLabelIndex values(16263,'н�����') 
GO
insert into HtmlLabelIndex values(16264,'��ѵ����') 
GO
insert into HtmlLabelIndex values(16265,'�ʲ��������뵥') 
GO
insert into HtmlLabelIndex values(16266,'����ս��Ͷ�����޹�˾������������ά�޵�') 
GO
insert into HtmlLabelIndex values(16267,'ά����') 
GO
insert into HtmlLabelIndex values(16268,'ά��ʱ��') 
GO
insert into HtmlLabelIndex values(16269,'ά�޷���') 
GO
insert into HtmlLabelIndex values(16270,'˵���������룡') 
GO
insert into HtmlLabelIndex values(16271,'���˽����') 
GO
insert into HtmlLabelIndex values(16272,'���¹���Ŀ��') 
GO
insert into HtmlLabelIndex values(16273,'���¹����ܽ�') 
GO
insert into HtmlLabelIndex values(16274,'��������������') 
GO
insert into HtmlLabelIndex values(16275,'����������') 
GO
insert into HtmlLabelIndex values(16276,'���¹����ܽ�') 
GO
insert into HtmlLabelIndex values(16277,'�ܽ�Ȩ��ָ�����ܴ���100%') 
GO
insert into HtmlLabelIndex values(16278,'�ƻ�Ȩ��ָ�����ܴ���100%') 
GO
insert into HtmlLabelIndex values(16279,'���ܹ����ܽ�') 
GO
insert into HtmlLabelIndex values(16280,'��ɽ��') 
GO
insert into HtmlLabelIndex values(16281,'δ�������') 
GO
insert into HtmlLabelIndex values(16282,'���ܹ����ƻ�') 
GO
insert into HtmlLabelIndex values(16283,'�Ƿ񹫿�') 
GO
insert into HtmlLabelIndex values(16284,'��ϸ˵��') 
GO
insert into HtmlLabelIndex values(16285,'��ʾ������Ϣ') 
GO
insert into HtmlLabelIndex values(16286,'�ò���Ԥ������׼') 
GO
insert into HtmlLabelIndex values(16287,'�ò���Ԥ��δ��׼') 
GO
insert into HtmlLabelIndex values(16288,'�ò���δ��Ԥ��') 
GO
insert into HtmlLabelIndex values(16289,'������Ϣ') 
GO
insert into HtmlLabelIndex values(16290,'��Ŀ��Ϣ') 
GO
insert into HtmlLabelIndex values(16291,'����') 
GO
insert into HtmlLabelIndex values(16292,'ʵ��(�������α���)') 
GO
insert into HtmlLabelIndex values(16293,'�Ƿ�֧') 
GO
insert into HtmlLabelIndex values(16294,'��Ŀ��Ԥ��') 
GO
insert into HtmlLabelIndex values(16295,'��Ŀ��֧��(�������α���)') 
GO
insert into HtmlLabelIndex values(16296,'���˸���ĿԤ��') 
GO
insert into HtmlLabelIndex values(16297,'���˸���Ŀʵ��(�������α���)') 
GO
insert into HtmlLabelIndex values(16298,'���Ÿ���ĿԤ��') 
GO
insert into HtmlLabelIndex values(16299,'���Ÿ���Ŀʵ��(�������α���)') 
GO
insert into HtmlLabelIndex values(16300,'ȫ������ĿԤ��') 
GO
insert into HtmlLabelIndex values(16301,'ȫ������Ŀʵ��(�������α���)') 
GO
insert into HtmlLabelIndex values(16302,'��֧��(�������α���)') 
GO
insert into HtmlLabelIndex values(16303,'���˸�CRMԤ��') 
GO
insert into HtmlLabelIndex values(16304,'���˸�CRMʵ��(�������α���)') 
GO
insert into HtmlLabelIndex values(16305,'���Ÿ�CRMԤ��') 
GO
insert into HtmlLabelIndex values(16306,'���Ÿ�CRMʵ��(�������α���)') 
GO
insert into HtmlLabelIndex values(16307,'ȫ����CRMԤ��') 
GO
insert into HtmlLabelIndex values(16308,'ȫ����CRMʵ��(�������α���)') 
GO
insert into HtmlLabelIndex values(16309,'���ز�����Ϣ') 
GO
insert into HtmlLabelIndex values(16310,'��������') 
GO
insert into HtmlLabelIndex values(16311,'�칫��Ʒһ���Է������') 
GO
insert into HtmlLabelIndex values(16312,'���ñ�') 
GO
insert into HtmlLabelIndex values(16313,'Ʒ��') 
GO
insert into HtmlLabelIndex values(16314,'���') 
GO
insert into HtmlLabelIndex values(16315,'���') 
GO
insert into HtmlLabelIndex values(16316,'�ձ�����(Uni)UB150ǩ�ֱ�') 
GO
insert into HtmlLabelIndex values(16317,'����') 
GO
insert into HtmlLabelIndex values(16318,'��ˮ��') 
GO
insert into HtmlLabelIndex values(16319,'������') 
GO
insert into HtmlLabelIndex values(16320,'�Լ�֧��') 
GO
insert into HtmlLabelIndex values(16321,'��˾ȫ��') 
GO
insert into HtmlLabelIndex values(16322,'֧������') 
GO
insert into HtmlLabelIndex values(16323,'����Ԥ����ϸ��Ϣ') 
GO
insert into HtmlLabelIndex values(16324,'��������') 
GO
insert into HtmlLabelIndex values(16325,'����') 
GO
insert into HtmlLabelIndex values(16326,'������') 
GO
insert into HtmlLabelIndex values(16327,'��û��ѡ��һ���������иı�����ݽ��޷��������棡') 
GO
insert into HtmlLabelIndex values(16328,'������׼') 
GO
insert into HtmlLabelIndex values(16329,'��') 
GO
insert into HtmlLabelIndex values(16330,'��') 
GO
insert into HtmlLabelIndex values(16331,'���ֲ��ܴ���5��') 
GO
insert into HtmlLabelIndex values(16332,'��������Ϣ�������') 
GO
insert into HtmlLabelIndex values(16333,'��������һ�ڵ����һ�ڵ�����ߴ���') 
GO
insert into HtmlLabelIndex values(16334,'��������ת...') 
GO
insert into HtmlLabelIndex values(16335,'ȫ��ɾ��') 
GO
insert into HtmlLabelIndex values(16336,'��������') 
GO
insert into HtmlLabelIndex values(16337,'���������') 
GO
insert into HtmlLabelIndex values(16338,'��������') 
GO
insert into HtmlLabelIndex values(16339,'���������') 
GO
insert into HtmlLabelIndex values(16340,'��������') 
GO
insert into HtmlLabelIndex values(16341,'��������') 
GO
insert into HtmlLabelIndex values(16342,'����δ�������') 
GO
insert into HtmlLabelIndex values(16343,'�������������') 
GO
insert into HtmlLabelIndex values(16344,'ȷ��ɾ��ѡ������Ϣ��?') 
GO
insert into HtmlLabelIndex values(16345,'����û�') 
GO
insert into HtmlLabelIndex values(16346,'ȫ������') 
GO
insert into HtmlLabelIndex values(16347,'���д���������') 
GO
insert into HtmlLabelIndex values(16348,'�������������') 
GO
insert into HtmlLabelIndex values(16349,'������') 
GO
insert into HtmlLabelIndex values(16350,'ͬ������') 
GO
insert into HtmlLabelIndex values(16351,'�˻�����ִ��') 
GO
insert into HtmlLabelIndex values(16352,'���ƹ�������ͼ') 
GO
insert into HtmlLabelIndex values(16353,'�Ѳ�����') 
GO
insert into HtmlLabelIndex values(16354,'δ������') 
GO
insert into HtmlLabelIndex values(16355,'�鿴��') 
GO
insert into HtmlLabelIndex values(16389,'�鿴ҳ������') 
GO
insert into HtmlLabelIndex values(16392,'�½�����') 
GO
insert into HtmlLabelIndex values(16394,'�ҵ�֪ʶ') 
GO
insert into HtmlLabelIndex values(16395,'����֪ʶ') 
GO
insert into HtmlLabelIndex values(16400,'�µĿͻ�') 
GO
insert into HtmlLabelIndex values(16401,'����ͻ�') 
GO
insert into HtmlLabelIndex values(16402,'��ϵ�ƻ�') 
GO
insert into HtmlLabelIndex values(16404,'���ۺ�ͬ') 
GO
insert into HtmlLabelIndex values(16406,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(16408,'��Ŀִ��') 
GO
insert into HtmlLabelIndex values(16411,'��ǰ����') 
GO
insert into HtmlLabelIndex values(16413,'��ѯ��Ŀ') 
GO
insert into HtmlLabelIndex values(16414,'�ҵ�����') 
GO
insert into HtmlLabelIndex values(16415,'�ҵĿ�Ƭ') 
GO
insert into HtmlLabelIndex values(16416,'�ҵĹ���') 
GO
insert into HtmlLabelIndex values(16417,'���˽���') 
GO
insert into HtmlLabelIndex values(16418,'��ѯ��Ա') 
GO
insert into HtmlLabelIndex values(16420,'�µĻ���') 
GO
insert into HtmlLabelIndex values(16421,'�ϵĻ���') 
GO
insert into HtmlLabelIndex values(16422,'�����ҷ���') 
GO
insert into HtmlLabelIndex values(16430,'�ҵ��±�') 
GO
insert into HtmlLabelIndex values(16435,'�ռ�����') 
GO
insert into HtmlLabelIndex values(16436,'��������') 
GO
insert into HtmlLabelIndex values(16440,'��ѯ�ʼ�') 
GO
insert into HtmlLabelIndex values(16441,'Ⱥ���ʼ�') 
GO
insert into HtmlLabelIndex values(16442,'��������') 
GO
insert into HtmlLabelIndex values(16443,'�ҵĶ���') 
GO
insert into HtmlLabelIndex values(16444,'�½�����') 
GO
insert into HtmlLabelIndex values(16445,'�汾���к�') 
GO
insert into HtmlLabelIndex values(16450,'��ʾģ��') 
GO
insert into HtmlLabelIndex values(16451,'ҳ������') 
GO
insert into HtmlLabelIndex values(16455,'��֯�ṹ') 
GO
insert into HtmlLabelIndex values(16456,'�ܲ�����') 
GO
insert into HtmlLabelIndex values(16457,'�ֲ�����') 
GO
insert into HtmlLabelIndex values(16458,'��������') 
GO
insert into HtmlLabelIndex values(16459,'ͼ�α༭ ') 
GO
insert into HtmlLabelIndex values(16460,'ְ������') 
GO
insert into HtmlLabelIndex values(16462,'ְ������') 
GO
insert into HtmlLabelIndex values(16464,'ѧ������') 
GO
insert into HtmlLabelIndex values(16467,'��Ա��ǩ') 
GO
insert into HtmlLabelIndex values(16469,'��Ա��ְ') 
GO
insert into HtmlLabelIndex values(16478,'���ڼ���') 
GO
insert into HtmlLabelIndex values(16481,'н������') 
GO
insert into HtmlLabelIndex values(16483,'·������') 
GO
insert into HtmlLabelIndex values(16484,'��������') 
GO
insert into HtmlLabelIndex values(16485,'�ƺ�����') 
GO
insert into HtmlLabelIndex values(16486,'��ַ����') 
GO
insert into HtmlLabelIndex values(16487,'�ʻ�����') 
GO
insert into HtmlLabelIndex values(16488,'��ϵ����') 
GO
insert into HtmlLabelIndex values(16489,'��ַ����') 
GO
insert into HtmlLabelIndex values(16496,'��ֵ����') 
GO
insert into HtmlLabelIndex values(16498,'ʱ������') 
GO
insert into HtmlLabelIndex values(16499,'�ɹ�����') 
GO
insert into HtmlLabelIndex values(16500,'ʧ������') 
GO
insert into HtmlLabelIndex values(16505,'Ԥ������') 
GO
insert into HtmlLabelIndex values(16507,'ָ������') 
GO
insert into HtmlLabelIndex values(16513,'�½���Ʒ') 
GO
insert into HtmlLabelIndex values(16514,'��������') 
GO
insert into HtmlLabelIndex values(16516,'����ά��') 
GO
insert into HtmlLabelIndex values(16519,'����ȷ��') 
GO
insert into HtmlLabelIndex values(16520,'������') 
GO
insert into HtmlLabelIndex values(16522,'��������') 
GO
insert into HtmlLabelIndex values(16524,'��������') 
GO
insert into HtmlLabelIndex values(16525,'��������') 
GO
insert into HtmlLabelIndex values(16526,'Ȩ������') 
GO
insert into HtmlLabelIndex values(16528,'Ȩ��ת��') 
GO
insert into HtmlLabelIndex values(16531,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(16533,'�ͻ�����') 
GO
insert into HtmlLabelIndex values(16543,'��Ա״��') 
GO
insert into HtmlLabelIndex values(16544,'�����б�') 
GO
insert into HtmlLabelIndex values(16557,'�������') 
GO
insert into HtmlLabelIndex values(16558,'����ͳ��') 
GO
insert into HtmlLabelIndex values(16574,'��Ŀ����') 
GO
insert into HtmlLabelIndex values(16578,'���ڲ���') 
GO
insert into HtmlLabelIndex values(16582,'�ͻ����') 
GO
insert into HtmlLabelIndex values(16586,'��ͬ���') 
GO
insert into HtmlLabelIndex values(16587,'��ͬ�б�') 
GO
insert into HtmlLabelIndex values(16592,'��Ա���') 
GO
insert into HtmlLabelIndex values(16599,'�����ʲ�') 
GO
insert into HtmlLabelIndex values(16605,'�ĵ�Ŀ¼����') 
GO
insert into HtmlLabelIndex values(16609,'����ĵ��ͻ�') 
GO
insert into HtmlLabelIndex values(16626,'��������') 
GO
insert into HtmlLabelIndex values(16628,'ȷ��Ҫ�˳�ϵͳ��') 
GO


insert into HtmlLabelIndex values(16631,'��������') 
GO
insert into HtmlLabelIndex values(16633,'�ͻ���Ϣ') 
GO
insert into HtmlLabelIndex values(16636,'����') 
GO
insert into HtmlLabelIndex values(16637,'�ʼ���') 
GO
insert into HtmlLabelIndex values(16515,'�����趨') 
GO
insert into HtmlLabelIndex values(16517,'����ά��') 
GO
insert into HtmlLabelIndex values(16518,'���ά��') 
GO
insert into HtmlLabelIndex values(16527,'��ɫ����') 
GO
insert into HtmlLabelIndex values(16532,'���̱���') 
GO
insert into HtmlLabelIndex values(16534,'���񱨱�') 
GO
insert into HtmlLabelIndex values(16536,'֪ʶ����') 
GO
insert into HtmlLabelIndex values(16545,'���䱨��') 
GO
insert into HtmlLabelIndex values(16547,'��ٱ���') 
GO
insert into HtmlLabelIndex values(16548,'�Ա𱨱�') 
GO
insert into HtmlLabelIndex values(16549,'���䱨��') 
GO
insert into HtmlLabelIndex values(16562,'�����ܶ�') 
GO
insert into HtmlLabelIndex values(16563,'�䶯���') 
GO
insert into HtmlLabelIndex values(16566,'ת�����') 
GO
insert into HtmlLabelIndex values(16567,'��ǩ���') 
GO
insert into HtmlLabelIndex values(16580,'���屨��') 
GO
insert into HtmlLabelIndex values(16581,'��������') 
GO
insert into HtmlLabelIndex values(16593,'�ͻ����') 
GO
insert into HtmlLabelIndex values(16606,'��౻���ĵ�') 
GO
insert into HtmlLabelIndex values(16608,'����ĵ�����') 
GO
insert into HtmlLabelIndex values(16617,'�ʲ�������') 
GO
insert into HtmlLabelIndex values(16622,'��������') 
GO
insert into HtmlLabelIndex values(16623,'��������') 
GO
insert into HtmlLabelIndex values(16624,'��������') 
GO
insert into HtmlLabelIndex values(16635,'���Ͷ���') 
GO
insert into HtmlLabelIndex values(16639,'�ƶ���������') 
GO



insert into HtmlLabelInfo values(57,'',8) 
GO
insert into HtmlLabelInfo values(57,'���ŵ���',7) 
GO
insert into HtmlLabelInfo values(58,'Documents',8) 
GO
insert into HtmlLabelInfo values(58,'�ĵ�',7) 
GO
insert into HtmlLabelInfo values(60,'Maintenance',8) 
GO
insert into HtmlLabelInfo values(60,'ά��',7) 
GO
insert into HtmlLabelInfo values(61,'Base',8) 
GO
insert into HtmlLabelInfo values(61,'����',7) 
GO
insert into HtmlLabelInfo values(63,'Types',8) 
GO
insert into HtmlLabelInfo values(63,'����',7) 
GO
insert into HtmlLabelInfo values(64,'Mould',8) 
GO
insert into HtmlLabelInfo values(64,'ģ��',7) 
GO
insert into HtmlLabelInfo values(65,'MainCategory',8) 
GO
insert into HtmlLabelInfo values(65,'��Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(66,'SubCategory',8) 
GO
insert into HtmlLabelInfo values(66,'��Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(67,'SecCategory',8) 
GO
insert into HtmlLabelInfo values(67,'��Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(68,'Setting',8) 
GO
insert into HtmlLabelInfo values(68,'����',7) 
GO
insert into HtmlLabelInfo values(70,'News',8) 
GO
insert into HtmlLabelInfo values(70,'����ҳ',7) 
GO
insert into HtmlLabelInfo values(71,'Mail',8) 
GO
insert into HtmlLabelInfo values(71,'�ʼ�',7) 
GO
insert into HtmlLabelInfo values(72,'Tools',8) 
GO
insert into HtmlLabelInfo values(72,'���ù���',7) 
GO
insert into HtmlLabelInfo values(73,'User Define',8) 
GO
insert into HtmlLabelInfo values(73,'�û��Զ���',7) 
GO
insert into HtmlLabelInfo values(74,'Picture',8) 
GO
insert into HtmlLabelInfo values(74,'ͼƬ',7) 
GO
insert into HtmlLabelInfo values(75,'Upload',8) 
GO
insert into HtmlLabelInfo values(75,'�ϴ�',7) 
GO
insert into HtmlLabelInfo values(76,'Web Site',8) 
GO
insert into HtmlLabelInfo values(76,'��վ',7) 
GO
insert into HtmlLabelInfo values(77,'Copy',8) 
GO
insert into HtmlLabelInfo values(77,'����',7) 
GO
insert into HtmlLabelInfo values(78,'Move',8) 
GO
insert into HtmlLabelInfo values(78,'�ƶ�',7) 
GO
insert into HtmlLabelInfo values(79,'Owner',8) 
GO
insert into HtmlLabelInfo values(79,'������',7) 
GO
insert into HtmlLabelInfo values(80,'Trans',8) 
GO
insert into HtmlLabelInfo values(80,'ת��',7) 
GO
insert into HtmlLabelInfo values(81,'Install',8) 
GO
insert into HtmlLabelInfo values(81,'��װ',7) 
GO
insert into HtmlLabelInfo values(82,'New',8) 
GO
insert into HtmlLabelInfo values(82,'�½�',7) 
GO
insert into HtmlLabelInfo values(83,'Log',8) 
GO
insert into HtmlLabelInfo values(83,'��־',7) 
GO
insert into HtmlLabelInfo values(84,'ID',8) 
GO
insert into HtmlLabelInfo values(84,'��ʶ',7) 
GO
insert into HtmlLabelInfo values(85,'Description',8) 
GO
insert into HtmlLabelInfo values(85,'˵��',7) 
GO
insert into HtmlLabelInfo values(86,'Save',8) 
GO
insert into HtmlLabelInfo values(86,'����',7) 
GO
insert into HtmlLabelInfo values(87,'Info',8) 
GO
insert into HtmlLabelInfo values(87,'��Ϣ',7) 
GO
insert into HtmlLabelInfo values(88,'Order',8) 
GO
insert into HtmlLabelInfo values(88,'˳��',7) 
GO
insert into HtmlLabelInfo values(89,'Display',8) 
GO
insert into HtmlLabelInfo values(89,'��ʾ',7) 
GO
insert into HtmlLabelInfo values(91,'Delete',8) 
GO
insert into HtmlLabelInfo values(91,'ɾ��',7) 
GO
insert into HtmlLabelInfo values(92,'Category',8) 
GO
insert into HtmlLabelInfo values(92,'Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(93,'Edit',8) 
GO
insert into HtmlLabelInfo values(93,'�༭',7) 
GO
insert into HtmlLabelInfo values(95,'Detail',8) 
GO
insert into HtmlLabelInfo values(95,'ϸ��',7) 
GO
insert into HtmlLabelInfo values(97,'Date',8) 
GO
insert into HtmlLabelInfo values(97,'����',7) 
GO
insert into HtmlLabelInfo values(99,'Opeator',8) 
GO
insert into HtmlLabelInfo values(99,'������',7) 
GO
insert into HtmlLabelInfo values(101,'Project',8) 
GO
insert into HtmlLabelInfo values(101,'��Ŀ',7) 
GO
insert into HtmlLabelInfo values(103,'Change',8) 
GO
insert into HtmlLabelInfo values(103,'�޸�',7) 
GO
insert into HtmlLabelInfo values(104,'Operation',8) 
GO
insert into HtmlLabelInfo values(104,'����',7) 
GO
insert into HtmlLabelInfo values(106,'Object',8) 
GO
insert into HtmlLabelInfo values(106,'����',7) 
GO
insert into HtmlLabelInfo values(108,'Client',8) 
GO
insert into HtmlLabelInfo values(108,'�ͻ���',7) 
GO
insert into HtmlLabelInfo values(110,'Address',8) 
GO
insert into HtmlLabelInfo values(110,'��ַ',7) 
GO
insert into HtmlLabelInfo values(112,'Setting',8) 
GO
insert into HtmlLabelInfo values(112,'�趨',7) 
GO
insert into HtmlLabelInfo values(114,'Publish',8) 
GO
insert into HtmlLabelInfo values(114,'����',7) 
GO
insert into HtmlLabelInfo values(115,'Use',8) 
GO
insert into HtmlLabelInfo values(115,'����',7) 
GO
insert into HtmlLabelInfo values(117,'Replies',8) 
GO
insert into HtmlLabelInfo values(117,'�ظ�',7) 
GO
insert into HtmlLabelInfo values(119,'Share',8) 
GO
insert into HtmlLabelInfo values(119,'����',7) 
GO
insert into HtmlLabelInfo values(120,'Security',8) 
GO
insert into HtmlLabelInfo values(120,'��ȫ',7) 
GO
insert into HtmlLabelInfo values(122,'Roles',8) 
GO
insert into HtmlLabelInfo values(122,'��ɫ',7) 
GO
insert into HtmlLabelInfo values(124,'Department',8) 
GO
insert into HtmlLabelInfo values(124,'����',7) 
GO
insert into HtmlLabelInfo values(125,'Create',8) 
GO
insert into HtmlLabelInfo values(125,'����',7) 
GO
insert into HtmlLabelInfo values(127,'Person',8) 
GO
insert into HtmlLabelInfo values(127,'��',7) 
GO
insert into HtmlLabelInfo values(129,'Apply',8) 
GO
insert into HtmlLabelInfo values(129,'����',7) 
GO
insert into HtmlLabelInfo values(130,'Contractor ',8) 
GO
insert into HtmlLabelInfo values(130,'�а���',7) 
GO
insert into HtmlLabelInfo values(131,'Employee ',8) 
GO
insert into HtmlLabelInfo values(131,'��Ա',7) 
GO
insert into HtmlLabelInfo values(132,'Agent ',8) 
GO
insert into HtmlLabelInfo values(132,'�н����',7) 
GO
insert into HtmlLabelInfo values(134,'Student',8) 
GO
insert into HtmlLabelInfo values(134,'ѧ��',7) 
GO
insert into HtmlLabelInfo values(136,'Customer',8) 
GO
insert into HtmlLabelInfo values(136,'�ͻ�',7) 
GO
insert into HtmlLabelInfo values(138,'Supplier',8) 
GO
insert into HtmlLabelInfo values(138,'��Ӧ��',7) 
GO
insert into HtmlLabelInfo values(139,'Level',8) 
GO
insert into HtmlLabelInfo values(139,'����',7) 
GO
insert into HtmlLabelInfo values(140,'Company',8) 
GO
insert into HtmlLabelInfo values(140,'�ܲ�',7) 
GO
insert into HtmlLabelInfo values(141,'SubCompany',8) 
GO
insert into HtmlLabelInfo values(141,'�ֲ�',7) 
GO
insert into HtmlLabelInfo values(142,'Approve',8) 
GO
insert into HtmlLabelInfo values(142,'��׼',7) 
GO
insert into HtmlLabelInfo values(144,'Manager ',8) 
GO
insert into HtmlLabelInfo values(144,'����',7) 
GO
insert into HtmlLabelInfo values(145,'Goods',8) 
GO
insert into HtmlLabelInfo values(145,'��Ʒ',7) 
GO
insert into HtmlLabelInfo values(147,'CRM',7) 
GO
insert into HtmlLabelInfo values(147,'CRM',8) 
GO
insert into HtmlLabelInfo values(149,'Default',8) 
GO
insert into HtmlLabelInfo values(149,'Ĭ��',7) 
GO
insert into HtmlLabelInfo values(151,'Top',8) 
GO
insert into HtmlLabelInfo values(151,'���',7) 
GO
insert into HtmlLabelInfo values(154,'General',8) 
GO
insert into HtmlLabelInfo values(154,'һ��',7) 
GO
insert into HtmlLabelInfo values(155,'Active',8) 
GO
insert into HtmlLabelInfo values(155,'��Ծ',7) 
GO
insert into HtmlLabelInfo values(156,'Affix',8) 
GO
insert into HtmlLabelInfo values(156,'����',7) 
GO
insert into HtmlLabelInfo values(158,'Number',8) 
GO
insert into HtmlLabelInfo values(158,'��Ŀ',7) 
GO
insert into HtmlLabelInfo values(160,'Used',8) 
GO
insert into HtmlLabelInfo values(160,'ʹ��',7) 
GO
insert into HtmlLabelInfo values(161,'No',8) 
GO
insert into HtmlLabelInfo values(161,'��',7) 
GO
insert into HtmlLabelInfo values(163,'Yes',8) 
GO
insert into HtmlLabelInfo values(163,'��',7) 
GO
insert into HtmlLabelInfo values(165,'No Used',8) 
GO
insert into HtmlLabelInfo values(165,'δʹ��',7) 
GO
insert into HtmlLabelInfo values(166,'Optional',8) 
GO
insert into HtmlLabelInfo values(166,'��ѡ��',7) 
GO
insert into HtmlLabelInfo values(168,'Mandatory',8) 
GO
insert into HtmlLabelInfo values(168,'ǿ����',7) 
GO
insert into HtmlLabelInfo values(169,'״��',7) 
GO
insert into HtmlLabelInfo values(169,'״��',8) 
GO
insert into HtmlLabelInfo values(170,'Future',8) 
GO
insert into HtmlLabelInfo values(170,'����',7) 
GO
insert into HtmlLabelInfo values(172,'Selection',8) 
GO
insert into HtmlLabelInfo values(172,'ѡ��',7) 
GO
insert into HtmlLabelInfo values(174,'Example',8) 
GO
insert into HtmlLabelInfo values(174,'����',7) 
GO
insert into HtmlLabelInfo values(176,'Label',8) 
GO
insert into HtmlLabelInfo values(176,'��ǩ',7) 
GO
insert into HtmlLabelInfo values(178,'Sort',8) 
GO
insert into HtmlLabelInfo values(178,'���',7) 
GO
insert into HtmlLabelInfo values(179,'Resource',8) 
GO
insert into HtmlLabelInfo values(179,'������Դ',7) 
GO
insert into HtmlLabelInfo values(181,'Hired',8) 
GO
insert into HtmlLabelInfo values(181,'����',7) 
GO
insert into HtmlLabelInfo values(182,'Cooperator',8) 
GO
insert into HtmlLabelInfo values(182,'�ϻ���',7) 
GO
insert into HtmlLabelInfo values(183,'prospect',7) 
GO
insert into HtmlLabelInfo values(183,'prospect',8) 
GO
insert into HtmlLabelInfo values(185,'Bank',8) 
GO
insert into HtmlLabelInfo values(185,'����',7) 
GO
insert into HtmlLabelInfo values(187,'Transaction',8) 
GO
insert into HtmlLabelInfo values(187,'����',7) 
GO
insert into HtmlLabelInfo values(189,'Financial',8) 
GO
insert into HtmlLabelInfo values(189,'����',7) 
GO
insert into HtmlLabelInfo values(191,'ref.',8) 
GO
insert into HtmlLabelInfo values(191,'�ο�',7) 
GO
insert into HtmlLabelInfo values(193,'Join',8) 
GO
insert into HtmlLabelInfo values(193,'����',7) 
GO
insert into HtmlLabelInfo values(195,'Name',8) 
GO
insert into HtmlLabelInfo values(195,'����',7) 
GO
insert into HtmlLabelInfo values(197,'Search',8) 
GO
insert into HtmlLabelInfo values(197,'����',7) 
GO
insert into HtmlLabelInfo values(199,'Reset',8) 
GO
insert into HtmlLabelInfo values(199,'��������',7) 
GO
insert into HtmlLabelInfo values(201,'Cancel',8) 
GO
insert into HtmlLabelInfo values(201,'ȡ��',7) 
GO
insert into HtmlLabelInfo values(203,'width',8) 
GO
insert into HtmlLabelInfo values(203,'���',7) 
GO
insert into HtmlLabelInfo values(207,'height',8) 
GO
insert into HtmlLabelInfo values(207,'�߶�',7) 
GO
insert into HtmlLabelInfo values(209,'Resize',8) 
GO
insert into HtmlLabelInfo values(209,'������С',7) 
GO
insert into HtmlLabelInfo values(211,'No,don\''t resize',8) 
GO
insert into HtmlLabelInfo values(211,'���Ķ�',7) 
GO
insert into HtmlLabelInfo values(212,'Yes,fix as standard',8) 
GO
insert into HtmlLabelInfo values(212,'�����ù̶�',7) 
GO
insert into HtmlLabelInfo values(213,'Yes,if smaller',8) 
GO
insert into HtmlLabelInfo values(213,'�Ķ������С��',7) 
GO
insert into HtmlLabelInfo values(214,'Yes,if bigger',8) 
GO
insert into HtmlLabelInfo values(214,'�Ķ����������',7) 
GO
insert into HtmlLabelInfo values(216,'combine',8) 
GO
insert into HtmlLabelInfo values(216,'�ϲ�',7) 
GO
insert into HtmlLabelInfo values(218,'pixel(s)',8) 
GO
insert into HtmlLabelInfo values(218,'����',7) 
GO
insert into HtmlLabelInfo values(219,'Byte(s)',8) 
GO
insert into HtmlLabelInfo values(219,'�ֽ�',7) 
GO
insert into HtmlLabelInfo values(220,'Draft',8) 
GO
insert into HtmlLabelInfo values(220,'�ݸ�',7) 
GO
insert into HtmlLabelInfo values(221,'Preview',8) 
GO
insert into HtmlLabelInfo values(221,'Ԥ��',7) 
GO
insert into HtmlLabelInfo values(222,'Html',7) 
GO
insert into HtmlLabelInfo values(222,'Html',8) 
GO
insert into HtmlLabelInfo values(224,'Header',8) 
GO
insert into HtmlLabelInfo values(224,'ҳü',7) 
GO
insert into HtmlLabelInfo values(225,'Normal',8) 
GO
insert into HtmlLabelInfo values(225,'����',7) 
GO
insert into HtmlLabelInfo values(227,'Frontpage',8) 
GO
insert into HtmlLabelInfo values(227,'��ҳ',7) 
GO
insert into HtmlLabelInfo values(229,'Title',8) 
GO
insert into HtmlLabelInfo values(229,'����',7) 
GO
insert into HtmlLabelInfo values(231,'Language',8) 
GO
insert into HtmlLabelInfo values(231,'����',7) 
GO
insert into HtmlLabelInfo values(233,'No',8) 
GO
insert into HtmlLabelInfo values(233,'��',7) 
GO
insert into HtmlLabelInfo values(235,'Everybody',8) 
GO
insert into HtmlLabelInfo values(235,'����',7) 
GO
insert into HtmlLabelInfo values(236,'Reject',8) 
GO
insert into HtmlLabelInfo values(236,'�˻�',7) 
GO
insert into HtmlLabelInfo values(244,'Reopen',8) 
GO
insert into HtmlLabelInfo values(244,'���´�',7) 
GO
insert into HtmlLabelInfo values(251,'Archive',8) 
GO
insert into HtmlLabelInfo values(251,'�鵵',7) 
GO
insert into HtmlLabelInfo values(256,'Reload',8) 
GO
insert into HtmlLabelInfo values(256,'����',7) 
GO
insert into HtmlLabelInfo values(257,'Print',8) 
GO
insert into HtmlLabelInfo values(257,'��ӡ',7) 
GO
insert into HtmlLabelInfo values(258,'Download',8) 
GO
insert into HtmlLabelInfo values(258,'����',7) 
GO
insert into HtmlLabelInfo values(259,'Workflow',8) 
GO
insert into HtmlLabelInfo values(259,'������',7) 
GO
insert into HtmlLabelInfo values(260,'Read',8) 
GO
insert into HtmlLabelInfo values(260,'�Ķ�',7) 
GO
insert into HtmlLabelInfo values(261,'Fields',8) 
GO
insert into HtmlLabelInfo values(261,'�ֶ�',7) 
GO
insert into HtmlLabelInfo values(264,'Record(s)',8) 
GO
insert into HtmlLabelInfo values(264,'��¼',7) 
GO
insert into HtmlLabelInfo values(265,'PerPage',8) 
GO
insert into HtmlLabelInfo values(265,'ÿҳ',7) 
GO
insert into HtmlLabelInfo values(271,'Creater',8) 
GO
insert into HtmlLabelInfo values(271,'������',7) 
GO
insert into HtmlLabelInfo values(275,'Help',8) 
GO
insert into HtmlLabelInfo values(275,'����',7) 
GO
insert into HtmlLabelInfo values(277,'Time',8) 
GO
insert into HtmlLabelInfo values(277,'ʱ��',7) 
GO
insert into HtmlLabelInfo values(280,'Size',8) 
GO
insert into HtmlLabelInfo values(280,'�ߴ�',7) 
GO
insert into HtmlLabelInfo values(293,'Change',8) 
GO
insert into HtmlLabelInfo values(293,'����',7) 
GO
insert into HtmlLabelInfo values(309,'Close',8) 
GO
insert into HtmlLabelInfo values(309,'�ر�',7) 
GO
insert into HtmlLabelInfo values(311,'Clear',8) 
GO
insert into HtmlLabelInfo values(311,'���',7) 
GO
insert into HtmlLabelInfo values(316,'News',8) 
GO
insert into HtmlLabelInfo values(316,'����',7) 
GO
insert into HtmlLabelInfo values(320,'List',8) 
GO
insert into HtmlLabelInfo values(320,'�б�',7) 
GO
insert into HtmlLabelInfo values(321,'Perpage Recorder',8) 
GO
insert into HtmlLabelInfo values(321,'ÿҳ��¼',7) 
GO
insert into HtmlLabelInfo values(322,'Import News',8) 
GO
insert into HtmlLabelInfo values(322,'Ҫ��',7) 
GO
insert into HtmlLabelInfo values(323,'Footer',8) 
GO
insert into HtmlLabelInfo values(323,'ҳ��',7) 
GO
insert into HtmlLabelInfo values(324,'Standard',8) 
GO
insert into HtmlLabelInfo values(324,'��׼',7) 
GO
insert into HtmlLabelInfo values(325,'Greater than or equal',8) 
GO
insert into HtmlLabelInfo values(325,'���ڻ����',7) 
GO
insert into HtmlLabelInfo values(326,'Smaller than or equal',8) 
GO
insert into HtmlLabelInfo values(326,'С�ڻ����',7) 
GO
insert into HtmlLabelInfo values(327,'Equal',8) 
GO
insert into HtmlLabelInfo values(327,'����',7) 
GO
insert into HtmlLabelInfo values(328,'Leave ',8) 
GO
insert into HtmlLabelInfo values(328,'����',7) 
GO
insert into HtmlLabelInfo values(329,'in days',8) 
GO
insert into HtmlLabelInfo values(329,'������',7) 
GO
insert into HtmlLabelInfo values(330,'Target',8) 
GO
insert into HtmlLabelInfo values(330,'Ŀ��',7) 
GO
insert into HtmlLabelInfo values(331,'Source',8) 
GO
insert into HtmlLabelInfo values(331,'Դ',7) 
GO
insert into HtmlLabelInfo values(332,'All',8) 
GO
insert into HtmlLabelInfo values(332,'ȫ��',7) 
GO
insert into HtmlLabelInfo values(333,'Button',8) 
GO
insert into HtmlLabelInfo values(333,'��ť',7) 
GO
insert into HtmlLabelInfo values(334,'Backgroud',8) 
GO
insert into HtmlLabelInfo values(334,'����',7) 
GO
insert into HtmlLabelInfo values(335,'LOGO',7) 
GO
insert into HtmlLabelInfo values(335,'LOGO',8) 
GO
insert into HtmlLabelInfo values(336,'Scale',8) 
GO
insert into HtmlLabelInfo values(336,'����',7) 
GO
insert into HtmlLabelInfo values(337,'KB',7) 
GO
insert into HtmlLabelInfo values(337,'KB',8) 
GO
insert into HtmlLabelInfo values(338,'Order',8) 
GO
insert into HtmlLabelInfo values(338,'����',7) 
GO
insert into HtmlLabelInfo values(339,'Ascending',8) 
GO
insert into HtmlLabelInfo values(339,'����',7) 
GO
insert into HtmlLabelInfo values(340,'Descending',8) 
GO
insert into HtmlLabelInfo values(340,'����',7) 
GO
insert into HtmlLabelInfo values(341,'Summary',8) 
GO
insert into HtmlLabelInfo values(341,'ժҪ',7) 
GO
insert into HtmlLabelInfo values(342,'Simple',8) 
GO
insert into HtmlLabelInfo values(342,'��',7) 
GO
insert into HtmlLabelInfo values(343,'Setting',8) 
GO
insert into HtmlLabelInfo values(343,'����',7) 
GO
insert into HtmlLabelInfo values(344,'Subject',8) 
GO
insert into HtmlLabelInfo values(344,'����',7) 
GO
insert into HtmlLabelInfo values(345,'Content',8) 
GO
insert into HtmlLabelInfo values(345,'����',7) 
GO
insert into HtmlLabelInfo values(346,'Contain',8) 
GO
insert into HtmlLabelInfo values(346,'����',7) 
GO
insert into HtmlLabelInfo values(347,'Advance',8) 
GO
insert into HtmlLabelInfo values(347,'�߼�',7) 
GO
insert into HtmlLabelInfo values(348,'From',8) 
GO
insert into HtmlLabelInfo values(348,'��',7) 
GO
insert into HtmlLabelInfo values(349,'To',8) 
GO
insert into HtmlLabelInfo values(349,'��',7) 
GO
insert into HtmlLabelInfo values(350,'SaveAs',8) 
GO
insert into HtmlLabelInfo values(350,'���Ϊ',7) 
GO
insert into HtmlLabelInfo values(351,'Report',8) 
GO
insert into HtmlLabelInfo values(351,'����',7) 
GO
insert into HtmlLabelInfo values(352,'Miscellaneous',8) 
GO
insert into HtmlLabelInfo values(352,'ͳ��',7) 
GO
insert into HtmlLabelInfo values(353,'Belong',8) 
GO
insert into HtmlLabelInfo values(353,'����',7) 
GO
insert into HtmlLabelInfo values(354,'Refresh',8) 
GO
insert into HtmlLabelInfo values(354,'ˢ��',7) 
GO
insert into HtmlLabelInfo values(355,'Count',8) 
GO
insert into HtmlLabelInfo values(355,'����',7) 
GO
insert into HtmlLabelInfo values(356,'Result',8) 
GO
insert into HtmlLabelInfo values(356,'���',7) 
GO
insert into HtmlLabelInfo values(357,'Job Title',8) 
GO
insert into HtmlLabelInfo values(357,'ְ��',7) 
GO
insert into HtmlLabelInfo values(358,'Count',8) 
GO
insert into HtmlLabelInfo values(358,'�ϼ�',7) 
GO
insert into HtmlLabelInfo values(359,'Confirm',8) 
GO
insert into HtmlLabelInfo values(359,'����',7) 
GO
insert into HtmlLabelInfo values(360,'Open',8) 
GO
insert into HtmlLabelInfo values(360,'��',7) 
GO
insert into HtmlLabelInfo values(361,'More',8) 
GO
insert into HtmlLabelInfo values(361,'��ϸ',7) 
GO
insert into HtmlLabelInfo values(362,'Employee',8) 
GO
insert into HtmlLabelInfo values(362,'Ա��',7) 
GO
insert into HtmlLabelInfo values(363,'Count',8) 
GO
insert into HtmlLabelInfo values(363,'����',7) 
GO
insert into HtmlLabelInfo values(364,'ReSearch',8) 
GO
insert into HtmlLabelInfo values(364,'��������',7) 
GO
insert into HtmlLabelInfo values(365,'New',8) 
GO
insert into HtmlLabelInfo values(365,'�½�',7) 
GO
insert into HtmlLabelInfo values(366,'Recruit',8) 
GO
insert into HtmlLabelInfo values(366,'��Ƹ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(367,'View',8) 
GO
insert into HtmlLabelInfo values(367,'�鿴',7) 
GO
insert into HtmlLabelInfo values(368,'Applier',8) 
GO
insert into HtmlLabelInfo values(368,'������',7) 
GO
insert into HtmlLabelInfo values(369,'Schedule',8) 
GO
insert into HtmlLabelInfo values(369,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(370,'Public',8) 
GO
insert into HtmlLabelInfo values(370,'����',7) 
GO
insert into HtmlLabelInfo values(371,'Vocation',8) 
GO
insert into HtmlLabelInfo values(371,'����',7) 
GO
insert into HtmlLabelInfo values(372,'Different',8) 
GO
insert into HtmlLabelInfo values(372,'��һ��',7) 
GO
insert into HtmlLabelInfo values(374,'HrmDuring',8) 
GO
insert into HtmlLabelInfo values(374,'�����ڼ�',7) 
GO
insert into HtmlLabelInfo values(375,'Other',8) 
GO
insert into HtmlLabelInfo values(375,'����',7) 
GO
insert into HtmlLabelInfo values(376,'Structure',8) 
GO
insert into HtmlLabelInfo values(376,'��֯',7) 
GO
insert into HtmlLabelInfo values(377,'Country',8) 
GO
insert into HtmlLabelInfo values(377,'����',7) 
GO
insert into HtmlLabelInfo values(378,'Position',8) 
GO
insert into HtmlLabelInfo values(378,'�칫�ص�',7) 
GO
insert into HtmlLabelInfo values(380,'Work',8) 
GO
insert into HtmlLabelInfo values(380,'����',7) 
GO
insert into HtmlLabelInfo values(381,'Structure',8) 
GO
insert into HtmlLabelInfo values(381,'�ṹ',7) 
GO
insert into HtmlLabelInfo values(382,'Duty ',8) 
GO
insert into HtmlLabelInfo values(382,'ְ��',7) 
GO
insert into HtmlLabelInfo values(383,'Function',8) 
GO
insert into HtmlLabelInfo values(383,'ְ��',7) 
GO
insert into HtmlLabelInfo values(384,'Skill',8) 
GO
insert into HtmlLabelInfo values(384,'����',7) 
GO
insert into HtmlLabelInfo values(385,'Perview',8) 
GO
insert into HtmlLabelInfo values(385,'Ȩ��',7) 
GO
insert into HtmlLabelInfo values(386,'Budget',8) 
GO
insert into HtmlLabelInfo values(386,'Ԥ��',7) 
GO
insert into HtmlLabelInfo values(387,'Element',8) 
GO
insert into HtmlLabelInfo values(387,'Ҫ��',7) 
GO
insert into HtmlLabelInfo values(388,'Main',8) 
GO
insert into HtmlLabelInfo values(388,'����',7) 
GO
insert into HtmlLabelInfo values(389,'Bank Account',8) 
GO
insert into HtmlLabelInfo values(389,'�����ʻ�',7) 
GO
insert into HtmlLabelInfo values(390,'Day',8) 
GO
insert into HtmlLabelInfo values(390,'��',7) 
GO
insert into HtmlLabelInfo values(391,'Hour',8) 
GO
insert into HtmlLabelInfo values(391,'Сʱ',7) 
GO
insert into HtmlLabelInfo values(392,'Monday',8) 
GO
insert into HtmlLabelInfo values(392,'����һ',7) 
GO
insert into HtmlLabelInfo values(393,'Tuesday',8) 
GO
insert into HtmlLabelInfo values(393,'���ڶ�',7) 
GO
insert into HtmlLabelInfo values(394,'Wednesday',8) 
GO
insert into HtmlLabelInfo values(394,'������',7) 
GO
insert into HtmlLabelInfo values(395,'Thursday',8) 
GO
insert into HtmlLabelInfo values(395,'������',7) 
GO
insert into HtmlLabelInfo values(396,'Friday',8) 
GO
insert into HtmlLabelInfo values(396,'������',7) 
GO
insert into HtmlLabelInfo values(397,'Saturday',8) 
GO
insert into HtmlLabelInfo values(397,'������',7) 
GO
insert into HtmlLabelInfo values(398,'Sunday',8) 
GO
insert into HtmlLabelInfo values(398,'������',7) 
GO
insert into HtmlLabelInfo values(399,'ShortName',8) 
GO
insert into HtmlLabelInfo values(399,'���',7) 
GO
insert into HtmlLabelInfo values(400,'Not_Define',8) 
GO
insert into HtmlLabelInfo values(400,'δ����',7) 
GO
insert into HtmlLabelInfo values(401,'Create',8) 
GO
insert into HtmlLabelInfo values(401,'����',7) 
GO
insert into HtmlLabelInfo values(402,'Value Added Tax ',8) 
GO
insert into HtmlLabelInfo values(402,'��ֵ˰',7) 
GO
insert into HtmlLabelInfo values(403,'Number',8) 
GO
insert into HtmlLabelInfo values(403,'����',7) 
GO
insert into HtmlLabelInfo values(404,'Start ',8) 
GO
insert into HtmlLabelInfo values(404,'��ʼ',7) 
GO
insert into HtmlLabelInfo values(405,'End ',8) 
GO
insert into HtmlLabelInfo values(405,'����',7) 
GO
insert into HtmlLabelInfo values(406,'Currency',8) 
GO
insert into HtmlLabelInfo values(406,'����',7) 
GO
insert into HtmlLabelInfo values(407,'Plan',8) 
GO
insert into HtmlLabelInfo values(407,'�ƻ�',7) 
GO
insert into HtmlLabelInfo values(408,'competency',8) 
GO
insert into HtmlLabelInfo values(408,'����',7) 
GO
insert into HtmlLabelInfo values(409,'Password',8) 
GO
insert into HtmlLabelInfo values(409,'����',7) 
GO
insert into HtmlLabelInfo values(410,'Other Info',8) 
GO
insert into HtmlLabelInfo values(410,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(411,'HRM Info',8) 
GO
insert into HtmlLabelInfo values(411,'��������',7) 
GO
insert into HtmlLabelInfo values(412,'Login ID',8) 
GO
insert into HtmlLabelInfo values(412,'��¼��',7) 
GO
insert into HtmlLabelInfo values(413,'Name',8) 
GO
insert into HtmlLabelInfo values(413,'����',7) 
GO
insert into HtmlLabelInfo values(415,'Inactive',8) 
GO
insert into HtmlLabelInfo values(415,'����Ծ',7) 
GO
insert into HtmlLabelInfo values(416,'Sex',8) 
GO
insert into HtmlLabelInfo values(416,'�Ա�',7) 
GO
insert into HtmlLabelInfo values(417,'male',8) 
GO
insert into HtmlLabelInfo values(417,'����',7) 
GO
insert into HtmlLabelInfo values(418,'female',8) 
GO
insert into HtmlLabelInfo values(418,'Ů��',7) 
GO
insert into HtmlLabelInfo values(419,'Work Location',8) 
GO
insert into HtmlLabelInfo values(419,'������ַ',7) 
GO
insert into HtmlLabelInfo values(420,'Officer',8) 
GO
insert into HtmlLabelInfo values(420,'�칫��',7) 
GO
insert into HtmlLabelInfo values(421,'Telephone',8) 
GO
insert into HtmlLabelInfo values(421,'�绰',7) 
GO
insert into HtmlLabelInfo values(422,'Mobil Phone',8) 
GO
insert into HtmlLabelInfo values(422,'�ֻ�',7) 
GO
insert into HtmlLabelInfo values(423,'Exist',8) 
GO
insert into HtmlLabelInfo values(423,'����',7) 
GO
insert into HtmlLabelInfo values(424,'Mender',8) 
GO
insert into HtmlLabelInfo values(424,'�޸���',7) 
GO
insert into HtmlLabelInfo values(425,'Cost ',8) 
GO
insert into HtmlLabelInfo values(425,'�ɱ�',7) 
GO
insert into HtmlLabelInfo values(426,'Center',8) 
GO
insert into HtmlLabelInfo values(426,'����',7) 
GO
insert into HtmlLabelInfo values(427,'G/L',8) 
GO
insert into HtmlLabelInfo values(427,'����',7) 
GO
insert into HtmlLabelInfo values(428,'Transactions',8) 
GO
insert into HtmlLabelInfo values(428,'��֧',7) 
GO
insert into HtmlLabelInfo values(430,'Participations',8) 
GO
insert into HtmlLabelInfo values(430,'����',7) 
GO
insert into HtmlLabelInfo values(431,'members',8) 
GO
insert into HtmlLabelInfo values(431,'��Ա',7) 
GO
insert into HtmlLabelInfo values(432,'Job Groups',8) 
GO
insert into HtmlLabelInfo values(432,'��������',7) 
GO
insert into HtmlLabelInfo values(433,'Description ',8) 
GO
insert into HtmlLabelInfo values(433,'����',7) 
GO
insert into HtmlLabelInfo values(434,'involvement',8) 
GO
insert into HtmlLabelInfo values(434,'�漰',7) 
GO
insert into HtmlLabelInfo values(436,'ratifier',8) 
GO
insert into HtmlLabelInfo values(436,'��׼��',7) 
GO
insert into HtmlLabelInfo values(437,'implement',8) 
GO
insert into HtmlLabelInfo values(437,'ʵ����',7) 
GO
insert into HtmlLabelInfo values(438,'handler',8) 
GO
insert into HtmlLabelInfo values(438,'������',7) 
GO
insert into HtmlLabelInfo values(439,'approver',8) 
GO
insert into HtmlLabelInfo values(439,'������',7) 
GO
insert into HtmlLabelInfo values(440,'popedomItem',8) 
GO
insert into HtmlLabelInfo values(440,'Ȩ����',7) 
GO
insert into HtmlLabelInfo values(441,'Assitant',8) 
GO
insert into HtmlLabelInfo values(441,'����',7) 
GO
insert into HtmlLabelInfo values(442,'Subordinates',8) 
GO
insert into HtmlLabelInfo values(442,'����',7) 
GO
insert into HtmlLabelInfo values(443,'Last login date',8) 
GO
insert into HtmlLabelInfo values(443,'����¼����',7) 
GO
insert into HtmlLabelInfo values(444,'Mobil Call',8) 
GO
insert into HtmlLabelInfo values(444,'Ѱ��',7) 
GO
insert into HtmlLabelInfo values(445,'Year',8) 
GO
insert into HtmlLabelInfo values(445,'��',7) 
GO
insert into HtmlLabelInfo values(446,'During',8) 
GO
insert into HtmlLabelInfo values(446,'�ڼ�',7) 
GO
insert into HtmlLabelInfo values(447,'changetype',8) 
GO
insert into HtmlLabelInfo values(447,'�䶯',7) 
GO
insert into HtmlLabelInfo values(448,'Salary',8) 
GO
insert into HtmlLabelInfo values(448,'н��',7) 
GO
insert into HtmlLabelInfo values(449,'Caculate',8) 
GO
insert into HtmlLabelInfo values(449,'����',7) 
GO
insert into HtmlLabelInfo values(450,'Difftime',8) 
GO
insert into HtmlLabelInfo values(450,'���ʱ��',7) 
GO
insert into HtmlLabelInfo values(451,'Min.',8) 
GO
insert into HtmlLabelInfo values(451,'��С',7) 
GO
insert into HtmlLabelInfo values(452,'countnum',8) 
GO
insert into HtmlLabelInfo values(452,'����',7) 
GO
insert into HtmlLabelInfo values(453,'fixnum',8) 
GO
insert into HtmlLabelInfo values(453,'�̶�ֵ',7) 
GO
insert into HtmlLabelInfo values(454,'Remark',8) 
GO
insert into HtmlLabelInfo values(454,'��ע',7) 
GO
insert into HtmlLabelInfo values(455,'SubCategory',8) 
GO
insert into HtmlLabelInfo values(455,'����',7) 
GO
insert into HtmlLabelInfo values(456,'Increase',8) 
GO
insert into HtmlLabelInfo values(456,'����',7) 
GO
insert into HtmlLabelInfo values(457,'Decrease',8) 
GO
insert into HtmlLabelInfo values(457,'����',7) 
GO
insert into HtmlLabelInfo values(458,'holiday',8) 
GO
insert into HtmlLabelInfo values(458,'��Ϣ��',7) 
GO
insert into HtmlLabelInfo values(459,'Fix',8) 
GO
insert into HtmlLabelInfo values(459,'�̶�',7) 
GO
insert into HtmlLabelInfo values(460,'Firstname',8) 
GO
insert into HtmlLabelInfo values(460,'����',7) 
GO
insert into HtmlLabelInfo values(461,'Lastname',8) 
GO
insert into HtmlLabelInfo values(461,'��',7) 
GO
insert into HtmlLabelInfo values(462,'Title',8) 
GO
insert into HtmlLabelInfo values(462,'�ƺ�',7) 
GO
insert into HtmlLabelInfo values(463,'Unknow',8) 
GO
insert into HtmlLabelInfo values(463,'δ֪',7) 
GO
insert into HtmlLabelInfo values(464,'Birthday',8) 
GO
insert into HtmlLabelInfo values(464,'��������',7) 
GO
insert into HtmlLabelInfo values(465,'Nationality',8) 
GO
insert into HtmlLabelInfo values(465,'����',7) 
GO
insert into HtmlLabelInfo values(466,'P&amp;L',7) 
GO
insert into HtmlLabelInfo values(466,'P&amp;L',8) 
GO
insert into HtmlLabelInfo values(467,'Oral',8) 
GO
insert into HtmlLabelInfo values(467,'ĸ��',7) 
GO
insert into HtmlLabelInfo values(468,'System',8) 
GO
insert into HtmlLabelInfo values(468,'ϵͳ',7) 
GO
insert into HtmlLabelInfo values(469,'Marital status',8) 
GO
insert into HtmlLabelInfo values(469,'����״��',7) 
GO
insert into HtmlLabelInfo values(470,'Single',8) 
GO
insert into HtmlLabelInfo values(470,'δ��',7) 
GO
insert into HtmlLabelInfo values(471,'Married',8) 
GO
insert into HtmlLabelInfo values(471,'�ѻ�',7) 
GO
insert into HtmlLabelInfo values(472,'Devorced',8) 
GO
insert into HtmlLabelInfo values(472,'����',7) 
GO
insert into HtmlLabelInfo values(473,'Living together',8) 
GO
insert into HtmlLabelInfo values(473,'ͬ��',7) 
GO
insert into HtmlLabelInfo values(474,'Married date',8) 
GO
insert into HtmlLabelInfo values(474,'�������',7) 
GO
insert into HtmlLabelInfo values(475,'Aliasname',8) 
GO
insert into HtmlLabelInfo values(475,'����',7) 
GO
insert into HtmlLabelInfo values(476,'Work info',8) 
GO
insert into HtmlLabelInfo values(476,'�칫��Ϣ',7) 
GO
insert into HtmlLabelInfo values(477,'Email',8) 
GO
insert into HtmlLabelInfo values(477,'�����ʼ�',7) 
GO
insert into HtmlLabelInfo values(478,'Home info',8) 
GO
insert into HtmlLabelInfo values(478,'��ͥ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(479,'Post Code',8) 
GO
insert into HtmlLabelInfo values(479,'��������',7) 
GO
insert into HtmlLabelInfo values(480,'Temporary',8) 
GO
insert into HtmlLabelInfo values(480,'��ʱ',7) 
GO
insert into HtmlLabelInfo values(481,'Start date',8) 
GO
insert into HtmlLabelInfo values(481,'��ʼ��',7) 
GO
insert into HtmlLabelInfo values(482,'Contract end date',8) 
GO
insert into HtmlLabelInfo values(482,'��ͬ��ֹ����',7) 
GO
insert into HtmlLabelInfo values(483,'System end date',8) 
GO
insert into HtmlLabelInfo values(483,'ϵͳֹͣ����',7) 
GO
insert into HtmlLabelInfo values(484,'Job level',8) 
GO
insert into HtmlLabelInfo values(484,'ְ��',7) 
GO
insert into HtmlLabelInfo values(485,'Purchare limit',8) 
GO
insert into HtmlLabelInfo values(485,'�ɹ�����',7) 
GO
insert into HtmlLabelInfo values(486,'Security no',8) 
GO
insert into HtmlLabelInfo values(486,'��ᰲȫ��',7) 
GO
insert into HtmlLabelInfo values(487,'Credit card',8) 
GO
insert into HtmlLabelInfo values(487,'���ÿ�',7) 
GO
insert into HtmlLabelInfo values(488,'Expiry date',8) 
GO
insert into HtmlLabelInfo values(488,'������',7) 
GO
insert into HtmlLabelInfo values(490,'Calendar',8) 
GO
insert into HtmlLabelInfo values(490,'����',7) 
GO
insert into HtmlLabelInfo values(491,'List',8) 
GO
insert into HtmlLabelInfo values(491,'�嵥',7) 
GO
insert into HtmlLabelInfo values(492,'purviewgroup',8) 
GO
insert into HtmlLabelInfo values(492,'Ȩ����',7) 
GO
insert into HtmlLabelInfo values(493,'City',8) 
GO
insert into HtmlLabelInfo values(493,'����',7) 
GO
insert into HtmlLabelInfo values(494,'Fax',8) 
GO
insert into HtmlLabelInfo values(494,'����',7) 
GO
insert into HtmlLabelInfo values(495,'Color',8) 
GO
insert into HtmlLabelInfo values(495,'��ɫ',7) 
GO
insert into HtmlLabelInfo values(496,'days',8) 
GO
insert into HtmlLabelInfo values(496,'����',7) 
GO
insert into HtmlLabelInfo values(497,'ForeignKey',8) 
GO
insert into HtmlLabelInfo values(497,'���',7) 
GO
insert into HtmlLabelInfo values(498,'Fail',8) 
GO
insert into HtmlLabelInfo values(498,'ʧ��',7) 
GO
insert into HtmlLabelInfo values(499,'Before',8) 
GO
insert into HtmlLabelInfo values(499,'ǰ��',7) 
GO
insert into HtmlLabelInfo values(500,'Last',8) 
GO
insert into HtmlLabelInfo values(500,'����',7) 
GO
insert into HtmlLabelInfo values(501,'Confirm password',8) 
GO
insert into HtmlLabelInfo values(501,'ȷ������',7) 
GO
insert into HtmlLabelInfo values(502,'Old',8) 
GO
insert into HtmlLabelInfo values(502,'��',7) 
GO
insert into HtmlLabelInfo values(503,'Payroll',8) 
GO
insert into HtmlLabelInfo values(503,'���ʵ�',7) 
GO
insert into HtmlLabelInfo values(504,'opinion',8) 
GO
insert into HtmlLabelInfo values(504,'���',7) 
GO
insert into HtmlLabelInfo values(505,'DocType',8) 
GO
insert into HtmlLabelInfo values(505,'�ĵ�����',7) 
GO
insert into HtmlLabelInfo values(506,'DocMould',8) 
GO
insert into HtmlLabelInfo values(506,'�ĵ�ģ��',7) 
GO
insert into HtmlLabelInfo values(507,'PicUpload',8) 
GO
insert into HtmlLabelInfo values(507,'ͼƬ�ϴ�',7) 
GO
insert into HtmlLabelInfo values(508,'DocCopyCut',8) 
GO
insert into HtmlLabelInfo values(508,'�ĵ�����ת��',7) 
GO
insert into HtmlLabelInfo values(509,'DefSchedule',8) 
GO
insert into HtmlLabelInfo values(509,'Ĭ�Ϲ���ʱ��',7) 
GO
insert into HtmlLabelInfo values(510,'DeptSchedule',8) 
GO
insert into HtmlLabelInfo values(510,'���Ź���ʱ��',7) 
GO
insert into HtmlLabelInfo values(511,'ResourceSchedule',8) 
GO
insert into HtmlLabelInfo values(511,'������Դ����ʱ��',7) 
GO
insert into HtmlLabelInfo values(512,'ScheduleDiff',8) 
GO
insert into HtmlLabelInfo values(512,'��һ�¹���ʱ��',7) 
GO
insert into HtmlLabelInfo values(513,'CostCenterMain',8) 
GO
insert into HtmlLabelInfo values(513,'�ɱ�������Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(514,'CostCenterSub',8) 
GO
insert into HtmlLabelInfo values(514,'�ɱ����ķ�Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(515,'CostCenter',8) 
GO
insert into HtmlLabelInfo values(515,'�ɱ�����',7) 
GO
insert into HtmlLabelInfo values(516,'PubHoliday',8) 
GO
insert into HtmlLabelInfo values(516,'��������',7) 
GO
insert into HtmlLabelInfo values(517,'Location',8) 
GO
insert into HtmlLabelInfo values(517,'����',7) 
GO
insert into HtmlLabelInfo values(518,'JobDuty',8) 
GO
insert into HtmlLabelInfo values(518,'����ְ��',7) 
GO
insert into HtmlLabelInfo values(519,'JobFunction',8) 
GO
insert into HtmlLabelInfo values(519,'����ְ��',7) 
GO
insert into HtmlLabelInfo values(520,'WorkSkill',8) 
GO
insert into HtmlLabelInfo values(520,'��������',7) 
GO
insert into HtmlLabelInfo values(521,'SalaryComponentTypes',8) 
GO
insert into HtmlLabelInfo values(521,'����Ҫ������',7) 
GO
insert into HtmlLabelInfo values(522,'Relative',8) 
GO
insert into HtmlLabelInfo values(522,'���',7) 
GO
insert into HtmlLabelInfo values(523,'Total',8) 
GO
insert into HtmlLabelInfo values(523,'�ܼ�',7) 
GO
insert into HtmlLabelInfo values(524,'Now',8) 
GO
insert into HtmlLabelInfo values(524,'��ǰ',7) 
GO
insert into HtmlLabelInfo values(525,'Last One',8) 
GO
insert into HtmlLabelInfo values(525,'ǰһ��',7) 
GO
insert into HtmlLabelInfo values(526,'Average',8) 
GO
insert into HtmlLabelInfo values(526,'ƽ��',7) 
GO
insert into HtmlLabelInfo values(527,'Search',8) 
GO
insert into HtmlLabelInfo values(527,'��ѯ',7) 
GO
insert into HtmlLabelInfo values(528,'Room',8) 
GO
insert into HtmlLabelInfo values(528,'����',7) 
GO
insert into HtmlLabelInfo values(529,'Global',8) 
GO
insert into HtmlLabelInfo values(529,'ȫ��',7) 
GO
insert into HtmlLabelInfo values(530,'Start',8) 
GO
insert into HtmlLabelInfo values(530,'��ʼ',7) 
GO
insert into HtmlLabelInfo values(531,'ShortCut',8) 
GO
insert into HtmlLabelInfo values(531,'��ݷ�ʽ',7) 
GO
insert into HtmlLabelInfo values(532,'Train',8) 
GO
insert into HtmlLabelInfo values(532,'��ѵ',7) 
GO
insert into HtmlLabelInfo values(533,'SalaryComponent',8) 
GO
insert into HtmlLabelInfo values(533,'����Ҫ��',7) 
GO
insert into HtmlLabelInfo values(534,'Salary',8) 
GO
insert into HtmlLabelInfo values(534,'���',7) 
GO
insert into HtmlLabelInfo values(535,'Logistic',8) 
GO
insert into HtmlLabelInfo values(535,'�ʲ�',7) 
GO
insert into HtmlLabelInfo values(536,'Allowance',8) 
GO
insert into HtmlLabelInfo values(536,'����',7) 
GO
insert into HtmlLabelInfo values(537,'Decrease',8) 
GO
insert into HtmlLabelInfo values(537,'����',7) 
GO
insert into HtmlLabelInfo values(538,'PerHalfyear',8) 
GO
insert into HtmlLabelInfo values(538,'ÿ����',7) 
GO
insert into HtmlLabelInfo values(539,'PerDay',8) 
GO
insert into HtmlLabelInfo values(539,'ÿ��',7) 
GO
insert into HtmlLabelInfo values(540,'PerHour',8) 
GO
insert into HtmlLabelInfo values(540,'ÿСʱ',7) 
GO
insert into HtmlLabelInfo values(541,'PerMonth',8) 
GO
insert into HtmlLabelInfo values(541,'ÿ��',7) 
GO
insert into HtmlLabelInfo values(542,'OnlyOnce',8) 
GO
insert into HtmlLabelInfo values(542,'ֻһ��',7) 
GO
insert into HtmlLabelInfo values(543,'PerSeason',8) 
GO
insert into HtmlLabelInfo values(543,'ÿ����',7) 
GO
insert into HtmlLabelInfo values(544,'PerTwoWeeks',8) 
GO
insert into HtmlLabelInfo values(544,'ÿ����',7) 
GO
insert into HtmlLabelInfo values(545,'PerWeek',8) 
GO
insert into HtmlLabelInfo values(545,'ÿ��',7) 
GO
insert into HtmlLabelInfo values(546,'PerYear',8) 
GO
insert into HtmlLabelInfo values(546,'ÿ��',7) 
GO
insert into HtmlLabelInfo values(547,'Online',8) 
GO
insert into HtmlLabelInfo values(547,'�Ƿ�����',7) 
GO
insert into HtmlLabelInfo values(548,'IncludeTex',8) 
GO
insert into HtmlLabelInfo values(548,'��˰',7) 
GO
insert into HtmlLabelInfo values(549,'AfterTex',8) 
GO
insert into HtmlLabelInfo values(549,'˰��',7) 
GO
insert into HtmlLabelInfo values(550,'ledger',8) 
GO
insert into HtmlLabelInfo values(550,'�����ʻ�',7) 
GO
insert into HtmlLabelInfo values(551,'AddRow',8) 
GO
insert into HtmlLabelInfo values(551,'����һ��',7) 
GO
insert into HtmlLabelInfo values(552,'Private',8) 
GO
insert into HtmlLabelInfo values(552,'˽��',7) 
GO
insert into HtmlLabelInfo values(553,'Process',8) 
GO
insert into HtmlLabelInfo values(553,'����',7) 
GO
insert into HtmlLabelInfo values(554,'Enter',8) 
GO
insert into HtmlLabelInfo values(554,'����',7) 
GO
insert into HtmlLabelInfo values(555,'Done',8) 
GO
insert into HtmlLabelInfo values(555,'���',7) 
GO
insert into HtmlLabelInfo values(556,'SelectAll',8) 
GO
insert into HtmlLabelInfo values(556,'ȫѡ',7) 
GO
insert into HtmlLabelInfo values(557,'none',8) 
GO
insert into HtmlLabelInfo values(557,'��',7) 
GO
insert into HtmlLabelInfo values(558,'NOTE',8) 
GO
insert into HtmlLabelInfo values(558,'��ʾ',7) 
GO
insert into HtmlLabelInfo values(559,'CheckStr',8) 
GO
insert into HtmlLabelInfo values(559,'���μ��',7) 
GO
insert into HtmlLabelInfo values(560,'OtherInfoType',8) 
GO
insert into HtmlLabelInfo values(560,'������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(561,'Parameter',8) 
GO
insert into HtmlLabelInfo values(561,'����',7) 
GO
insert into HtmlLabelInfo values(562,'Organization chart',8) 
GO
insert into HtmlLabelInfo values(562,'��֯ͼ��',7) 
GO
insert into HtmlLabelInfo values(563,'Data',8) 
GO
insert into HtmlLabelInfo values(563,'����',7) 
GO
insert into HtmlLabelInfo values(564,'Indicator',8) 
GO
insert into HtmlLabelInfo values(564,'ָʾ��',7) 
GO
insert into HtmlLabelInfo values(565,'FIE',8) 
GO
insert into HtmlLabelInfo values(565,'����ʱ�����',7) 
GO
insert into HtmlLabelInfo values(566,'Revenue',8) 
GO
insert into HtmlLabelInfo values(566,'����',7) 
GO
insert into HtmlLabelInfo values(567,'Scenario',8) 
GO
insert into HtmlLabelInfo values(567,'�汾',7) 
GO
insert into HtmlLabelInfo values(568,'Abbreviation',8) 
GO
insert into HtmlLabelInfo values(568,'��д',7) 
GO
insert into HtmlLabelInfo values(569,'Contact Way',8) 
GO
insert into HtmlLabelInfo values(569,'��ϵ����',7) 
GO
insert into HtmlLabelInfo values(570,'Free Field',8) 
GO
insert into HtmlLabelInfo values(570,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(571,'Account',8) 
GO
insert into HtmlLabelInfo values(571,'�ʻ�',7) 
GO
insert into HtmlLabelInfo values(572,'Contacter',8) 
GO
insert into HtmlLabelInfo values(572,'��ϵ��',7) 
GO
insert into HtmlLabelInfo values(573,'Delivery Methods',8) 
GO
insert into HtmlLabelInfo values(573,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(574,'Marketing',8) 
GO
insert into HtmlLabelInfo values(574,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(575,'Sector',8) 
GO
insert into HtmlLabelInfo values(575,'��ҵ',7) 
GO
insert into HtmlLabelInfo values(576,'Sizes',8) 
GO
insert into HtmlLabelInfo values(576,'��ģ',7) 
GO
insert into HtmlLabelInfo values(577,'Payment Way',8) 
GO
insert into HtmlLabelInfo values(577,'֧����ʽ',7) 
GO
insert into HtmlLabelInfo values(578,'Classification ',8) 
GO
insert into HtmlLabelInfo values(578,'�ּ�',7) 
GO
insert into HtmlLabelInfo values(579,'Rules',8) 
GO
insert into HtmlLabelInfo values(579,'����',7) 
GO
insert into HtmlLabelInfo values(580,'Credit Level',8) 
GO
insert into HtmlLabelInfo values(580,'���õȼ�',7) 
GO
insert into HtmlLabelInfo values(581,'�ۼƺ�ͬ���',7) 
GO
insert into HtmlLabelInfo values(581,'�ۼƺ�ͬ���',8) 
GO
insert into HtmlLabelInfo values(582,'Portal',8) 
GO
insert into HtmlLabelInfo values(582,'�Ż�',7) 
GO
insert into HtmlLabelInfo values(583,'Prefix',8) 
GO
insert into HtmlLabelInfo values(583,'ǰ׺',7) 
GO
insert into HtmlLabelInfo values(584,'Postfix',8) 
GO
insert into HtmlLabelInfo values(584,'��׺',7) 
GO
insert into HtmlLabelInfo values(585,'Ledger',8) 
GO
insert into HtmlLabelInfo values(585,'��Ŀ',7) 
GO
insert into HtmlLabelInfo values(586,'Project Type',8) 
GO
insert into HtmlLabelInfo values(586,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(587,'Project Status',8) 
GO
insert into HtmlLabelInfo values(587,'��Ŀ״̬',7) 
GO
insert into HtmlLabelInfo values(588,'Exchange rate',8) 
GO
insert into HtmlLabelInfo values(588,'����',7) 
GO
insert into HtmlLabelInfo values(589,'Reset',8) 
GO
insert into HtmlLabelInfo values(589,'��ԭ',7) 
GO
insert into HtmlLabelInfo values(590,'Code',8) 
GO
insert into HtmlLabelInfo values(590,'����',7) 
GO
insert into HtmlLabelInfo values(591,'�ϼ���λ',7) 
GO
insert into HtmlLabelInfo values(591,'�ϼ���λ',8) 
GO
insert into HtmlLabelInfo values(593,'�ȼ�����',7) 
GO
insert into HtmlLabelInfo values(593,'�ȼ�����',8) 
GO
insert into HtmlLabelInfo values(594,'����',7) 
GO
insert into HtmlLabelInfo values(594,'����',8) 
GO
insert into HtmlLabelInfo values(595,'����',7) 
GO
insert into HtmlLabelInfo values(595,'����',8) 
GO
insert into HtmlLabelInfo values(596,'Superior',8) 
GO
insert into HtmlLabelInfo values(596,'�ϼ�',7) 
GO
insert into HtmlLabelInfo values(597,'Delivery',8) 
GO
insert into HtmlLabelInfo values(597,'�ͻ�',7) 
GO
insert into HtmlLabelInfo values(598,'Send',8) 
GO
insert into HtmlLabelInfo values(598,'����',7) 
GO
insert into HtmlLabelInfo values(599,'Term',8) 
GO
insert into HtmlLabelInfo values(599,'��ʽ',7) 
GO
insert into HtmlLabelInfo values(600,'Ship',8) 
GO
insert into HtmlLabelInfo values(600,'�˻�',7) 
GO
insert into HtmlLabelInfo values(601,'Receive',8) 
GO
insert into HtmlLabelInfo values(601,'�ջ�',7) 
GO
insert into HtmlLabelInfo values(602,'Status',8) 
GO
insert into HtmlLabelInfo values(602,'״̬',7) 
GO
insert into HtmlLabelInfo values(603,'Level',8) 
GO
insert into HtmlLabelInfo values(603,'�ȼ�',7) 
GO
insert into HtmlLabelInfo values(604,'Method',8) 
GO
insert into HtmlLabelInfo values(604,'����',7) 
GO
insert into HtmlLabelInfo values(605,'SecVocation',8) 
GO
insert into HtmlLabelInfo values(605,'����ҵ',7) 
GO
insert into HtmlLabelInfo values(606,'Label',8) 
GO
insert into HtmlLabelInfo values(606,'��ʾ��',7) 
GO
insert into HtmlLabelInfo values(607,'Number',8) 
GO
insert into HtmlLabelInfo values(607,'����',7) 
GO
insert into HtmlLabelInfo values(608,'Text',8) 
GO
insert into HtmlLabelInfo values(608,'�ı�',7) 
GO
insert into HtmlLabelInfo values(609,'YesNo',8) 
GO
insert into HtmlLabelInfo values(609,'�ж�',7) 
GO
insert into HtmlLabelInfo values(610,'Project Card',8) 
GO
insert into HtmlLabelInfo values(610,'��Ŀ��',7) 
GO
insert into HtmlLabelInfo values(611,'Add',8) 
GO
insert into HtmlLabelInfo values(611,'���',7) 
GO
insert into HtmlLabelInfo values(612,'Name',8) 
GO
insert into HtmlLabelInfo values(612,'��',7) 
GO
insert into HtmlLabelInfo values(613,'Original',8) 
GO
insert into HtmlLabelInfo values(613,'ԭʼ',7) 
GO
insert into HtmlLabelInfo values(614,'Contract',8) 
GO
insert into HtmlLabelInfo values(614,'��ͬ',7) 
GO
insert into HtmlLabelInfo values(615,'Submit',8) 
GO
insert into HtmlLabelInfo values(615,'�ύ',7) 
GO
insert into HtmlLabelInfo values(616,'Submiter',8) 
GO
insert into HtmlLabelInfo values(616,'�ύ��',7) 
GO
insert into HtmlLabelInfo values(617,'End Date',8) 
GO
insert into HtmlLabelInfo values(617,'��ֹ��',7) 
GO
insert into HtmlLabelInfo values(618,'Modify Log',8) 
GO
insert into HtmlLabelInfo values(618,'�޸ļ�¼',7) 
GO
insert into HtmlLabelInfo values(619,'Home',8) 
GO
insert into HtmlLabelInfo values(619,'סլ',7) 
GO
insert into HtmlLabelInfo values(620,'Mobile Telephone',8) 
GO
insert into HtmlLabelInfo values(620,'�ƶ��绰',7) 
GO
insert into HtmlLabelInfo values(621,'Contact',8) 
GO
insert into HtmlLabelInfo values(621,'��ϵ',7) 
GO
insert into HtmlLabelInfo values(622,'Log',8) 
GO
insert into HtmlLabelInfo values(622,'���',7) 
GO
insert into HtmlLabelInfo values(623,'By',8) 
GO
insert into HtmlLabelInfo values(623,'��',7) 
GO
insert into HtmlLabelInfo values(624,'Member Only',8) 
GO
insert into HtmlLabelInfo values(624,'��Ա�ɼ�',7) 
GO
insert into HtmlLabelInfo values(625,'Whether customer is passive',8) 
GO
insert into HtmlLabelInfo values(625,'�Ƿ�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(626,'Manager View',8) 
GO
insert into HtmlLabelInfo values(626,'��Ա�ϼ��ɼ�',7) 
GO
insert into HtmlLabelInfo values(627,'Parent View',8) 
GO
insert into HtmlLabelInfo values(627,'�ϼ���Ա�ɼ�',7) 
GO
insert into HtmlLabelInfo values(628,'True',8) 
GO
insert into HtmlLabelInfo values(628,'ʵ��',7) 
GO
insert into HtmlLabelInfo values(629,'Expense',8) 
GO
insert into HtmlLabelInfo values(629,'֧��',7) 
GO
insert into HtmlLabelInfo values(630,'Operation',8) 
GO
insert into HtmlLabelInfo values(630,'ҵ��',7) 
GO
insert into HtmlLabelInfo values(631,'Complain',8) 
GO
insert into HtmlLabelInfo values(631,'��Թ',7) 
GO
insert into HtmlLabelInfo values(632,'Human Hour',8) 
GO
insert into HtmlLabelInfo values(632,'��ʱ',7) 
GO
insert into HtmlLabelInfo values(633,'Management',8) 
GO
insert into HtmlLabelInfo values(633,'����',7) 
GO
insert into HtmlLabelInfo values(634,'Intro',8) 
GO
insert into HtmlLabelInfo values(634,'����',7) 
GO
insert into HtmlLabelInfo values(635,'Passive',8) 
GO
insert into HtmlLabelInfo values(635,'����',7) 
GO
insert into HtmlLabelInfo values(636,'Parent Project',8) 
GO
insert into HtmlLabelInfo values(636,'�ϼ���Ŀ',7) 
GO
insert into HtmlLabelInfo values(637,'Evaluate Doc',8) 
GO
insert into HtmlLabelInfo values(637,'������',7) 
GO
insert into HtmlLabelInfo values(638,'Confirm Doc',8) 
GO
insert into HtmlLabelInfo values(638,'ȷ����',7) 
GO
insert into HtmlLabelInfo values(639,'Propose Doc',8) 
GO
insert into HtmlLabelInfo values(639,'������',7) 
GO
insert into HtmlLabelInfo values(640,'Job Title',8) 
GO
insert into HtmlLabelInfo values(640,'����ͷ��',7) 
GO
insert into HtmlLabelInfo values(642,'English',8) 
GO
insert into HtmlLabelInfo values(642,'Ӣ��',7) 
GO
insert into HtmlLabelInfo values(643,'Province',8) 
GO
insert into HtmlLabelInfo values(643,'ʡ',7) 
GO
insert into HtmlLabelInfo values(644,'County',8) 
GO
insert into HtmlLabelInfo values(644,'��',7) 
GO
insert into HtmlLabelInfo values(645,'Source',8) 
GO
insert into HtmlLabelInfo values(645,'���;��',7) 
GO
insert into HtmlLabelInfo values(646,'Sales Confirm Book',8) 
GO
insert into HtmlLabelInfo values(646,'����ȷ����',7) 
GO
insert into HtmlLabelInfo values(647,'Card',8) 
GO
insert into HtmlLabelInfo values(647,'��',7) 
GO
insert into HtmlLabelInfo values(648,'Request',8) 
GO
insert into HtmlLabelInfo values(648,'����',7) 
GO
insert into HtmlLabelInfo values(649,'Currency',8) 
GO
insert into HtmlLabelInfo values(649,'����',7) 
GO
insert into HtmlLabelInfo values(650,'Credit Salary Modify',8) 
GO
insert into HtmlLabelInfo values(650,'���ý������',7) 
GO
insert into HtmlLabelInfo values(651,'Discount Rate',8) 
GO
insert into HtmlLabelInfo values(651,'�ۿ���',7) 
GO
insert into HtmlLabelInfo values(652,'Payment Type',8) 
GO
insert into HtmlLabelInfo values(652,'֧������',7) 
GO
insert into HtmlLabelInfo values(653,'��ֵ˰����',7) 
GO
insert into HtmlLabelInfo values(653,'��ֵ˰����',8) 
GO
insert into HtmlLabelInfo values(654,'Bank Account',8) 
GO
insert into HtmlLabelInfo values(654,'�����ʻ�',7) 
GO
insert into HtmlLabelInfo values(655,'Invoice Customer',8) 
GO
insert into HtmlLabelInfo values(655,'��Ʊ�ͻ�',7) 
GO
insert into HtmlLabelInfo values(657,'Delivery Type',8) 
GO
insert into HtmlLabelInfo values(657,'��������',7) 
GO
insert into HtmlLabelInfo values(658,'Payment Term',8) 
GO
insert into HtmlLabelInfo values(658,'֧������',7) 
GO
insert into HtmlLabelInfo values(659,'Type Since',8) 
GO
insert into HtmlLabelInfo values(659,'���ʹ�',7) 
GO
insert into HtmlLabelInfo values(660,'Fullname',8) 
GO
insert into HtmlLabelInfo values(660,'ȫ��',7) 
GO
insert into HtmlLabelInfo values(661,'Office Telephone',8) 
GO
insert into HtmlLabelInfo values(661,'�칫�ҵ绰',7) 
GO
insert into HtmlLabelInfo values(662,'Home Telephone',8) 
GO
insert into HtmlLabelInfo values(662,'סլ�绰',7) 
GO
insert into HtmlLabelInfo values(663,'Entries',8) 
GO
insert into HtmlLabelInfo values(663,'��¼',7) 
GO
insert into HtmlLabelInfo values(664,'Process',8) 
GO
insert into HtmlLabelInfo values(664,'����',7) 
GO
insert into HtmlLabelInfo values(665,'Watch',8) 
GO
insert into HtmlLabelInfo values(665,'���',7) 
GO
insert into HtmlLabelInfo values(666,'G/L',8) 
GO
insert into HtmlLabelInfo values(666,'�ܷ�����',7) 
GO
insert into HtmlLabelInfo values(667,'G/L',8) 
GO
insert into HtmlLabelInfo values(667,'��ϸ��',7) 
GO
insert into HtmlLabelInfo values(668,'Analyze',8) 
GO
insert into HtmlLabelInfo values(668,'����',7) 
GO
insert into HtmlLabelInfo values(669,'level',8) 
GO
insert into HtmlLabelInfo values(669,'���',7) 
GO
insert into HtmlLabelInfo values(670,'leave',8) 
GO
insert into HtmlLabelInfo values(670,'���',7) 
GO
insert into HtmlLabelInfo values(671,'age',8) 
GO
insert into HtmlLabelInfo values(671,'����',7) 
GO
insert into HtmlLabelInfo values(672,'FlowIn',8) 
GO
insert into HtmlLabelInfo values(672,'����',7) 
GO
insert into HtmlLabelInfo values(673,'FlowOut',8) 
GO
insert into HtmlLabelInfo values(673,'����',7) 
GO
insert into HtmlLabelInfo values(674,'login',8) 
GO
insert into HtmlLabelInfo values(674,'��¼',7) 
GO
insert into HtmlLabelInfo values(675,'review',8) 
GO
insert into HtmlLabelInfo values(675,'����',7) 
GO
insert into HtmlLabelInfo values(676,'curve',8) 
GO
insert into HtmlLabelInfo values(676,'�����ͼ��',7) 
GO
insert into HtmlLabelInfo values(677,'mailmerge',8) 
GO
insert into HtmlLabelInfo values(677,'�ʼ��ϲ�',7) 
GO
insert into HtmlLabelInfo values(678,'activity',8) 
GO
insert into HtmlLabelInfo values(678,'�',7) 
GO
insert into HtmlLabelInfo values(679,'recent',8) 
GO
insert into HtmlLabelInfo values(679,'����',7) 
GO
insert into HtmlLabelInfo values(680,'stock',8) 
GO
insert into HtmlLabelInfo values(680,'��Ȩ',7) 
GO
insert into HtmlLabelInfo values(681,'Insert Images',8) 
GO
insert into HtmlLabelInfo values(681,'����ͼƬ',7) 
GO
insert into HtmlLabelInfo values(682,'Logistics',8) 
GO
insert into HtmlLabelInfo values(682,'����',7) 
GO
insert into HtmlLabelInfo values(683,'SecurityLevel',8) 
GO
insert into HtmlLabelInfo values(683,'��ȫ����',7) 
GO
insert into HtmlLabelInfo values(684,'FieldManage',8) 
GO
insert into HtmlLabelInfo values(684,'�ֶι���',7) 
GO
insert into HtmlLabelInfo values(685,'FieldName',8) 
GO
insert into HtmlLabelInfo values(685,'�ֶ�����',7) 
GO
insert into HtmlLabelInfo values(686,'FieldType',8) 
GO
insert into HtmlLabelInfo values(686,'�ֶ�����',7) 
GO
insert into HtmlLabelInfo values(687,'ShowType',8) 
GO
insert into HtmlLabelInfo values(687,'������ʽ',7) 
GO
insert into HtmlLabelInfo values(688,'SingleLineText',8) 
GO
insert into HtmlLabelInfo values(688,'�����ı���',7) 
GO
insert into HtmlLabelInfo values(689,'MultiLineText',8) 
GO
insert into HtmlLabelInfo values(689,'�����ı���',7) 
GO
insert into HtmlLabelInfo values(690,'SelectCombo',8) 
GO
insert into HtmlLabelInfo values(690,'ѡ���',7) 
GO
insert into HtmlLabelInfo values(691,'CheckCombo',8) 
GO
insert into HtmlLabelInfo values(691,'Check��',7) 
GO
insert into HtmlLabelInfo values(694,'SelectAll',8) 
GO
insert into HtmlLabelInfo values(694,'ȫ��ѡ��',7) 
GO
insert into HtmlLabelInfo values(695,'BrowserButton',8) 
GO
insert into HtmlLabelInfo values(695,'�����ť',7) 
GO
insert into HtmlLabelInfo values(696,'Int',8) 
GO
insert into HtmlLabelInfo values(696,'����',7) 
GO
insert into HtmlLabelInfo values(697,'Float',8) 
GO
insert into HtmlLabelInfo values(697,'������',7) 
GO
insert into HtmlLabelInfo values(698,'StrLength',8) 
GO
insert into HtmlLabelInfo values(698,'�ı�����',7) 
GO
insert into HtmlLabelInfo values(699,'FormManage',8) 
GO
insert into HtmlLabelInfo values(699,'������',7) 
GO
insert into HtmlLabelInfo values(700,'Form',8) 
GO
insert into HtmlLabelInfo values(700,'��',7) 
GO
insert into HtmlLabelInfo values(701,'AddField',8) 
GO
insert into HtmlLabelInfo values(701,'�����ֶ�',7) 
GO
insert into HtmlLabelInfo values(702,'DeleteField',8) 
GO
insert into HtmlLabelInfo values(702,'ɾ���ֶ�',7) 
GO
insert into HtmlLabelInfo values(703,'Asset Type',8) 
GO
insert into HtmlLabelInfo values(703,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(704,'Asset Assortment',8) 
GO
insert into HtmlLabelInfo values(704,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(705,'Measure unit ',8) 
GO
insert into HtmlLabelInfo values(705,'������λ',7) 
GO
insert into HtmlLabelInfo values(706,'Asset Relation Type',8) 
GO
insert into HtmlLabelInfo values(706,'��������',7) 
GO
insert into HtmlLabelInfo values(707,'Account Type',8) 
GO
insert into HtmlLabelInfo values(707,'���㷽��',7) 
GO
insert into HtmlLabelInfo values(708,'Order',8) 
GO
insert into HtmlLabelInfo values(708,'������',7) 
GO
insert into HtmlLabelInfo values(709,'Sales Order',8) 
GO
insert into HtmlLabelInfo values(709,'������',7) 
GO
insert into HtmlLabelInfo values(710,'Payment Type',8) 
GO
insert into HtmlLabelInfo values(710,'�ո��ʽ',7) 
GO
insert into HtmlLabelInfo values(711,'Warehouse',8) 
GO
insert into HtmlLabelInfo values(711,'�ֿ�',7) 
GO
insert into HtmlLabelInfo values(712,'Stock flowmode',8) 
GO
insert into HtmlLabelInfo values(712,'�����ⷽʽ',7) 
GO
insert into HtmlLabelInfo values(713,'Attribute',8) 
GO
insert into HtmlLabelInfo values(713,'����',7) 
GO
insert into HtmlLabelInfo values(714,'mark',8) 
GO
insert into HtmlLabelInfo values(714,'���',7) 
GO
insert into HtmlLabelInfo values(715,'Change Mark',8) 
GO
insert into HtmlLabelInfo values(715,'���±��',7) 
GO
insert into HtmlLabelInfo values(716,'Assortment',8) 
GO
insert into HtmlLabelInfo values(716,'����',7) 
GO
insert into HtmlLabelInfo values(717,'Validy date',8) 
GO
insert into HtmlLabelInfo values(717,'��Ч��',7) 
GO
insert into HtmlLabelInfo values(718,'End date',8) 
GO
insert into HtmlLabelInfo values(718,'��Ч��',7) 
GO
insert into HtmlLabelInfo values(719,'Cost price',8) 
GO
insert into HtmlLabelInfo values(719,'�ɱ��۸�',7) 
GO
insert into HtmlLabelInfo values(720,'Purchase price',8) 
GO
insert into HtmlLabelInfo values(720,'�ɹ���',7) 
GO
insert into HtmlLabelInfo values(721,'Sales price',8) 
GO
insert into HtmlLabelInfo values(721,'���ۼ�',7) 
GO
insert into HtmlLabelInfo values(722,'Create date',8) 
GO
insert into HtmlLabelInfo values(722,'��������',7) 
GO
insert into HtmlLabelInfo values(723,'Modify date',8) 
GO
insert into HtmlLabelInfo values(723,'�޸�����',7) 
GO
insert into HtmlLabelInfo values(724,'Relation',8) 
GO
insert into HtmlLabelInfo values(724,'����',7) 
GO
insert into HtmlLabelInfo values(725,'Realize',8) 
GO
insert into HtmlLabelInfo values(725,'�ύ',7) 
GO
insert into HtmlLabelInfo values(726,'Price',8) 
GO
insert into HtmlLabelInfo values(726,'�۸�',7) 
GO
insert into HtmlLabelInfo values(727,'Shop basket',8) 
GO
insert into HtmlLabelInfo values(727,'���ﳵ',7) 
GO
insert into HtmlLabelInfo values(728,'appertain',8) 
GO
insert into HtmlLabelInfo values(728,'����',7) 
GO
insert into HtmlLabelInfo values(729,'relation',8) 
GO
insert into HtmlLabelInfo values(729,'��ϵ',7) 
GO
insert into HtmlLabelInfo values(730,'View',8) 
GO
insert into HtmlLabelInfo values(730,'��ȡ',7) 
GO
insert into HtmlLabelInfo values(731,'User Info',8) 
GO
insert into HtmlLabelInfo values(731,'�û���Ϣ',7) 
GO
insert into HtmlLabelInfo values(732,'Pending',8) 
GO
insert into HtmlLabelInfo values(732,'δ���',7) 
GO
insert into HtmlLabelInfo values(733,'EndDate',8) 
GO
insert into HtmlLabelInfo values(733,'������',7) 
GO
insert into HtmlLabelInfo values(734,'QualityAnylize',8) 
GO
insert into HtmlLabelInfo values(734,'��������',7) 
GO
insert into HtmlLabelInfo values(735,'Websales order',8) 
GO
insert into HtmlLabelInfo values(735,'���϶���',7) 
GO
insert into HtmlLabelInfo values(736,'Balances Sheet',8) 
GO
insert into HtmlLabelInfo values(736,'�ʲ���ծ��',7) 
GO
insert into HtmlLabelInfo values(737,'Active',8) 
GO
insert into HtmlLabelInfo values(737,'����',7) 
GO
insert into HtmlLabelInfo values(738,'�ʲ����üƻ�',7) 
GO
insert into HtmlLabelInfo values(738,'�ʲ����üƻ�',8) 
GO
insert into HtmlLabelInfo values(739,'Asset stock ',8) 
GO
insert into HtmlLabelInfo values(739,'�����Ϣ',7) 
GO
insert into HtmlLabelInfo values(740,'Start Date',8) 
GO
insert into HtmlLabelInfo values(740,'��ʼ����',7) 
GO
insert into HtmlLabelInfo values(741,'End Date',8) 
GO
insert into HtmlLabelInfo values(741,'��������',7) 
GO
insert into HtmlLabelInfo values(742,'Start Time',8) 
GO
insert into HtmlLabelInfo values(742,'��ʼʱ��',7) 
GO
insert into HtmlLabelInfo values(743,'End Time',8) 
GO
insert into HtmlLabelInfo values(743,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(744,'P&amp;L Sheet',8) 
GO
insert into HtmlLabelInfo values(744,'�����',7) 
GO
insert into HtmlLabelInfo values(745,'Buyer',8) 
GO
insert into HtmlLabelInfo values(745,'��',7) 
GO
insert into HtmlLabelInfo values(746,'Seller',8) 
GO
insert into HtmlLabelInfo values(746,'����',7) 
GO
insert into HtmlLabelInfo values(747,'Asset stock',8) 
GO
insert into HtmlLabelInfo values(747,'���',7) 
GO
insert into HtmlLabelInfo values(748,'Stock inout Detail',8) 
GO
insert into HtmlLabelInfo values(748,'�������ϸ',7) 
GO
insert into HtmlLabelInfo values(749,'����ⵥ��',7) 
GO
insert into HtmlLabelInfo values(749,'����ⵥ��',8) 
GO
insert into HtmlLabelInfo values(750,'���ⵥ',7) 
GO
insert into HtmlLabelInfo values(750,'���ⵥ',8) 
GO
insert into HtmlLabelInfo values(751,'��ⵥ',7) 
GO
insert into HtmlLabelInfo values(751,'��ⵥ',8) 
GO
insert into HtmlLabelInfo values(752,'��ⵥ���',7) 
GO
insert into HtmlLabelInfo values(752,'��ⵥ���',8) 
GO
insert into HtmlLabelInfo values(753,'�������',7) 
GO
insert into HtmlLabelInfo values(753,'�������',8) 
GO
insert into HtmlLabelInfo values(754,'��ⷽʽ',7) 
GO
insert into HtmlLabelInfo values(754,'��ⷽʽ',8) 
GO
insert into HtmlLabelInfo values(755,'��ⵥ��',7) 
GO
insert into HtmlLabelInfo values(755,'��ⵥ��',8) 
GO
insert into HtmlLabelInfo values(756,'���ⵥ��� ',7) 
GO
insert into HtmlLabelInfo values(756,'���ⵥ��� ',8) 
GO
insert into HtmlLabelInfo values(757,'Ĭ�ϱ���',7) 
GO
insert into HtmlLabelInfo values(757,'Ĭ�ϱ���',8) 
GO
insert into HtmlLabelInfo values(758,'Ĭ�ϱ��ֽ����ܼ�',7) 
GO
insert into HtmlLabelInfo values(758,'Ĭ�ϱ��ֽ����ܼ�',8) 
GO
insert into HtmlLabelInfo values(759,'Ĭ�ϱ��ֽ�����˰��',7) 
GO
insert into HtmlLabelInfo values(759,'Ĭ�ϱ��ֽ�����˰��',8) 
GO
insert into HtmlLabelInfo values(760,'�����ܼ�',7) 
GO
insert into HtmlLabelInfo values(760,'�����ܼ�',8) 
GO
insert into HtmlLabelInfo values(761,'������˰��',7) 
GO
insert into HtmlLabelInfo values(761,'������˰��',8) 
GO
insert into HtmlLabelInfo values(762,'���ⷽʽ ',7) 
GO
insert into HtmlLabelInfo values(762,'���ⷽʽ ',8) 
GO
insert into HtmlLabelInfo values(763,'Not confine',8) 
GO
insert into HtmlLabelInfo values(763,'����',7) 
GO
insert into HtmlLabelInfo values(764,'High school',8) 
GO
insert into HtmlLabelInfo values(764,'����',7) 
GO
insert into HtmlLabelInfo values(765,'technical secondary school ',8) 
GO
insert into HtmlLabelInfo values(765,'��ר',7) 
GO
insert into HtmlLabelInfo values(766,'junior college ',8) 
GO
insert into HtmlLabelInfo values(766,'��ר',7) 
GO
insert into HtmlLabelInfo values(767,'undergraduate course ',8) 
GO
insert into HtmlLabelInfo values(767,'����',7) 
GO
insert into HtmlLabelInfo values(768,'master degree',8) 
GO
insert into HtmlLabelInfo values(768,'˶ʿ�о���',7) 
GO
insert into HtmlLabelInfo values(769,'doctor\''s degree',8) 
GO
insert into HtmlLabelInfo values(769,'��ʿ�о���',7) 
GO
insert into HtmlLabelInfo values(770,'��������',7) 
GO
insert into HtmlLabelInfo values(770,'��������',8) 
GO
insert into HtmlLabelInfo values(771,'��ͬ��� ',7) 
GO
insert into HtmlLabelInfo values(771,'��ͬ��� ',8) 
GO
insert into HtmlLabelInfo values(772,'Document Move',8) 
GO
insert into HtmlLabelInfo values(772,'�ĵ��ƶ�',7) 
GO
insert into HtmlLabelInfo values(773,'Career apply information',8) 
GO
insert into HtmlLabelInfo values(773,'ӦƸ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(774,'System Set',8) 
GO
insert into HtmlLabelInfo values(774,'ϵͳ����',7) 
GO
insert into HtmlLabelInfo values(775,'System Log',8) 
GO
insert into HtmlLabelInfo values(775,'ϵͳ��־',7) 
GO
insert into HtmlLabelInfo values(776,'',8) 
GO
insert into HtmlLabelInfo values(776,'�ؽ����ݿ�',7) 
GO
insert into HtmlLabelInfo values(777,'',8) 
GO
insert into HtmlLabelInfo values(777,'��Ŀ��ȫ��',7) 
GO
insert into HtmlLabelInfo values(778,'',8) 
GO
insert into HtmlLabelInfo values(778,'��Ŀ����ϸ',7) 
GO
insert into HtmlLabelInfo values(779,'',8) 
GO
insert into HtmlLabelInfo values(779,'��������ϵ��',7) 
GO
insert into HtmlLabelInfo values(780,'',8) 
GO
insert into HtmlLabelInfo values(780,'������',7) 
GO
insert into HtmlLabelInfo values(781,'',8) 
GO
insert into HtmlLabelInfo values(781,'��������',7) 
GO
insert into HtmlLabelInfo values(782,'',8) 
GO
insert into HtmlLabelInfo values(782,'�����Ŀ',7) 
GO
insert into HtmlLabelInfo values(783,'',8) 
GO
insert into HtmlLabelInfo values(783,'��ؿͻ�',7) 
GO
insert into HtmlLabelInfo values(784,'',8) 
GO
insert into HtmlLabelInfo values(784,'��������',7) 
GO
insert into HtmlLabelInfo values(785,'',8) 
GO
insert into HtmlLabelInfo values(785,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(786,'',8) 
GO
insert into HtmlLabelInfo values(786,'���˼ƻ�',7) 
GO
insert into HtmlLabelInfo values(787,'',8) 
GO
insert into HtmlLabelInfo values(787,'�ύ��',7) 
GO
insert into HtmlLabelInfo values(788,'',8) 
GO
insert into HtmlLabelInfo values(788,'���ñ�����',7) 
GO
insert into HtmlLabelInfo values(789,'',8) 
GO
insert into HtmlLabelInfo values(789,'������',7) 
GO
insert into HtmlLabelInfo values(790,'',8) 
GO
insert into HtmlLabelInfo values(790,'��������',7) 
GO
insert into HtmlLabelInfo values(791,'',8) 
GO
insert into HtmlLabelInfo values(791,'����',7) 
GO
insert into HtmlLabelInfo values(792,'',8) 
GO
insert into HtmlLabelInfo values(792,'�����Ա',7) 
GO
insert into HtmlLabelInfo values(793,'',8) 
GO
insert into HtmlLabelInfo values(793,'�������',7) 
GO
insert into HtmlLabelInfo values(794,'',8) 
GO
insert into HtmlLabelInfo values(794,'�����ܽ��',7) 
GO
insert into HtmlLabelInfo values(795,'',8) 
GO
insert into HtmlLabelInfo values(795,'��������',7) 
GO
insert into HtmlLabelInfo values(796,'',8) 
GO
insert into HtmlLabelInfo values(796,'�跽��Ŀ',7) 
GO
insert into HtmlLabelInfo values(797,'',8) 
GO
insert into HtmlLabelInfo values(797,'�跽ժҪ',7) 
GO
insert into HtmlLabelInfo values(798,'',8) 
GO
insert into HtmlLabelInfo values(798,'������Ŀ',7) 
GO
insert into HtmlLabelInfo values(799,'',8) 
GO
insert into HtmlLabelInfo values(799,'����ժҪ',7) 
GO
insert into HtmlLabelInfo values(800,'',8) 
GO
insert into HtmlLabelInfo values(800,'ʡ��',7) 
GO
insert into HtmlLabelInfo values(801,'',8) 
GO
insert into HtmlLabelInfo values(801,'����',7) 
GO
insert into HtmlLabelInfo values(802,'',8) 
GO
insert into HtmlLabelInfo values(802,'γ��',7) 
GO
insert into HtmlLabelInfo values(803,'',8) 
GO
insert into HtmlLabelInfo values(803,'רҵ',7) 
GO
insert into HtmlLabelInfo values(804,'',8) 
GO
insert into HtmlLabelInfo values(804,'�ù�����',7) 
GO
insert into HtmlLabelInfo values(805,'',8) 
GO
insert into HtmlLabelInfo values(805,'ְ�����',7) 
GO
insert into HtmlLabelInfo values(806,'ְ��',7) 
GO
insert into HtmlLabelInfo values(806,'ְ��',8) 
GO
insert into HtmlLabelInfo values(807,'',8) 
GO
insert into HtmlLabelInfo values(807,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(808,'',8) 
GO
insert into HtmlLabelInfo values(808,'��������',7) 
GO
insert into HtmlLabelInfo values(809,'',8) 
GO
insert into HtmlLabelInfo values(809,'����',7) 
GO
insert into HtmlLabelInfo values(810,'',8) 
GO
insert into HtmlLabelInfo values(810,'�ͷ�',7) 
GO
insert into HtmlLabelInfo values(811,'',8) 
GO
insert into HtmlLabelInfo values(811,'����',7) 
GO
insert into HtmlLabelInfo values(812,'',8) 
GO
insert into HtmlLabelInfo values(812,'��������',7) 
GO
insert into HtmlLabelInfo values(813,'',8) 
GO
insert into HtmlLabelInfo values(813,'�������',7) 
GO
insert into HtmlLabelInfo values(814,'',8) 
GO
insert into HtmlLabelInfo values(814,'��ͥ���',7) 
GO
insert into HtmlLabelInfo values(815,'',8) 
GO
insert into HtmlLabelInfo values(815,'��������',7) 
GO
insert into HtmlLabelInfo values(816,'',8) 
GO
insert into HtmlLabelInfo values(816,'��ѵ��¼',7) 
GO
insert into HtmlLabelInfo values(817,'���ͼ�¼',7) 
GO
insert into HtmlLabelInfo values(817,'���ͼ�¼',8) 
GO
insert into HtmlLabelInfo values(818,'',8) 
GO
insert into HtmlLabelInfo values(818,'ѧ��',7) 
GO
insert into HtmlLabelInfo values(819,'',8) 
GO
insert into HtmlLabelInfo values(819,'����',7) 
GO
insert into HtmlLabelInfo values(820,'',8) 
GO
insert into HtmlLabelInfo values(820,'�м�',7) 
GO
insert into HtmlLabelInfo values(821,'',8) 
GO
insert into HtmlLabelInfo values(821,'����',7) 
GO
insert into HtmlLabelInfo values(822,'',8) 
GO
insert into HtmlLabelInfo values(822,'����',7) 
GO
insert into HtmlLabelInfo values(823,'',8) 
GO
insert into HtmlLabelInfo values(823,'��ͨ',7) 
GO
insert into HtmlLabelInfo values(824,'',8) 
GO
insert into HtmlLabelInfo values(824,'����',7) 
GO
insert into HtmlLabelInfo values(825,'',7) 
GO
insert into HtmlLabelInfo values(825,'',8) 
GO
insert into HtmlLabelInfo values(826,'',8) 
GO
insert into HtmlLabelInfo values(826,'ȷ��',7) 
GO
insert into HtmlLabelInfo values(827,'',8) 
GO
insert into HtmlLabelInfo values(827,'�����',7) 
GO
insert into HtmlLabelInfo values(828,'',8) 
GO
insert into HtmlLabelInfo values(828,'�������',7) 
GO
insert into HtmlLabelInfo values(829,'',8) 
GO
insert into HtmlLabelInfo values(829,'��ٵ�',7) 
GO
insert into HtmlLabelInfo values(830,'',8) 
GO
insert into HtmlLabelInfo values(830,'�ʲ�״̬',7) 
GO
insert into HtmlLabelInfo values(831,'',8) 
GO
insert into HtmlLabelInfo values(831,'�ʲ���',7) 
GO
insert into HtmlLabelInfo values(832,'',8) 
GO
insert into HtmlLabelInfo values(832,'���ʲ���',7) 
GO
insert into HtmlLabelInfo values(833,'',8) 
GO
insert into HtmlLabelInfo values(833,'��ѵѧʱ',7) 
GO
insert into HtmlLabelInfo values(834,'',8) 
GO
insert into HtmlLabelInfo values(834,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(835,'',8) 
GO
insert into HtmlLabelInfo values(835,'�۾ɷ�һ',7) 
GO
insert into HtmlLabelInfo values(836,'',8) 
GO
insert into HtmlLabelInfo values(836,'�۾ɷ���',7) 
GO
insert into HtmlLabelInfo values(837,'',8) 
GO
insert into HtmlLabelInfo values(837,'�ʲ��۾ɷ�',7) 
GO
insert into HtmlLabelInfo values(838,'',8) 
GO
insert into HtmlLabelInfo values(838,'��ϵʵʩ��',7) 
GO
insert into HtmlLabelInfo values(839,'',8) 
GO
insert into HtmlLabelInfo values(839,'��������Դ',7) 
GO
insert into HtmlLabelInfo values(840,'',8) 
GO
insert into HtmlLabelInfo values(840,'��ͻ�',7) 
GO
insert into HtmlLabelInfo values(841,'',8) 
GO
insert into HtmlLabelInfo values(841,'��Ŀ�ƻ�',7) 
GO
insert into HtmlLabelInfo values(842,'',8) 
GO
insert into HtmlLabelInfo values(842,'�ƻ�����',7) 
GO
insert into HtmlLabelInfo values(843,'',8) 
GO
insert into HtmlLabelInfo values(843,'�ƻ�����',7) 
GO
insert into HtmlLabelInfo values(844,'',8) 
GO
insert into HtmlLabelInfo values(844,'�ο��ĵ�',7) 
GO
insert into HtmlLabelInfo values(845,'',8) 
GO
insert into HtmlLabelInfo values(845,'Ԥ����',7) 
GO
insert into HtmlLabelInfo values(846,'',8) 
GO
insert into HtmlLabelInfo values(846,'����Ŀ',7) 
GO
insert into HtmlLabelInfo values(847,'',8) 
GO
insert into HtmlLabelInfo values(847,'����',7) 
GO
insert into HtmlLabelInfo values(848,'',8) 
GO
insert into HtmlLabelInfo values(848,'��Ҫ��',7) 
GO
insert into HtmlLabelInfo values(849,'',8) 
GO
insert into HtmlLabelInfo values(849,'�Ӱ�����',7) 
GO
insert into HtmlLabelInfo values(850,'',8) 
GO
insert into HtmlLabelInfo values(850,'�Ӱ���',7) 
GO
insert into HtmlLabelInfo values(851,'',8) 
GO
insert into HtmlLabelInfo values(851,'�Ӱ�ԭ��',7) 
GO
insert into HtmlLabelInfo values(852,'',8) 
GO
insert into HtmlLabelInfo values(852,'������',7) 
GO
insert into HtmlLabelInfo values(853,'',8) 
GO
insert into HtmlLabelInfo values(853,'��Сʱ��',7) 
GO
insert into HtmlLabelInfo values(854,'',8) 
GO
insert into HtmlLabelInfo values(854,'������������',7) 
GO
insert into HtmlLabelInfo values(855,'',8) 
GO
insert into HtmlLabelInfo values(855,'��������',7) 
GO
insert into HtmlLabelInfo values(856,'',8) 
GO
insert into HtmlLabelInfo values(856,'������',7) 
GO
insert into HtmlLabelInfo values(857,'',8) 
GO
insert into HtmlLabelInfo values(857,'����ĵ�',7) 
GO
insert into HtmlLabelInfo values(858,'',8) 
GO
insert into HtmlLabelInfo values(858,'����ʲ�',7) 
GO
insert into HtmlLabelInfo values(859,'',8) 
GO
insert into HtmlLabelInfo values(859,'����ԭ��',7) 
GO
insert into HtmlLabelInfo values(860,'',8) 
GO
insert into HtmlLabelInfo values(860,'��������',7) 
GO
insert into HtmlLabelInfo values(861,'',8) 
GO
insert into HtmlLabelInfo values(861,'ԭ��',7) 
GO
insert into HtmlLabelInfo values(862,'',8) 
GO
insert into HtmlLabelInfo values(862,'�������',7) 
GO
insert into HtmlLabelInfo values(863,'',8) 
GO
insert into HtmlLabelInfo values(863,'������',7) 
GO
insert into HtmlLabelInfo values(864,'',8) 
GO
insert into HtmlLabelInfo values(864,'�ƻ�����',7) 
GO
insert into HtmlLabelInfo values(865,'',8) 
GO
insert into HtmlLabelInfo values(865,'�ƻ���',7) 
GO
insert into HtmlLabelInfo values(866,'',8) 
GO
insert into HtmlLabelInfo values(866,'�ܼƻ����',7) 
GO
insert into HtmlLabelInfo values(867,'',8) 
GO
insert into HtmlLabelInfo values(867,'��ؿͻ�',7) 
GO
insert into HtmlLabelInfo values(868,'',8) 
GO
insert into HtmlLabelInfo values(868,'����ĵ�',7) 
GO
insert into HtmlLabelInfo values(869,'',8) 
GO
insert into HtmlLabelInfo values(869,'�깺����',7) 
GO
insert into HtmlLabelInfo values(870,'',8) 
GO
insert into HtmlLabelInfo values(870,'�깺��',7) 
GO
insert into HtmlLabelInfo values(871,'',8) 
GO
insert into HtmlLabelInfo values(871,'��;',7) 
GO
insert into HtmlLabelInfo values(872,'',8) 
GO
insert into HtmlLabelInfo values(872,'�ʲ��깺��',7) 
GO
insert into HtmlLabelInfo values(873,'',8) 
GO
insert into HtmlLabelInfo values(873,'������',7) 
GO
insert into HtmlLabelInfo values(874,'',8) 
GO
insert into HtmlLabelInfo values(874,'ƾ֤��',7) 
GO
insert into HtmlLabelInfo values(875,'',8) 
GO
insert into HtmlLabelInfo values(875,'һ�ܹ��������',7) 
GO
insert into HtmlLabelInfo values(876,'',8) 
GO
insert into HtmlLabelInfo values(876,'�¹����ƻ���',7) 
GO
insert into HtmlLabelInfo values(877,'',8) 
GO
insert into HtmlLabelInfo values(877,'�¹����ܽᵥ',7) 
GO
insert into HtmlLabelInfo values(878,'',8) 
GO
insert into HtmlLabelInfo values(878,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(879,'',8) 
GO
insert into HtmlLabelInfo values(879,'�깺����',7) 
GO
insert into HtmlLabelInfo values(880,'',8) 
GO
insert into HtmlLabelInfo values(880,'��������',7) 
GO
insert into HtmlLabelInfo values(881,'',8) 
GO
insert into HtmlLabelInfo values(881,'���ø���',7) 
GO
insert into HtmlLabelInfo values(882,'',8) 
GO
insert into HtmlLabelInfo values(882,'������',7) 
GO
insert into HtmlLabelInfo values(883,'',8) 
GO
insert into HtmlLabelInfo values(883,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(884,'',8) 
GO
insert into HtmlLabelInfo values(884,'ԭ������',7) 
GO
insert into HtmlLabelInfo values(885,'',8) 
GO
insert into HtmlLabelInfo values(885,'ԭ�����ž���',7) 
GO
insert into HtmlLabelInfo values(886,'',8) 
GO
insert into HtmlLabelInfo values(886,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(887,'',8) 
GO
insert into HtmlLabelInfo values(887,'�·�',7) 
GO
insert into HtmlLabelInfo values(888,'',8) 
GO
insert into HtmlLabelInfo values(888,'ԭ�����',7) 
GO
insert into HtmlLabelInfo values(889,'',8) 
GO
insert into HtmlLabelInfo values(889,'���������',7) 
GO
insert into HtmlLabelInfo values(890,'',8) 
GO
insert into HtmlLabelInfo values(890,'¼��֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(891,'',8) 
GO
insert into HtmlLabelInfo values(891,'��ְ֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(892,'',8) 
GO
insert into HtmlLabelInfo values(892,'�ܲ�Ԥ�㶨�Ƶ�',7) 
GO
insert into HtmlLabelInfo values(893,'',8) 
GO
insert into HtmlLabelInfo values(893,'��¼����',7) 
GO
insert into HtmlLabelInfo values(894,'',8) 
GO
insert into HtmlLabelInfo values(894,'���˲���',7) 
GO
insert into HtmlLabelInfo values(895,'',8) 
GO
insert into HtmlLabelInfo values(895,'��ְ�ʸ�',7) 
GO
insert into HtmlLabelInfo values(896,'',8) 
GO
insert into HtmlLabelInfo values(896,'������',7) 
GO
insert into HtmlLabelInfo values(897,'',8) 
GO
insert into HtmlLabelInfo values(897,'��ְ��',7) 
GO
insert into HtmlLabelInfo values(898,'',8) 
GO
insert into HtmlLabelInfo values(898,'��ְʱ��',7) 
GO
insert into HtmlLabelInfo values(899,'',8) 
GO
insert into HtmlLabelInfo values(899,'��ְ˵��',7) 
GO
insert into HtmlLabelInfo values(900,'',8) 
GO
insert into HtmlLabelInfo values(900,'��Ʊ����',7) 
GO
insert into HtmlLabelInfo values(901,'',8) 
GO
insert into HtmlLabelInfo values(901,'������',7) 
GO
insert into HtmlLabelInfo values(902,'',8) 
GO
insert into HtmlLabelInfo values(902,'���ղֿ�',7) 
GO
insert into HtmlLabelInfo values(903,'',8) 
GO
insert into HtmlLabelInfo values(903,'�ʲ����',7) 
GO
insert into HtmlLabelInfo values(904,'',8) 
GO
insert into HtmlLabelInfo values(904,'����ͺ�',7) 
GO
insert into HtmlLabelInfo values(905,'',8) 
GO
insert into HtmlLabelInfo values(905,'Ӧ������',7) 
GO
insert into HtmlLabelInfo values(906,'',8) 
GO
insert into HtmlLabelInfo values(906,'ʵ������',7) 
GO
insert into HtmlLabelInfo values(907,'',8) 
GO
insert into HtmlLabelInfo values(907,'�ƻ��۸�',7) 
GO
insert into HtmlLabelInfo values(908,'',8) 
GO
insert into HtmlLabelInfo values(908,'ʵ�ʼ۸�',7) 
GO
insert into HtmlLabelInfo values(909,'',8) 
GO
insert into HtmlLabelInfo values(909,'�ƻ����',7) 
GO
insert into HtmlLabelInfo values(910,'',8) 
GO
insert into HtmlLabelInfo values(910,'ʵ�ʽ��',7) 
GO
insert into HtmlLabelInfo values(911,'',8) 
GO
insert into HtmlLabelInfo values(911,'�۸����',7) 
GO
insert into HtmlLabelInfo values(912,'',8) 
GO
insert into HtmlLabelInfo values(912,'�������',7) 
GO
insert into HtmlLabelInfo values(913,'',8) 
GO
insert into HtmlLabelInfo values(913,'�ɹ���',7) 
GO
insert into HtmlLabelInfo values(914,'',8) 
GO
insert into HtmlLabelInfo values(914,'������λ����',7) 
GO
insert into HtmlLabelInfo values(915,'',8) 
GO
insert into HtmlLabelInfo values(915,'�ʲ��̵�',7) 
GO
insert into HtmlLabelInfo values(916,'',8) 
GO
insert into HtmlLabelInfo values(916,'�̵���Ա',7) 
GO
insert into HtmlLabelInfo values(917,'',8) 
GO
insert into HtmlLabelInfo values(917,'�̵���Ա2',7) 
GO
insert into HtmlLabelInfo values(918,'',8) 
GO
insert into HtmlLabelInfo values(918,'�̵㲿��',7) 
GO
insert into HtmlLabelInfo values(919,'',8) 
GO
insert into HtmlLabelInfo values(919,'�̵�ʱ��',7) 
GO
insert into HtmlLabelInfo values(920,'',8) 
GO
insert into HtmlLabelInfo values(920,'����',7) 
GO
insert into HtmlLabelInfo values(921,'',8) 
GO
insert into HtmlLabelInfo values(921,'������¼',7) 
GO
insert into HtmlLabelInfo values(922,'',8) 
GO
insert into HtmlLabelInfo values(922,'�������ñ���',7) 
GO
insert into HtmlLabelInfo values(923,'',8) 
GO
insert into HtmlLabelInfo values(923,'��������',7) 
GO
insert into HtmlLabelInfo values(924,'',8) 
GO
insert into HtmlLabelInfo values(924,'����ά��',7) 
GO
insert into HtmlLabelInfo values(925,'',8) 
GO
insert into HtmlLabelInfo values(925,'�칫��Ʒ����',7) 
GO
insert into HtmlLabelInfo values(926,'',8) 
GO
insert into HtmlLabelInfo values(926,'��ػ���',7) 
GO
insert into HtmlLabelInfo values(1000,'',8) 
GO
insert into HtmlLabelInfo values(1000,'ָ���´���',7) 
GO
insert into HtmlLabelInfo values(1001,'',8) 
GO
insert into HtmlLabelInfo values(1001,'ָ���´ﲿ��',7) 
GO
insert into HtmlLabelInfo values(1002,'',8) 
GO
insert into HtmlLabelInfo values(1002,'���ָ��',7) 
GO
insert into HtmlLabelInfo values(1003,'',8) 
GO
insert into HtmlLabelInfo values(1003,'��׼������',7) 
GO
insert into HtmlLabelInfo values(1004,'',8) 
GO
insert into HtmlLabelInfo values(1004,'������ת��',7) 
GO
insert into HtmlLabelInfo values(1005,'',8) 
GO
insert into HtmlLabelInfo values(1005,'��עͨ��',7) 
GO
insert into HtmlLabelInfo values(1006,'',8) 
GO
insert into HtmlLabelInfo values(1006,'��ע',7) 
GO
insert into HtmlLabelInfo values(1007,'',8) 
GO
insert into HtmlLabelInfo values(1007,'ǩ��',7) 
GO
insert into HtmlLabelInfo values(1008,'',8) 
GO
insert into HtmlLabelInfo values(1008,'�������',7) 
GO
insert into HtmlLabelInfo values(1009,'',8) 
GO
insert into HtmlLabelInfo values(1009,'����ͨ��',7) 
GO
insert into HtmlLabelInfo values(1010,'',8) 
GO
insert into HtmlLabelInfo values(1010,'�����˻�',7) 
GO
insert into HtmlLabelInfo values(1011,'',8) 
GO
insert into HtmlLabelInfo values(1011,'Ԥ���������',7) 
GO
insert into HtmlLabelInfo values(1012,'',8) 
GO
insert into HtmlLabelInfo values(1012,'�����ŷ���Ԥ���',7) 
GO
insert into HtmlLabelInfo values(1013,'',8) 
GO
insert into HtmlLabelInfo values(1013,'ȫ��',7) 
GO
insert into HtmlLabelInfo values(1014,'',8) 
GO
insert into HtmlLabelInfo values(1014,'��ʽ',7) 
GO
insert into HtmlLabelInfo values(1015,'',8) 
GO
insert into HtmlLabelInfo values(1015,'������ͳ��',7) 
GO
insert into HtmlLabelInfo values(1016,'',8) 
GO
insert into HtmlLabelInfo values(1016,'��Ԥ�����ͳ��',7) 
GO
insert into HtmlLabelInfo values(1017,'',8) 
GO
insert into HtmlLabelInfo values(1017,'�����ʲ��б�',7) 
GO
insert into HtmlLabelInfo values(1018,'',8) 
GO
insert into HtmlLabelInfo values(1018,'�����ʲ����',7) 
GO
insert into HtmlLabelInfo values(1019,'',8) 
GO
insert into HtmlLabelInfo values(1019,'�����ʲ�����',7) 
GO
insert into HtmlLabelInfo values(1020,'',8) 
GO
insert into HtmlLabelInfo values(1020,'��������',7) 
GO
insert into HtmlLabelInfo values(1021,'',8) 
GO
insert into HtmlLabelInfo values(1021,'�����ʻ�����Ӣ�Ļ�ƴ����',7) 
GO
insert into HtmlLabelInfo values(1022,'',8) 
GO
insert into HtmlLabelInfo values(1022,'��ŵЭ��',7) 
GO
insert into HtmlLabelInfo values(1023,'',8) 
GO
insert into HtmlLabelInfo values(1023,'��Ƭӡ��',7) 
GO
insert into HtmlLabelInfo values(1024,'',8) 
GO
insert into HtmlLabelInfo values(1024,'ӡ�ƺ���',7) 
GO
insert into HtmlLabelInfo values(1025,'',8) 
GO
insert into HtmlLabelInfo values(1025,'ѡ��',7) 
GO
insert into HtmlLabelInfo values(1026,'',8) 
GO
insert into HtmlLabelInfo values(1026,'�ܷ���',7) 
GO
insert into HtmlLabelInfo values(1027,'',8) 
GO
insert into HtmlLabelInfo values(1027,'����Ԥ��',7) 
GO
insert into HtmlLabelInfo values(1028,'',8) 
GO
insert into HtmlLabelInfo values(1028,'��סʱ��',7) 
GO
insert into HtmlLabelInfo values(1029,'',8) 
GO
insert into HtmlLabelInfo values(1029,'�˷�ʱ��',7) 
GO
insert into HtmlLabelInfo values(1030,'',8) 
GO
insert into HtmlLabelInfo values(1030,'ס����',7) 
GO
insert into HtmlLabelInfo values(1031,'',8) 
GO
insert into HtmlLabelInfo values(1031,'������׼',7) 
GO
insert into HtmlLabelInfo values(1032,'',8) 
GO
insert into HtmlLabelInfo values(1032,'�����׼',7) 
GO
insert into HtmlLabelInfo values(1033,'',8) 
GO
insert into HtmlLabelInfo values(1033,'������ܲ�ȷ��',7) 
GO
insert into HtmlLabelInfo values(1034,'',8) 
GO
insert into HtmlLabelInfo values(1034,'�Ƿ񳬱�',7) 
GO
insert into HtmlLabelInfo values(1035,'',8) 
GO
insert into HtmlLabelInfo values(1035,'�������',7) 
GO
insert into HtmlLabelInfo values(1036,'',8) 
GO
insert into HtmlLabelInfo values(1036,'���ʱ��',7) 
GO
insert into HtmlLabelInfo values(1037,'',8) 
GO
insert into HtmlLabelInfo values(1037,'��������',7) 
GO
insert into HtmlLabelInfo values(1038,'',8) 
GO
insert into HtmlLabelInfo values(1038,'�����ճ�',7) 
GO
insert into HtmlLabelInfo values(1039,'',8) 
GO
insert into HtmlLabelInfo values(1039,'�����¹������ܱ�',7) 
GO
insert into HtmlLabelInfo values(1040,'',8) 
GO
insert into HtmlLabelInfo values(1040,'�����',7) 
GO
insert into HtmlLabelInfo values(1041,'',8) 
GO
insert into HtmlLabelInfo values(1041,'��Ҫʱ��',7) 
GO
insert into HtmlLabelInfo values(1042,'',8) 
GO
insert into HtmlLabelInfo values(1042,'Ԥ�ƻ���ʱ��',7) 
GO
insert into HtmlLabelInfo values(1043,'',8) 
GO
insert into HtmlLabelInfo values(1043,'�����',7) 
GO
insert into HtmlLabelInfo values(1044,'',8) 
GO
insert into HtmlLabelInfo values(1044,'�������',7) 
GO
insert into HtmlLabelInfo values(1045,'',8) 
GO
insert into HtmlLabelInfo values(1045,'�����ʻ���',7) 
GO
insert into HtmlLabelInfo values(1046,'',8) 
GO
insert into HtmlLabelInfo values(1046,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(1047,'',8) 
GO
insert into HtmlLabelInfo values(1047,'������',7) 
GO
insert into HtmlLabelInfo values(1048,'',8) 
GO
insert into HtmlLabelInfo values(1048,'ӡˢ��λ',7) 
GO
insert into HtmlLabelInfo values(1049,'',8) 
GO
insert into HtmlLabelInfo values(1049,'����',7) 
GO
insert into HtmlLabelInfo values(1050,'',8) 
GO
insert into HtmlLabelInfo values(1050,'��������',7) 
GO
insert into HtmlLabelInfo values(1051,'',8) 
GO
insert into HtmlLabelInfo values(1051,'Ԥ����˾',7) 
GO
insert into HtmlLabelInfo values(1052,'',8) 
GO
insert into HtmlLabelInfo values(1052,'���˲�������',7) 
GO
insert into HtmlLabelInfo values(1053,'',8) 
GO
insert into HtmlLabelInfo values(1053,'����������ϸ',7) 
GO
insert into HtmlLabelInfo values(1054,'',8) 
GO
insert into HtmlLabelInfo values(1054,'ҵ���д��ѱ���',7) 
GO
insert into HtmlLabelInfo values(1055,'',8) 
GO
insert into HtmlLabelInfo values(1055,'�д�����',7) 
GO
insert into HtmlLabelInfo values(1056,'',8) 
GO
insert into HtmlLabelInfo values(1056,'�д�����',7) 
GO
insert into HtmlLabelInfo values(1057,'',8) 
GO
insert into HtmlLabelInfo values(1057,'�д�����',7) 
GO
insert into HtmlLabelInfo values(1058,'',8) 
GO
insert into HtmlLabelInfo values(1058,'������ʽ',7) 
GO
insert into HtmlLabelInfo values(1059,'',8) 
GO
insert into HtmlLabelInfo values(1059,'���ѵص�',7) 
GO
insert into HtmlLabelInfo values(1060,'',8) 
GO
insert into HtmlLabelInfo values(1060,'����Ŀ��',7) 
GO
insert into HtmlLabelInfo values(1201,'',8) 
GO
insert into HtmlLabelInfo values(1201,'���Ϻ�',7) 
GO
insert into HtmlLabelInfo values(1202,'',8) 
GO
insert into HtmlLabelInfo values(1202,'�����',7) 
GO
insert into HtmlLabelInfo values(1203,'',8) 
GO
insert into HtmlLabelInfo values(1203,'�����',7) 
GO
insert into HtmlLabelInfo values(1204,'',8) 
GO
insert into HtmlLabelInfo values(1204,'�����',7) 
GO
insert into HtmlLabelInfo values(1205,'',8) 
GO
insert into HtmlLabelInfo values(1205,'�˳�',7) 
GO
insert into HtmlLabelInfo values(1206,'',8) 
GO
insert into HtmlLabelInfo values(1206,'�ҵ���ҳ',7) 
GO
insert into HtmlLabelInfo values(1207,'',8) 
GO
insert into HtmlLabelInfo values(1207,'��������',7) 
GO
insert into HtmlLabelInfo values(1208,'',8) 
GO
insert into HtmlLabelInfo values(1208,'�ҵ�CRM',7) 
GO
insert into HtmlLabelInfo values(1209,'',8) 
GO
insert into HtmlLabelInfo values(1209,'�ҵ��ʲ�',7) 
GO
insert into HtmlLabelInfo values(1210,'',8) 
GO
insert into HtmlLabelInfo values(1210,'�ҵ�����',7) 
GO
insert into HtmlLabelInfo values(1211,'',8) 
GO
insert into HtmlLabelInfo values(1211,'�ҵ���Ŀ',7) 
GO
insert into HtmlLabelInfo values(1212,'',8) 
GO
insert into HtmlLabelInfo values(1212,'�ҵ��ĵ�',7) 
GO
insert into HtmlLabelInfo values(1213,'',8) 
GO
insert into HtmlLabelInfo values(1213,'�ҵ��ʼ�',7) 
GO
insert into HtmlLabelInfo values(1214,'',8) 
GO
insert into HtmlLabelInfo values(1214,'�ĵ� - ����',7) 
GO
insert into HtmlLabelInfo values(1215,'',8) 
GO
insert into HtmlLabelInfo values(1215,'�ĵ� - Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(1216,'ͳ�� - ������Ϣ',8) 
GO
insert into HtmlLabelInfo values(1216,'ͳ�� - ������Ϣ',7) 
GO
insert into HtmlLabelInfo values(1217,'',8) 
GO
insert into HtmlLabelInfo values(1217,'ͳ�� - ����',7) 
GO
insert into HtmlLabelInfo values(1218,'',8) 
GO
insert into HtmlLabelInfo values(1218,'ͳ�� - �ͻ���Ϣ',7) 
GO
insert into HtmlLabelInfo values(1219,'',8) 
GO
insert into HtmlLabelInfo values(1219,'��÷�ʽ',7) 
GO
insert into HtmlLabelInfo values(1220,'',8) 
GO
insert into HtmlLabelInfo values(1220,'����ֲ�',7) 
GO
insert into HtmlLabelInfo values(1221,'',8) 
GO
insert into HtmlLabelInfo values(1221,'�ͻ���ϵ���',7) 
GO
insert into HtmlLabelInfo values(1222,'',8) 
GO
insert into HtmlLabelInfo values(1222,'�ͻ��������',7) 
GO
insert into HtmlLabelInfo values(1223,'',8) 
GO
insert into HtmlLabelInfo values(1223,'��¼ - ����',7) 
GO
insert into HtmlLabelInfo values(1224,'',8) 
GO
insert into HtmlLabelInfo values(1224,'�޸� - ����',7) 
GO
insert into HtmlLabelInfo values(1225,'',8) 
GO
insert into HtmlLabelInfo values(1225,'��ȡ - ����',7) 
GO
insert into HtmlLabelInfo values(1226,'',8) 
GO
insert into HtmlLabelInfo values(1226,'�ʼ�����',7) 
GO
insert into HtmlLabelInfo values(1227,'',8) 
GO
insert into HtmlLabelInfo values(1227,'��׼->�����ͻ�',7) 
GO
insert into HtmlLabelInfo values(1228,'',8) 
GO
insert into HtmlLabelInfo values(1228,'��׼->Ǳ�ڿͻ�',7) 
GO
insert into HtmlLabelInfo values(1229,'',8) 
GO
insert into HtmlLabelInfo values(1229,'��׼->�ɹ��ͻ�',7) 
GO
insert into HtmlLabelInfo values(1230,'',8) 
GO
insert into HtmlLabelInfo values(1230,'��׼->�Ե�ͻ�',7) 
GO
insert into HtmlLabelInfo values(1231,'',8) 
GO
insert into HtmlLabelInfo values(1231,'��׼->���Ϳͻ�',7) 
GO
insert into HtmlLabelInfo values(1232,'',8) 
GO
insert into HtmlLabelInfo values(1232,'����',7) 
GO
insert into HtmlLabelInfo values(1233,'',8) 
GO
insert into HtmlLabelInfo values(1233,'�ⶳ',7) 
GO
insert into HtmlLabelInfo values(1234,'',8) 
GO
insert into HtmlLabelInfo values(1234,'�Ż�����',7) 
GO
insert into HtmlLabelInfo values(1235,'',8) 
GO
insert into HtmlLabelInfo values(1235,'�Ż���׼',7) 
GO
insert into HtmlLabelInfo values(1236,'',8) 
GO
insert into HtmlLabelInfo values(1236,'�Ż�����',7) 
GO
insert into HtmlLabelInfo values(1237,'',8) 
GO
insert into HtmlLabelInfo values(1237,'�Ż�����',7) 
GO
insert into HtmlLabelInfo values(1238,'',8) 
GO
insert into HtmlLabelInfo values(1238,'�Ż�����������',7) 
GO
insert into HtmlLabelInfo values(1239,'',8) 
GO
insert into HtmlLabelInfo values(1239,'�½�������',7) 
GO
insert into HtmlLabelInfo values(1240,'',8) 
GO
insert into HtmlLabelInfo values(1240,'�Ż�״̬',7) 
GO
insert into HtmlLabelInfo values(1241,'',8) 
GO
insert into HtmlLabelInfo values(1241,'δ��ͨ',7) 
GO
insert into HtmlLabelInfo values(1242,'',8) 
GO
insert into HtmlLabelInfo values(1242,'������',7) 
GO
insert into HtmlLabelInfo values(1243,'',8) 
GO
insert into HtmlLabelInfo values(1243,'ֱ��ת���տ',7) 
GO
insert into HtmlLabelInfo values(1244,'',8) 
GO
insert into HtmlLabelInfo values(1244,'����ֱ�ӻ�Ʊ',7) 
GO
insert into HtmlLabelInfo values(1245,'',8) 
GO
insert into HtmlLabelInfo values(1245,'��CHF����ҵ�֧��',7) 
GO
insert into HtmlLabelInfo values(1246,'',8) 
GO
insert into HtmlLabelInfo values(1246,'֧Ʊ',7) 
GO
insert into HtmlLabelInfo values(1247,'',8) 
GO
insert into HtmlLabelInfo values(1247,'ֱ��ת��',7) 
GO
insert into HtmlLabelInfo values(1248,'',8) 
GO
insert into HtmlLabelInfo values(1248,'�տ�',7) 
GO
insert into HtmlLabelInfo values(1249,'',8) 
GO
insert into HtmlLabelInfo values(1249,'�ֽ�',7) 
GO
insert into HtmlLabelInfo values(1250,'',8) 
GO
insert into HtmlLabelInfo values(1250,'ָ������',7) 
GO
insert into HtmlLabelInfo values(1251,'',8) 
GO
insert into HtmlLabelInfo values(1251,'ESR֧��',7) 
GO
insert into HtmlLabelInfo values(1252,'',8) 
GO
insert into HtmlLabelInfo values(1252,'��Ʊ',7) 
GO
insert into HtmlLabelInfo values(1253,'',8) 
GO
insert into HtmlLabelInfo values(1253,'ES֧��',7) 
GO
insert into HtmlLabelInfo values(1254,'',8) 
GO
insert into HtmlLabelInfo values(1254,'����֧Ʊ',7) 
GO
insert into HtmlLabelInfo values(1255,'',8) 
GO
insert into HtmlLabelInfo values(1255,'�����ͻ���ϵ���',7) 
GO
insert into HtmlLabelInfo values(1256,'',8) 
GO
insert into HtmlLabelInfo values(1256,'����',7) 
GO
insert into HtmlLabelInfo values(1258,'',8) 
GO
insert into HtmlLabelInfo values(1258,'��һҳ',7) 
GO
insert into HtmlLabelInfo values(1259,'',8) 
GO
insert into HtmlLabelInfo values(1259,'��һҳ',7) 
GO
insert into HtmlLabelInfo values(1260,'',8) 
GO
insert into HtmlLabelInfo values(1260,'������Email��ַ',7) 
GO
insert into HtmlLabelInfo values(1261,'',8) 
GO
insert into HtmlLabelInfo values(1261,'���͵�',7) 
GO
insert into HtmlLabelInfo values(1262,'',8) 
GO
insert into HtmlLabelInfo values(1262,'����ϵ��',7) 
GO
insert into HtmlLabelInfo values(1263,'',8) 
GO
insert into HtmlLabelInfo values(1263,'������ϵ��',7) 
GO
insert into HtmlLabelInfo values(1264,'',8) 
GO
insert into HtmlLabelInfo values(1264,'��ʽ',7) 
GO
insert into HtmlLabelInfo values(1265,'',8) 
GO
insert into HtmlLabelInfo values(1265,'����',7) 
GO
insert into HtmlLabelInfo values(1266,'',8) 
GO
insert into HtmlLabelInfo values(1266,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(1267,'',8) 
GO
insert into HtmlLabelInfo values(1267,'��ʽ',7) 
GO
insert into HtmlLabelInfo values(1268,'',8) 
GO
insert into HtmlLabelInfo values(1268,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(1269,'',8) 
GO
insert into HtmlLabelInfo values(1269,'�ͻ�û�п�Ŀ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(1270,'',8) 
GO
insert into HtmlLabelInfo values(1270,'���޽��',7) 
GO
insert into HtmlLabelInfo values(1271,'',8) 
GO
insert into HtmlLabelInfo values(1271,'���޽��',7) 
GO
insert into HtmlLabelInfo values(1272,'',8) 
GO
insert into HtmlLabelInfo values(1272,'��ȡʱ��',7) 
GO
insert into HtmlLabelInfo values(1273,'',8) 
GO
insert into HtmlLabelInfo values(1273,'��ȡ��',7) 
GO
insert into HtmlLabelInfo values(1274,'',8) 
GO
insert into HtmlLabelInfo values(1274,'��ϵʵʩ��',7) 
GO
insert into HtmlLabelInfo values(1275,'',8) 
GO
insert into HtmlLabelInfo values(1275,'��ϵʱ��',7) 
GO
insert into HtmlLabelInfo values(1276,'',8) 
GO
insert into HtmlLabelInfo values(1276,'��¼ʱ��',7) 
GO
insert into HtmlLabelInfo values(1277,'',8) 
GO
insert into HtmlLabelInfo values(1277,'��ϵʱ��',7) 
GO
insert into HtmlLabelInfo values(1278,'',8) 
GO
insert into HtmlLabelInfo values(1278,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(1279,'',8) 
GO
insert into HtmlLabelInfo values(1279,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(1280,'',8) 
GO
insert into HtmlLabelInfo values(1280,'��ͨ',7) 
GO
insert into HtmlLabelInfo values(1281,'',8) 
GO
insert into HtmlLabelInfo values(1281,'�ӷ���',7) 
GO
insert into HtmlLabelInfo values(1282,'',8) 
GO
insert into HtmlLabelInfo values(1282,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(1283,'',8) 
GO
insert into HtmlLabelInfo values(1283,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(1284,'',8) 
GO
insert into HtmlLabelInfo values(1284,'�ͻ�״��',7) 
GO
insert into HtmlLabelInfo values(1285,'',8) 
GO
insert into HtmlLabelInfo values(1285,'�ͻ���ģ',7) 
GO
insert into HtmlLabelInfo values(1286,'',8) 
GO
insert into HtmlLabelInfo values(1286,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(1287,'',8) 
GO
insert into HtmlLabelInfo values(1287,'��Ŀ��֯',7) 
GO
insert into HtmlLabelInfo values(1288,'',8) 
GO
insert into HtmlLabelInfo values(1288,'CRM ����',7) 
GO
insert into HtmlLabelInfo values(1289,'',8) 
GO
insert into HtmlLabelInfo values(1289,'CRM ��֯',7) 
GO
insert into HtmlLabelInfo values(1290,'',8) 
GO
insert into HtmlLabelInfo values(1290,'����',7) 
GO
insert into HtmlLabelInfo values(1291,'',8) 
GO
insert into HtmlLabelInfo values(1291,'��ĿȨ��',7) 
GO
insert into HtmlLabelInfo values(1292,'',8) 
GO
insert into HtmlLabelInfo values(1292,'�鿴������Ϣ',7) 
GO
insert into HtmlLabelInfo values(1293,'',8) 
GO
insert into HtmlLabelInfo values(1293,'�鿴��ϸ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(1294,'',8) 
GO
insert into HtmlLabelInfo values(1294,'��Ŀ��',7) 
GO
insert into HtmlLabelInfo values(1295,'',8) 
GO
insert into HtmlLabelInfo values(1295,'�ƻ�&����',7) 
GO
insert into HtmlLabelInfo values(1296,'',8) 
GO
insert into HtmlLabelInfo values(1296,'����&���',7) 
GO
insert into HtmlLabelInfo values(1297,'',8) 
GO
insert into HtmlLabelInfo values(1297,'��������',7) 
GO
insert into HtmlLabelInfo values(1298,'',8) 
GO
insert into HtmlLabelInfo values(1298,'����',7) 
GO
insert into HtmlLabelInfo values(1299,'',8) 
GO
insert into HtmlLabelInfo values(1299,'�����ɱ�',7) 
GO
insert into HtmlLabelInfo values(1300,'',8) 
GO
insert into HtmlLabelInfo values(1300,'�豸�ɱ�',7) 
GO
insert into HtmlLabelInfo values(1301,'',8) 
GO
insert into HtmlLabelInfo values(1301,'���ϳɱ�',7) 
GO
insert into HtmlLabelInfo values(1302,'',8) 
GO
insert into HtmlLabelInfo values(1302,'�̶��ʲ��������ܱ�',7) 
GO
insert into HtmlLabelInfo values(1303,'',8) 
GO
insert into HtmlLabelInfo values(1303,'���Ź̶��ʲ�����һ����',7) 
GO
insert into HtmlLabelInfo values(1304,'',8) 
GO
insert into HtmlLabelInfo values(1304,'���Ź̶��ʲ�����һ����',7) 
GO
insert into HtmlLabelInfo values(1305,'',8) 
GO
insert into HtmlLabelInfo values(1305,'�����Ź̶��ʲ��ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1306,'',8) 
GO
insert into HtmlLabelInfo values(1306,'��˾�̶��ʲ��ɹ���ϸ��',7) 
GO
insert into HtmlLabelInfo values(1307,'',8) 
GO
insert into HtmlLabelInfo values(1307,'���¸���������ɹ�һ����',7) 
GO
insert into HtmlLabelInfo values(1308,'',8) 
GO
insert into HtmlLabelInfo values(1308,'����һ�ܹ������ܱ�',7) 
GO
insert into HtmlLabelInfo values(1309,'',8) 
GO
insert into HtmlLabelInfo values(1309,'�����Ű칫��Ʒ�ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1310,'',8) 
GO
insert into HtmlLabelInfo values(1310,'��������Ʒ�ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1311,'',8) 
GO
insert into HtmlLabelInfo values(1311,'�����ŵ�ֵ�׺�Ʒ�ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1312,'',8) 
GO
insert into HtmlLabelInfo values(1312,'������IT�豸�ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1313,'',8) 
GO
insert into HtmlLabelInfo values(1313,'�����żҾ߲ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1314,'',8) 
GO
insert into HtmlLabelInfo values(1314,'������ͼ��ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1315,'',8) 
GO
insert into HtmlLabelInfo values(1315,'��˾�칫��Ʒ�ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1316,'',8) 
GO
insert into HtmlLabelInfo values(1316,'��˾��Ʒ�ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1317,'',8) 
GO
insert into HtmlLabelInfo values(1317,'��˾��ֵ�׺�Ʒ�ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1318,'',8) 
GO
insert into HtmlLabelInfo values(1318,'��˾IT�豸�ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1319,'',8) 
GO
insert into HtmlLabelInfo values(1319,'��˾�Ҿ߲ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1320,'',8) 
GO
insert into HtmlLabelInfo values(1320,'��˾ͼ��ɹ��ƻ���',7) 
GO
insert into HtmlLabelInfo values(1321,'',8) 
GO
insert into HtmlLabelInfo values(1321,'����',7) 
GO
insert into HtmlLabelInfo values(1322,'',8) 
GO
insert into HtmlLabelInfo values(1322,'��ʼ����',7) 
GO
insert into HtmlLabelInfo values(1323,'',8) 
GO
insert into HtmlLabelInfo values(1323,'��������',7) 
GO
insert into HtmlLabelInfo values(1324,'',8) 
GO
insert into HtmlLabelInfo values(1324,'����',7) 
GO
insert into HtmlLabelInfo values(1325,'',8) 
GO
insert into HtmlLabelInfo values(1325,'�̶��ɱ�',7) 
GO
insert into HtmlLabelInfo values(1326,'',8) 
GO
insert into HtmlLabelInfo values(1326,'�豸',7) 
GO
insert into HtmlLabelInfo values(1327,'',8) 
GO
insert into HtmlLabelInfo values(1327,'�ɱ�/��',7) 
GO
insert into HtmlLabelInfo values(1328,'',8) 
GO
insert into HtmlLabelInfo values(1328,'����',7) 
GO
insert into HtmlLabelInfo values(1329,'',8) 
GO
insert into HtmlLabelInfo values(1329,'��λ',7) 
GO
insert into HtmlLabelInfo values(1330,'',8) 
GO
insert into HtmlLabelInfo values(1330,'����',7) 
GO
insert into HtmlLabelInfo values(1331,'',8) 
GO
insert into HtmlLabelInfo values(1331,'����',7) 
GO
insert into HtmlLabelInfo values(1332,'',8) 
GO
insert into HtmlLabelInfo values(1332,'����',7) 
GO
insert into HtmlLabelInfo values(1333,'',8) 
GO
insert into HtmlLabelInfo values(1333,'�ƻ��汾',7) 
GO
insert into HtmlLabelInfo values(1334,'',8) 
GO
insert into HtmlLabelInfo values(1334,'����˵��',7) 
GO
insert into HtmlLabelInfo values(1335,'',8) 
GO
insert into HtmlLabelInfo values(1335,'��ǰ״��',7) 
GO
insert into HtmlLabelInfo values(1336,'',8) 
GO
insert into HtmlLabelInfo values(1336,'��Ŀ�ƻ�',7) 
GO
insert into HtmlLabelInfo values(1337,'',8) 
GO
insert into HtmlLabelInfo values(1337,'��Ŀ�ƻ�֪ͨ',7) 
GO
insert into HtmlLabelInfo values(1338,'',8) 
GO
insert into HtmlLabelInfo values(1338,'ִ��',7) 
GO
insert into HtmlLabelInfo values(1339,'',8) 
GO
insert into HtmlLabelInfo values(1339,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(1340,'',8) 
GO
insert into HtmlLabelInfo values(1340,'������',7) 
GO
insert into HtmlLabelInfo values(1341,'',8) 
GO
insert into HtmlLabelInfo values(1341,'�ĵ�����',7) 
GO
insert into HtmlLabelInfo values(1342,'',8) 
GO
insert into HtmlLabelInfo values(1342,'�������',7) 
GO
insert into HtmlLabelInfo values(1343,'',8) 
GO
insert into HtmlLabelInfo values(1343,'�ύ��׼',7) 
GO
insert into HtmlLabelInfo values(1344,'',8) 
GO
insert into HtmlLabelInfo values(1344,'�ƻ���׼',7) 
GO
insert into HtmlLabelInfo values(1345,'',8) 
GO
insert into HtmlLabelInfo values(1345,'�ƻ����',7) 
GO
insert into HtmlLabelInfo values(1346,'',8) 
GO
insert into HtmlLabelInfo values(1346,'�ƻ�ɾ��',7) 
GO
insert into HtmlLabelInfo values(1347,'',8) 
GO
insert into HtmlLabelInfo values(1347,'�ƻ�����',7) 
GO
insert into HtmlLabelInfo values(1348,'',8) 
GO
insert into HtmlLabelInfo values(1348,'֪ͨ��Ա',7) 
GO
insert into HtmlLabelInfo values(1349,'',8) 
GO
insert into HtmlLabelInfo values(1349,'����ʹ��',7) 
GO
insert into HtmlLabelInfo values(1350,'',8) 
GO
insert into HtmlLabelInfo values(1350,'�豸ʹ��',7) 
GO
insert into HtmlLabelInfo values(1351,'',8) 
GO
insert into HtmlLabelInfo values(1351,'����ʹ��',7) 
GO
insert into HtmlLabelInfo values(1352,'',8) 
GO
insert into HtmlLabelInfo values(1352,'��������',7) 
GO
insert into HtmlLabelInfo values(1353,'',8) 
GO
insert into HtmlLabelInfo values(1353,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(1354,'',8) 
GO
insert into HtmlLabelInfo values(1354,'�Ƚ϶���',7) 
GO
insert into HtmlLabelInfo values(1355,'',8) 
GO
insert into HtmlLabelInfo values(1355,'��׼�ƻ�',7) 
GO
insert into HtmlLabelInfo values(1356,'',8) 
GO
insert into HtmlLabelInfo values(1356,'��ǰ�ƻ�',7) 
GO
insert into HtmlLabelInfo values(1357,'',8) 
GO
insert into HtmlLabelInfo values(1357,'��ֵ(��׼)',7) 
GO
insert into HtmlLabelInfo values(1358,'',8) 
GO
insert into HtmlLabelInfo values(1358,'��ֵ(��ǰ)',7) 
GO
insert into HtmlLabelInfo values(1359,'',8) 
GO
insert into HtmlLabelInfo values(1359,'�۾ɷ���',7) 
GO
insert into HtmlLabelInfo values(1360,'',8) 
GO
insert into HtmlLabelInfo values(1360,'�������',7) 
GO
insert into HtmlLabelInfo values(1361,'',8) 
GO
insert into HtmlLabelInfo values(1361,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(1362,'',8) 
GO
insert into HtmlLabelInfo values(1362,'������',7) 
GO
insert into HtmlLabelInfo values(1363,'',8) 
GO
insert into HtmlLabelInfo values(1363,'��������',7) 
GO
insert into HtmlLabelInfo values(1364,'',8) 
GO
insert into HtmlLabelInfo values(1364,'���쳧��',7) 
GO
insert into HtmlLabelInfo values(1365,'',8) 
GO
insert into HtmlLabelInfo values(1365,'��������',7) 
GO
insert into HtmlLabelInfo values(1366,'',8) 
GO
insert into HtmlLabelInfo values(1366,'����',7) 
GO
insert into HtmlLabelInfo values(1367,'',8) 
GO
insert into HtmlLabelInfo values(1367,'�ɹ�',7) 
GO
insert into HtmlLabelInfo values(1368,'',8) 
GO
insert into HtmlLabelInfo values(1368,'����',7) 
GO
insert into HtmlLabelInfo values(1369,'',8) 
GO
insert into HtmlLabelInfo values(1369,'����',7) 
GO
insert into HtmlLabelInfo values(1370,'',8) 
GO
insert into HtmlLabelInfo values(1370,'����',7) 
GO
insert into HtmlLabelInfo values(1371,'',8) 
GO
insert into HtmlLabelInfo values(1371,'���',7) 
GO
insert into HtmlLabelInfo values(1372,'',8) 
GO
insert into HtmlLabelInfo values(1372,'��ʼ�۸�',7) 
GO
insert into HtmlLabelInfo values(1373,'',8) 
GO
insert into HtmlLabelInfo values(1373,'�۾ɵ׼�',7) 
GO
insert into HtmlLabelInfo values(1374,'',8) 
GO
insert into HtmlLabelInfo values(1374,'�۾���Ϣ',7) 
GO
insert into HtmlLabelInfo values(1375,'',8) 
GO
insert into HtmlLabelInfo values(1375,'���',7) 
GO
insert into HtmlLabelInfo values(1376,'',8) 
GO
insert into HtmlLabelInfo values(1376,'����',7) 
GO
insert into HtmlLabelInfo values(1377,'',8) 
GO
insert into HtmlLabelInfo values(1377,'����',7) 
GO
insert into HtmlLabelInfo values(1378,'',8) 
GO
insert into HtmlLabelInfo values(1378,'����',7) 
GO
insert into HtmlLabelInfo values(1379,'',8) 
GO
insert into HtmlLabelInfo values(1379,'���',7) 
GO
insert into HtmlLabelInfo values(1380,'',8) 
GO
insert into HtmlLabelInfo values(1380,'��ת',7) 
GO
insert into HtmlLabelInfo values(1381,'',8) 
GO
insert into HtmlLabelInfo values(1381,'�ƽ�',7) 
GO
insert into HtmlLabelInfo values(1382,'',8) 
GO
insert into HtmlLabelInfo values(1382,'ά��',7) 
GO
insert into HtmlLabelInfo values(1383,'',8) 
GO
insert into HtmlLabelInfo values(1383,'����',7) 
GO
insert into HtmlLabelInfo values(1384,'',8) 
GO
insert into HtmlLabelInfo values(1384,'�黹',7) 
GO
insert into HtmlLabelInfo values(1385,'',8) 
GO
insert into HtmlLabelInfo values(1385,'��ʧ',7) 
GO
insert into HtmlLabelInfo values(1386,'',8) 
GO
insert into HtmlLabelInfo values(1386,'����',7) 
GO
insert into HtmlLabelInfo values(1387,'',8) 
GO
insert into HtmlLabelInfo values(1387,'��ŵص�',7) 
GO
insert into HtmlLabelInfo values(1388,'',8) 
GO
insert into HtmlLabelInfo values(1388,'�������ޣ��·�',7) 
GO
insert into HtmlLabelInfo values(1389,'',8) 
GO
insert into HtmlLabelInfo values(1389,'��ǰ��ֵ',7) 
GO
insert into HtmlLabelInfo values(1390,'',8) 
GO
insert into HtmlLabelInfo values(1390,'��ֵ��',7) 
GO
insert into HtmlLabelInfo values(1391,'',8) 
GO
insert into HtmlLabelInfo values(1391,'���۾���',7) 
GO
insert into HtmlLabelInfo values(1392,'',8) 
GO
insert into HtmlLabelInfo values(1392,'��������',7) 
GO
insert into HtmlLabelInfo values(1393,'',8) 
GO
insert into HtmlLabelInfo values(1393,'��ط���',7) 
GO
insert into HtmlLabelInfo values(1394,'',8) 
GO
insert into HtmlLabelInfo values(1394,'��ת����',7) 
GO
insert into HtmlLabelInfo values(1395,'',8) 
GO
insert into HtmlLabelInfo values(1395,'�ص�',7) 
GO
insert into HtmlLabelInfo values(1396,'',8) 
GO
insert into HtmlLabelInfo values(1396,'����',7) 
GO
insert into HtmlLabelInfo values(1397,'',8) 
GO
insert into HtmlLabelInfo values(1397,'�̿�',7) 
GO
insert into HtmlLabelInfo values(1398,'',8) 
GO
insert into HtmlLabelInfo values(1398,'��ӯ',7) 
GO
insert into HtmlLabelInfo values(1399,'',8) 
GO
insert into HtmlLabelInfo values(1399,'ά�޵�λ',7) 
GO
insert into HtmlLabelInfo values(1400,'',8) 
GO
insert into HtmlLabelInfo values(1400,'����',7) 
GO
insert into HtmlLabelInfo values(1401,'',8) 
GO
insert into HtmlLabelInfo values(1401,'�ƽ�����',7) 
GO
insert into HtmlLabelInfo values(1402,'',8) 
GO
insert into HtmlLabelInfo values(1402,'��һ��',7) 
GO
insert into HtmlLabelInfo values(1403,'',8) 
GO
insert into HtmlLabelInfo values(1403,'�������',7) 
GO
insert into HtmlLabelInfo values(1404,'',8) 
GO
insert into HtmlLabelInfo values(1404,'�������',7) 
GO
insert into HtmlLabelInfo values(1405,'',8) 
GO
insert into HtmlLabelInfo values(1405,'��������',7) 
GO
insert into HtmlLabelInfo values(1406,'',8) 
GO
insert into HtmlLabelInfo values(1406,'��ʧ����',7) 
GO
insert into HtmlLabelInfo values(1408,'',8) 
GO
insert into HtmlLabelInfo values(1408,'��ʧ��״̬',7) 
GO
insert into HtmlLabelInfo values(1409,'',8) 
GO
insert into HtmlLabelInfo values(1409,'ά������',7) 
GO
insert into HtmlLabelInfo values(1410,'',8) 
GO
insert into HtmlLabelInfo values(1410,'��������',7) 
GO
insert into HtmlLabelInfo values(1411,'',8) 
GO
insert into HtmlLabelInfo values(1411,'��������',7) 
GO
insert into HtmlLabelInfo values(1412,'',8) 
GO
insert into HtmlLabelInfo values(1412,'��������',7) 
GO
insert into HtmlLabelInfo values(1413,'',8) 
GO
insert into HtmlLabelInfo values(1413,'�黹����',7) 
GO
insert into HtmlLabelInfo values(1414,'',8) 
GO
insert into HtmlLabelInfo values(1414,'�黹��״̬',7) 
GO
insert into HtmlLabelInfo values(1415,'',8) 
GO
insert into HtmlLabelInfo values(1415,'�̵�����',7) 
GO
insert into HtmlLabelInfo values(1416,'',8) 
GO
insert into HtmlLabelInfo values(1416,'�̵���',7) 
GO
insert into HtmlLabelInfo values(1417,'',8) 
GO
insert into HtmlLabelInfo values(1417,'��������',7) 
GO
insert into HtmlLabelInfo values(1418,'',8) 
GO
insert into HtmlLabelInfo values(1418,'ʵ������',7) 
GO
insert into HtmlLabelInfo values(1419,'',8) 
GO
insert into HtmlLabelInfo values(1419,'ӯ������',7) 
GO
insert into HtmlLabelInfo values(1420,'',8) 
GO
insert into HtmlLabelInfo values(1420,'ӯ�����',7) 
GO
insert into HtmlLabelInfo values(1421,'',8) 
GO
insert into HtmlLabelInfo values(1421,'����',7) 
GO
insert into HtmlLabelInfo values(1422,'',8) 
GO
insert into HtmlLabelInfo values(1422,'δ����',7) 
GO
insert into HtmlLabelInfo values(1423,'',8) 
GO
insert into HtmlLabelInfo values(1423,'������',7) 
GO
insert into HtmlLabelInfo values(1424,'',8) 
GO
insert into HtmlLabelInfo values(1424,'�̵�ʱ��',7) 
GO
insert into HtmlLabelInfo values(1425,'',8) 
GO
insert into HtmlLabelInfo values(1425,'��������',7) 
GO
insert into HtmlLabelInfo values(1426,'',8) 
GO
insert into HtmlLabelInfo values(1426,'ѡ��',7) 
GO
insert into HtmlLabelInfo values(1427,'',8) 
GO
insert into HtmlLabelInfo values(1427,'ʱ��(��)',7) 
GO
insert into HtmlLabelInfo values(1428,'',8) 
GO
insert into HtmlLabelInfo values(1428,'�����',7) 
GO
insert into HtmlLabelInfo values(1429,'',8) 
GO
insert into HtmlLabelInfo values(1429,'ɾ����',7) 
GO
insert into HtmlLabelInfo values(1430,'',8) 
GO
insert into HtmlLabelInfo values(1430,'ʱ��(��)',7) 
GO
insert into HtmlLabelInfo values(1431,'',8) 
GO
insert into HtmlLabelInfo values(1431,'��ʼ����',7) 
GO
insert into HtmlLabelInfo values(1432,'',8) 
GO
insert into HtmlLabelInfo values(1432,'��������',7) 
GO
insert into HtmlLabelInfo values(1433,'',8) 
GO
insert into HtmlLabelInfo values(1433,'�۾ɺ���(t)',7) 
GO
insert into HtmlLabelInfo values(1434,'',8) 
GO
insert into HtmlLabelInfo values(1434,'ԭ����',7) 
GO
insert into HtmlLabelInfo values(1435,'',8) 
GO
insert into HtmlLabelInfo values(1435,'��ת������',7) 
GO
insert into HtmlLabelInfo values(1436,'',8) 
GO
insert into HtmlLabelInfo values(1436,'��ת����',7) 
GO
insert into HtmlLabelInfo values(1437,'',8) 
GO
insert into HtmlLabelInfo values(1437,'����',7) 
GO
insert into HtmlLabelInfo values(1438,'',8) 
GO
insert into HtmlLabelInfo values(1438,'�ʲ��ܱ�',7) 
GO
insert into HtmlLabelInfo values(1439,'',8) 
GO
insert into HtmlLabelInfo values(1439,'�ʲ����',7) 
GO
insert into HtmlLabelInfo values(1440,'',8) 
GO
insert into HtmlLabelInfo values(1440,'�ܱ���',7) 
GO
insert into HtmlLabelInfo values(1441,'',8) 
GO
insert into HtmlLabelInfo values(1441,'�۾ɱ���',7) 
GO
insert into HtmlLabelInfo values(1442,'',8) 
GO
insert into HtmlLabelInfo values(1442,'������ �� ͳ�Ʊ���',7) 
GO
insert into HtmlLabelInfo values(1443,'',8) 
GO
insert into HtmlLabelInfo values(1443,'����',7) 
GO
insert into HtmlLabelInfo values(1444,'',8) 
GO
insert into HtmlLabelInfo values(1444,'С��',7) 
GO
insert into HtmlLabelInfo values(1445,'',8) 
GO
insert into HtmlLabelInfo values(1445,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(1446,'',8) 
GO
insert into HtmlLabelInfo values(1446,'�������',7) 
GO
insert into HtmlLabelInfo values(1447,'',8) 
GO
insert into HtmlLabelInfo values(1447,'�ܽ��',7) 
GO
insert into HtmlLabelInfo values(1448,'',8) 
GO
insert into HtmlLabelInfo values(1448,'Ŀǰ״̬',7) 
GO
insert into HtmlLabelInfo values(1449,'',8) 
GO
insert into HtmlLabelInfo values(1449,'˭��ʹ��',7) 
GO
insert into HtmlLabelInfo values(1450,'',8) 
GO
insert into HtmlLabelInfo values(1450,'��ֵ',7) 
GO
insert into HtmlLabelInfo values(1451,'',8) 
GO
insert into HtmlLabelInfo values(1451,'��ǰ����',7) 
GO
insert into HtmlLabelInfo values(1452,'',8) 
GO
insert into HtmlLabelInfo values(1452,'���ʿ�Ŀ',7) 
GO
insert into HtmlLabelInfo values(1453,'',8) 
GO
insert into HtmlLabelInfo values(1453,'�����ڼ�',7) 
GO
insert into HtmlLabelInfo values(1454,'',8) 
GO
insert into HtmlLabelInfo values(1454,'�Ѵ���',7) 
GO
insert into HtmlLabelInfo values(1455,'',8) 
GO
insert into HtmlLabelInfo values(1455,'��������',7) 
GO
insert into HtmlLabelInfo values(1456,'',8) 
GO
insert into HtmlLabelInfo values(1456,'��������',7) 
GO
insert into HtmlLabelInfo values(1457,'',8) 
GO
insert into HtmlLabelInfo values(1457,'����������������',7) 
GO
insert into HtmlLabelInfo values(1458,'',8) 
GO
insert into HtmlLabelInfo values(1458,'����������������',7) 
GO
insert into HtmlLabelInfo values(1459,'',8) 
GO
insert into HtmlLabelInfo values(1459,'�ڼ� �� , ��',7) 
GO
insert into HtmlLabelInfo values(1460,'',8) 
GO
insert into HtmlLabelInfo values(1460,'��ĩ',7) 
GO
insert into HtmlLabelInfo values(1461,'',8) 
GO
insert into HtmlLabelInfo values(1461,'����',7) 
GO
insert into HtmlLabelInfo values(1462,'',8) 
GO
insert into HtmlLabelInfo values(1462,'��������',7) 
GO
insert into HtmlLabelInfo values(1463,'',8) 
GO
insert into HtmlLabelInfo values(1463,'����',7) 
GO
insert into HtmlLabelInfo values(1464,'',8) 
GO
insert into HtmlLabelInfo values(1464,'�ٷֱ�',7) 
GO
insert into HtmlLabelInfo values(1465,'',8) 
GO
insert into HtmlLabelInfo values(1465,'�跽',7) 
GO
insert into HtmlLabelInfo values(1466,'',8) 
GO
insert into HtmlLabelInfo values(1466,'����',7) 
GO
insert into HtmlLabelInfo values(1467,'',8) 
GO
insert into HtmlLabelInfo values(1467,'�Զ���ϸ',7) 
GO
insert into HtmlLabelInfo values(1468,'',8) 
GO
insert into HtmlLabelInfo values(1468,'�ͻ�:Ԥ��',7) 
GO
insert into HtmlLabelInfo values(1469,'',8) 
GO
insert into HtmlLabelInfo values(1469,'�ͻ�:Ӧ��',7) 
GO
insert into HtmlLabelInfo values(1470,'',8) 
GO
insert into HtmlLabelInfo values(1470,'��Ӧ��:Ԥ��',7) 
GO
insert into HtmlLabelInfo values(1471,'',8) 
GO
insert into HtmlLabelInfo values(1471,'��Ӧ��:Ӧ��',7) 
GO
insert into HtmlLabelInfo values(1472,'',8) 
GO
insert into HtmlLabelInfo values(1472,'����, ����:',7) 
GO
insert into HtmlLabelInfo values(1473,'',8) 
GO
insert into HtmlLabelInfo values(1473,'��ծ',7) 
GO
insert into HtmlLabelInfo values(1474,'',8) 
GO
insert into HtmlLabelInfo values(1474,'������Ȩ��',7) 
GO
insert into HtmlLabelInfo values(1475,'',8) 
GO
insert into HtmlLabelInfo values(1475,'����',7) 
GO
insert into HtmlLabelInfo values(1476,'',8) 
GO
insert into HtmlLabelInfo values(1476,'���Ҷһ�',7) 
GO
insert into HtmlLabelInfo values(1477,'',8) 
GO
insert into HtmlLabelInfo values(1477,'��ʷ',7) 
GO
insert into HtmlLabelInfo values(1478,'',8) 
GO
insert into HtmlLabelInfo values(1478,'Ŀ¼��Ϣ',7) 
GO
insert into HtmlLabelInfo values(1479,'',8) 
GO
insert into HtmlLabelInfo values(1479,'Ȩ����ϸ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(1480,'',8) 
GO
insert into HtmlLabelInfo values(1480,'�ڳ�',7) 
GO
insert into HtmlLabelInfo values(1481,'',8) 
GO
insert into HtmlLabelInfo values(1481,'ѡ��',7) 
GO
insert into HtmlLabelInfo values(1482,'',8) 
GO
insert into HtmlLabelInfo values(1482,'�ڳ���',7) 
GO
insert into HtmlLabelInfo values(1483,'',8) 
GO
insert into HtmlLabelInfo values(1483,'��ĩ��',7) 
GO
insert into HtmlLabelInfo values(1484,'',8) 
GO
insert into HtmlLabelInfo values(1484,'�ʲ��ܼ�',7) 
GO
insert into HtmlLabelInfo values(1485,'',8) 
GO
insert into HtmlLabelInfo values(1485,'��ծ��������Ȩ��',7) 
GO
insert into HtmlLabelInfo values(1486,'',8) 
GO
insert into HtmlLabelInfo values(1486,'�д�',7) 
GO
insert into HtmlLabelInfo values(1487,'',8) 
GO
insert into HtmlLabelInfo values(1487,'��ծ�ܼ�',7) 
GO
insert into HtmlLabelInfo values(1488,'',8) 
GO
insert into HtmlLabelInfo values(1488,'������Ȩ���ܼ�',7) 
GO
insert into HtmlLabelInfo values(1489,'',8) 
GO
insert into HtmlLabelInfo values(1489,'��ծ��������Ȩ���ܼ�',7) 
GO
insert into HtmlLabelInfo values(1490,'',8) 
GO
insert into HtmlLabelInfo values(1490,'���ŷ���Ԥ���',7) 
GO
insert into HtmlLabelInfo values(1491,'',8) 
GO
insert into HtmlLabelInfo values(1491,'����',7) 
GO
insert into HtmlLabelInfo values(1492,'',8) 
GO
insert into HtmlLabelInfo values(1492,'һ��',7) 
GO
insert into HtmlLabelInfo values(1493,'',8) 
GO
insert into HtmlLabelInfo values(1493,'����',7) 
GO
insert into HtmlLabelInfo values(1494,'',8) 
GO
insert into HtmlLabelInfo values(1494,'����',7) 
GO
insert into HtmlLabelInfo values(1495,'',8) 
GO
insert into HtmlLabelInfo values(1495,'����',7) 
GO
insert into HtmlLabelInfo values(1496,'',8) 
GO
insert into HtmlLabelInfo values(1496,'����',7) 
GO
insert into HtmlLabelInfo values(1497,'',8) 
GO
insert into HtmlLabelInfo values(1497,'����',7) 
GO
insert into HtmlLabelInfo values(1498,'',8) 
GO
insert into HtmlLabelInfo values(1498,'����',7) 
GO
insert into HtmlLabelInfo values(1499,'',8) 
GO
insert into HtmlLabelInfo values(1499,'����',7) 
GO
insert into HtmlLabelInfo values(1500,'Homepage',8) 
GO
insert into HtmlLabelInfo values(1500,'�ҵ���ҳ',7) 
GO
insert into HtmlLabelInfo values(1501,'',8) 
GO
insert into HtmlLabelInfo values(1501,'��ת���',7) 
GO
insert into HtmlLabelInfo values(1502,'',8) 
GO
insert into HtmlLabelInfo values(1502,'�ʸ�֤��',7) 
GO
insert into HtmlLabelInfo values(1503,'',8) 
GO
insert into HtmlLabelInfo values(1503,'��ְ����',7) 
GO
insert into HtmlLabelInfo values(1504,'',8) 
GO
insert into HtmlLabelInfo values(1504,'н�긣��',7) 
GO
insert into HtmlLabelInfo values(1505,'',8) 
GO
insert into HtmlLabelInfo values(1505,'���ݼټ�¼',7) 
GO
insert into HtmlLabelInfo values(1506,'',8) 
GO
insert into HtmlLabelInfo values(1506,'�̵�',7) 
GO
insert into HtmlLabelInfo values(1507,'',8) 
GO
insert into HtmlLabelInfo values(1507,'����Ա',7) 
GO
insert into HtmlLabelInfo values(1508,'',8) 
GO
insert into HtmlLabelInfo values(1508,'ʹ����',7) 
GO
insert into HtmlLabelInfo values(1509,'',8) 
GO
insert into HtmlLabelInfo values(1509,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(1510,'',8) 
GO
insert into HtmlLabelInfo values(1510,'�ʲ����ܱ�',7) 
GO
insert into HtmlLabelInfo values(1511,'',8) 
GO
insert into HtmlLabelInfo values(1511,'���÷�̯',7) 
GO
insert into HtmlLabelInfo values(1512,'',8) 
GO
insert into HtmlLabelInfo values(1512,'������',7) 
GO
insert into HtmlLabelInfo values(1513,'',8) 
GO
insert into HtmlLabelInfo values(1513,'�ճ��칫��Ʒһ����',7) 
GO
insert into HtmlLabelInfo values(1514,'',8) 
GO
insert into HtmlLabelInfo values(1514,'����',7) 
GO
insert into HtmlLabelInfo values(1515,'',8) 
GO
insert into HtmlLabelInfo values(1515,'ͨѶ¼',7) 
GO
insert into HtmlLabelInfo values(1516,'',8) 
GO
insert into HtmlLabelInfo values(1516,'��ְ����',7) 
GO
insert into HtmlLabelInfo values(1517,'',8) 
GO
insert into HtmlLabelInfo values(1517,'����סַ',7) 
GO
insert into HtmlLabelInfo values(1518,'',8) 
GO
insert into HtmlLabelInfo values(1518,'��ҵѧУ',7) 
GO
insert into HtmlLabelInfo values(1519,'',8) 
GO
insert into HtmlLabelInfo values(1519,'��ҵ����',7) 
GO
insert into HtmlLabelInfo values(1520,'',8) 
GO
insert into HtmlLabelInfo values(1520,'�����̴���',7) 
GO
insert into HtmlLabelInfo values(1521,'',8) 
GO
insert into HtmlLabelInfo values(1521,'���½�����',7) 
GO
insert into HtmlLabelInfo values(1522,'',8) 
GO
insert into HtmlLabelInfo values(1522,'����������',7) 
GO
insert into HtmlLabelInfo values(1523,'',8) 
GO
insert into HtmlLabelInfo values(1523,'�����ܼ�',7) 
GO
insert into HtmlLabelInfo values(1524,'',8) 
GO
insert into HtmlLabelInfo values(1524,'��ĩ���',7) 
GO
insert into HtmlLabelInfo values(1800,'',8) 
GO
insert into HtmlLabelInfo values(1800,'����',7) 
GO
insert into HtmlLabelInfo values(1801,'',8) 
GO
insert into HtmlLabelInfo values(1801,'ʮ��',7) 
GO
insert into HtmlLabelInfo values(1802,'',8) 
GO
insert into HtmlLabelInfo values(1802,'ʮһ��',7) 
GO
insert into HtmlLabelInfo values(1803,'',8) 
GO
insert into HtmlLabelInfo values(1803,'ʮ����',7) 
GO
insert into HtmlLabelInfo values(1804,'',8) 
GO
insert into HtmlLabelInfo values(1804,'����',7) 
GO
insert into HtmlLabelInfo values(1805,'',8) 
GO
insert into HtmlLabelInfo values(1805,'������',7) 
GO
insert into HtmlLabelInfo values(1806,'',8) 
GO
insert into HtmlLabelInfo values(1806,'�����ۼ���',7) 
GO
insert into HtmlLabelInfo values(1807,'',8) 
GO
insert into HtmlLabelInfo values(1807,'�����ۼ���',7) 
GO
insert into HtmlLabelInfo values(1808,'',8) 
GO
insert into HtmlLabelInfo values(1808,'���汨��',7) 
GO
insert into HtmlLabelInfo values(1809,'',8) 
GO
insert into HtmlLabelInfo values(1809,'��ϸ������',7) 
GO
insert into HtmlLabelInfo values(1810,'',8) 
GO
insert into HtmlLabelInfo values(1810,'�ڳ����',7) 
GO
insert into HtmlLabelInfo values(1811,'',8) 
GO
insert into HtmlLabelInfo values(1811,'���',7) 
GO
insert into HtmlLabelInfo values(1812,'',8) 
GO
insert into HtmlLabelInfo values(1812,'�ڼ�,��',7) 
GO
insert into HtmlLabelInfo values(1813,'',8) 
GO
insert into HtmlLabelInfo values(1813,'�ڼ�,��',7) 
GO
insert into HtmlLabelInfo values(1814,'',8) 
GO
insert into HtmlLabelInfo values(1814,'��, �ڼ�',7) 
GO
insert into HtmlLabelInfo values(1815,'',8) 
GO
insert into HtmlLabelInfo values(1815,'�ѵ���',7) 
GO
insert into HtmlLabelInfo values(1816,'',8) 
GO
insert into HtmlLabelInfo values(1816,'����',7) 
GO
insert into HtmlLabelInfo values(1817,'',8) 
GO
insert into HtmlLabelInfo values(1817,'����',7) 
GO
insert into HtmlLabelInfo values(1818,'',8) 
GO
insert into HtmlLabelInfo values(1818,'����',7) 
GO
insert into HtmlLabelInfo values(1819,'',8) 
GO
insert into HtmlLabelInfo values(1819,'��¼����',7) 
GO
insert into HtmlLabelInfo values(1820,'',8) 
GO
insert into HtmlLabelInfo values(1820,'�跽���',7) 
GO
insert into HtmlLabelInfo values(1821,'',8) 
GO
insert into HtmlLabelInfo values(1821,'�������',7) 
GO
insert into HtmlLabelInfo values(1822,'',8) 
GO
insert into HtmlLabelInfo values(1822,'��¼��',7) 
GO
insert into HtmlLabelInfo values(1823,'',8) 
GO
insert into HtmlLabelInfo values(1823,'����',7) 
GO
insert into HtmlLabelInfo values(1824,'',8) 
GO
insert into HtmlLabelInfo values(1824,'��/�ڼ�',7) 
GO
insert into HtmlLabelInfo values(1825,'',8) 
GO
insert into HtmlLabelInfo values(1825,'��:������Դ��',7) 
GO
insert into HtmlLabelInfo values(1826,'',8) 
GO
insert into HtmlLabelInfo values(1826,'���(cm)',7) 
GO
insert into HtmlLabelInfo values(1827,'',8) 
GO
insert into HtmlLabelInfo values(1827,'����״��',7) 
GO
insert into HtmlLabelInfo values(1828,'',8) 
GO
insert into HtmlLabelInfo values(1828,'�������ڵ�',7) 
GO
insert into HtmlLabelInfo values(1829,'',8) 
GO
insert into HtmlLabelInfo values(1829,'�־�ס��',7) 
GO
insert into HtmlLabelInfo values(1830,'',8) 
GO
insert into HtmlLabelInfo values(1830,'Ӧ��',7) 
GO
insert into HtmlLabelInfo values(1831,'',8) 
GO
insert into HtmlLabelInfo values(1831,'��ְ',7) 
GO
insert into HtmlLabelInfo values(1832,'',8) 
GO
insert into HtmlLabelInfo values(1832,'��ҵ',7) 
GO
insert into HtmlLabelInfo values(1833,'',8) 
GO
insert into HtmlLabelInfo values(1833,'ѧλ',7) 
GO
insert into HtmlLabelInfo values(1834,'',8) 
GO
insert into HtmlLabelInfo values(1834,'��������',7) 
GO
insert into HtmlLabelInfo values(1835,'',8) 
GO
insert into HtmlLabelInfo values(1835,'�뵳����',7) 
GO
insert into HtmlLabelInfo values(1836,'',8) 
GO
insert into HtmlLabelInfo values(1836,'��������',7) 
GO
insert into HtmlLabelInfo values(1837,'',8) 
GO
insert into HtmlLabelInfo values(1837,'������ò',7) 
GO
insert into HtmlLabelInfo values(1838,'',8) 
GO
insert into HtmlLabelInfo values(1838,'֤�����',7) 
GO
insert into HtmlLabelInfo values(1839,'',8) 
GO
insert into HtmlLabelInfo values(1839,'֤������',7) 
GO
insert into HtmlLabelInfo values(1840,'',8) 
GO
insert into HtmlLabelInfo values(1840,'����',7) 
GO
insert into HtmlLabelInfo values(1841,'',8) 
GO
insert into HtmlLabelInfo values(1841,'��ѵ������֤��',7) 
GO
insert into HtmlLabelInfo values(1842,'',8) 
GO
insert into HtmlLabelInfo values(1842,'��ְ����',7) 
GO
insert into HtmlLabelInfo values(1843,'',8) 
GO
insert into HtmlLabelInfo values(1843,'Ŀǰ��н',7) 
GO
insert into HtmlLabelInfo values(1844,'',8) 
GO
insert into HtmlLabelInfo values(1844,'��������(��)',7) 
GO
insert into HtmlLabelInfo values(1845,'',8) 
GO
insert into HtmlLabelInfo values(1845,'��н����',7) 
GO
insert into HtmlLabelInfo values(1846,'',8) 
GO
insert into HtmlLabelInfo values(1846,'��������',7) 
GO
insert into HtmlLabelInfo values(1847,'',8) 
GO
insert into HtmlLabelInfo values(1847,'����Ҫ��',7) 
GO
insert into HtmlLabelInfo values(1848,'',8) 
GO
insert into HtmlLabelInfo values(1848,'������ҳ',7) 
GO
insert into HtmlLabelInfo values(1849,'',8) 
GO
insert into HtmlLabelInfo values(1849,'�Լ���',7) 
GO
insert into HtmlLabelInfo values(1850,'',8) 
GO
insert into HtmlLabelInfo values(1850,'ѧУ',7) 
GO
insert into HtmlLabelInfo values(1851,'',8) 
GO
insert into HtmlLabelInfo values(1851,'��˾',7) 
GO
insert into HtmlLabelInfo values(1852,'',8) 
GO
insert into HtmlLabelInfo values(1852,'����',7) 
GO
insert into HtmlLabelInfo values(1853,'',8) 
GO
insert into HtmlLabelInfo values(1853,'¼��',7) 
GO
insert into HtmlLabelInfo values(1854,'',8) 
GO
insert into HtmlLabelInfo values(1854,'ӦƸ�ظ�(�ʼ�)',7) 
GO
insert into HtmlLabelInfo values(1855,'',8) 
GO
insert into HtmlLabelInfo values(1855,'ӦƸ����',7) 
GO
insert into HtmlLabelInfo values(1856,'',8) 
GO
insert into HtmlLabelInfo values(1856,'ӦƸְλ',7) 
GO
insert into HtmlLabelInfo values(1857,'',8) 
GO
insert into HtmlLabelInfo values(1857,'��������',7) 
GO
insert into HtmlLabelInfo values(1858,'',8) 
GO
insert into HtmlLabelInfo values(1858,'ְλ����',7) 
GO
insert into HtmlLabelInfo values(1859,'',8) 
GO
insert into HtmlLabelInfo values(1859,'����',7) 
GO
insert into HtmlLabelInfo values(1860,'',8) 
GO
insert into HtmlLabelInfo values(1860,'���ѧ��',7) 
GO
insert into HtmlLabelInfo values(1861,'',8) 
GO
insert into HtmlLabelInfo values(1861,'������',7) 
GO
insert into HtmlLabelInfo values(1862,'',8) 
GO
insert into HtmlLabelInfo values(1862,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(1863,'',8) 
GO
insert into HtmlLabelInfo values(1863,'ӦƸ',7) 
GO
insert into HtmlLabelInfo values(1864,'',8) 
GO
insert into HtmlLabelInfo values(1864,'��������',7) 
GO
insert into HtmlLabelInfo values(1865,'',8) 
GO
insert into HtmlLabelInfo values(1865,'ְλ����',7) 
GO
insert into HtmlLabelInfo values(1866,'',8) 
GO
insert into HtmlLabelInfo values(1866,'�ù���ʽ',7) 
GO
insert into HtmlLabelInfo values(1867,'',8) 
GO
insert into HtmlLabelInfo values(1867,'��Ա',7) 
GO
insert into HtmlLabelInfo values(1868,'',8) 
GO
insert into HtmlLabelInfo values(1868,'��ԱҪ��',7) 
GO
insert into HtmlLabelInfo values(1869,'',8) 
GO
insert into HtmlLabelInfo values(1869,'���ò�ѯ����',7) 
GO
insert into HtmlLabelInfo values(1870,'',8) 
GO
insert into HtmlLabelInfo values(1870,'���Ͷ�ѧУ',7) 
GO
insert into HtmlLabelInfo values(1871,'',8) 
GO
insert into HtmlLabelInfo values(1871,'����ҵ��˾',7) 
GO
insert into HtmlLabelInfo values(1872,'',8) 
GO
insert into HtmlLabelInfo values(1872,'�꣬�ڼ�',7) 
GO
insert into HtmlLabelInfo values(1873,'',8) 
GO
insert into HtmlLabelInfo values(1873,'ָʾ��,�ɱ�����',7) 
GO
insert into HtmlLabelInfo values(1874,'',8) 
GO
insert into HtmlLabelInfo values(1874,'����, ����',7) 
GO
insert into HtmlLabelInfo values(1875,'',8) 
GO
insert into HtmlLabelInfo values(1875,'�Ƚ�, �汾',7) 
GO
insert into HtmlLabelInfo values(1876,'',8) 
GO
insert into HtmlLabelInfo values(1876,'��һ��',7) 
GO
insert into HtmlLabelInfo values(1877,'',8) 
GO
insert into HtmlLabelInfo values(1877,'��û�м�����ϱ�׼�����ݡ�',7) 
GO
insert into HtmlLabelInfo values(1878,'',8) 
GO
insert into HtmlLabelInfo values(1878,'�ֲ�����',7) 
GO
insert into HtmlLabelInfo values(1879,'',8) 
GO
insert into HtmlLabelInfo values(1879,'�ֲ�����',7) 
GO
insert into HtmlLabelInfo values(1880,'',8) 
GO
insert into HtmlLabelInfo values(1880,'�����ܲ�',7) 
GO
insert into HtmlLabelInfo values(1881,'',8) 
GO
insert into HtmlLabelInfo values(1881,'�������',7) 
GO
insert into HtmlLabelInfo values(1882,'',8) 
GO
insert into HtmlLabelInfo values(1882,'�γ�',7) 
GO
insert into HtmlLabelInfo values(1883,'',8) 
GO
insert into HtmlLabelInfo values(1883,'������-ͳ�Ʊ���',7) 
GO
insert into HtmlLabelInfo values(1884,'',8) 
GO
insert into HtmlLabelInfo values(1884,'��������',7) 
GO
insert into HtmlLabelInfo values(1885,'',8) 
GO
insert into HtmlLabelInfo values(1885,'������',7) 
GO
insert into HtmlLabelInfo values(1886,'',8) 
GO
insert into HtmlLabelInfo values(1886,'����',7) 
GO
insert into HtmlLabelInfo values(1887,'',8) 
GO
insert into HtmlLabelInfo values(1887,'���֤����',7) 
GO
insert into HtmlLabelInfo values(1888,'',8) 
GO
insert into HtmlLabelInfo values(1888,'������',7) 
GO
insert into HtmlLabelInfo values(1889,'',8) 
GO
insert into HtmlLabelInfo values(1889,'�߼���ѯ����',7) 
GO
insert into HtmlLabelInfo values(1890,'',8) 
GO
insert into HtmlLabelInfo values(1890,'����(Сʱ)',7) 
GO
insert into HtmlLabelInfo values(1891,'',8) 
GO
insert into HtmlLabelInfo values(1891,'����-������Դ',7) 
GO
insert into HtmlLabelInfo values(1892,'',8) 
GO
insert into HtmlLabelInfo values(1892,'�˴�',7) 
GO
insert into HtmlLabelInfo values(1893,'',8) 
GO
insert into HtmlLabelInfo values(1893,'��������',7) 
GO
insert into HtmlLabelInfo values(1894,'',8) 
GO
insert into HtmlLabelInfo values(1894,'����',7) 
GO
insert into HtmlLabelInfo values(1895,'',8) 
GO
insert into HtmlLabelInfo values(1895,'����',7) 
GO
insert into HtmlLabelInfo values(1896,'',8) 
GO
insert into HtmlLabelInfo values(1896,'����',7) 
GO
insert into HtmlLabelInfo values(1897,'',8) 
GO
insert into HtmlLabelInfo values(1897,'����ԭ��',7) 
GO
insert into HtmlLabelInfo values(1898,'',8) 
GO
insert into HtmlLabelInfo values(1898,'��Ҫѧ��',7) 
GO
insert into HtmlLabelInfo values(1899,'',8) 
GO
insert into HtmlLabelInfo values(1899,'�ʱ�',7) 
GO
insert into HtmlLabelInfo values(1900,'',8) 
GO
insert into HtmlLabelInfo values(1900,'����סַ',7) 
GO
insert into HtmlLabelInfo values(1901,'',8) 
GO
insert into HtmlLabelInfo values(1901,'�������',7) 
GO
insert into HtmlLabelInfo values(1902,'',8) 
GO
insert into HtmlLabelInfo values(1902,'��Ҫѧ��',7) 
GO
insert into HtmlLabelInfo values(1903,'',8) 
GO
insert into HtmlLabelInfo values(1903,'ѧУ����',7) 
GO
insert into HtmlLabelInfo values(1904,'',8) 
GO
insert into HtmlLabelInfo values(1904,'��ѧרҵ',7) 
GO
insert into HtmlLabelInfo values(1905,'',8) 
GO
insert into HtmlLabelInfo values(1905,'�䷢����',7) 
GO
insert into HtmlLabelInfo values(1906,'',8) 
GO
insert into HtmlLabelInfo values(1906,'��ְǰ��������',7) 
GO
insert into HtmlLabelInfo values(1907,'',8) 
GO
insert into HtmlLabelInfo values(1907,'��ְ��������',7) 
GO
insert into HtmlLabelInfo values(1908,'',8) 
GO
insert into HtmlLabelInfo values(1908,'��ְʱ��',7) 
GO
insert into HtmlLabelInfo values(1909,'',8) 
GO
insert into HtmlLabelInfo values(1909,'ְ��',7) 
GO
insert into HtmlLabelInfo values(1910,'',8) 
GO
insert into HtmlLabelInfo values(1910,'�ɾͺ�����',7) 
GO
insert into HtmlLabelInfo values(1911,'',8) 
GO
insert into HtmlLabelInfo values(1911,'���ܵ����ֽ���������',7) 
GO
insert into HtmlLabelInfo values(1912,'',8) 
GO
insert into HtmlLabelInfo values(1912,'��Ҫ��ͥ��Ա',7) 
GO
insert into HtmlLabelInfo values(1913,'',8) 
GO
insert into HtmlLabelInfo values(1913,'�뱾�˹�ϵ',7) 
GO
insert into HtmlLabelInfo values(1914,'',8) 
GO
insert into HtmlLabelInfo values(1914,'������λ',7) 
GO
insert into HtmlLabelInfo values(1915,'',8) 
GO
insert into HtmlLabelInfo values(1915,'ְ��',7) 
GO
insert into HtmlLabelInfo values(1916,'',8) 
GO
insert into HtmlLabelInfo values(1916,'��ϵ�绰',7) 
GO
insert into HtmlLabelInfo values(1917,'',8) 
GO
insert into HtmlLabelInfo values(1917,'��˾�ڲ����ͼ�¼',7) 
GO
insert into HtmlLabelInfo values(1918,'',8) 
GO
insert into HtmlLabelInfo values(1918,'н�긣������',7) 
GO
insert into HtmlLabelInfo values(1919,'',8) 
GO
insert into HtmlLabelInfo values(1919,'����',7) 
GO
insert into HtmlLabelInfo values(1920,'',8) 
GO
insert into HtmlLabelInfo values(1920,'�¼�',7) 
GO
insert into HtmlLabelInfo values(1921,'',8) 
GO
insert into HtmlLabelInfo values(1921,'����',7) 
GO
insert into HtmlLabelInfo values(1922,'',8) 
GO
insert into HtmlLabelInfo values(1922,'��ɥ��',7) 
GO
insert into HtmlLabelInfo values(1923,'',8) 
GO
insert into HtmlLabelInfo values(1923,'�ݼ�',7) 
GO
insert into HtmlLabelInfo values(1924,'',8) 
GO
insert into HtmlLabelInfo values(1924,'ȱ��',7) 
GO
insert into HtmlLabelInfo values(1925,'',8) 
GO
insert into HtmlLabelInfo values(1925,'��',7) 
GO
insert into HtmlLabelInfo values(1926,'',8) 
GO
insert into HtmlLabelInfo values(1926,'��',7) 
GO
insert into HtmlLabelInfo values(1927,'',8) 
GO
insert into HtmlLabelInfo values(1927,'ͼʾ',7) 
GO
insert into HtmlLabelInfo values(1928,'',8) 
GO
insert into HtmlLabelInfo values(1928,'��Ч������',7) 
GO
insert into HtmlLabelInfo values(1929,'',8) 
GO
insert into HtmlLabelInfo values(1929,'��ǰ״̬',7) 
GO
insert into HtmlLabelInfo values(1930,'',8) 
GO
insert into HtmlLabelInfo values(1930,'�־�ס�ص绰',7) 
GO
insert into HtmlLabelInfo values(1931,'',8) 
GO
insert into HtmlLabelInfo values(1931,'�־�ס���ʱ�',7) 
GO
insert into HtmlLabelInfo values(1932,'',8) 
GO
insert into HtmlLabelInfo values(1932,'ӦƸ��',7) 
GO
insert into HtmlLabelInfo values(1933,'',8) 
GO
insert into HtmlLabelInfo values(1933,'����',7) 
GO
insert into HtmlLabelInfo values(1934,'',8) 
GO
insert into HtmlLabelInfo values(1934,'����',7) 
GO
insert into HtmlLabelInfo values(1935,'',8) 
GO
insert into HtmlLabelInfo values(1935,'������ʼ����',7) 
GO
insert into HtmlLabelInfo values(1936,'',8) 
GO
insert into HtmlLabelInfo values(1936,'��ͬ��ʼʱ��',7) 
GO
insert into HtmlLabelInfo values(1937,'',8) 
GO
insert into HtmlLabelInfo values(1937,'��ְ��',7) 
GO
insert into HtmlLabelInfo values(1938,'',8) 
GO
insert into HtmlLabelInfo values(1938,'����Ȩ��',7) 
GO
insert into HtmlLabelInfo values(1939,'',8) 
GO
insert into HtmlLabelInfo values(1939,'�������ʺ�',7) 
GO
insert into HtmlLabelInfo values(1940,'',8) 
GO
insert into HtmlLabelInfo values(1940,'������ʼʱ��',7) 
GO
insert into HtmlLabelInfo values(1941,'',8) 
GO
insert into HtmlLabelInfo values(1941,'֧������',7) 
GO
insert into HtmlLabelInfo values(1942,'',8) 
GO
insert into HtmlLabelInfo values(1942,'��ϸ����',7) 
GO
insert into HtmlLabelInfo values(1943,'',8) 
GO
insert into HtmlLabelInfo values(1943,'��ͥ��Ա',7) 
GO
insert into HtmlLabelInfo values(1944,'',8) 
GO
insert into HtmlLabelInfo values(1944,'��ν',7) 
GO
insert into HtmlLabelInfo values(1945,'',8) 
GO
insert into HtmlLabelInfo values(1945,'������',7) 
GO
insert into HtmlLabelInfo values(1946,'',8) 
GO
insert into HtmlLabelInfo values(1946,'������',7) 
GO
insert into HtmlLabelInfo values(1947,'',8) 
GO
insert into HtmlLabelInfo values(1947,'��˽����',7) 
GO
insert into HtmlLabelInfo values(1948,'',8) 
GO
insert into HtmlLabelInfo values(1948,'��˽����',7) 
GO
insert into HtmlLabelInfo values(1949,'',8) 
GO
insert into HtmlLabelInfo values(1949,'���ñ���',7) 
GO
insert into HtmlLabelInfo values(1950,'',8) 
GO
insert into HtmlLabelInfo values(1950,'��ͨ��������',7) 
GO
insert into HtmlLabelInfo values(1951,'',8) 
GO
insert into HtmlLabelInfo values(1951,'�����������',7) 
GO
insert into HtmlLabelInfo values(1952,'',8) 
GO
insert into HtmlLabelInfo values(1952,'˽�˻���',7) 
GO
insert into HtmlLabelInfo values(1953,'',8) 
GO
insert into HtmlLabelInfo values(1953,'˽�˽��',7) 
GO
insert into HtmlLabelInfo values(1954,'',8) 
GO
insert into HtmlLabelInfo values(1954,'����',7) 
GO
insert into HtmlLabelInfo values(1955,'',8) 
GO
insert into HtmlLabelInfo values(1955,'��Ŀ���',7) 
GO
insert into HtmlLabelInfo values(1956,'',8) 
GO
insert into HtmlLabelInfo values(1956,'ȱ�����',7) 
GO
insert into HtmlLabelInfo values(1957,'',8) 
GO
insert into HtmlLabelInfo values(1957,'�Ӱ����',7) 
GO
insert into HtmlLabelInfo values(1958,'',8) 
GO
insert into HtmlLabelInfo values(1958,'��ͨ�Ӱ�',7) 
GO
insert into HtmlLabelInfo values(1959,'',8) 
GO
insert into HtmlLabelInfo values(1959,'�ڼ��ռӰ�',7) 
GO
insert into HtmlLabelInfo values(1960,'',8) 
GO
insert into HtmlLabelInfo values(1960,'������',7) 
GO
insert into HtmlLabelInfo values(1961,'',8) 
GO
insert into HtmlLabelInfo values(1961,'�����',7) 
GO
insert into HtmlLabelInfo values(1962,'',8) 
GO
insert into HtmlLabelInfo values(1962,'��������',7) 
GO
insert into HtmlLabelInfo values(1963,'',8) 
GO
insert into HtmlLabelInfo values(1963,'¼��Ա',7) 
GO
insert into HtmlLabelInfo values(1964,'����',7) 
GO
insert into HtmlLabelInfo values(1964,'����',8) 
GO
insert into HtmlLabelInfo values(1965,'',8) 
GO
insert into HtmlLabelInfo values(1965,'�������',7) 
GO
insert into HtmlLabelInfo values(1966,'����,�뵳����',7) 
GO
insert into HtmlLabelInfo values(1966,'����,�뵳����',8) 
GO
insert into HtmlLabelInfo values(1967,'Home address',8) 
GO
insert into HtmlLabelInfo values(1967,'��ͥ��ַ',7) 
GO
insert into HtmlLabelInfo values(1968,'��ͥ�ʱ�',7) 
GO
insert into HtmlLabelInfo values(1968,'��ͥ�ʱ�',8) 
GO
insert into HtmlLabelInfo values(1969,'��ͥ�绰',7) 
GO
insert into HtmlLabelInfo values(1969,'��ͥ�绰',8) 
GO
insert into HtmlLabelInfo values(1970,'Contract start time',8) 
GO
insert into HtmlLabelInfo values(1970,'��ͬ��ʼ����',7) 
GO
insert into HtmlLabelInfo values(1971,'��ѵ��ʼʱ��',7) 
GO
insert into HtmlLabelInfo values(1971,'��ѵ��ʼʱ��',8) 
GO
insert into HtmlLabelInfo values(1972,'Training finish time',8) 
GO
insert into HtmlLabelInfo values(1972,'��ѵ����ʱ��',7) 
GO
insert into HtmlLabelInfo values(1973,'ѧʱ(Сʱ)',7) 
GO
insert into HtmlLabelInfo values(1973,'ѧʱ(Сʱ)',8) 
GO
insert into HtmlLabelInfo values(1974,'��ѵ��λ',7) 
GO
insert into HtmlLabelInfo values(1974,'��ѵ��λ',8) 
GO
insert into HtmlLabelInfo values(1975,'Company character',8) 
GO
insert into HtmlLabelInfo values(1975,'��˾����',7) 
GO
insert into HtmlLabelInfo values(1976,'��˾����',7) 
GO
insert into HtmlLabelInfo values(1976,'��˾����',8) 
GO
insert into HtmlLabelInfo values(1977,'Describe for work',8) 
GO
insert into HtmlLabelInfo values(1977,'��������',7) 
GO
insert into HtmlLabelInfo values(1978,'��ְԭ��',7) 
GO
insert into HtmlLabelInfo values(1978,'��ְԭ��',8) 
GO
insert into HtmlLabelInfo values(1979,'Not start',8) 
GO
insert into HtmlLabelInfo values(1979,'δ��ʼ',7) 
GO
insert into HtmlLabelInfo values(1980,'�ȴ�����',7) 
GO
insert into HtmlLabelInfo values(1980,'�ȴ�����',8) 
GO
insert into HtmlLabelInfo values(1981,'�ѳ���',7) 
GO
insert into HtmlLabelInfo values(1981,'�ѳ���',8) 
GO
insert into HtmlLabelInfo values(1982,'����',7) 
GO
insert into HtmlLabelInfo values(1982,'����',8) 
GO
insert into HtmlLabelInfo values(1983,'�ĵ������ƶ�',7) 
GO
insert into HtmlLabelInfo values(1983,'�ĵ������ƶ�',8) 
GO
insert into HtmlLabelInfo values(1984,'����',7) 
GO
insert into HtmlLabelInfo values(1984,'����',8) 
GO
insert into HtmlLabelInfo values(1985,'�ĵ�����',7) 
GO
insert into HtmlLabelInfo values(1985,'�ĵ�����',8) 
GO
insert into HtmlLabelInfo values(1986,'�½��ĵ�',7) 
GO
insert into HtmlLabelInfo values(1986,'�½��ĵ�',8) 
GO
insert into HtmlLabelInfo values(1987,'',8) 
GO
insert into HtmlLabelInfo values(1987,'��ɫ',7) 
GO
insert into HtmlLabelInfo values(1988,'��������',7) 
GO
insert into HtmlLabelInfo values(1988,'��������',8) 
GO
insert into HtmlLabelInfo values(1989,'��������',7) 
GO
insert into HtmlLabelInfo values(1989,'��������',8) 
GO
insert into HtmlLabelInfo values(1990,'������',7) 
GO
insert into HtmlLabelInfo values(1990,'������',8) 
GO
insert into HtmlLabelInfo values(1991,'��Ԫ������',7) 
GO
insert into HtmlLabelInfo values(1991,'��Ԫ������',8) 
GO
insert into HtmlLabelInfo values(1992,'�ڲ��趨',7) 
GO
insert into HtmlLabelInfo values(1992,'�ڲ��趨',8) 
GO
insert into HtmlLabelInfo values(1993,'��������',7) 
GO
insert into HtmlLabelInfo values(1993,'��������',8) 
GO
insert into HtmlLabelInfo values(1994,'Inside',8) 
GO
insert into HtmlLabelInfo values(1994,'�ڲ�',7) 
GO
insert into HtmlLabelInfo values(1995,'�ⲿ',7) 
GO
insert into HtmlLabelInfo values(1995,'�ⲿ',8) 
GO
insert into HtmlLabelInfo values(1996,'��ʾ����',7) 
GO
insert into HtmlLabelInfo values(1996,'��ʾ����',8) 
GO
insert into HtmlLabelInfo values(1997,'Chinese',8) 
GO
insert into HtmlLabelInfo values(1997,'����',7) 
GO
insert into HtmlLabelInfo values(1998,'',8) 
GO
insert into HtmlLabelInfo values(1998,'Ӣ��',7) 
GO
insert into HtmlLabelInfo values(1999,'',8) 
GO
insert into HtmlLabelInfo values(1999,'����ҳ�ĸ�����ʾ����.����',7) 
GO
insert into HtmlLabelInfo values(2000,'�ĵ�ժҪ',7) 
GO
insert into HtmlLabelInfo values(2000,'�ĵ�ժҪ',8) 
GO
insert into HtmlLabelInfo values(2001,'�ظ��ĵ���',7) 
GO
insert into HtmlLabelInfo values(2001,'�ظ��ĵ���',8) 
GO
insert into HtmlLabelInfo values(2002,'������',7) 
GO
insert into HtmlLabelInfo values(2002,'������',8) 
GO
insert into HtmlLabelInfo values(2003,'�ĵ�����Ϊ',7) 
GO
insert into HtmlLabelInfo values(2004,'���зǻظ�',7) 
GO
insert into HtmlLabelInfo values(2004,'���зǻظ�',8) 
GO
insert into HtmlLabelInfo values(2005,'�ؽ���',7) 
GO
insert into HtmlLabelInfo values(2005,'�ؽ���',8) 
GO
insert into HtmlLabelInfo values(2006,'��ʾ�ظ�����',7) 
GO
insert into HtmlLabelInfo values(2006,'��ʾ�ظ�����',8) 
GO
insert into HtmlLabelInfo values(2007,'��ʾ��������',7) 
GO
insert into HtmlLabelInfo values(2007,'��ʾ��������',8) 
GO
insert into HtmlLabelInfo values(2008,'Ĭ���ĵ���ʾģ��',7) 
GO
insert into HtmlLabelInfo values(2008,'Ĭ���ĵ���ʾģ��',8) 
GO
insert into HtmlLabelInfo values(2009,'Documents of news page',8) 
GO
insert into HtmlLabelInfo values(2009,'����ҳ�ĵ�',7) 
GO
insert into HtmlLabelInfo values(2010,'����ҳ����',7) 
GO
insert into HtmlLabelInfo values(2010,'����ҳ����',8) 
GO
insert into HtmlLabelInfo values(2011,'û��Ȩ��',7) 
GO
insert into HtmlLabelInfo values(2011,'û��Ȩ��',8) 
GO
insert into HtmlLabelInfo values(2012,'�Բ�������ʱû��Ȩ�ޣ�',7) 
GO
insert into HtmlLabelInfo values(2012,'�Բ�������ʱû��Ȩ�ޣ�',8) 
GO
insert into HtmlLabelInfo values(2013,'�뷵�ػ��߽��벻ͬ��ҳ��',7) 
GO
insert into HtmlLabelInfo values(2013,'�뷵�ػ��߽��벻ͬ��ҳ��',8) 
GO
insert into HtmlLabelInfo values(2014,'�ܼ�: ��Ŀ',7) 
GO
insert into HtmlLabelInfo values(2014,'�ܼ�: ��Ŀ',8) 
GO
insert into HtmlLabelInfo values(2015,'�ܼ�: �ʲ�',7) 
GO
insert into HtmlLabelInfo values(2015,'�ܼ�: �ʲ�',8) 
GO
insert into HtmlLabelInfo values(2016,'Resource:real',7) 
GO
insert into HtmlLabelInfo values(2016,'Resource:real',8) 
GO
insert into HtmlLabelInfo values(2017,'Chart:cost center',8) 
GO
insert into HtmlLabelInfo values(2017,'��֯ͼ��:�ɱ�����',7) 
GO
insert into HtmlLabelInfo values(2018,'�ܼ�: �ͻ�',7) 
GO
insert into HtmlLabelInfo values(2018,'�ܼ�: �ͻ�',8) 
GO
insert into HtmlLabelInfo values(2019,'Sum',8) 
GO
insert into HtmlLabelInfo values(2019,'�ܼ�',7) 
GO
insert into HtmlLabelInfo values(2020,'ʣ���ܼ�',7) 
GO
insert into HtmlLabelInfo values(2020,'ʣ���ܼ�',8) 
GO
insert into HtmlLabelInfo values(2021,'�ܼ�: �ĵ�',7) 
GO
insert into HtmlLabelInfo values(2021,'�ܼ�: �ĵ�',8) 
GO
insert into HtmlLabelInfo values(2022,'Reset',8) 
GO
insert into HtmlLabelInfo values(2022,'����',7) 
GO
insert into HtmlLabelInfo values(2023,'��¼��Ϣ',7) 
GO
insert into HtmlLabelInfo values(2023,'��¼��Ϣ',8) 
GO
insert into HtmlLabelInfo values(2024,'�ʺ�',7) 
GO
insert into HtmlLabelInfo values(2024,'�ʺ�',8) 
GO
insert into HtmlLabelInfo values(2025,'Save password',8) 
GO
insert into HtmlLabelInfo values(2025,'��������',7) 
GO
insert into HtmlLabelInfo values(2026,'Group',8) 
GO
insert into HtmlLabelInfo values(2026,'��',7) 
GO
insert into HtmlLabelInfo values(2027,'>�ʼ��û����Ѵ��ڣ���������������',7) 
GO
insert into HtmlLabelInfo values(2027,'>�ʼ��û����Ѵ��ڣ���������������',8) 
GO
insert into HtmlLabelInfo values(2028,'User exist,please enter the user name again',8) 
GO
insert into HtmlLabelInfo values(2028,'�û��Ѵ����ʼ��û��飬����ѡ���û���',7) 
GO
insert into HtmlLabelInfo values(2029,'�½��ʼ�',7) 
GO
insert into HtmlLabelInfo values(2029,'�½��ʼ�',8) 
GO
insert into HtmlLabelInfo values(2030,'ɾ���ʼ�',7) 
GO
insert into HtmlLabelInfo values(2030,'ɾ���ʼ�',8) 
GO
insert into HtmlLabelInfo values(2031,'Permanently delete',8) 
GO
insert into HtmlLabelInfo values(2031,'����ɾ��',7) 
GO
insert into HtmlLabelInfo values(2032,'�ʼ��˵�',7) 
GO
insert into HtmlLabelInfo values(2032,'�ʼ��˵�',8) 
GO
insert into HtmlLabelInfo values(2033,'Folder',8) 
GO
insert into HtmlLabelInfo values(2033,'�ʼ���',7) 
GO
insert into HtmlLabelInfo values(2034,'From',8) 
GO
insert into HtmlLabelInfo values(2034,'������',7) 
GO
insert into HtmlLabelInfo values(2035,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(2035,'����ʱ��',8) 
GO
insert into HtmlLabelInfo values(2036,'��С',7) 
GO
insert into HtmlLabelInfo values(2036,'��С',8) 
GO
insert into HtmlLabelInfo values(2037,'�����ʼ�',7) 
GO
insert into HtmlLabelInfo values(2037,'�����ʼ�',8) 
GO
insert into HtmlLabelInfo values(2038,'������',7) 
GO
insert into HtmlLabelInfo values(2038,'������',8) 
GO
insert into HtmlLabelInfo values(2039,'�ݸ���',7) 
GO
insert into HtmlLabelInfo values(2039,'�ݸ���',8) 
GO
insert into HtmlLabelInfo values(2040,'������',7) 
GO
insert into HtmlLabelInfo values(2040,'������',8) 
GO
insert into HtmlLabelInfo values(2041,'',8) 
GO
insert into HtmlLabelInfo values(2041,'����ɾ��',7) 
GO
insert into HtmlLabelInfo values(2042,'�����ʼ���',7) 
GO
insert into HtmlLabelInfo values(2042,'�����ʼ���',8) 
GO
insert into HtmlLabelInfo values(2043,'Mail box',8) 
GO
insert into HtmlLabelInfo values(2043,'�ʼ���',7) 
GO
insert into HtmlLabelInfo values(2044,'�ʼ����ͳɹ�',7) 
GO
insert into HtmlLabelInfo values(2044,'�ʼ����ͳɹ�',8) 
GO
insert into HtmlLabelInfo values(2045,'�ʼ�����ʧ��',7) 
GO
insert into HtmlLabelInfo values(2045,'�ʼ�����ʧ��',8) 
GO
insert into HtmlLabelInfo values(2046,'�ռ���',7) 
GO
insert into HtmlLabelInfo values(2046,'�ռ���',8) 
GO
insert into HtmlLabelInfo values(2047,'��������',7) 
GO
insert into HtmlLabelInfo values(2047,'��������',8) 
GO
insert into HtmlLabelInfo values(2048,'Move to outbox',8) 
GO
insert into HtmlLabelInfo values(2048,'����������',7) 
GO
insert into HtmlLabelInfo values(2049,'�����ݸ���',7) 
GO
insert into HtmlLabelInfo values(2049,'�����ݸ���',8) 
GO
insert into HtmlLabelInfo values(2050,'��������',7) 
GO
insert into HtmlLabelInfo values(2050,'��������',8) 
GO
insert into HtmlLabelInfo values(15881,'',8) 
GO
insert into HtmlLabelInfo values(15882,'���¹���',7) 
GO
insert into HtmlLabelInfo values(15882,'',8) 
GO
insert into HtmlLabelInfo values(15883,'������Ա',7) 
GO
insert into HtmlLabelInfo values(15883,'',8) 
GO
insert into HtmlLabelInfo values(15884,'��Ƹ',7) 
GO
insert into HtmlLabelInfo values(15884,'',8) 
GO
insert into HtmlLabelInfo values(15885,'ӦƸ��Ա',7) 
GO
insert into HtmlLabelInfo values(15885,'',8) 
GO
insert into HtmlLabelInfo values(15886,'��¡����ս��Ͷ�����޹�˾',7) 
GO
insert into HtmlLabelInfo values(15886,'',8) 
GO
insert into HtmlLabelInfo values(15887,'������ͳ��ͼ',7) 
GO
insert into HtmlLabelInfo values(15887,'',8) 
GO
insert into HtmlLabelInfo values(15888,'��Ա��ȫ����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15888,'',8) 
GO
insert into HtmlLabelInfo values(15889,'��Ա�Ա�ͳ��',7) 
GO
insert into HtmlLabelInfo values(15889,'',8) 
GO
insert into HtmlLabelInfo values(15890,'Ա��״̬',7) 
GO
insert into HtmlLabelInfo values(15890,'',8) 
GO
insert into HtmlLabelInfo values(15891,'��Ա״̬ͳ��',7) 
GO
insert into HtmlLabelInfo values(15891,'',8) 
GO
insert into HtmlLabelInfo values(15892,'�滮����',7) 
GO
insert into HtmlLabelInfo values(15892,'',8) 
GO
insert into HtmlLabelInfo values(15893,'�滮������',7) 
GO
insert into HtmlLabelInfo values(15893,'',8) 
GO
insert into HtmlLabelInfo values(15894,'�滮����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15894,'',8) 
GO
insert into HtmlLabelInfo values(15895,'�滮��ʼʱ��',7) 
GO
insert into HtmlLabelInfo values(15895,'',8) 
GO
insert into HtmlLabelInfo values(15896,'�滮����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15896,'',8) 
GO
insert into HtmlLabelInfo values(15897,'�滮����',7) 
GO
insert into HtmlLabelInfo values(15897,'',8) 
GO
insert into HtmlLabelInfo values(15898,'�滮Ŀ��',7) 
GO
insert into HtmlLabelInfo values(15898,'',8) 
GO
insert into HtmlLabelInfo values(15899,'�μ���',7) 
GO
insert into HtmlLabelInfo values(15899,'',8) 
GO
insert into HtmlLabelInfo values(15900,'��ѵ�滮����',7) 
GO
insert into HtmlLabelInfo values(15900,'',8) 
GO
insert into HtmlLabelInfo values(15901,'��ػ�������',7) 
GO
insert into HtmlLabelInfo values(15901,'',8) 
GO
insert into HtmlLabelInfo values(15902,'��ػ�������',7) 
GO
insert into HtmlLabelInfo values(15902,'',8) 
GO
insert into HtmlLabelInfo values(15903,'�����ѵ��',7) 
GO
insert into HtmlLabelInfo values(15903,'',8) 
GO
insert into HtmlLabelInfo values(15904,'���������',7) 
GO
insert into HtmlLabelInfo values(15904,'',8) 
GO
insert into HtmlLabelInfo values(15905,'���������',7) 
GO
insert into HtmlLabelInfo values(15905,'',8) 
GO
insert into HtmlLabelInfo values(15906,'������',7) 
GO
insert into HtmlLabelInfo values(15906,'',8) 
GO
insert into HtmlLabelInfo values(15907,'����',7) 
GO
insert into HtmlLabelInfo values(15907,'',8) 
GO
insert into HtmlLabelInfo values(15908,'һ����',7) 
GO
insert into HtmlLabelInfo values(15908,'',8) 
GO
insert into HtmlLabelInfo values(15909,'����',7) 
GO
insert into HtmlLabelInfo values(15909,'',8) 
GO
insert into HtmlLabelInfo values(15910,'�ܺ���',7) 
GO
insert into HtmlLabelInfo values(15910,'',8) 
GO
insert into HtmlLabelInfo values(15911,'��������',7) 
GO
insert into HtmlLabelInfo values(15911,'',8) 
GO
insert into HtmlLabelInfo values(15912,'������',7) 
GO
insert into HtmlLabelInfo values(15912,'',8) 
GO
insert into HtmlLabelInfo values(15913,'������',7) 
GO
insert into HtmlLabelInfo values(15913,'',8) 
GO
insert into HtmlLabelInfo values(15914,'������',7) 
GO
insert into HtmlLabelInfo values(15914,'',8) 
GO
insert into HtmlLabelInfo values(15915,'��ѵ��֯��',7) 
GO
insert into HtmlLabelInfo values(15915,'',8) 
GO
insert into HtmlLabelInfo values(15916,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(15916,'',8) 
GO
insert into HtmlLabelInfo values(15917,'��ѵĿ��',7) 
GO
insert into HtmlLabelInfo values(15917,'',8) 
GO
insert into HtmlLabelInfo values(15918,'��ѵ�ص�',7) 
GO
insert into HtmlLabelInfo values(15918,'',8) 
GO
insert into HtmlLabelInfo values(15919,'�����',7) 
GO
insert into HtmlLabelInfo values(15919,'',8) 
GO
insert into HtmlLabelInfo values(15920,'�������',7) 
GO
insert into HtmlLabelInfo values(15920,'',8) 
GO
insert into HtmlLabelInfo values(15921,'��ѵ�滮������',7) 
GO
insert into HtmlLabelInfo values(15921,'',8) 
GO
insert into HtmlLabelInfo values(15922,'��ѵ�������',7) 
GO
insert into HtmlLabelInfo values(15922,'',8) 
GO
insert into HtmlLabelInfo values(15923,'��ѵ��Դ����',7) 
GO
insert into HtmlLabelInfo values(15923,'',8) 
GO
insert into HtmlLabelInfo values(15924,'��Դ����',7) 
GO
insert into HtmlLabelInfo values(15924,'',8) 
GO
insert into HtmlLabelInfo values(15925,'��ѵ��Դ�������',7) 
GO
insert into HtmlLabelInfo values(15925,'',8) 
GO
insert into HtmlLabelInfo values(15926,'��Ա�ù�����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15926,'',8) 
GO
insert into HtmlLabelInfo values(15927,'��������',7) 
GO
insert into HtmlLabelInfo values(15927,'',8) 
GO
insert into HtmlLabelInfo values(15928,'��Ա����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15928,'',8) 
GO
insert into HtmlLabelInfo values(15929,'������Դ����',7) 
GO
insert into HtmlLabelInfo values(15929,'',8) 
GO
insert into HtmlLabelInfo values(15930,'����',7) 
GO
insert into HtmlLabelInfo values(15930,'',8) 
GO
insert into HtmlLabelInfo values(15931,'ӦƸ����',7) 
GO
insert into HtmlLabelInfo values(15931,'',8) 
GO
insert into HtmlLabelInfo values(15932,'���',7) 
GO
insert into HtmlLabelInfo values(15932,'',8) 
GO
insert into HtmlLabelInfo values(15933,'���',7) 
GO
insert into HtmlLabelInfo values(15933,'',8) 
GO
insert into HtmlLabelInfo values(15934,'��λ����',7) 
GO
insert into HtmlLabelInfo values(15934,'',8) 
GO
insert into HtmlLabelInfo values(15935,'��ʾ����',7) 
GO
insert into HtmlLabelInfo values(15935,'',8) 
GO
insert into HtmlLabelInfo values(15936,'ӦƸ��Ա����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15936,'',8) 
GO
insert into HtmlLabelInfo values(15937,'ӦƸ���',7) 
GO
insert into HtmlLabelInfo values(15937,'',8) 
GO
insert into HtmlLabelInfo values(15938,'����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15938,'',8) 
GO
insert into HtmlLabelInfo values(15939,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(15939,'',8) 
GO
insert into HtmlLabelInfo values(15940,'���ͬ����',7) 
GO
insert into HtmlLabelInfo values(15940,'',8) 
GO
insert into HtmlLabelInfo values(15941,'���ź�ͬͳ��',7) 
GO
insert into HtmlLabelInfo values(15941,'',8) 
GO
insert into HtmlLabelInfo values(15942,'��ͬ���ͳ��',7) 
GO
insert into HtmlLabelInfo values(15942,'',8) 
GO
insert into HtmlLabelInfo values(15943,'��ͬʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15943,'',8) 
GO
insert into HtmlLabelInfo values(15944,'��ͬ����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15944,'',8) 
GO
insert into HtmlLabelInfo values(15945,'���˴�',7) 
GO
insert into HtmlLabelInfo values(15945,'',8) 
GO
insert into HtmlLabelInfo values(15946,'��ͬ��',7) 
GO
insert into HtmlLabelInfo values(15946,'',8) 
GO
insert into HtmlLabelInfo values(15947,'��ͬ����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15947,'',8) 
GO
insert into HtmlLabelInfo values(15948,'��ͬͳ��',7) 
GO
insert into HtmlLabelInfo values(15948,'',8) 
GO
insert into HtmlLabelInfo values(15949,'��ͬ������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(15949,'',8) 
GO
insert into HtmlLabelInfo values(15950,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(15950,'',8) 
GO
insert into HtmlLabelInfo values(15951,'��ͬ��λ',7) 
GO
insert into HtmlLabelInfo values(15951,'',8) 
GO
insert into HtmlLabelInfo values(15952,'��ͬʱ��',7) 
GO
insert into HtmlLabelInfo values(15952,'',8) 
GO
insert into HtmlLabelInfo values(15953,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(15953,'',8) 
GO
insert into HtmlLabelInfo values(15954,'��ǩʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15954,'',8) 
GO
insert into HtmlLabelInfo values(15955,'��ְ����',7) 
GO
insert into HtmlLabelInfo values(15955,'',8) 
GO
insert into HtmlLabelInfo values(15956,'����ְ����',7) 
GO
insert into HtmlLabelInfo values(15956,'',8) 
GO
insert into HtmlLabelInfo values(15957,'������ְͳ��',7) 
GO
insert into HtmlLabelInfo values(15957,'',8) 
GO
insert into HtmlLabelInfo values(15958,'��ְʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15958,'',8) 
GO
insert into HtmlLabelInfo values(15959,'��ְ����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15959,'',8) 
GO
insert into HtmlLabelInfo values(15960,'��ְ������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(15960,'',8) 
GO
insert into HtmlLabelInfo values(15961,'��ְ����',7) 
GO
insert into HtmlLabelInfo values(15961,'',8) 
GO
insert into HtmlLabelInfo values(15962,'��ǩ����',7) 
GO
insert into HtmlLabelInfo values(15962,'',8) 
GO
insert into HtmlLabelInfo values(15963,'����ǩ����',7) 
GO
insert into HtmlLabelInfo values(15963,'',8) 
GO
insert into HtmlLabelInfo values(15964,'������ǩͳ��',7) 
GO
insert into HtmlLabelInfo values(15964,'',8) 
GO
insert into HtmlLabelInfo values(15965,'��ǩʱ��',7) 
GO
insert into HtmlLabelInfo values(15965,'',8) 
GO
insert into HtmlLabelInfo values(15966,'��ǩ����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15966,'',8) 
GO
insert into HtmlLabelInfo values(15967,'��ǩ����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15967,'',8) 
GO
insert into HtmlLabelInfo values(15968,'��ǩͳ��',7) 
GO
insert into HtmlLabelInfo values(15968,'',8) 
GO
insert into HtmlLabelInfo values(15969,'��ǩ������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(15969,'',8) 
GO
insert into HtmlLabelInfo values(15970,'��ǩ����',7) 
GO
insert into HtmlLabelInfo values(15970,'',8) 
GO
insert into HtmlLabelInfo values(15971,'��ǩ��������',7) 
GO
insert into HtmlLabelInfo values(15971,'',8) 
GO
insert into HtmlLabelInfo values(15972,'��Ƹ����',7) 
GO
insert into HtmlLabelInfo values(15972,'',8) 
GO
insert into HtmlLabelInfo values(15973,'���Ƹ����',7) 
GO
insert into HtmlLabelInfo values(15973,'',8) 
GO
insert into HtmlLabelInfo values(15974,'���Ž�Ƹͳ��',7) 
GO
insert into HtmlLabelInfo values(15974,'',8) 
GO
insert into HtmlLabelInfo values(15975,'��Ƹʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15975,'',8) 
GO
insert into HtmlLabelInfo values(15976,'��Ƹʱ��',7) 
GO
insert into HtmlLabelInfo values(15976,'',8) 
GO
insert into HtmlLabelInfo values(15977,'��Ƹ����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15977,'',8) 
GO
insert into HtmlLabelInfo values(15978,'��Ƹͳ��',7) 
GO
insert into HtmlLabelInfo values(15978,'',8) 
GO
insert into HtmlLabelInfo values(15979,'��Ƹ������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(15979,'',8) 
GO
insert into HtmlLabelInfo values(15980,'��Ƹ����',7) 
GO
insert into HtmlLabelInfo values(15980,'',8) 
GO
insert into HtmlLabelInfo values(15981,'ת������',7) 
GO
insert into HtmlLabelInfo values(15981,'',8) 
GO
insert into HtmlLabelInfo values(15982,'��ת������',7) 
GO
insert into HtmlLabelInfo values(15982,'',8) 
GO
insert into HtmlLabelInfo values(15983,'����ת��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15983,'',8) 
GO
insert into HtmlLabelInfo values(15984,'ת��ʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15984,'',8) 
GO
insert into HtmlLabelInfo values(15985,'ת��ʱ��',7) 
GO
insert into HtmlLabelInfo values(15985,'',8) 
GO
insert into HtmlLabelInfo values(15986,'ת������ͳ��',7) 
GO
insert into HtmlLabelInfo values(15986,'',8) 
GO
insert into HtmlLabelInfo values(15987,'ת��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15987,'',8) 
GO
insert into HtmlLabelInfo values(15988,'ת��������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(15988,'',8) 
GO
insert into HtmlLabelInfo values(15989,'��������',7) 
GO
insert into HtmlLabelInfo values(15989,'',8) 
GO
insert into HtmlLabelInfo values(15990,'���������',7) 
GO
insert into HtmlLabelInfo values(15990,'',8) 
GO
insert into HtmlLabelInfo values(15991,'���ŵ���ͳ��',7) 
GO
insert into HtmlLabelInfo values(15991,'',8) 
GO
insert into HtmlLabelInfo values(15992,'����ʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15992,'',8) 
GO
insert into HtmlLabelInfo values(15993,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15993,'',8) 
GO
insert into HtmlLabelInfo values(15994,'����ǰְ��',7) 
GO
insert into HtmlLabelInfo values(15994,'',8) 
GO
insert into HtmlLabelInfo values(15995,'������ְ��',7) 
GO
insert into HtmlLabelInfo values(15995,'',8) 
GO
insert into HtmlLabelInfo values(15996,'��������ͳ��',7) 
GO
insert into HtmlLabelInfo values(15996,'',8) 
GO
insert into HtmlLabelInfo values(15997,'����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15997,'',8) 
GO
insert into HtmlLabelInfo values(15998,'����������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(15998,'',8) 
GO
insert into HtmlLabelInfo values(15999,'������λ',7) 
GO
insert into HtmlLabelInfo values(15999,'',8) 
GO
insert into HtmlLabelInfo values(16000,'�����λ',7) 
GO
insert into HtmlLabelInfo values(16000,'',8) 
GO
insert into HtmlLabelInfo values(16001,'��������',7) 
GO
insert into HtmlLabelInfo values(16001,'',8) 
GO
insert into HtmlLabelInfo values(16002,'��Ƹ����',7) 
GO
insert into HtmlLabelInfo values(16002,'',8) 
GO
insert into HtmlLabelInfo values(16003,'�귵Ƹ����',7) 
GO
insert into HtmlLabelInfo values(16003,'',8) 
GO
insert into HtmlLabelInfo values(16004,'��Ƹʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(16004,'',8) 
GO
insert into HtmlLabelInfo values(16005,'��Ƹʱ��',7) 
GO
insert into HtmlLabelInfo values(16005,'',8) 
GO
insert into HtmlLabelInfo values(16006,'��Ƹ����ʱ��',7) 
GO
insert into HtmlLabelInfo values(16006,'',8) 
GO
insert into HtmlLabelInfo values(16007,'��Ƹ����ͳ��',7) 
GO
insert into HtmlLabelInfo values(16007,'',8) 
GO
insert into HtmlLabelInfo values(16008,'��Ƹͳ��',7) 
GO
insert into HtmlLabelInfo values(16008,'',8) 
GO
insert into HtmlLabelInfo values(16009,'��Ƹ������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(16009,'',8) 
GO
insert into HtmlLabelInfo values(16010,'��Ƹ����',7) 
GO
insert into HtmlLabelInfo values(16010,'',8) 
GO
insert into HtmlLabelInfo values(16011,'��Ƹ��λ',7) 
GO
insert into HtmlLabelInfo values(16011,'',8) 
GO
insert into HtmlLabelInfo values(16012,'��Ƹ����',7) 
GO
insert into HtmlLabelInfo values(16012,'',8) 
GO
insert into HtmlLabelInfo values(16013,'��Ƹ��������',7) 
GO
insert into HtmlLabelInfo values(16013,'',8) 
GO
insert into HtmlLabelInfo values(16014,'���ŷ�Ƹͳ��',7) 
GO
insert into HtmlLabelInfo values(16014,'',8) 
GO
insert into HtmlLabelInfo values(16015,'��ͥ��ϵ����',7) 
GO
insert into HtmlLabelInfo values(16015,'',8) 
GO
insert into HtmlLabelInfo values(16016,'�����ʺ�',7) 
GO
insert into HtmlLabelInfo values(16016,'',8) 
GO
insert into HtmlLabelInfo values(16017,'��½�ʺ�',7) 
GO
insert into HtmlLabelInfo values(16017,'',8) 
GO
insert into HtmlLabelInfo values(16018,'��ͥ��ϵ��ʽ',7) 
GO
insert into HtmlLabelInfo values(16018,'',8) 
GO
insert into HtmlLabelInfo values(16019,'����ͳ��',7) 
GO
insert into HtmlLabelInfo values(16019,'',8) 
GO
insert into HtmlLabelInfo values(16020,'����ʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(16020,'',8) 
GO
insert into HtmlLabelInfo values(16021,'���벿��ͳ��',7) 
GO
insert into HtmlLabelInfo values(16021,'',8) 
GO
insert into HtmlLabelInfo values(16022,'������Ա����',7) 
GO
insert into HtmlLabelInfo values(16022,'',8) 
GO
insert into HtmlLabelInfo values(16023,'��������Ա����',7) 
GO
insert into HtmlLabelInfo values(16023,'',8) 
GO
insert into HtmlLabelInfo values(16024,'����ʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(16024,'',8) 
GO
insert into HtmlLabelInfo values(16025,'���ݱ���',7) 
GO
insert into HtmlLabelInfo values(16025,'',8) 
GO
insert into HtmlLabelInfo values(16026,'�����ݱ���',7) 
GO
insert into HtmlLabelInfo values(16026,'',8) 
GO
insert into HtmlLabelInfo values(16027,'��������ͳ��',7) 
GO
insert into HtmlLabelInfo values(16027,'',8) 
GO
insert into HtmlLabelInfo values(16028,'����ʱ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(16028,'',8) 
GO
insert into HtmlLabelInfo values(16029,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(16029,'',8) 
GO
insert into HtmlLabelInfo values(16030,'���ݲ���ͳ��',7) 
GO
insert into HtmlLabelInfo values(16030,'',8) 
GO
insert into HtmlLabelInfo values(16031,'����ͳ��',7) 
GO
insert into HtmlLabelInfo values(16031,'',8) 
GO
insert into HtmlLabelInfo values(16032,'���ݾ�����Ϣ����',7) 
GO
insert into HtmlLabelInfo values(16032,'',8) 
GO
insert into HtmlLabelInfo values(16033,'���ݲ���',7) 
GO
insert into HtmlLabelInfo values(16033,'',8) 
GO
insert into HtmlLabelInfo values(16034,'���ݸ�λ',7) 
GO
insert into HtmlLabelInfo values(16034,'',8) 
GO
insert into HtmlLabelInfo values(16035,'��������',7) 
GO
insert into HtmlLabelInfo values(16035,'',8) 
GO
insert into HtmlLabelInfo values(16036,'�˴�ͳ��',7) 
GO
insert into HtmlLabelInfo values(16036,'',8) 
GO
insert into HtmlLabelInfo values(16037,'���ڿ�ʼ����',7) 
GO
insert into HtmlLabelInfo values(16037,'',8) 
GO
insert into HtmlLabelInfo values(16038,'���ڽ�������',7) 
GO
insert into HtmlLabelInfo values(16038,'',8) 
GO
insert into HtmlLabelInfo values(16039,'���ڿ�ʼʱ��',7) 
GO
insert into HtmlLabelInfo values(16039,'',8) 
GO
insert into HtmlLabelInfo values(16040,'���ڽ���ʱ��',7) 
GO
insert into HtmlLabelInfo values(16040,'',8) 
GO
insert into HtmlLabelInfo values(16041,'�䶯����',7) 
GO
insert into HtmlLabelInfo values(16041,'',8) 
GO
insert into HtmlLabelInfo values(16042,'���ڲ���ͳ��',7) 
GO
insert into HtmlLabelInfo values(16042,'',8) 
GO
insert into HtmlLabelInfo values(16043,'����ͳ��',7) 
GO
insert into HtmlLabelInfo values(16043,'',8) 
GO
insert into HtmlLabelInfo values(16044,'�������',7) 
GO
insert into HtmlLabelInfo values(16044,'',8) 
GO
insert into HtmlLabelInfo values(16045,'���ڲ���',7) 
GO
insert into HtmlLabelInfo values(16045,'',8) 
GO
insert into HtmlLabelInfo values(16046,'���౨��',7) 
GO
insert into HtmlLabelInfo values(16046,'',8) 
GO
insert into HtmlLabelInfo values(16047,'������������',7) 
GO
insert into HtmlLabelInfo values(16047,'',8) 
GO
insert into HtmlLabelInfo values(16048,'������Ա',7) 
GO
insert into HtmlLabelInfo values(16048,'',8) 
GO
insert into HtmlLabelInfo values(16049,'�·ݱ���',7) 
GO
insert into HtmlLabelInfo values(16049,'',8) 
GO
insert into HtmlLabelInfo values(16050,'�����ڲ���',7) 
GO
insert into HtmlLabelInfo values(16050,'',8) 
GO
insert into HtmlLabelInfo values(16051,'����Ա',7) 
GO
insert into HtmlLabelInfo values(16051,'',8) 
GO
insert into HtmlLabelInfo values(16052,'�·��˴α���',7) 
GO
insert into HtmlLabelInfo values(16052,'',8) 
GO
insert into HtmlLabelInfo values(16053,'�·���������',7) 
GO
insert into HtmlLabelInfo values(16053,'',8) 
GO
insert into HtmlLabelInfo values(16054,'���ھ�����Ϣ����',7) 
GO
insert into HtmlLabelInfo values(16054,'',8) 
GO
insert into HtmlLabelInfo values(16055,'��������',7) 
GO
insert into HtmlLabelInfo values(16055,'',8) 
GO
insert into HtmlLabelInfo values(16056,'ʵ�ʼ���ʱ��',7) 
GO
insert into HtmlLabelInfo values(16056,'',8) 
GO
insert into HtmlLabelInfo values(16057,'ʵ�ʼ�������',7) 
GO
insert into HtmlLabelInfo values(16057,'',8) 
GO
insert into HtmlLabelInfo values(16058,'�����˴α���',7) 
GO
insert into HtmlLabelInfo values(16058,'',8) 
GO
insert into HtmlLabelInfo values(16059,'�꿼������',7) 
GO
insert into HtmlLabelInfo values(16059,'',8) 
GO
insert into HtmlLabelInfo values(16060,'������Դ�ù�����',7) 
GO
insert into HtmlLabelInfo values(16060,'',8) 
GO
insert into HtmlLabelInfo values(16061,'�ù���������ͳ��',7) 
GO
insert into HtmlLabelInfo values(16061,'',8) 
GO
insert into HtmlLabelInfo values(16062,'�ù����������Ϣ����',7) 
GO
insert into HtmlLabelInfo values(16062,'',8) 
GO
insert into HtmlLabelInfo values(16063,'��������',7) 
GO
insert into HtmlLabelInfo values(16063,'',8) 
GO
insert into HtmlLabelInfo values(16064,'���ù����󱨱�',7) 
GO
insert into HtmlLabelInfo values(16064,'',8) 
GO
insert into HtmlLabelInfo values(16065,'���Ϳ���',7) 
GO
insert into HtmlLabelInfo values(16065,'',8) 
GO
insert into HtmlLabelInfo values(16066,'ϵͳ����',7) 
GO
insert into HtmlLabelInfo values(16066,'',8) 
GO
insert into HtmlLabelInfo values(16067,'����½����',7) 
GO
insert into HtmlLabelInfo values(16067,'',8) 
GO
insert into HtmlLabelInfo values(16068,'���ڲμӵ���ѵ�',7) 
GO
insert into HtmlLabelInfo values(16068,'',8) 
GO
insert into HtmlLabelInfo values(16069,'���Բμӵ���ѵ����',7) 
GO
insert into HtmlLabelInfo values(16069,'',8) 
GO
insert into HtmlLabelInfo values(16070,'��������',7) 
GO
insert into HtmlLabelInfo values(16070,'',8) 
GO
insert into HtmlLabelInfo values(16071,'��ʾ��ɫ',7) 
GO
insert into HtmlLabelInfo values(16071,'',8) 
GO
insert into HtmlLabelInfo values(16072,'��Ա����û������ֱ���ϼ���ȷ����������',7) 
GO
insert into HtmlLabelInfo values(16072,'',8) 
GO
insert into HtmlLabelInfo values(16073,'��ͬ��ʼ���ڲ��ܴ��ں�ͬ�������ڣ�',7) 
GO
insert into HtmlLabelInfo values(16073,'',8) 
GO
insert into HtmlLabelInfo values(16074,'�����ص�',7) 
GO
insert into HtmlLabelInfo values(16074,'',8) 
GO
insert into HtmlLabelInfo values(16075,'ɾ��ͼƬ',7) 
GO
insert into HtmlLabelInfo values(16075,'',8) 
GO
insert into HtmlLabelInfo values(16076,'��ϵ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(16076,'',8) 
GO
insert into HtmlLabelInfo values(16077,'��ְ֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(16077,'',8) 
GO
insert into HtmlLabelInfo values(16078,'��Ч�û����ѵ�license���ޣ�',7) 
GO
insert into HtmlLabelInfo values(16078,'',8) 
GO
insert into HtmlLabelInfo values(16079,'����ǩ��',7) 
GO
insert into HtmlLabelInfo values(16079,'',8) 
GO
insert into HtmlLabelInfo values(16080,'��ǩ״̬',7) 
GO
insert into HtmlLabelInfo values(16080,'',8) 
GO
insert into HtmlLabelInfo values(16081,'��ǩ��ע',7) 
GO
insert into HtmlLabelInfo values(16081,'',8) 
GO
insert into HtmlLabelInfo values(16082,'��ǩ��ͬ',7) 
GO
insert into HtmlLabelInfo values(16082,'',8) 
GO
insert into HtmlLabelInfo values(16083,'��ǩ֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(16083,'',8) 
GO
insert into HtmlLabelInfo values(16084,'�����ʻ�',7) 
GO
insert into HtmlLabelInfo values(16084,'',8) 
GO
insert into HtmlLabelInfo values(16085,'�������ʻ�',7) 
GO
insert into HtmlLabelInfo values(16085,'',8) 
GO
insert into HtmlLabelInfo values(16086,'����Ƹ��',7) 
GO
insert into HtmlLabelInfo values(16086,'',8) 
GO
insert into HtmlLabelInfo values(16087,'��Ƹԭ��',7) 
GO
insert into HtmlLabelInfo values(16087,'',8) 
GO
insert into HtmlLabelInfo values(16088,'��Ƹ��ͬ',7) 
GO
insert into HtmlLabelInfo values(16088,'',8) 
GO
insert into HtmlLabelInfo values(16089,'��Ƹ֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(16089,'',8) 
GO
insert into HtmlLabelInfo values(16090,'��ת����',7) 
GO
insert into HtmlLabelInfo values(16090,'',8) 
GO
insert into HtmlLabelInfo values(16091,'ת��֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(16091,'',8) 
GO
insert into HtmlLabelInfo values(16092,'�����޸ĳɹ�',7) 
GO
insert into HtmlLabelInfo values(16092,'',8) 
GO
insert into HtmlLabelInfo values(16093,'�����ճ�',7) 
GO
insert into HtmlLabelInfo values(16093,'',8) 
GO
insert into HtmlLabelInfo values(16094,'�ճ�����',7) 
GO
insert into HtmlLabelInfo values(16094,'',8) 
GO
insert into HtmlLabelInfo values(16095,'��Ŀ�ճ�',7) 
GO
insert into HtmlLabelInfo values(16095,'',8) 
GO
insert into HtmlLabelInfo values(16096,'���ճ�',7) 
GO
insert into HtmlLabelInfo values(16096,'',8) 
GO
insert into HtmlLabelInfo values(16097,'���ճ�',7) 
GO
insert into HtmlLabelInfo values(16097,'',8) 
GO
insert into HtmlLabelInfo values(16098,'���ճ�',7) 
GO
insert into HtmlLabelInfo values(16098,'',8) 
GO
insert into HtmlLabelInfo values(16099,'�����ճ�',7) 
GO
insert into HtmlLabelInfo values(16099,'',8) 
GO
insert into HtmlLabelInfo values(16100,'��һ',7) 
GO
insert into HtmlLabelInfo values(16100,'',8) 
GO
insert into HtmlLabelInfo values(16101,'�ܶ�',7) 
GO
insert into HtmlLabelInfo values(16101,'',8) 
GO
insert into HtmlLabelInfo values(16102,'����',7) 
GO
insert into HtmlLabelInfo values(16102,'',8) 
GO
insert into HtmlLabelInfo values(16103,'����',7) 
GO
insert into HtmlLabelInfo values(16103,'',8) 
GO
insert into HtmlLabelInfo values(16104,'����',7) 
GO
insert into HtmlLabelInfo values(16104,'',8) 
GO
insert into HtmlLabelInfo values(16105,'����',7) 
GO
insert into HtmlLabelInfo values(16105,'',8) 
GO
insert into HtmlLabelInfo values(16106,'����',7) 
GO
insert into HtmlLabelInfo values(16106,'',8) 
GO
insert into HtmlLabelInfo values(16107,'�ָ�λ',7) 
GO
insert into HtmlLabelInfo values(16107,'',8) 
GO
insert into HtmlLabelInfo values(16108,'����֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(16108,'',8) 
GO
insert into HtmlLabelInfo values(16109,'����Ƹ��',7) 
GO
insert into HtmlLabelInfo values(16109,'',8) 
GO
insert into HtmlLabelInfo values(16110,'��Ƹ��ʼ����',7) 
GO
insert into HtmlLabelInfo values(16110,'',8) 
GO
insert into HtmlLabelInfo values(16111,'��Ƹ��������',7) 
GO
insert into HtmlLabelInfo values(16111,'',8) 
GO
insert into HtmlLabelInfo values(16112,'��Ƹԭ��',7) 
GO
insert into HtmlLabelInfo values(16112,'',8) 
GO
insert into HtmlLabelInfo values(16113,'��Ƹ��ͬ',7) 
GO
insert into HtmlLabelInfo values(16113,'',8) 
GO
insert into HtmlLabelInfo values(16114,'��Ƹ֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(16114,'',8) 
GO
insert into HtmlLabelInfo values(16115,'������',7) 
GO
insert into HtmlLabelInfo values(16115,'',8) 
GO
insert into HtmlLabelInfo values(16116,'���ݱ�ע',7) 
GO
insert into HtmlLabelInfo values(16116,'',8) 
GO
insert into HtmlLabelInfo values(16117,'���ݺ�ͬ',7) 
GO
insert into HtmlLabelInfo values(16117,'',8) 
GO
insert into HtmlLabelInfo values(16118,'����֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(16118,'',8) 
GO
insert into HtmlLabelInfo values(16119,'Ա����Ƹ֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16119,'',8) 
GO
insert into HtmlLabelInfo values(16120,'Ա��ת��֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16120,'',8) 
GO
insert into HtmlLabelInfo values(16121,'Ա����ǩ֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16121,'',8) 
GO
insert into HtmlLabelInfo values(16122,'Ա������֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16122,'',8) 
GO
insert into HtmlLabelInfo values(16123,'Ա����ְ֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16123,'',8) 
GO
insert into HtmlLabelInfo values(16124,'Ա������֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16124,'',8) 
GO
insert into HtmlLabelInfo values(16125,'Ա����Ƹ֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16125,'',8) 
GO
insert into HtmlLabelInfo values(16126,'��½��',7) 
GO
insert into HtmlLabelInfo values(16126,'',8) 
GO
insert into HtmlLabelInfo values(16127,'����ȷ��',7) 
GO
insert into HtmlLabelInfo values(16127,'',8) 
GO
insert into HtmlLabelInfo values(16128,'��¼����ͻ������',7) 
GO
insert into HtmlLabelInfo values(16128,'',8) 
GO
insert into HtmlLabelInfo values(16129,'��¼�û����ѵ�license����,�����������µ��û���¼��Ϣ��',7) 
GO
insert into HtmlLabelInfo values(16129,'',8) 
GO
insert into HtmlLabelInfo values(16130,'������',7) 
GO
insert into HtmlLabelInfo values(16130,'',8) 
GO
insert into HtmlLabelInfo values(16131,'����',7) 
GO
insert into HtmlLabelInfo values(16131,'',8) 
GO
insert into HtmlLabelInfo values(16132,'�ܺ�',7) 
GO
insert into HtmlLabelInfo values(16132,'',8) 
GO
insert into HtmlLabelInfo values(16133,'�������',7) 
GO
insert into HtmlLabelInfo values(16133,'',8) 
GO
insert into HtmlLabelInfo values(16134,'�ճ�����',7) 
GO
insert into HtmlLabelInfo values(16134,'',8) 
GO
insert into HtmlLabelInfo values(16135,'δ�μ�',7) 
GO
insert into HtmlLabelInfo values(16135,'',8) 
GO
insert into HtmlLabelInfo values(16136,'������¼',7) 
GO
insert into HtmlLabelInfo values(16136,'',8) 
GO
insert into HtmlLabelInfo values(16137,'�䶯ԭ��',7) 
GO
insert into HtmlLabelInfo values(16137,'',8) 
GO
insert into HtmlLabelInfo values(16138,'�ܹ�˾',7) 
GO
insert into HtmlLabelInfo values(16138,'',8) 
GO
insert into HtmlLabelInfo values(16139,'ϵͳ����Ա',7) 
GO
insert into HtmlLabelInfo values(16139,'',8) 
GO
insert into HtmlLabelInfo values(16140,'�μ���Ա',7) 
GO
insert into HtmlLabelInfo values(16140,'',8) 
GO
insert into HtmlLabelInfo values(16141,'��֯��',7) 
GO
insert into HtmlLabelInfo values(16141,'',8) 
GO
insert into HtmlLabelInfo values(16142,'Ŀ��',7) 
GO
insert into HtmlLabelInfo values(16142,'',8) 
GO
insert into HtmlLabelInfo values(16143,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(16143,'',8) 
GO
insert into HtmlLabelInfo values(16144,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(16144,'',8) 
GO
insert into HtmlLabelInfo values(16145,'Ч��',7) 
GO
insert into HtmlLabelInfo values(16145,'',8) 
GO
insert into HtmlLabelInfo values(16146,'��ѵ��Ա',7) 
GO
insert into HtmlLabelInfo values(16146,'',8) 
GO
insert into HtmlLabelInfo values(16147,'������ѵ��Ѿ���ɾ������',7) 
GO
insert into HtmlLabelInfo values(16147,'',8) 
GO
insert into HtmlLabelInfo values(16148,'������ѵ��',7) 
GO
insert into HtmlLabelInfo values(16148,'',8) 
GO
insert into HtmlLabelInfo values(16149,'֪ͨ����',7) 
GO
insert into HtmlLabelInfo values(16149,'',8) 
GO
insert into HtmlLabelInfo values(16150,'��ѵ�ճ�',7) 
GO
insert into HtmlLabelInfo values(16150,'',8) 
GO
insert into HtmlLabelInfo values(16151,'������ѵ�ճ�',7) 
GO
insert into HtmlLabelInfo values(16151,'',8) 
GO
insert into HtmlLabelInfo values(16152,'��ѵ��ܽ�',7) 
GO
insert into HtmlLabelInfo values(16152,'',8) 
GO
insert into HtmlLabelInfo values(16153,'ʵ����ѵ����',7) 
GO
insert into HtmlLabelInfo values(16153,'',8) 
GO
insert into HtmlLabelInfo values(16154,'�ܽ���',7) 
GO
insert into HtmlLabelInfo values(16154,'',8) 
GO
insert into HtmlLabelInfo values(16155,'�ܽ�����',7) 
GO
insert into HtmlLabelInfo values(16155,'',8) 
GO
insert into HtmlLabelInfo values(16156,'��ѵ����֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16156,'',8) 
GO
insert into HtmlLabelInfo values(16157,'������ѵ�滮�Ѿ���ɾ������',7) 
GO
insert into HtmlLabelInfo values(16157,'',8) 
GO
insert into HtmlLabelInfo values(16158,'ʵʩ���',7) 
GO
insert into HtmlLabelInfo values(16158,'',8) 
GO
insert into HtmlLabelInfo values(16159,'����',7) 
GO
insert into HtmlLabelInfo values(16159,'',8) 
GO
insert into HtmlLabelInfo values(16160,'�Ϻ�',7) 
GO
insert into HtmlLabelInfo values(16160,'',8) 
GO
insert into HtmlLabelInfo values(16161,'�¿���',7) 
GO
insert into HtmlLabelInfo values(16161,'',8) 
GO
insert into HtmlLabelInfo values(16162,'��ѵ�滮����֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16162,'',8) 
GO
insert into HtmlLabelInfo values(16163,'�Բ�������Ȩ����������ѵ������',7) 
GO
insert into HtmlLabelInfo values(16163,'',8) 
GO
insert into HtmlLabelInfo values(16164,'��ѵ֪ͨ',7) 
GO
insert into HtmlLabelInfo values(16164,'',8) 
GO
insert into HtmlLabelInfo values(16165,'�ⲿ��Դ',7) 
GO
insert into HtmlLabelInfo values(16165,'',8) 
GO
insert into HtmlLabelInfo values(16166,'�ڲ���Դ',7) 
GO
insert into HtmlLabelInfo values(16166,'',8) 
GO
insert into HtmlLabelInfo values(16167,'����Ȩ����',7) 
GO
insert into HtmlLabelInfo values(16167,'',8) 
GO
insert into HtmlLabelInfo values(16168,'���ſ�ݷ�ʽ',7) 
GO
insert into HtmlLabelInfo values(16168,'',8) 
GO
insert into HtmlLabelInfo values(16169,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(16169,'',8) 
GO
insert into HtmlLabelInfo values(16170,'��΢�������',7) 
GO
insert into HtmlLabelInfo values(16170,'',8) 
GO
insert into HtmlLabelInfo values(16171,'�ĵ�ģ������',7) 
GO
insert into HtmlLabelInfo values(16171,'',8) 
GO
insert into HtmlLabelInfo values(16172,'�޸Ĺ���',7) 
GO
insert into HtmlLabelInfo values(16172,'',8) 
GO
insert into HtmlLabelInfo values(16173,'�ʲ�ʹ��',7) 
GO
insert into HtmlLabelInfo values(16173,'',8) 
GO
insert into HtmlLabelInfo values(16174,'�ǣ���ѡ��',7) 
GO
insert into HtmlLabelInfo values(16174,'',8) 
GO
insert into HtmlLabelInfo values(16175,'��δʹ�ã�',7) 
GO
insert into HtmlLabelInfo values(16175,'',8) 
GO
insert into HtmlLabelInfo values(16176,'�ǣ�ǿ���ԣ�',7) 
GO
insert into HtmlLabelInfo values(16176,'',8) 
GO
insert into HtmlLabelInfo values(16177,'������Դʹ��',7) 
GO
insert into HtmlLabelInfo values(16177,'',8) 
GO
insert into HtmlLabelInfo values(16178,'��Ŀʹ��',7) 
GO
insert into HtmlLabelInfo values(16178,'',8) 
GO
insert into HtmlLabelInfo values(16179,'����',7) 
GO
insert into HtmlLabelInfo values(16179,'cut',8) 
GO
insert into HtmlLabelInfo values(16180,'ճ��',7) 
GO
insert into HtmlLabelInfo values(16180,'paste',8) 
GO
insert into HtmlLabelInfo values(16181,'������',7) 
GO
insert into HtmlLabelInfo values(16181,'',8) 
GO
insert into HtmlLabelInfo values(16182,'ɾ����',7) 
GO
insert into HtmlLabelInfo values(16182,'',8) 
GO
insert into HtmlLabelInfo values(16183,'ɾ����',7) 
GO
insert into HtmlLabelInfo values(16183,'',8) 
GO
insert into HtmlLabelInfo values(16184,'���뵥Ԫ��',7) 
GO
insert into HtmlLabelInfo values(16184,'',8) 
GO
insert into HtmlLabelInfo values(16185,'ɾ����Ԫ��',7) 
GO
insert into HtmlLabelInfo values(16185,'',8) 
GO
insert into HtmlLabelInfo values(16186,'�ϲ���Ԫ��',7) 
GO
insert into HtmlLabelInfo values(16186,'',8) 
GO
insert into HtmlLabelInfo values(16187,'��ֵ�Ԫ��',7) 
GO
insert into HtmlLabelInfo values(16187,'',8) 
GO
insert into HtmlLabelInfo values(16188,'����ѡ�������ͼƬ',7) 
GO
insert into HtmlLabelInfo values(16188,'',8) 
GO
insert into HtmlLabelInfo values(16189,'����',7) 
GO
insert into HtmlLabelInfo values(16189,'',8) 
GO
insert into HtmlLabelInfo values(16190,'����',7) 
GO
insert into HtmlLabelInfo values(16190,'',8) 
GO
insert into HtmlLabelInfo values(16191,'������',7) 
GO
insert into HtmlLabelInfo values(16191,'',8) 
GO
insert into HtmlLabelInfo values(16192,'����',7) 
GO
insert into HtmlLabelInfo values(16192,'',8) 
GO
insert into HtmlLabelInfo values(16193,'����',7) 
GO
insert into HtmlLabelInfo values(16193,'',8) 
GO
insert into HtmlLabelInfo values(16194,'��԰',7) 
GO
insert into HtmlLabelInfo values(16194,'',8) 
GO
insert into HtmlLabelInfo values(16195,'����',7) 
GO
insert into HtmlLabelInfo values(16195,'',8) 
GO
insert into HtmlLabelInfo values(16196,'����',7) 
GO
insert into HtmlLabelInfo values(16196,'',8) 
GO
insert into HtmlLabelInfo values(16197,'�ֺ�',7) 
GO
insert into HtmlLabelInfo values(16197,'',8) 
GO
insert into HtmlLabelInfo values(16198,'�Ӵ�',7) 
GO
insert into HtmlLabelInfo values(16198,'',8) 
GO
insert into HtmlLabelInfo values(16199,'��б',7) 
GO
insert into HtmlLabelInfo values(16199,'',8) 
GO
insert into HtmlLabelInfo values(16200,'�»���',7) 
GO
insert into HtmlLabelInfo values(16200,'',8) 
GO
insert into HtmlLabelInfo values(16201,'ͻ����ʾ',7) 
GO
insert into HtmlLabelInfo values(16201,'',8) 
GO
insert into HtmlLabelInfo values(16202,'�����',7) 
GO
insert into HtmlLabelInfo values(16202,'',8) 
GO
insert into HtmlLabelInfo values(16203,'����',7) 
GO
insert into HtmlLabelInfo values(16203,'',8) 
GO
insert into HtmlLabelInfo values(16204,'�Ҷ���',7) 
GO
insert into HtmlLabelInfo values(16204,'',8) 
GO
insert into HtmlLabelInfo values(16205,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(16205,'',8) 
GO
insert into HtmlLabelInfo values(16206,'����������',7) 
GO
insert into HtmlLabelInfo values(16206,'',8) 
GO
insert into HtmlLabelInfo values(16207,'����������',7) 
GO
insert into HtmlLabelInfo values(16207,'',8) 
GO
insert into HtmlLabelInfo values(16208,'��������',7) 
GO
insert into HtmlLabelInfo values(16208,'',8) 
GO
insert into HtmlLabelInfo values(16209,'����ͼ��',7) 
GO
insert into HtmlLabelInfo values(16209,'',8) 
GO
insert into HtmlLabelInfo values(16210,'����',7) 
GO
insert into HtmlLabelInfo values(16210,'cancel',8) 
GO
insert into HtmlLabelInfo values(16211,'�ָ�',7) 
GO
insert into HtmlLabelInfo values(16211,'',8) 
GO
insert into HtmlLabelInfo values(16212,'����λ��',7) 
GO
insert into HtmlLabelInfo values(16212,'',8) 
GO
insert into HtmlLabelInfo values(16213,'����',7) 
GO
insert into HtmlLabelInfo values(16213,'',8) 
GO
insert into HtmlLabelInfo values(16214,'����',7) 
GO
insert into HtmlLabelInfo values(16214,'',8) 
GO
insert into HtmlLabelInfo values(16215,'�������ĵ����',7) 
GO
insert into HtmlLabelInfo values(16215,'',8) 
GO
insert into HtmlLabelInfo values(16216,'ȫ��չ��',7) 
GO
insert into HtmlLabelInfo values(16216,'',8) 
GO
insert into HtmlLabelInfo values(16217,'ѡ����ɫ',7) 
GO
insert into HtmlLabelInfo values(16217,'',8) 
GO
insert into HtmlLabelInfo values(16218,'�ʼ�ģ��',7) 
GO
insert into HtmlLabelInfo values(16218,'',8) 
GO
insert into HtmlLabelInfo values(16219,'����HTML�����е�NAME����Ӧ�����ݱ��еĸ��ֶ�����һ��.',7) 
GO
insert into HtmlLabelInfo values(16219,'',8) 
GO
insert into HtmlLabelInfo values(16220,'����',7) 
GO
insert into HtmlLabelInfo values(16220,'E-mail',8) 
GO
insert into HtmlLabelInfo values(16221,'��������',7) 
GO
insert into HtmlLabelInfo values(16221,'',8) 
GO
insert into HtmlLabelInfo values(16222,'ϵͳ��������',7) 
GO
insert into HtmlLabelInfo values(16222,'',8) 
GO
insert into HtmlLabelInfo values(16223,'�������',7) 
GO
insert into HtmlLabelInfo values(16223,'',8) 
GO
insert into HtmlLabelInfo values(16224,'�����ɱ�����',7) 
GO
insert into HtmlLabelInfo values(16224,'',8) 
GO
insert into HtmlLabelInfo values(16225,'��Ʒ���',7) 
GO
insert into HtmlLabelInfo values(16225,'',8) 
GO
insert into HtmlLabelInfo values(16226,'��˾����',7) 
GO
insert into HtmlLabelInfo values(16226,'',8) 
GO
insert into HtmlLabelInfo values(16227,'�����˲���,��ο�HRM(����-��-����)',7) 
GO
insert into HtmlLabelInfo values(16227,'',8) 
GO
insert into HtmlLabelInfo values(16228,'�ĵ�����',7) 
GO
insert into HtmlLabelInfo values(16228,'',8) 
GO
insert into HtmlLabelInfo values(16229,'����������',7) 
GO
insert into HtmlLabelInfo values(16229,'',8) 
GO
insert into HtmlLabelInfo values(16230,'���������ƺ�����',7) 
GO
insert into HtmlLabelInfo values(16230,'',8) 
GO
insert into HtmlLabelInfo values(16231,'�����޸���',7) 
GO
insert into HtmlLabelInfo values(16231,'',8) 
GO
insert into HtmlLabelInfo values(16232,'�����޸�����',7) 
GO
insert into HtmlLabelInfo values(16232,'',8) 
GO
insert into HtmlLabelInfo values(16233,'ʹ�õ�����',7) 
GO
insert into HtmlLabelInfo values(16233,'',8) 
GO
insert into HtmlLabelInfo values(16234,'�ظ��ĵ������ĵ�',7) 
GO
insert into HtmlLabelInfo values(16234,'',8) 
GO
insert into HtmlLabelInfo values(16235,'�ĵ���״̬(�ݸ�,��,����,�鵵)',7) 
GO
insert into HtmlLabelInfo values(16235,'',8) 
GO
insert into HtmlLabelInfo values(16236,'�ĵ�����',7) 
GO
insert into HtmlLabelInfo values(16236,'',8) 
GO
insert into HtmlLabelInfo values(16237,'����״̬(����,����,��������)',7) 
GO
insert into HtmlLabelInfo values(16237,'',8) 
GO
insert into HtmlLabelInfo values(16238,'���鿴����',7) 
GO
insert into HtmlLabelInfo values(16238,'',8) 
GO
insert into HtmlLabelInfo values(16239,'�ĵ��İ�ȫ����',7) 
GO
insert into HtmlLabelInfo values(16239,'',8) 
GO
insert into HtmlLabelInfo values(16240,'�ĵ�����',7) 
GO
insert into HtmlLabelInfo values(16240,'',8) 
GO
insert into HtmlLabelInfo values(16241,'��������Ŀ��',7) 
GO
insert into HtmlLabelInfo values(16241,'',8) 
GO
insert into HtmlLabelInfo values(16242,'��������',7) 
GO
insert into HtmlLabelInfo values(16242,'',8) 
GO
insert into HtmlLabelInfo values(16243,'���Ķ�',7) 
GO
insert into HtmlLabelInfo values(16243,'',8) 
GO
insert into HtmlLabelInfo values(16244,'ȫ���ĵ�:�����Ķ�����(����)',7) 
GO
insert into HtmlLabelInfo values(16244,'',8) 
GO
insert into HtmlLabelInfo values(16245,'������������',7) 
GO
insert into HtmlLabelInfo values(16245,'',8) 
GO
insert into HtmlLabelInfo values(16246,'��������',7) 
GO
insert into HtmlLabelInfo values(16246,'',8) 
GO
insert into HtmlLabelInfo values(16247,'�˶��ɹ�',7) 
GO
insert into HtmlLabelInfo values(16247,'',8) 
GO
insert into HtmlLabelInfo values(16248,'�ύ�ɹ�',7) 
GO
insert into HtmlLabelInfo values(16248,'',8) 
GO
insert into HtmlLabelInfo values(16249,'����ͼ�α༭',7) 
GO
insert into HtmlLabelInfo values(16249,'',8) 
GO
insert into HtmlLabelInfo values(16250,'��ְ',7) 
GO
insert into HtmlLabelInfo values(16250,'',8) 
GO
insert into HtmlLabelInfo values(16251,'ӦƸ��',7) 
GO
insert into HtmlLabelInfo values(16251,'',8) 
GO
insert into HtmlLabelInfo values(16252,'���ڹ���',7) 
GO
insert into HtmlLabelInfo values(16252,'',8) 
GO
insert into HtmlLabelInfo values(16253,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(16253,'',8) 
GO
insert into HtmlLabelInfo values(16254,'һ�㹤��ʱ��',7) 
GO
insert into HtmlLabelInfo values(16254,'',8) 
GO
insert into HtmlLabelInfo values(16255,'�Ű�����',7) 
GO
insert into HtmlLabelInfo values(16255,'',8) 
GO
insert into HtmlLabelInfo values(16256,'�Ű�ά��',7) 
GO
insert into HtmlLabelInfo values(16256,'',8) 
GO
insert into HtmlLabelInfo values(16257,'���û��ӿ�',7) 
GO
insert into HtmlLabelInfo values(16257,'',8) 
GO
insert into HtmlLabelInfo values(16258,'�����ݵ���',7) 
GO
insert into HtmlLabelInfo values(16258,'',8) 
GO
insert into HtmlLabelInfo values(16259,'�����ݵ���',7) 
GO
insert into HtmlLabelInfo values(16259,'',8) 
GO
insert into HtmlLabelInfo values(16260,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(16260,'',8) 
GO
insert into HtmlLabelInfo values(16261,'��������',7) 
GO
insert into HtmlLabelInfo values(16261,'',8) 
GO
insert into HtmlLabelInfo values(16262,'���ʸ���˰����Ŀ',7) 
GO
insert into HtmlLabelInfo values(16262,'',8) 
GO
insert into HtmlLabelInfo values(16263,'н�����',7) 
GO
insert into HtmlLabelInfo values(16263,'',8) 
GO
insert into HtmlLabelInfo values(16264,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(16264,'',8) 
GO
insert into HtmlLabelInfo values(16265,'�ʲ��������뵥',7) 
GO
insert into HtmlLabelInfo values(16265,'',8) 
GO
insert into HtmlLabelInfo values(16266,'����ս��Ͷ�����޹�˾������������ά�޵�',7) 
GO
insert into HtmlLabelInfo values(16266,'',8) 
GO
insert into HtmlLabelInfo values(16267,'ά����',7) 
GO
insert into HtmlLabelInfo values(16267,'',8) 
GO
insert into HtmlLabelInfo values(16268,'ά��ʱ��',7) 
GO
insert into HtmlLabelInfo values(16268,'',8) 
GO
insert into HtmlLabelInfo values(16269,'ά�޷���',7) 
GO
insert into HtmlLabelInfo values(16269,'',8) 
GO
insert into HtmlLabelInfo values(16270,'˵���������룡',7) 
GO
insert into HtmlLabelInfo values(16270,'',8) 
GO
insert into HtmlLabelInfo values(16271,'���˽����',7) 
GO
insert into HtmlLabelInfo values(16271,'',8) 
GO
insert into HtmlLabelInfo values(16272,'���¹���Ŀ��',7) 
GO
insert into HtmlLabelInfo values(16272,'',8) 
GO
insert into HtmlLabelInfo values(16273,'���¹����ܽ�',7) 
GO
insert into HtmlLabelInfo values(16273,'',8) 
GO
insert into HtmlLabelInfo values(16274,'��������������',7) 
GO
insert into HtmlLabelInfo values(16274,'',8) 
GO
insert into HtmlLabelInfo values(16275,'����������',7) 
GO
insert into HtmlLabelInfo values(16275,'',8) 
GO
insert into HtmlLabelInfo values(16276,'���¹����ܽ�',7) 
GO
insert into HtmlLabelInfo values(16276,'',8) 
GO
insert into HtmlLabelInfo values(16277,'�ܽ�Ȩ��ָ�����ܴ���100%',7) 
GO
insert into HtmlLabelInfo values(16277,'',8) 
GO
insert into HtmlLabelInfo values(16278,'�ƻ�Ȩ��ָ�����ܴ���100%',7) 
GO
insert into HtmlLabelInfo values(16278,'',8) 
GO
insert into HtmlLabelInfo values(16279,'�ܽ�Ȩ��ָ�����ܴ���100%',7) 
GO
insert into HtmlLabelInfo values(16279,'',8) 
GO
insert into HtmlLabelInfo values(16279,'�ƻ�Ȩ��ָ�����ܴ���100%',7) 
GO
insert into HtmlLabelInfo values(16279,'',8) 
GO
insert into HtmlLabelInfo values(16279,'���ܹ����ܽ�',7) 
GO
insert into HtmlLabelInfo values(16279,'',8) 
GO
insert into HtmlLabelInfo values(16280,'��ɽ��',7) 
GO
insert into HtmlLabelInfo values(16280,'',8) 
GO
insert into HtmlLabelInfo values(16281,'δ�������',7) 
GO
insert into HtmlLabelInfo values(16281,'',8) 
GO
insert into HtmlLabelInfo values(16282,'���ܹ����ƻ�',7) 
GO
insert into HtmlLabelInfo values(16282,'',8) 
GO
insert into HtmlLabelInfo values(16283,'�Ƿ񹫿�',7) 
GO
insert into HtmlLabelInfo values(16283,'',8) 
GO
insert into HtmlLabelInfo values(16284,'��ϸ˵��',7) 
GO
insert into HtmlLabelInfo values(16284,'',8) 
GO
insert into HtmlLabelInfo values(16285,'��ʾ������Ϣ',7) 
GO
insert into HtmlLabelInfo values(16285,'',8) 
GO
insert into HtmlLabelInfo values(16286,'�ò���Ԥ������׼',7) 
GO
insert into HtmlLabelInfo values(16286,'',8) 
GO
insert into HtmlLabelInfo values(16287,'�ò���Ԥ��δ��׼',7) 
GO
insert into HtmlLabelInfo values(16287,'',8) 
GO
insert into HtmlLabelInfo values(16288,'�ò���δ��Ԥ��',7) 
GO
insert into HtmlLabelInfo values(16288,'',8) 
GO
insert into HtmlLabelInfo values(16289,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(16289,'',8) 
GO
insert into HtmlLabelInfo values(16290,'��Ŀ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(16290,'',8) 
GO
insert into HtmlLabelInfo values(16291,'����',7) 
GO
insert into HtmlLabelInfo values(16291,'',8) 
GO
insert into HtmlLabelInfo values(16292,'ʵ��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16292,'',8) 
GO
insert into HtmlLabelInfo values(16293,'�Ƿ�֧',7) 
GO
insert into HtmlLabelInfo values(16293,'',8) 
GO
insert into HtmlLabelInfo values(16294,'��Ŀ��Ԥ��',7) 
GO
insert into HtmlLabelInfo values(16294,'',8) 
GO
insert into HtmlLabelInfo values(16295,'��Ŀ��֧��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16295,'',8) 
GO
insert into HtmlLabelInfo values(16296,'���˸���ĿԤ��',7) 
GO
insert into HtmlLabelInfo values(16296,'',8) 
GO
insert into HtmlLabelInfo values(16297,'���˸���Ŀʵ��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16297,'',8) 
GO
insert into HtmlLabelInfo values(16298,'���Ÿ���ĿԤ��',7) 
GO
insert into HtmlLabelInfo values(16298,'',8) 
GO
insert into HtmlLabelInfo values(16299,'���Ÿ���Ŀʵ��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16299,'',8) 
GO
insert into HtmlLabelInfo values(16300,'ȫ������ĿԤ��',7) 
GO
insert into HtmlLabelInfo values(16300,'',8) 
GO
insert into HtmlLabelInfo values(16301,'ȫ������Ŀʵ��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16301,'',8) 
GO
insert into HtmlLabelInfo values(16302,'��֧��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16302,'',8) 
GO
insert into HtmlLabelInfo values(16303,'���˸�CRMԤ��',7) 
GO
insert into HtmlLabelInfo values(16303,'',8) 
GO
insert into HtmlLabelInfo values(16304,'���˸�CRMʵ��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16304,'',8) 
GO
insert into HtmlLabelInfo values(16305,'���Ÿ�CRMԤ��',7) 
GO
insert into HtmlLabelInfo values(16305,'',8) 
GO
insert into HtmlLabelInfo values(16306,'���Ÿ�CRMʵ��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16306,'',8) 
GO
insert into HtmlLabelInfo values(16307,'ȫ����CRMԤ��',7) 
GO
insert into HtmlLabelInfo values(16307,'',8) 
GO
insert into HtmlLabelInfo values(16308,'ȫ����CRMʵ��(�������α���)',7) 
GO
insert into HtmlLabelInfo values(16308,'',8) 
GO
insert into HtmlLabelInfo values(16309,'���ز�����Ϣ',7) 
GO
insert into HtmlLabelInfo values(16309,'',8) 
GO
insert into HtmlLabelInfo values(16310,'��������',7) 
GO
insert into HtmlLabelInfo values(16310,'',8) 
GO
insert into HtmlLabelInfo values(16311,'�칫��Ʒһ���Է������',7) 
GO
insert into HtmlLabelInfo values(16311,'',8) 
GO
insert into HtmlLabelInfo values(16312,'���ñ�',7) 
GO
insert into HtmlLabelInfo values(16312,'',8) 
GO
insert into HtmlLabelInfo values(16313,'Ʒ��',7) 
GO
insert into HtmlLabelInfo values(16313,'',8) 
GO
insert into HtmlLabelInfo values(16314,'���',7) 
GO
insert into HtmlLabelInfo values(16314,'',8) 
GO
insert into HtmlLabelInfo values(16315,'���',7) 
GO
insert into HtmlLabelInfo values(16315,'',8) 
GO
insert into HtmlLabelInfo values(16316,'�ձ�����(Uni)UB150ǩ�ֱ�',7) 
GO
insert into HtmlLabelInfo values(16316,'',8) 
GO
insert into HtmlLabelInfo values(16317,'����',7) 
GO
insert into HtmlLabelInfo values(16317,'',8) 
GO
insert into HtmlLabelInfo values(16318,'��ˮ��',7) 
GO
insert into HtmlLabelInfo values(16318,'',8) 
GO
insert into HtmlLabelInfo values(16319,'������',7) 
GO
insert into HtmlLabelInfo values(16319,'',8) 
GO
insert into HtmlLabelInfo values(16320,'�Լ�֧��',7) 
GO
insert into HtmlLabelInfo values(16320,'',8) 
GO
insert into HtmlLabelInfo values(16321,'��˾ȫ��',7) 
GO
insert into HtmlLabelInfo values(16321,'',8) 
GO
insert into HtmlLabelInfo values(16322,'֧������',7) 
GO
insert into HtmlLabelInfo values(16322,'',8) 
GO
insert into HtmlLabelInfo values(16323,'����Ԥ����ϸ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(16323,'',8) 
GO
insert into HtmlLabelInfo values(16324,'��������',7) 
GO
insert into HtmlLabelInfo values(16324,'',8) 
GO
insert into HtmlLabelInfo values(16325,'����',7) 
GO
insert into HtmlLabelInfo values(16325,'',8) 
GO
insert into HtmlLabelInfo values(16326,'������',7) 
GO
insert into HtmlLabelInfo values(16326,'',8) 
GO
insert into HtmlLabelInfo values(16327,'��û��ѡ��һ���������иı�����ݽ��޷��������棡',7) 
GO
insert into HtmlLabelInfo values(16327,'',8) 
GO
insert into HtmlLabelInfo values(16328,'������׼',7) 
GO
insert into HtmlLabelInfo values(16328,'',8) 
GO
insert into HtmlLabelInfo values(16329,'��',7) 
GO
insert into HtmlLabelInfo values(16329,'',8) 
GO
insert into HtmlLabelInfo values(16330,'��',7) 
GO
insert into HtmlLabelInfo values(16330,'',8) 
GO
insert into HtmlLabelInfo values(16331,'���ֲ��ܴ���5��',7) 
GO
insert into HtmlLabelInfo values(16331,'',8) 
GO
insert into HtmlLabelInfo values(16332,'��������Ϣ�������',7) 
GO
insert into HtmlLabelInfo values(16332,'',8) 
GO
insert into HtmlLabelInfo values(16333,'��������һ�ڵ����һ�ڵ�����ߴ���',7) 
GO
insert into HtmlLabelInfo values(16333,'',8) 
GO
insert into HtmlLabelInfo values(16334,'��������ת...',7) 
GO
insert into HtmlLabelInfo values(16334,'',8) 
GO
insert into HtmlLabelInfo values(16335,'ȫ��ɾ��',7) 
GO
insert into HtmlLabelInfo values(16335,'',8) 
GO
insert into HtmlLabelInfo values(16336,'��������',7) 
GO
insert into HtmlLabelInfo values(16336,'',8) 
GO
insert into HtmlLabelInfo values(16337,'���������',7) 
GO
insert into HtmlLabelInfo values(16337,'',8) 
GO
insert into HtmlLabelInfo values(16338,'��������',7) 
GO
insert into HtmlLabelInfo values(16338,'',8) 
GO
insert into HtmlLabelInfo values(16339,'���������',7) 
GO
insert into HtmlLabelInfo values(16339,'',8) 
GO
insert into HtmlLabelInfo values(16340,'��������',7) 
GO
insert into HtmlLabelInfo values(16340,'',8) 
GO
insert into HtmlLabelInfo values(16341,'��������',7) 
GO
insert into HtmlLabelInfo values(16341,'',8) 
GO
insert into HtmlLabelInfo values(16342,'����δ�������',7) 
GO
insert into HtmlLabelInfo values(16342,'',8) 
GO
insert into HtmlLabelInfo values(16343,'�������������',7) 
GO
insert into HtmlLabelInfo values(16343,'',8) 
GO
insert into HtmlLabelInfo values(16344,'ȷ��ɾ��ѡ������Ϣ��?',7) 
GO
insert into HtmlLabelInfo values(16344,'',8) 
GO
insert into HtmlLabelInfo values(16345,'����û�',7) 
GO
insert into HtmlLabelInfo values(16345,'',8) 
GO
insert into HtmlLabelInfo values(16346,'ȫ������',7) 
GO
insert into HtmlLabelInfo values(16346,'',8) 
GO
insert into HtmlLabelInfo values(16347,'���д���������',7) 
GO
insert into HtmlLabelInfo values(16347,'',8) 
GO
insert into HtmlLabelInfo values(16348,'�������������',7) 
GO
insert into HtmlLabelInfo values(16348,'',8) 
GO
insert into HtmlLabelInfo values(16349,'������',7) 
GO
insert into HtmlLabelInfo values(16349,'',8) 
GO
insert into HtmlLabelInfo values(16350,'ͬ������',7) 
GO
insert into HtmlLabelInfo values(16350,'',8) 
GO
insert into HtmlLabelInfo values(16351,'�˻�����ִ��',7) 
GO
insert into HtmlLabelInfo values(16351,'',8) 
GO
insert into HtmlLabelInfo values(16352,'���ƹ�������ͼ',7) 
GO
insert into HtmlLabelInfo values(16352,'',8) 
GO
insert into HtmlLabelInfo values(16353,'�Ѳ�����',7) 
GO
insert into HtmlLabelInfo values(16353,'',8) 
GO
insert into HtmlLabelInfo values(16354,'δ������',7) 
GO
insert into HtmlLabelInfo values(16354,'',8) 
GO
insert into HtmlLabelInfo values(16355,'�鿴��',7) 
GO
insert into HtmlLabelInfo values(16355,'',8) 
GO
insert into HtmlLabelInfo values(16389,'�鿴ҳ������',7) 
GO
insert into HtmlLabelInfo values(16392,'�½�����',7) 
GO
insert into HtmlLabelInfo values(16392,'',8) 
GO
insert into HtmlLabelInfo values(16394,'�ҵ�֪ʶ',7) 
GO
insert into HtmlLabelInfo values(16395,'����֪ʶ',7) 
GO
insert into HtmlLabelInfo values(16400,'�µĿͻ�',7) 
GO
insert into HtmlLabelInfo values(16400,'',8) 
GO
insert into HtmlLabelInfo values(16401,'����ͻ�',7) 
GO
insert into HtmlLabelInfo values(16401,'',8) 
GO
insert into HtmlLabelInfo values(16403,'',8) 
GO
insert into HtmlLabelInfo values(16404,'���ۺ�ͬ',7) 
GO
insert into HtmlLabelInfo values(16404,'',8) 
GO
insert into HtmlLabelInfo values(16405,'',8) 
GO
insert into HtmlLabelInfo values(16406,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(16406,'',8) 
GO
insert into HtmlLabelInfo values(16408,'��Ŀִ��',7) 
GO
insert into HtmlLabelInfo values(16408,'',8) 
GO
insert into HtmlLabelInfo values(16411,'��ǰ����',7) 
GO
insert into HtmlLabelInfo values(16411,'',8) 
GO
insert into HtmlLabelInfo values(16412,'',8) 
GO
insert into HtmlLabelInfo values(16413,'��ѯ��Ŀ',7) 
GO
insert into HtmlLabelInfo values(16414,'�ҵ�����',7) 
GO
insert into HtmlLabelInfo values(16414,'',8) 
GO
insert into HtmlLabelInfo values(16416,'�ҵĹ���',7) 
GO
insert into HtmlLabelInfo values(16416,'',8) 
GO
insert into HtmlLabelInfo values(16417,'',8) 
GO
insert into HtmlLabelInfo values(16418,'',8) 
GO
insert into HtmlLabelInfo values(16419,'',8) 
GO
insert into HtmlLabelInfo values(16420,'�µĻ���',7) 
GO
insert into HtmlLabelInfo values(16421,'�ϵĻ���',7) 
GO
insert into HtmlLabelInfo values(16421,'',8) 
GO
insert into HtmlLabelInfo values(16422,'�����ҷ���',7) 
GO
insert into HtmlLabelInfo values(16423,'',8) 
GO
insert into HtmlLabelInfo values(16426,'',8) 
GO
insert into HtmlLabelInfo values(16429,'',8) 
GO
insert into HtmlLabelInfo values(16430,'',8) 
GO
insert into HtmlLabelInfo values(16431,'',8) 
GO
insert into HtmlLabelInfo values(16432,'',8) 
GO
insert into HtmlLabelInfo values(16435,'�ռ�����',7) 
GO
insert into HtmlLabelInfo values(16436,'��������',7) 
GO
insert into HtmlLabelInfo values(16437,'',8) 
GO
insert into HtmlLabelInfo values(16438,'',8) 
GO
insert into HtmlLabelInfo values(16439,'��������',7) 
GO
insert into HtmlLabelInfo values(16440,'��ѯ�ʼ�',7) 
GO
insert into HtmlLabelInfo values(16440,'',8) 
GO
insert into HtmlLabelInfo values(16441,'Ⱥ���ʼ�',7) 
GO
insert into HtmlLabelInfo values(16442,'��������',7) 
GO
insert into HtmlLabelInfo values(16443,'�ҵĶ���',7) 
GO
insert into HtmlLabelInfo values(16444,'�½�����',7) 
GO
insert into HtmlLabelInfo values(16446,'',8) 
GO
insert into HtmlLabelInfo values(16448,'',8) 
GO
insert into HtmlLabelInfo values(16450,'��ʾģ��',7) 
GO
insert into HtmlLabelInfo values(16450,'',8) 
GO
insert into HtmlLabelInfo values(16451,'ҳ������',7) 
GO
insert into HtmlLabelInfo values(16451,'',8) 
GO
insert into HtmlLabelInfo values(16455,'��֯�ṹ',7) 
GO
insert into HtmlLabelInfo values(16456,'�ܲ�����',7) 
GO
insert into HtmlLabelInfo values(16457,'�ֲ�����',7) 
GO
insert into HtmlLabelInfo values(16458,'��������',7) 
GO
insert into HtmlLabelInfo values(16459,'ͼ�α༭ ',7) 
GO
insert into HtmlLabelInfo values(16460,'ְ������',7) 
GO
insert into HtmlLabelInfo values(16460,'',8) 
GO
insert into HtmlLabelInfo values(16461,'',8) 
GO
insert into HtmlLabelInfo values(16462,'ְ������',7) 
GO
insert into HtmlLabelInfo values(16462,'',8) 
GO
insert into HtmlLabelInfo values(16463,'רҵ����',7) 
GO
insert into HtmlLabelInfo values(16463,'',8) 
GO
insert into HtmlLabelInfo values(16464,'ѧ������',7) 
GO
insert into HtmlLabelInfo values(16465,'',8) 
GO
insert into HtmlLabelInfo values(16466,'',8) 
GO
insert into HtmlLabelInfo values(16467,'��Ա��ǩ',7) 
GO
insert into HtmlLabelInfo values(16468,'',8) 
GO
insert into HtmlLabelInfo values(16469,'',8) 
GO
insert into HtmlLabelInfo values(16470,'',8) 
GO
insert into HtmlLabelInfo values(16471,'',8) 
GO
insert into HtmlLabelInfo values(16473,'',8) 
GO
insert into HtmlLabelInfo values(16475,'��˾ʱ��',7) 
GO
insert into HtmlLabelInfo values(16475,'',8) 
GO
insert into HtmlLabelInfo values(16478,'���ڼ���',7) 
GO
insert into HtmlLabelInfo values(16481,'н������',7) 
GO
insert into HtmlLabelInfo values(16483,'·������',7) 
GO
insert into HtmlLabelInfo values(16483,'',8) 
GO
insert into HtmlLabelInfo values(16484,'��������',7) 
GO
insert into HtmlLabelInfo values(16485,'�ƺ�����',7) 
GO
insert into HtmlLabelInfo values(16486,'��ַ����',7) 
GO
insert into HtmlLabelInfo values(16486,'',8) 
GO
insert into HtmlLabelInfo values(16487,'�ʻ�����',7) 
GO
insert into HtmlLabelInfo values(16488,'��ϵ����',7) 
GO
insert into HtmlLabelInfo values(16489,'��ַ����',7) 
GO
insert into HtmlLabelInfo values(16491,'',8) 
GO
insert into HtmlLabelInfo values(16494,'',8) 
GO
insert into HtmlLabelInfo values(16495,'',8) 
GO
insert into HtmlLabelInfo values(16497,'',8) 
GO
insert into HtmlLabelInfo values(16498,'ʱ������',7) 
GO
insert into HtmlLabelInfo values(16499,'�ɹ�����',7) 
GO
insert into HtmlLabelInfo values(16500,'ʧ������',7) 
GO
insert into HtmlLabelInfo values(16503,'',8) 
GO
insert into HtmlLabelInfo values(16505,'Ԥ������',7) 
GO
insert into HtmlLabelInfo values(16506,'',8) 
GO
insert into HtmlLabelInfo values(16507,'ָ������',7) 
GO
insert into HtmlLabelInfo values(16507,'',8) 
GO
insert into HtmlLabelInfo values(16508,'',8) 
GO
insert into HtmlLabelInfo values(16509,'',8) 
GO
insert into HtmlLabelInfo values(16512,'��Ʒ����',7) 
GO
insert into HtmlLabelInfo values(16512,'',8) 
GO
insert into HtmlLabelInfo values(16513,'�½���Ʒ',7) 
GO
insert into HtmlLabelInfo values(16513,'',8) 
GO
insert into HtmlLabelInfo values(16514,'��������',7) 
GO
insert into HtmlLabelInfo values(16514,'',8) 
GO
insert into HtmlLabelInfo values(16515,'�����趨',7) 
GO
insert into HtmlLabelInfo values(16516,'����ά��',7) 
GO
insert into HtmlLabelInfo values(16517,'',8) 
GO
insert into HtmlLabelInfo values(16518,'',8) 
GO
insert into HtmlLabelInfo values(16519,'����ȷ��',7) 
GO
insert into HtmlLabelInfo values(16520,'������',7) 
GO
insert into HtmlLabelInfo values(16521,'',8) 
GO
insert into HtmlLabelInfo values(16522,'��������',7) 
GO
insert into HtmlLabelInfo values(16523,'',8) 
GO
insert into HtmlLabelInfo values(16524,'��������',7) 
GO
insert into HtmlLabelInfo values(16524,'',8) 
GO
insert into HtmlLabelInfo values(16525,'��������',7) 
GO
insert into HtmlLabelInfo values(16525,'',8) 
GO
insert into HtmlLabelInfo values(16526,'Ȩ������',7) 
GO
insert into HtmlLabelInfo values(16526,'',8) 
GO
insert into HtmlLabelInfo values(16527,'��ɫ����',7) 
GO
insert into HtmlLabelInfo values(16527,'',8) 
GO
insert into HtmlLabelInfo values(16528,'Ȩ��ת��',7) 
GO
insert into HtmlLabelInfo values(16528,'',8) 
GO
insert into HtmlLabelInfo values(16530,'',8) 
GO
insert into HtmlLabelInfo values(16531,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(16532,'���̱���',7) 
GO
insert into HtmlLabelInfo values(16532,'',8) 
GO
insert into HtmlLabelInfo values(16533,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(16533,'',8) 
GO
insert into HtmlLabelInfo values(16534,'���񱨱�',7) 
GO
insert into HtmlLabelInfo values(16535,'',8) 
GO
insert into HtmlLabelInfo values(16536,'֪ʶ����',7) 
GO
insert into HtmlLabelInfo values(16538,'',8) 
GO
insert into HtmlLabelInfo values(16543,'',8) 
GO
insert into HtmlLabelInfo values(16544,'',8) 
GO
insert into HtmlLabelInfo values(16545,'���䱨��',7) 
GO
insert into HtmlLabelInfo values(16545,'',8) 
GO
insert into HtmlLabelInfo values(16547,'��ٱ���',7) 
GO
insert into HtmlLabelInfo values(16547,'',8) 
GO
insert into HtmlLabelInfo values(16548,'�Ա𱨱�',7) 
GO
insert into HtmlLabelInfo values(16549,'���䱨��',7) 
GO
insert into HtmlLabelInfo values(16551,'',8) 
GO
insert into HtmlLabelInfo values(16552,'',8) 
GO
insert into HtmlLabelInfo values(16553,'ְ�񱨱�',7) 
GO
insert into HtmlLabelInfo values(16554,'ְ�Ʊ���',7) 
GO
insert into HtmlLabelInfo values(16556,'',8) 
GO
insert into HtmlLabelInfo values(16557,'�������',7) 
GO
insert into HtmlLabelInfo values(16558,'����ͳ��',7) 
GO
insert into HtmlLabelInfo values(16558,'',8) 
GO
insert into HtmlLabelInfo values(16559,'���ڱ���',7) 
GO
insert into HtmlLabelInfo values(16560,'н��ͳ��',7) 
GO
insert into HtmlLabelInfo values(16561,'���ʲ���',7) 
GO
insert into HtmlLabelInfo values(16562,'�����ܶ�',7) 
GO
insert into HtmlLabelInfo values(16562,'',8) 
GO
insert into HtmlLabelInfo values(16563,'�䶯���',7) 
GO
insert into HtmlLabelInfo values(16564,'',8) 
GO
insert into HtmlLabelInfo values(16565,'',8) 
GO
insert into HtmlLabelInfo values(16566,'ת�����',7) 
GO
insert into HtmlLabelInfo values(16566,'',8) 
GO
insert into HtmlLabelInfo values(16567,'��ǩ���',7) 
GO
insert into HtmlLabelInfo values(16567,'',8) 
GO
insert into HtmlLabelInfo values(16568,'��Ƹ���',7) 
GO
insert into HtmlLabelInfo values(16568,'',8) 
GO
insert into HtmlLabelInfo values(16569,'',8) 
GO
insert into HtmlLabelInfo values(16570,'',8) 
GO
insert into HtmlLabelInfo values(16571,'��Ƹ���',7) 
GO
insert into HtmlLabelInfo values(16574,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(16574,'',8) 
GO
insert into HtmlLabelInfo values(16575,'',8) 
GO
insert into HtmlLabelInfo values(16576,'',8) 
GO
insert into HtmlLabelInfo values(16577,'',8) 
GO
insert into HtmlLabelInfo values(16578,'���ڲ���',7) 
GO
insert into HtmlLabelInfo values(16578,'',8) 
GO
insert into HtmlLabelInfo values(16580,'���屨��',7) 
GO
insert into HtmlLabelInfo values(16580,'',8) 
GO
insert into HtmlLabelInfo values(16581,'��������',7) 
GO
insert into HtmlLabelInfo values(16582,'�ͻ����',7) 
GO
insert into HtmlLabelInfo values(16582,'',8) 
GO
insert into HtmlLabelInfo values(16586,'��ͬ���',7) 
GO
insert into HtmlLabelInfo values(16587,'��ͬ�б�',7) 
GO
insert into HtmlLabelInfo values(16588,'',8) 
GO
insert into HtmlLabelInfo values(16589,'',8) 
GO
insert into HtmlLabelInfo values(16590,'',8) 
GO
insert into HtmlLabelInfo values(16591,'',8) 
GO
insert into HtmlLabelInfo values(16592,'��Ա���',7) 
GO
insert into HtmlLabelInfo values(16592,'',8) 
GO
insert into HtmlLabelInfo values(16593,'�ͻ����',7) 
GO
insert into HtmlLabelInfo values(16593,'',8) 
GO
insert into HtmlLabelInfo values(16595,'',8) 
GO
insert into HtmlLabelInfo values(16597,'���ͱ���',7) 
GO
insert into HtmlLabelInfo values(16597,'',8) 
GO
insert into HtmlLabelInfo values(16598,'',8) 
GO
insert into HtmlLabelInfo values(16599,'�����ʲ�',7) 
GO
insert into HtmlLabelInfo values(16601,'',8) 
GO
insert into HtmlLabelInfo values(16602,'����Ķ���־',7) 
GO
insert into HtmlLabelInfo values(16602,'',8) 
GO
insert into HtmlLabelInfo values(16603,'֪ʶ��������',7) 
GO
insert into HtmlLabelInfo values(16603,'',8) 
GO
insert into HtmlLabelInfo values(16605,'',8) 
GO
insert into HtmlLabelInfo values(16606,'��౻���ĵ�',7) 
GO
insert into HtmlLabelInfo values(16606,'',8) 
GO
insert into HtmlLabelInfo values(16608,'����ĵ�����',7) 
GO
insert into HtmlLabelInfo values(16609,'����ĵ��ͻ�',7) 
GO
insert into HtmlLabelInfo values(16609,'',8) 
GO
insert into HtmlLabelInfo values(16610,'',8) 
GO
insert into HtmlLabelInfo values(16611,'����ĵ���Ŀ',7) 
GO
insert into HtmlLabelInfo values(16612,'',8) 
GO
insert into HtmlLabelInfo values(16614,'�����ұ���',7) 
GO
insert into HtmlLabelInfo values(16615,'',8) 
GO
insert into HtmlLabelInfo values(16617,'�ʲ�������',7) 
GO
insert into HtmlLabelInfo values(16617,'',8) 
GO
insert into HtmlLabelInfo values(16619,'��Ԥ������',7) 
GO
insert into HtmlLabelInfo values(16622,'�����ѳɹ�',7) 
GO
insert into HtmlLabelInfo values(16623,'���״̬',7) 
GO
insert into HtmlLabelInfo values(16623,'ConfirmStatus',8) 
GO
insert into HtmlLabelInfo values(16624,'���ȷ��',7) 
GO
insert into HtmlLabelInfo values(16624,'ConfirmSucc',8) 
GO
insert into HtmlLabelInfo values(16627,'',8) 
GO
insert into HtmlLabelInfo values(16628,'ȷ��Ҫ�˳�ϵͳ��',7) 
GO
insert into HtmlLabelInfo values(16630,'uploadexcelfile',8) 
GO
insert into HtmlLabelInfo values(16631,'ȷ��',7) 
GO
insert into HtmlLabelInfo values(16631,'Confirm',8) 
GO
insert into HtmlLabelInfo values(16633,'�ͻ���Ϣ',7) 
GO
insert into HtmlLabelInfo values(16634,'',8) 
GO
insert into HtmlLabelInfo values(16635,'���Ͷ���',7) 
GO
insert into HtmlLabelInfo values(16635,'',8) 
GO
insert into HtmlLabelInfo values(16636,'����',7) 
GO
insert into HtmlLabelInfo values(16637,'�ʼ���',7) 
GO
insert into HtmlLabelInfo values(16638,'',8) 
GO
insert into HtmlLabelInfo values(16639,'�ƶ���������',7) 
GO
insert into HtmlLabelInfo values(16639,'',8) 
GO
insert into HtmlLabelInfo values(2051,'�����ʼ�',7) 
GO
insert into HtmlLabelInfo values(2051,'�����ʼ�',8) 
GO
insert into HtmlLabelInfo values(2052,'ת���ʼ�',7) 
GO
insert into HtmlLabelInfo values(2052,'ת���ʼ�',8) 
GO
insert into HtmlLabelInfo values(2053,'�ظ�ȫ��',8) 
GO
insert into HtmlLabelInfo values(2053,'�ظ�ȫ��',7) 
GO
insert into HtmlLabelInfo values(2054,'�ظ��ʼ�',8) 
GO
insert into HtmlLabelInfo values(2054,'�ظ��ʼ�',7) 
GO
insert into HtmlLabelInfo values(2055,'',8) 
GO
insert into HtmlLabelInfo values(2055,'ת���ʼ�',7) 
GO
insert into HtmlLabelInfo values(2056,'�ƶ�������',7) 
GO
insert into HtmlLabelInfo values(2056,'�ƶ�������',8) 
GO
insert into HtmlLabelInfo values(2057,'���Ƶ�����',7) 
GO
insert into HtmlLabelInfo values(2057,'���Ƶ�����',8) 
GO
insert into HtmlLabelInfo values(2058,'�ʼ�������',7) 
GO
insert into HtmlLabelInfo values(2058,'�ʼ�������',8) 
GO
insert into HtmlLabelInfo values(2059,'Login log',8) 
GO
insert into HtmlLabelInfo values(2059,'��¼��־',7) 
GO
insert into HtmlLabelInfo values(2060,'������',7) 
GO
insert into HtmlLabelInfo values(2060,'������',8) 
GO
insert into HtmlLabelInfo values(2061,'��־����',7) 
GO
insert into HtmlLabelInfo values(2061,'��־����',8) 
GO
insert into HtmlLabelInfo values(2062,'�ͻ���ϵ�ƻ�',7) 
GO
insert into HtmlLabelInfo values(2062,'�ͻ���ϵ�ƻ�',8) 
GO
insert into HtmlLabelInfo values(2063,'',8) 
GO
insert into HtmlLabelInfo values(2063,'�µĹ���������:��',7) 
GO
insert into HtmlLabelInfo values(2064,'',8) 
GO
insert into HtmlLabelInfo values(2064,'�µĹ���������:����������',7) 
GO
insert into HtmlLabelInfo values(2065,'',8) 
GO
insert into HtmlLabelInfo values(2065,'�µĹ���������:����',7) 
GO
insert into HtmlLabelInfo values(2066,'',8) 
GO
insert into HtmlLabelInfo values(2066,'���������',7) 
GO
insert into HtmlLabelInfo values(2067,'',8) 
GO
insert into HtmlLabelInfo values(2067,'���������(������)',7) 
GO
insert into HtmlLabelInfo values(2068,'�ڵ㳬ʱ',7) 
GO
insert into HtmlLabelInfo values(2068,'�ڵ㳬ʱ',8) 
GO
insert into HtmlLabelInfo values(2069,'�����ĵ�',7) 
GO
insert into HtmlLabelInfo values(2069,'�����ĵ�',8) 
GO
insert into HtmlLabelInfo values(2070,'Process ',8) 
GO
insert into HtmlLabelInfo values(2070,'�����ĵ�',7) 
GO
insert into HtmlLabelInfo values(2071,'���ݿ������',7) 
GO
insert into HtmlLabelInfo values(2071,'���ݿ������',8) 
GO
insert into HtmlLabelInfo values(2072,'Login name',8) 
GO
insert into HtmlLabelInfo values(2072,'�û���',7) 
GO
insert into HtmlLabelInfo values(2073,'����',7) 
GO
insert into HtmlLabelInfo values(2073,'����',8) 
GO
insert into HtmlLabelInfo values(2074,'��������',7) 
GO
insert into HtmlLabelInfo values(2074,'��������',8) 
GO
insert into HtmlLabelInfo values(2075,'Rate of motion',8) 
GO
insert into HtmlLabelInfo values(2075,'�ƶ��ٶ�',7) 
GO
insert into HtmlLabelInfo values(2076,'������ɫ',7) 
GO
insert into HtmlLabelInfo values(2076,'������ɫ',8) 
GO
insert into HtmlLabelInfo values(2077,'������ɫ',7) 
GO
insert into HtmlLabelInfo values(2077,'������ɫ',8) 
GO
insert into HtmlLabelInfo values(2078,'������ʱ��',7) 
GO
insert into HtmlLabelInfo values(2078,'������ʱ��',8) 
GO
insert into HtmlLabelInfo values(2079,'����������',7) 
GO
insert into HtmlLabelInfo values(2079,'����������',8) 
GO
insert into HtmlLabelInfo values(2080,'Recent news',8) 
GO
insert into HtmlLabelInfo values(2080,'�������',7) 
GO
insert into HtmlLabelInfo values(2081,'Favorite',8) 
GO
insert into HtmlLabelInfo values(2081,'�ղؼ�',7) 
GO
insert into HtmlLabelInfo values(2082,'Joining day',8) 
GO
insert into HtmlLabelInfo values(2082,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(2083,'Recipient',8) 
GO
insert into HtmlLabelInfo values(2083,'����',7) 
GO
insert into HtmlLabelInfo values(2084,'Copy recipient',8) 
GO
insert into HtmlLabelInfo values(2084,'����',7) 
GO
insert into HtmlLabelInfo values(2085,'Confidential recipient',8) 
GO
insert into HtmlLabelInfo values(2085,'����',7) 
GO
insert into HtmlLabelInfo values(2086,'Normal',8) 
GO
insert into HtmlLabelInfo values(2086,'��ͨ',7) 
GO
insert into HtmlLabelInfo values(2087,'Emergent',8) 
GO
insert into HtmlLabelInfo values(2087,'����',7) 
GO
insert into HtmlLabelInfo values(2088,'Not important',8) 
GO
insert into HtmlLabelInfo values(2088,'����Ҫ',7) 
GO
insert into HtmlLabelInfo values(2089,'Please separate with the English comma between multi-recipient',8) 
GO
insert into HtmlLabelInfo values(2089,'���ռ������ö��ŷָ�',7) 
GO
insert into HtmlLabelInfo values(2090,'Please separate with the English comma between multi-copy recipient',8) 
GO
insert into HtmlLabelInfo values(2090,'�೭�������ö��ŷָ�',7) 
GO
insert into HtmlLabelInfo values(2091,'Please separate with the English comma between multi-confidential recipient',8) 
GO
insert into HtmlLabelInfo values(2091,'�����������ö��ŷָ�',7) 
GO
insert into HtmlLabelInfo values(2092,'Save in outbox',8) 
GO
insert into HtmlLabelInfo values(2092,'���浽������',7) 
GO
insert into HtmlLabelInfo values(2093,'Priority',8) 
GO
insert into HtmlLabelInfo values(2093,'���ȼ���',7) 
GO
insert into HtmlLabelInfo values(2094,'Owner',8) 
GO
insert into HtmlLabelInfo values(2094,'�ĵ�������',7) 
GO
insert into HtmlLabelInfo values(2095,'Key word',8) 
GO
insert into HtmlLabelInfo values(2095,'���I��',7) 
GO
insert into HtmlLabelInfo values(2096,'Reply opinion',8) 
GO
insert into HtmlLabelInfo values(2096,'��������',7) 
GO
insert into HtmlLabelInfo values(2097,'Principal',8) 
GO
insert into HtmlLabelInfo values(2097,'������',7) 
GO
insert into HtmlLabelInfo values(2098,'Sub-task',8) 
GO
insert into HtmlLabelInfo values(2098,'������',7) 
GO
insert into HtmlLabelInfo values(2099,'Task Spread',8) 
GO
insert into HtmlLabelInfo values(2099,'����չ��',7) 
GO
insert into HtmlLabelInfo values(2100,'Save as plan',8) 
GO
insert into HtmlLabelInfo values(2100,'����Ϊ�ƻ�',7) 
GO
insert into HtmlLabelInfo values(2101,'My plans',8) 
GO
insert into HtmlLabelInfo values(2101,'�ҵļƻ�',7) 
GO
insert into HtmlLabelInfo values(2102,'My Conference',8) 
GO
insert into HtmlLabelInfo values(2102,'�ҵĻ���',7) 
GO
insert into HtmlLabelInfo values(2103,'Conference',8) 
GO
insert into HtmlLabelInfo values(2103,'����',7) 
GO
insert into HtmlLabelInfo values(2104,'Conference type',8) 
GO
insert into HtmlLabelInfo values(2104,'��������',7) 
GO
insert into HtmlLabelInfo values(2105,'Conference place',8) 
GO
insert into HtmlLabelInfo values(2105,'����ص�',7) 
GO
insert into HtmlLabelInfo values(2106,'Attending person',8) 
GO
insert into HtmlLabelInfo values(2106,'�λ���Ա',7) 
GO
insert into HtmlLabelInfo values(2107,'Conference service',8) 
GO
insert into HtmlLabelInfo values(2107,'�������',7) 
GO
insert into HtmlLabelInfo values(2108,'Receipt',8) 
GO
insert into HtmlLabelInfo values(2108,'��ִ',7) 
GO
insert into HtmlLabelInfo values(2109,'The number of record ',8) 
GO
insert into HtmlLabelInfo values(2109,'��¼��',7) 
GO
insert into HtmlLabelInfo values(2110,'Current page',8) 
GO
insert into HtmlLabelInfo values(2110,'��ǰҳ��',7) 
GO
insert into HtmlLabelInfo values(2111,'The number of record ',8) 
GO
insert into HtmlLabelInfo values(2111,'���м�¼',7) 
GO
insert into HtmlLabelInfo values(2112,'Share setting',8) 
GO
insert into HtmlLabelInfo values(2112,'��������',7) 
GO
insert into HtmlLabelInfo values(2113,'CRM',8) 
GO
insert into HtmlLabelInfo values(2113,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(2114,'Project',8) 
GO
insert into HtmlLabelInfo values(2114,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(2115,'Document',8) 
GO
insert into HtmlLabelInfo values(2115,'֪ʶ����',7) 
GO
insert into HtmlLabelInfo values(2116,'Logistics',8) 
GO
insert into HtmlLabelInfo values(2116,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(2117,'Financials',8) 
GO
insert into HtmlLabelInfo values(2117,'�������',7) 
GO
insert into HtmlLabelInfo values(2118,'Workflow',8) 
GO
insert into HtmlLabelInfo values(2118,'��������',7) 
GO
insert into HtmlLabelInfo values(2119,'Post-doctor',8) 
GO
insert into HtmlLabelInfo values(2119,'��ʿ��',7) 
GO
insert into HtmlLabelInfo values(2120,'Direct superior',8) 
GO
insert into HtmlLabelInfo values(2120,'ֱ���ϼ�',7) 
GO
insert into HtmlLabelInfo values(2121,'The detail',8) 
GO
insert into HtmlLabelInfo values(2121,'��ϸ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(2151,'Conference subject',8) 
GO
insert into HtmlLabelInfo values(2151,'��������',7) 
GO
insert into HtmlLabelInfo values(2152,'Convener ',8) 
GO
insert into HtmlLabelInfo values(2152,'�ټ���',7) 
GO
insert into HtmlLabelInfo values(2153,'Approver',8) 
GO
insert into HtmlLabelInfo values(2153,'��׼��',7) 
GO
insert into HtmlLabelInfo values(2154,'Other place',8) 
GO
insert into HtmlLabelInfo values(2154,'�����ص�',7) 
GO
insert into HtmlLabelInfo values(2155,'Service type',8) 
GO
insert into HtmlLabelInfo values(2155,'��������',7) 
GO
insert into HtmlLabelInfo values(2156,'',8) 
GO
insert into HtmlLabelInfo values(2156,'������Ա',7) 
GO
insert into HtmlLabelInfo values(2157,'Service item',8) 
GO
insert into HtmlLabelInfo values(2157,'������Ŀ',7) 
GO
insert into HtmlLabelInfo values(2158,'Please separate with the English comma between multi-items ',8) 
GO
insert into HtmlLabelInfo values(2158,'���������Ŀ֮������Ӣ�Ķ���,�ָ�',7) 
GO
insert into HtmlLabelInfo values(2159,'Compart',8) 
GO
insert into HtmlLabelInfo values(2159,'�ָ�',7) 
GO
insert into HtmlLabelInfo values(2160,'Conference receipt',8) 
GO
insert into HtmlLabelInfo values(2160,'�����ִ',7) 
GO
insert into HtmlLabelInfo values(2161,'Open',8) 
GO
insert into HtmlLabelInfo values(2161,'����',7) 
GO
insert into HtmlLabelInfo values(2162,'',8) 
GO
insert into HtmlLabelInfo values(2162,'��������',7) 
GO
insert into HtmlLabelInfo values(2163,'',8) 
GO
insert into HtmlLabelInfo values(2163,'�������',7) 
GO
insert into HtmlLabelInfo values(2164,'Small meeting room',8) 
GO
insert into HtmlLabelInfo values(2164,'С������',7) 
GO
insert into HtmlLabelInfo values(2165,'Use report of meeting room',8) 
GO
insert into HtmlLabelInfo values(2165,'�鿴������ʹ��״��',7) 
GO
insert into HtmlLabelInfo values(2166,'Number of people that should arrive',8) 
GO
insert into HtmlLabelInfo values(2166,'Ӧ������',7) 
GO
insert into HtmlLabelInfo values(2167,'Customer',8) 
GO
insert into HtmlLabelInfo values(2167,'�λ�ͻ�',7) 
GO
insert into HtmlLabelInfo values(2168,'Other attendee',8) 
GO
insert into HtmlLabelInfo values(2168,'������Ա',7) 
GO
insert into HtmlLabelInfo values(2169,'Agenda ',8) 
GO
insert into HtmlLabelInfo values(2169,'���',7) 
GO
insert into HtmlLabelInfo values(2170,'Decision summary',8) 
GO
insert into HtmlLabelInfo values(2170,'�������',7) 
GO
insert into HtmlLabelInfo values(2171,'Decision',8) 
GO
insert into HtmlLabelInfo values(2171,'����',7) 
GO
insert into HtmlLabelInfo values(2172,'Executor',8) 
GO
insert into HtmlLabelInfo values(2172,'ִ����',7) 
GO
insert into HtmlLabelInfo values(2173,'Scrutineer ',8) 
GO
insert into HtmlLabelInfo values(2173,'�����',7) 
GO
insert into HtmlLabelInfo values(2174,'First class',8) 
GO
insert into HtmlLabelInfo values(2174,'ͷ�Ȳ�',7) 
GO
insert into HtmlLabelInfo values(2175,'Business class',8) 
GO
insert into HtmlLabelInfo values(2175,'�����',7) 
GO
insert into HtmlLabelInfo values(2176,'Economy class',8) 
GO
insert into HtmlLabelInfo values(2176,'���ò�',7) 
GO
insert into HtmlLabelInfo values(2177,'Soft berth',8) 
GO
insert into HtmlLabelInfo values(2177,'����',7) 
GO
insert into HtmlLabelInfo values(2178,'Hard berth',8) 
GO
insert into HtmlLabelInfo values(2178,'Ӳ��',7) 
GO
insert into HtmlLabelInfo values(2179,'Hard seat',8) 
GO
insert into HtmlLabelInfo values(2179,'Ӳ��',7) 
GO
insert into HtmlLabelInfo values(2180,'Plane',8) 
GO
insert into HtmlLabelInfo values(2180,'�ɻ�',7) 
GO
insert into HtmlLabelInfo values(2181,'Train',8) 
GO
insert into HtmlLabelInfo values(2181,'��',7) 
GO
insert into HtmlLabelInfo values(2182,'Vehicle',8) 
GO
insert into HtmlLabelInfo values(2182,'��ͨ����',7) 
GO
insert into HtmlLabelInfo values(2183,'Return date,time',8) 
GO
insert into HtmlLabelInfo values(2183,'�س�����.ʱ��',7) 
GO
insert into HtmlLabelInfo values(2184,'Order the returen ticket',8) 
GO
insert into HtmlLabelInfo values(2184,'�Ƿ��趩�س�Ʊ',7) 
GO
insert into HtmlLabelInfo values(2185,'Reserve room(room standard)',8) 
GO
insert into HtmlLabelInfo values(2185,'�Ƿ��趩��(��׼)',7) 
GO
insert into HtmlLabelInfo values(2186,'Arriving Date,Time',8) 
GO
insert into HtmlLabelInfo values(2186,'Ԥ�Ƶ�������.ʱ��',7) 
GO
insert into HtmlLabelInfo values(2187,'Whether attend',8) 
GO
insert into HtmlLabelInfo values(2187,'�Ƿ�μ�',7) 
GO
insert into HtmlLabelInfo values(2188,'Other Attendee',8) 
GO
insert into HtmlLabelInfo values(2188,'�����˲μ�',7) 
GO
insert into HtmlLabelInfo values(2189,'Other attendee',8) 
GO
insert into HtmlLabelInfo values(2189,'�����λ���Ա',7) 
GO
insert into HtmlLabelInfo values(2190,'Finish allocating ',8) 
GO
insert into HtmlLabelInfo values(2190,'�������',7) 
GO
insert into HtmlLabelInfo values(2191,'Adjust',8) 
GO
insert into HtmlLabelInfo values(2191,'����',7) 
GO
insert into HtmlLabelInfo values(2192,'Arrange Schedule',8) 
GO
insert into HtmlLabelInfo values(2192,'�ճ̰���',7) 
GO
insert into HtmlLabelInfo values(2193,'Use report of meeting room',8) 
GO
insert into HtmlLabelInfo values(2193,'�鿴������ʹ�����',7) 
GO
insert into HtmlLabelInfo values(2194,'Conference decision',8) 
GO
insert into HtmlLabelInfo values(2194,'�������',7) 
GO
insert into HtmlLabelInfo values(2195,'Attend',8) 
GO
insert into HtmlLabelInfo values(2195,'�μ�',7) 
GO
insert into HtmlLabelInfo values(2196,'Arriving time',8) 
GO
insert into HtmlLabelInfo values(2196,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(2197,'Reserve room',8) 
GO
insert into HtmlLabelInfo values(2197,'����',7) 
GO
insert into HtmlLabelInfo values(2198,'Room standard',8) 
GO
insert into HtmlLabelInfo values(2198,'������׼',7) 
GO
insert into HtmlLabelInfo values(2199,'Order the returen ticket',8) 
GO
insert into HtmlLabelInfo values(2199,'���س�Ʊ',7) 
GO
insert into HtmlLabelInfo values(2200,'Time of return',8) 
GO
insert into HtmlLabelInfo values(2200,'�س�ʱ��',7) 
GO
insert into HtmlLabelInfo values(2201,'Plane first class ',8) 
GO
insert into HtmlLabelInfo values(2201,'�ɻ�ͷ�Ȳ�',7) 
GO
insert into HtmlLabelInfo values(2202,'Plane business class',8) 
GO
insert into HtmlLabelInfo values(2202,'�ɻ������',7) 
GO
insert into HtmlLabelInfo values(2203,'Plane economy class',8) 
GO
insert into HtmlLabelInfo values(2203,'�ɻ����ò�',7) 
GO
insert into HtmlLabelInfo values(2204,'Train soft berth',8) 
GO
insert into HtmlLabelInfo values(2204,'������',7) 
GO
insert into HtmlLabelInfo values(2205,'Train hard berth',8) 
GO
insert into HtmlLabelInfo values(2205,'��Ӳ��',7) 
GO
insert into HtmlLabelInfo values(2206,'Train hard seat',8) 
GO
insert into HtmlLabelInfo values(2206,'��Ӳ��',7) 
GO
insert into HtmlLabelInfo values(2207,'The confirmed number of people',8) 
GO
insert into HtmlLabelInfo values(2207,'��ȷ���λ���Ա�ܼ�',7) 
GO
insert into HtmlLabelInfo values(2208,'Company staff ',8) 
GO
insert into HtmlLabelInfo values(2208,'���й�˾Ա��',7) 
GO
insert into HtmlLabelInfo values(2209,'Outside Personnel',8) 
GO
insert into HtmlLabelInfo values(2209,'�ⲿ��Ա',7) 
GO
insert into HtmlLabelInfo values(2210,'Tidy',8) 
GO
insert into HtmlLabelInfo values(2210,'����',7) 
GO
insert into HtmlLabelInfo values(2211,'Schedule ',8) 
GO
insert into HtmlLabelInfo values(2211,'�ճ�',7) 
GO
insert into HtmlLabelInfo values(2212,'Data',8) 
GO
insert into HtmlLabelInfo values(2212,'����',7) 
GO
insert into HtmlLabelInfo values(2213,'Realized',8) 
GO
insert into HtmlLabelInfo values(2213,'��ʵ��',7) 
GO
insert into HtmlLabelInfo values(2214,'',8) 
GO
insert into HtmlLabelInfo values(2214,'��������˰˰�ʱ�',7) 
GO
insert into HtmlLabelInfo values(2215,'',8) 
GO
insert into HtmlLabelInfo values(2215,'���շ���',7) 
GO
insert into HtmlLabelInfo values(2216,'',8) 
GO
insert into HtmlLabelInfo values(2216,'��׼�ȼ�',7) 
GO
insert into HtmlLabelInfo values(2217,'',8) 
GO
insert into HtmlLabelInfo values(2217,'������Ŀ��',7) 
GO
insert into HtmlLabelInfo values(2218,'',8) 
GO
insert into HtmlLabelInfo values(2218,'���˹�������',7) 
GO
insert into HtmlLabelInfo values(2219,'',8) 
GO
insert into HtmlLabelInfo values(2219,'���˹��ʱ䶯��ʷ��¼',7) 
GO
insert into HtmlLabelInfo values(2220,'',8) 
GO
insert into HtmlLabelInfo values(2220,'���ŷ���',7) 
GO
insert into HtmlLabelInfo values(2221,'',8) 
GO
insert into HtmlLabelInfo values(2221,'���ŷ������',7) 
GO
insert into HtmlLabelInfo values(2222,'',8) 
GO
insert into HtmlLabelInfo values(2222,'���ŷ������-�û��Ա����ͳ��',7) 
GO
insert into HtmlLabelInfo values(2223,'',8) 
GO
insert into HtmlLabelInfo values(2223,'���ŷ������-ϵͳ���Ͷ���ͳ��',7) 
GO
insert into HtmlLabelInfo values(2224,'',8) 
GO
insert into HtmlLabelInfo values(2224,'����ְԱ��',7) 
GO
insert into HtmlLabelInfo values(2225,'',8) 
GO
insert into HtmlLabelInfo values(2225,'��ְ��Ŀ��',7) 
GO
insert into HtmlLabelInfo values(2226,'',8) 
GO
insert into HtmlLabelInfo values(2226,'����ְԱ����Ŀ����',7) 
GO
insert into HtmlLabelInfo values(2227,'',8) 
GO
insert into HtmlLabelInfo values(2227,'���ۻ���',7) 
GO
insert into HtmlLabelInfo values(2228,'',8) 
GO
insert into HtmlLabelInfo values(2228,'��Ŀ״̬������',7) 
GO
insert into HtmlLabelInfo values(2229,'',8) 
GO
insert into HtmlLabelInfo values(2229,'��Ŀ״̬������',7) 
GO
insert into HtmlLabelInfo values(2230,'',8) 
GO
insert into HtmlLabelInfo values(2230,'��Ŀ״̬�����',7) 
GO
insert into HtmlLabelInfo values(2231,'',8) 
GO
insert into HtmlLabelInfo values(2231,'��Ŀ״̬������',7) 
GO
insert into HtmlLabelInfo values(2232,'',8) 
GO
insert into HtmlLabelInfo values(2232,'��̱�����',7) 
GO
insert into HtmlLabelInfo values(2233,'',8) 
GO
insert into HtmlLabelInfo values(2233,'ǰ������',7) 
GO
insert into HtmlLabelInfo values(2234,'',8) 
GO
insert into HtmlLabelInfo values(2234,'��������״̬',7) 
GO
insert into HtmlLabelInfo values(2235,'',8) 
GO
insert into HtmlLabelInfo values(2235,'δ��׼',7) 
GO
insert into HtmlLabelInfo values(2236,'',8) 
GO
insert into HtmlLabelInfo values(2236,'�Ѿ�����',7) 
GO
insert into HtmlLabelInfo values(2237,'',8) 
GO
insert into HtmlLabelInfo values(2237,'����ͼ��',7) 
GO
insert into HtmlLabelInfo values(2238,'',8) 
GO
insert into HtmlLabelInfo values(2238,'������/�ĵ�',7) 
GO
insert into HtmlLabelInfo values(2239,'',8) 
GO
insert into HtmlLabelInfo values(2239,'�������',7) 
GO
insert into HtmlLabelInfo values(2240,'',8) 
GO
insert into HtmlLabelInfo values(2240,'����˵��',7) 
GO
insert into HtmlLabelInfo values(2241,'',8) 
GO
insert into HtmlLabelInfo values(2241,'ȫ��ѡ��',7) 
GO
insert into HtmlLabelInfo values(2242,'',8) 
GO
insert into HtmlLabelInfo values(2242,'������',7) 
GO
insert into HtmlLabelInfo values(2243,'',8) 
GO
insert into HtmlLabelInfo values(2243,'������׼',7) 
GO
insert into HtmlLabelInfo values(2244,'',8) 
GO
insert into HtmlLabelInfo values(2244,'����',7) 
GO
insert into HtmlLabelInfo values(2245,'',8) 
GO
insert into HtmlLabelInfo values(2245,'��Ч',7) 
GO
insert into HtmlLabelInfo values(2246,'',8) 
GO
insert into HtmlLabelInfo values(2246,'��Ч',7) 
GO
insert into HtmlLabelInfo values(2247,'',8) 
GO
insert into HtmlLabelInfo values(2247,'����Ԥ��',7) 
GO
insert into HtmlLabelInfo values(2248,'',8) 
GO
insert into HtmlLabelInfo values(2248,'Ԥ������',7) 
GO
insert into HtmlLabelInfo values(2249,'',8) 
GO
insert into HtmlLabelInfo values(2249,'������',7) 
GO
insert into HtmlLabelInfo values(2250,'',8) 
GO
insert into HtmlLabelInfo values(2250,'����״̬',7) 
GO
insert into HtmlLabelInfo values(2251,'',8) 
GO
insert into HtmlLabelInfo values(2251,'�鿴����ؽ���',7) 
GO
insert into HtmlLabelInfo values(2252,'',8) 
GO
insert into HtmlLabelInfo values(2252,'�ɹ��ؼ�����',7) 
GO
insert into HtmlLabelInfo values(2253,'',8) 
GO
insert into HtmlLabelInfo values(2253,'ʧ�ܹؼ�����',7) 
GO
insert into HtmlLabelInfo values(3000,'File Date',8) 
GO
insert into HtmlLabelInfo values(3000,'�鵵����',7) 
GO
insert into HtmlLabelInfo values(3001,'The last approver',8) 
GO
insert into HtmlLabelInfo values(3001,'���������',7) 
GO
insert into HtmlLabelInfo values(3002,'The last modifier',8) 
GO
insert into HtmlLabelInfo values(3002,'����޸���',7) 
GO
insert into HtmlLabelInfo values(3003,'Saver',8) 
GO
insert into HtmlLabelInfo values(3003,'�鵵��',7) 
GO
insert into HtmlLabelInfo values(3004,'Doc.Checkup Workflow',8) 
GO
insert into HtmlLabelInfo values(3004,'�ĵ�������������',7) 
GO
insert into HtmlLabelInfo values(3005,'Share Level',8) 
GO
insert into HtmlLabelInfo values(3005,'������',7) 
GO
insert into HtmlLabelInfo values(5000,'weather forcast',8) 
GO
insert into HtmlLabelInfo values(5000,'����Ԥ��',7) 
GO
insert into HtmlLabelInfo values(5001,'Temperature',8) 
GO
insert into HtmlLabelInfo values(5001,'�¶�',7) 
GO
insert into HtmlLabelInfo values(6001,'The next grade',8) 
GO
insert into HtmlLabelInfo values(6001,'��һ��',7) 
GO
insert into HtmlLabelInfo values(6002,'��ʾ��Ŀ',7) 
GO
insert into HtmlLabelInfo values(6002,'��ʾ��Ŀ',8) 
GO
insert into HtmlLabelInfo values(6003,'����������',7) 
GO
insert into HtmlLabelInfo values(6003,'����������',8) 
GO
insert into HtmlLabelInfo values(6004,'���µ�֪ͨ���淢��',7) 
GO
insert into HtmlLabelInfo values(6004,'���µ�֪ͨ���淢��',8) 
GO
insert into HtmlLabelInfo values(6005,'�ֻ�',7) 
GO
insert into HtmlLabelInfo values(6005,'�ֻ�',8) 
GO
insert into HtmlLabelInfo values(6006,'No new notice now',8) 
GO
insert into HtmlLabelInfo values(6006,'�����µĹ��淢��',7) 
GO
insert into HtmlLabelInfo values(6007,'New Notice',8) 
GO
insert into HtmlLabelInfo values(6007,'�µĹ���',7) 
GO
insert into HtmlLabelInfo values(6008,'Secretary',8) 
GO
insert into HtmlLabelInfo values(6008,'����',7) 
GO
insert into HtmlLabelInfo values(6009,'Discuss',8) 
GO
insert into HtmlLabelInfo values(6009,'���۽���',7) 
GO
insert into HtmlLabelInfo values(6010,'Accepter',8) 
GO
insert into HtmlLabelInfo values(6010,'������',7) 
GO
insert into HtmlLabelInfo values(6011,'Forward',8) 
GO
insert into HtmlLabelInfo values(6011,'ת��',7) 
GO
insert into HtmlLabelInfo values(6012,'Need law department to verify',8) 
GO
insert into HtmlLabelInfo values(6012,'�Ƿ��跨�ɲ����',7) 
GO
insert into HtmlLabelInfo values(6013,'President',8) 
GO
insert into HtmlLabelInfo values(6013,'�ܲ�',7) 
GO
insert into HtmlLabelInfo values(6014,'Expense Type',8) 
GO
insert into HtmlLabelInfo values(6014,'������ʽ',7) 
GO
insert into HtmlLabelInfo values(6015,'My report',8) 
GO
insert into HtmlLabelInfo values(6015,'�ҵı���',7) 
GO
insert into HtmlLabelInfo values(6016,'ʵ�����',7) 
GO
insert into HtmlLabelInfo values(6016,'real amount',8) 
GO
insert into HtmlLabelInfo values(6050,'�ʲ��������',7) 
GO
insert into HtmlLabelInfo values(6050,'',8) 
GO
insert into HtmlLabelInfo values(6051,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(6051,'',8) 
GO
insert into HtmlLabelInfo values(6052,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(6052,'',8) 
GO
insert into HtmlLabelInfo values(6053,'�ʲ�ά��',7) 
GO
insert into HtmlLabelInfo values(6053,'',8) 
GO
insert into HtmlLabelInfo values(6054,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(6054,'',8) 
GO
insert into HtmlLabelInfo values(6055,'�ʲ����',7) 
GO
insert into HtmlLabelInfo values(6055,'',8) 
GO
insert into HtmlLabelInfo values(6056,'ԭֵ',7) 
GO
insert into HtmlLabelInfo values(6056,'',8) 
GO
insert into HtmlLabelInfo values(6057,'���չ���',7) 
GO
insert into HtmlLabelInfo values(6057,'',8) 
GO
insert into HtmlLabelInfo values(6058,'�鿴�����Ĺ�������',7) 
GO
insert into HtmlLabelInfo values(6058,'',8) 
GO
insert into HtmlLabelInfo values(6059,'�ҵĿͻ�',7) 
GO
insert into HtmlLabelInfo values(6059,'',8) 
GO
insert into HtmlLabelInfo values(6060,'�鿴�����Ŀͻ�',7) 
GO
insert into HtmlLabelInfo values(6060,'',8) 
GO
insert into HtmlLabelInfo values(6061,'�ͻ���ϵ����',7) 
GO
insert into HtmlLabelInfo values(6061,'',8) 
GO
insert into HtmlLabelInfo values(6062,'��ҳ����',7) 
GO
insert into HtmlLabelInfo values(6062,'',8) 
GO
insert into HtmlLabelInfo values(6063,'����->��Ч�ͻ�',7) 
GO
insert into HtmlLabelInfo values(6063,'',8) 
GO
insert into HtmlLabelInfo values(6064,'����->�����ͻ�',7) 
GO
insert into HtmlLabelInfo values(6064,'',8) 
GO
insert into HtmlLabelInfo values(6066,'��Ȥ',7) 
GO
insert into HtmlLabelInfo values(6066,'',8) 
GO
insert into HtmlLabelInfo values(6067,'����',7) 
GO
insert into HtmlLabelInfo values(6067,'',8) 
GO
insert into HtmlLabelInfo values(6068,'ר��',7) 
GO
insert into HtmlLabelInfo values(6068,'',8) 
GO
insert into HtmlLabelInfo values(6069,'��������',7) 
GO
insert into HtmlLabelInfo values(6069,'',8) 
GO
insert into HtmlLabelInfo values(6070,'�ͻ���ֵ����',7) 
GO
insert into HtmlLabelInfo values(6070,'',8) 
GO
insert into HtmlLabelInfo values(6071,'Ȩ��',7) 
GO
insert into HtmlLabelInfo values(6071,'',8) 
GO
insert into HtmlLabelInfo values(6072,'���',7) 
GO
insert into HtmlLabelInfo values(6072,'',8) 
GO
insert into HtmlLabelInfo values(6073,'�ͻ���ֵ',7) 
GO
insert into HtmlLabelInfo values(6073,'',8) 
GO
insert into HtmlLabelInfo values(6074,'��',7) 
GO
insert into HtmlLabelInfo values(6074,'',8) 
GO
insert into HtmlLabelInfo values(6076,'��',7) 
GO
insert into HtmlLabelInfo values(6076,'',8) 
GO
insert into HtmlLabelInfo values(6077,'��ǰʱ��',7) 
GO
insert into HtmlLabelInfo values(6077,'',8) 
GO
insert into HtmlLabelInfo values(6078,'�Ƿ�����',7) 
GO
insert into HtmlLabelInfo values(6078,'',8) 
GO
insert into HtmlLabelInfo values(6079,'�ͻ��ػ�',7) 
GO
insert into HtmlLabelInfo values(6079,'',8) 
GO
insert into HtmlLabelInfo values(6080,'�ͻ�Ͷ��',7) 
GO
insert into HtmlLabelInfo values(6080,'',8) 
GO
insert into HtmlLabelInfo values(6081,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(6081,'',8) 
GO
insert into HtmlLabelInfo values(6082,'�ͻ���ϵ',7) 
GO
insert into HtmlLabelInfo values(6082,'',8) 
GO
insert into HtmlLabelInfo values(6083,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(6083,'',8) 
GO
insert into HtmlLabelInfo values(6084,'�ֳɱ�����',7) 
GO
insert into HtmlLabelInfo values(6086,'��λ',7) 
GO
insert into HtmlLabelInfo values(6087,'����',7) 
GO
insert into HtmlLabelInfo values(6087,'Personal',8) 
GO
insert into HtmlLabelInfo values(6088,'ת��',7) 
GO
insert into HtmlLabelInfo values(6088,'Hire',8) 
GO
insert into HtmlLabelInfo values(6089,'��ǩ',7) 
GO
insert into HtmlLabelInfo values(6089,'Extend',8) 
GO
insert into HtmlLabelInfo values(6090,'����',7) 
GO
insert into HtmlLabelInfo values(6090,'Redeploy',8) 
GO
insert into HtmlLabelInfo values(6091,'��ְ',7) 
GO
insert into HtmlLabelInfo values(6091,'Dismiss',8) 
GO
insert into HtmlLabelInfo values(6092,'����',7) 
GO
insert into HtmlLabelInfo values(6092,'Retire',8) 
GO
insert into HtmlLabelInfo values(6093,'��Ƹ',7) 
GO
insert into HtmlLabelInfo values(6093,'Rehire',8) 
GO
insert into HtmlLabelInfo values(6094,'��Ƹ',7) 
GO
insert into HtmlLabelInfo values(6094,'Fire',8) 
GO
insert into HtmlLabelInfo values(6095,'ǩ��',7) 
GO
insert into HtmlLabelInfo values(6095,'',8) 
GO
insert into HtmlLabelInfo values(6096,'�ܳɱ�����',7) 
GO
insert into HtmlLabelInfo values(6097,'���ö��',7) 
GO
insert into HtmlLabelInfo values(6097,'',8) 
GO
insert into HtmlLabelInfo values(6098,'�����ڼ�',7) 
GO
insert into HtmlLabelInfo values(6098,'',8) 
GO
insert into HtmlLabelInfo values(6099,'��������',7) 
GO
insert into HtmlLabelInfo values(6099,'',8) 
GO
insert into HtmlLabelInfo values(6100,'���͹���',7) 
GO
insert into HtmlLabelInfo values(6100,'',8) 
GO
insert into HtmlLabelInfo values(6101,'�滮',7) 
GO
insert into HtmlLabelInfo values(6101,'Layout',8) 
GO
insert into HtmlLabelInfo values(6102,'����',7) 
GO
insert into HtmlLabelInfo values(6102,'Assess',8) 
GO
insert into HtmlLabelInfo values(6103,'����',7) 
GO
insert into HtmlLabelInfo values(6103,'Plan',8) 
GO
insert into HtmlLabelInfo values(6104,'������Χ',7) 
GO
insert into HtmlLabelInfo values(6104,'OpenRange',8) 
GO
insert into HtmlLabelInfo values(6105,'��Դ',7) 
GO
insert into HtmlLabelInfo values(6105,'Resource',8) 
GO
insert into HtmlLabelInfo values(6106,'����',7) 
GO
insert into HtmlLabelInfo values(6106,'Test',8) 
GO
insert into HtmlLabelInfo values(6107,'��������',7) 
GO
insert into HtmlLabelInfo values(6107,'',8) 
GO
insert into HtmlLabelInfo values(6109,'��������',7) 
GO
insert into HtmlLabelInfo values(6109,'',8) 
GO
insert into HtmlLabelInfo values(6110,'ְλ����',7) 
GO
insert into HtmlLabelInfo values(6110,'',8) 
GO
insert into HtmlLabelInfo values(6111,'��������',7) 
GO
insert into HtmlLabelInfo values(6111,'',8) 
GO
insert into HtmlLabelInfo values(6112,'ԭ��λ',7) 
GO
insert into HtmlLabelInfo values(6112,'',8) 
GO
insert into HtmlLabelInfo values(6113,'�¸�λ',7) 
GO
insert into HtmlLabelInfo values(6113,'',8) 
GO
insert into HtmlLabelInfo values(6114,'ԭְ��',7) 
GO
insert into HtmlLabelInfo values(6114,'',8) 
GO
insert into HtmlLabelInfo values(6115,'��ְ��',7) 
GO
insert into HtmlLabelInfo values(6115,'',8) 
GO
insert into HtmlLabelInfo values(6116,'����ԭ��',7) 
GO
insert into HtmlLabelInfo values(6116,'',8) 
GO
insert into HtmlLabelInfo values(6119,'��ְ����',7) 
GO
insert into HtmlLabelInfo values(6119,'',8) 
GO
insert into HtmlLabelInfo values(6120,'��ְ��ͬ',7) 
GO
insert into HtmlLabelInfo values(6120,'',8) 
GO
insert into HtmlLabelInfo values(6121,'ת������',7) 
GO
insert into HtmlLabelInfo values(6121,'',8) 
GO
insert into HtmlLabelInfo values(6122,'ת������',7) 
GO
insert into HtmlLabelInfo values(6122,'',8) 
GO
insert into HtmlLabelInfo values(6123,'ת����ע',7) 
GO
insert into HtmlLabelInfo values(6123,'',8) 
GO
insert into HtmlLabelInfo values(6124,'����ʵʩ',7) 
GO
insert into HtmlLabelInfo values(6124,'',8) 
GO
insert into HtmlLabelInfo values(6125,'���˱���',7) 
GO
insert into HtmlLabelInfo values(6125,'',8) 
GO
insert into HtmlLabelInfo values(6126,'',8) 
GO
insert into HtmlLabelInfo values(6126,'ʵ���ܽ��',7) 
GO
insert into HtmlLabelInfo values(6128,'��ѵ�滮',7) 
GO
insert into HtmlLabelInfo values(6128,'TrainLayout',8) 
GO
insert into HtmlLabelInfo values(6130,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(6130,'TrainType',8) 
GO
insert into HtmlLabelInfo values(6131,'�ù�����',7) 
GO
insert into HtmlLabelInfo values(6131,'UseDemand',8) 
GO
insert into HtmlLabelInfo values(6132,'��Ƹ�ƻ�',7) 
GO
insert into HtmlLabelInfo values(6132,'CareerPlan',8) 
GO
insert into HtmlLabelInfo values(6133,'��Ƹ����',7) 
GO
insert into HtmlLabelInfo values(6133,'CareerManage',8) 
GO
insert into HtmlLabelInfo values(6134,'����',7) 
GO
insert into HtmlLabelInfo values(6134,'Interview',8) 
GO
insert into HtmlLabelInfo values(6135,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(6135,'FinishInfo',8) 
GO
insert into HtmlLabelInfo values(6136,'��ѵ�',7) 
GO
insert into HtmlLabelInfo values(6136,'Train',8) 
GO
insert into HtmlLabelInfo values(6137,'��ְά��',7) 
GO
insert into HtmlLabelInfo values(6137,'HrmInfoMaintenance',8) 
GO
insert into HtmlLabelInfo values(6138,'����ά��',7) 
GO
insert into HtmlLabelInfo values(6138,'ScheduleMaintance',8) 
GO
insert into HtmlLabelInfo values(6139,'��������',7) 
GO
insert into HtmlLabelInfo values(6139,'ScheduleDiffType',8) 
GO
insert into HtmlLabelInfo values(6140,'������Դ����',7) 
GO
insert into HtmlLabelInfo values(6140,'HrmResourceSchedule',8) 
GO
insert into HtmlLabelInfo values(6150,'��������',7) 
GO
insert into HtmlLabelInfo values(6150,'',8) 
GO
insert into HtmlLabelInfo values(6151,'�Ӱ�',7) 
GO
insert into HtmlLabelInfo values(6151,'',8) 
GO
insert into HtmlLabelInfo values(6152,'����',7) 
GO
insert into HtmlLabelInfo values(6152,'',8) 
GO
insert into HtmlLabelInfo values(6153,'��λʱ��',7) 
GO
insert into HtmlLabelInfo values(6153,'',8) 
GO
insert into HtmlLabelInfo values(6155,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(6155,'',8) 
GO
insert into HtmlLabelInfo values(6156,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(6156,'',8) 
GO
insert into HtmlLabelInfo values(6157,'�Ƿ��������û�׼����',7) 
GO
insert into HtmlLabelInfo values(6157,'',8) 
GO
insert into HtmlLabelInfo values(6158,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(6158,'HrmContractType',8) 
GO
insert into HtmlLabelInfo values(6159,'�Ӱ�����',7) 
GO
insert into HtmlLabelInfo values(6159,'',8) 
GO
insert into HtmlLabelInfo values(6160,'ҵ���ͬ',7) 
GO
insert into HtmlLabelInfo values(6160,'',8) 
GO
insert into HtmlLabelInfo values(6161,'��غ�ͬ',7) 
GO
insert into HtmlLabelInfo values(6161,'',8) 
GO
insert into HtmlLabelInfo values(6162,'��ͬ�ĵ�',7) 
GO
insert into HtmlLabelInfo values(6162,'',8) 
GO
insert into HtmlLabelInfo values(6163,'���ĵ�',7) 
GO
insert into HtmlLabelInfo values(6163,'',8) 
GO
insert into HtmlLabelInfo values(6164,'��ǩ��',7) 
GO
insert into HtmlLabelInfo values(6164,'',8) 
GO
insert into HtmlLabelInfo values(6165,'���ø���',7) 
GO
insert into HtmlLabelInfo values(6165,'',8) 
GO
insert into HtmlLabelInfo values(7014,'����ʵʩ',7) 
GO
insert into HtmlLabelInfo values(7014,'',8) 
GO
insert into HtmlLabelInfo values(7015,'���Ϳ���',7) 
GO
insert into HtmlLabelInfo values(7015,'',8) 
GO
insert into HtmlLabelInfo values(6117,'������Ŀ',7) 
GO
insert into HtmlLabelInfo values(6117,'',8) 
GO
insert into HtmlLabelInfo values(6118,'��������',7) 
GO
insert into HtmlLabelInfo values(6118,'',8) 
GO
insert into HtmlLabelInfo values(7172,'���ͱ���',7) 
GO
insert into HtmlLabelInfo values(7172,'',8) 
GO
insert into HtmlLabelInfo values(7173,'������Աͳ��',7) 
GO
insert into HtmlLabelInfo values(7173,'',8) 
GO
insert into HtmlLabelInfo values(7174,'��������ͼ',7) 
GO
insert into HtmlLabelInfo values(7174,'',8) 
GO
insert into HtmlLabelInfo values(7171,'��΢�������',7) 
GO
insert into HtmlLabelInfo values(7171,'weaverPlugin_download',8) 
GO
insert into HtmlLabelInfo values(7175,'���ţ���ȫ����',7) 
GO
insert into HtmlLabelInfo values(7175,'department+security level',8) 
GO
insert into HtmlLabelInfo values(7176,'��ɫ����ȫ���𣫼���',7) 
GO
insert into HtmlLabelInfo values(7176,'role+security level+role level',8) 
GO
insert into HtmlLabelInfo values(7177,'��ȫ����',7) 
GO
insert into HtmlLabelInfo values(7177,'security level',8) 
GO
insert into HtmlLabelInfo values(7178,'�û����ͣ���ȫ����',7) 
GO
insert into HtmlLabelInfo values(7178,'usertype+security level',8) 
GO
insert into HtmlLabelInfo values(7179,'�û�����',7) 
GO
insert into HtmlLabelInfo values(7179,'usertype',8) 
GO
insert into HtmlLabelInfo values(7180,'��ʱ��',7) 
GO
insert into HtmlLabelInfo values(7180,'',8) 
GO
insert into HtmlLabelInfo values(7181,'�ⲿϵͳ�û�',7) 
GO
insert into HtmlLabelInfo values(7181,'OtherSystemUser',8) 
GO
insert into HtmlLabelInfo values(6141,'''',8) 
GO
insert into HtmlLabelInfo values(6146,'''',8) 
GO
insert into HtmlLabelInfo values(6141,'���벿��',7) 
GO
insert into HtmlLabelInfo values(6141,'',8) 
GO
insert into HtmlLabelInfo values(6146,'��ͬ���',7) 
GO
insert into HtmlLabelInfo values(6146,'',8) 
GO
insert into HtmlLabelInfo values(6141,'���벿��',7) 
GO
insert into HtmlLabelInfo values(6141,'',8) 
GO
insert into HtmlLabelInfo values(6146,'��ͬ���',7) 
GO
insert into HtmlLabelInfo values(6146,'',8) 
GO
insert into HtmlLabelInfo values(6166,'��ز�Ʒ',7) 
GO
insert into HtmlLabelInfo values(6166,'',8) 
GO
insert into HtmlLabelInfo values(6166,'��ز�Ʒ',7) 
GO
insert into HtmlLabelInfo values(6166,'',8) 
GO
insert into HtmlLabelInfo values(6167,'�¹����ܽ���ƻ�',7) 
GO
insert into HtmlLabelInfo values(6167,'',8) 
GO
insert into HtmlLabelInfo values(16350,'ͬ������',7) 
GO
insert into HtmlLabelInfo values(16350,'',8) 
GO
insert into HtmlLabelInfo values(16351,'�˻�����ִ��',7) 
GO
insert into HtmlLabelInfo values(16351,'',8) 
GO
insert into HtmlLabelInfo values(16352,'���ƹ�������ͼ',7) 
GO
insert into HtmlLabelInfo values(16352,'',8) 
GO
insert into HtmlLabelInfo values(16353,'�Ѳ�����',7) 
GO
insert into HtmlLabelInfo values(16353,'',8) 
GO
insert into HtmlLabelInfo values(16354,'δ������',7) 
GO
insert into HtmlLabelInfo values(16354,'',8) 
GO
insert into HtmlLabelInfo values(16355,'�鿴��',7) 
GO
insert into HtmlLabelInfo values(16355,'',8) 
GO
insert into HtmlLabelInfo values(16356,'��������',7) 
GO
insert into HtmlLabelInfo values(16356,'',8) 
GO
insert into HtmlLabelInfo values(15000,'�ⲿϵͳ�ӿ�',7) 
GO
insert into HtmlLabelInfo values(15000,'',8) 
GO
insert into HtmlLabelInfo values(15001,'������',7) 
GO
insert into HtmlLabelInfo values(15001,'',8) 
GO
insert into HtmlLabelInfo values(15002,'����ϵͳ',7) 
GO
insert into HtmlLabelInfo values(15002,'',8) 
GO
insert into HtmlLabelInfo values(15003,'�½�����',7) 
GO
insert into HtmlLabelInfo values(15003,'',8) 
GO
insert into HtmlLabelInfo values(15004,'�½�����',7) 
GO
insert into HtmlLabelInfo values(15004,'',8) 
GO
insert into HtmlLabelInfo values(15005,'�½���Ա',7) 
GO
insert into HtmlLabelInfo values(15005,'',8) 
GO
insert into HtmlLabelInfo values(15006,'�½��ͻ�',7) 
GO
insert into HtmlLabelInfo values(15006,'',8) 
GO
insert into HtmlLabelInfo values(15007,'�½���Ŀ',7) 
GO
insert into HtmlLabelInfo values(15007,'',8) 
GO
insert into HtmlLabelInfo values(15008,'�½�����',7) 
GO
insert into HtmlLabelInfo values(15008,'',8) 
GO
insert into HtmlLabelInfo values(15009,'�½��ʲ�',7) 
GO
insert into HtmlLabelInfo values(15009,'',8) 
GO
insert into HtmlLabelInfo values(15010,'�ҵĹ�������',7) 
GO
insert into HtmlLabelInfo values(15010,'',8) 
GO
insert into HtmlLabelInfo values(15011,'֪ʶ�ĵ�',7) 
GO
insert into HtmlLabelInfo values(15011,'',8) 
GO
insert into HtmlLabelInfo values(15012,'ϵͳ����',7) 
GO
insert into HtmlLabelInfo values(15012,'',8) 
GO
insert into HtmlLabelInfo values(15013,'ƪ�ĵ�',7) 
GO
insert into HtmlLabelInfo values(15013,'',8) 
GO
insert into HtmlLabelInfo values(15014,'������',7) 
GO
insert into HtmlLabelInfo values(15014,'',8) 
GO
insert into HtmlLabelInfo values(15015,'ƪ',7) 
GO
insert into HtmlLabelInfo values(15015,'',8) 
GO
insert into HtmlLabelInfo values(15016,'����δ��',7) 
GO
insert into HtmlLabelInfo values(15016,'',8) 
GO
insert into HtmlLabelInfo values(15017,'�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�',7) 
GO
insert into HtmlLabelInfo values(15017,'',8) 
GO
insert into HtmlLabelInfo values(15018,'licence�ļ�',7) 
GO
insert into HtmlLabelInfo values(15018,'',8) 
GO
insert into HtmlLabelInfo values(15019,'ʶ����',7) 
GO
insert into HtmlLabelInfo values(15019,'',8) 
GO
insert into HtmlLabelInfo values(15020,'�ᡡʾ',7) 
GO
insert into HtmlLabelInfo values(15020,'',8) 
GO
insert into HtmlLabelInfo values(15021,'�뽫',7) 
GO
insert into HtmlLabelInfo values(15021,'',8) 
GO
insert into HtmlLabelInfo values(15022,'��',7) 
GO
insert into HtmlLabelInfo values(15022,'',8) 
GO
insert into HtmlLabelInfo values(15023,'�ύ�������Ӧ��,�Ի�ȡLicense',7) 
GO
insert into HtmlLabelInfo values(15023,'',8) 
GO
insert into HtmlLabelInfo values(15024,'���ݿ�',7) 
GO
insert into HtmlLabelInfo values(15024,'',8) 
GO
insert into HtmlLabelInfo values(15025,'���ݿ�����',7) 
GO
insert into HtmlLabelInfo values(15025,'',8) 
GO
insert into HtmlLabelInfo values(15026,'���ݿ�����',7) 
GO
insert into HtmlLabelInfo values(15026,'',8) 
GO
insert into HtmlLabelInfo values(15027,'ʹ���������ݿ�',7) 
GO
insert into HtmlLabelInfo values(15027,'',8) 
GO
insert into HtmlLabelInfo values(15028,'�������',7) 
GO
insert into HtmlLabelInfo values(15028,'',8) 
GO
insert into HtmlLabelInfo values(15029,'�û���',7) 
GO
insert into HtmlLabelInfo values(15029,'',8) 
GO
insert into HtmlLabelInfo values(15030,'��Ч��',7) 
GO
insert into HtmlLabelInfo values(15030,'',8) 
GO
insert into HtmlLabelInfo values(15031,'�����µĹ�������Ҫ����',7) 
GO
insert into HtmlLabelInfo values(15031,'',8) 
GO
insert into HtmlLabelInfo values(15032,'�������Ĺ������Ѿ����',7) 
GO
insert into HtmlLabelInfo values(15032,'',8) 
GO
insert into HtmlLabelInfo values(15033,'�رմ���',7) 
GO
insert into HtmlLabelInfo values(15033,'',8) 
GO
insert into HtmlLabelInfo values(15034,'�������ڴ�����',7) 
GO
insert into HtmlLabelInfo values(15034,'',8) 
GO
insert into HtmlLabelInfo values(15035,'�������ڲ鿴��',7) 
GO
insert into HtmlLabelInfo values(15035,'',8) 
GO
insert into HtmlLabelInfo values(15036,'���յ����ѹ�����',7) 
GO
insert into HtmlLabelInfo values(15036,'',8) 
GO
insert into HtmlLabelInfo values(15037,'�ʼ�ϵͳ����',7) 
GO
insert into HtmlLabelInfo values(15037,'',8) 
GO
insert into HtmlLabelInfo values(15038,'������',7) 
GO
insert into HtmlLabelInfo values(15038,'',8) 
GO
insert into HtmlLabelInfo values(15039,'�Ƿ���Ҫ������֤',7) 
GO
insert into HtmlLabelInfo values(15039,'',8) 
GO
insert into HtmlLabelInfo values(15040,'Ⱥ��SMTP������',7) 
GO
insert into HtmlLabelInfo values(15040,'',8) 
GO
insert into HtmlLabelInfo values(15041,'Ⱥ��Ĭ�Ϸ����˵�ַ',7) 
GO
insert into HtmlLabelInfo values(15041,'',8) 
GO
insert into HtmlLabelInfo values(15042,'Ⱥ��Ĭ����֤�û���',7) 
GO
insert into HtmlLabelInfo values(15042,'',8) 
GO
insert into HtmlLabelInfo values(15043,'Ⱥ��Ĭ����֤�û�����',7) 
GO
insert into HtmlLabelInfo values(15043,'',8) 
GO
insert into HtmlLabelInfo values(15044,'Ⱥ���������Ƿ���Ҫ������֤',7) 
GO
insert into HtmlLabelInfo values(15044,'',8) 
GO
insert into HtmlLabelInfo values(15045,'�ļ�ϵͳ����',7) 
GO
insert into HtmlLabelInfo values(15045,'',8) 
GO
insert into HtmlLabelInfo values(15046,'�ļ����Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(15046,'',8) 
GO
insert into HtmlLabelInfo values(15047,'�ļ�����Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(15047,'',8) 
GO
insert into HtmlLabelInfo values(15048,'�ļ���������',7) 
GO
insert into HtmlLabelInfo values(15048,'',8) 
GO
insert into HtmlLabelInfo values(15049,'����',7) 
GO
insert into HtmlLabelInfo values(15049,'',8) 
GO
insert into HtmlLabelInfo values(15050,'�Ƿ�ѹ�����',7) 
GO
insert into HtmlLabelInfo values(15050,'',8) 
GO
insert into HtmlLabelInfo values(15051,'�������ݱ���',7) 
GO
insert into HtmlLabelInfo values(15051,'',8) 
GO
insert into HtmlLabelInfo values(15052,'ϵͳ��ɫ',7) 
GO
insert into HtmlLabelInfo values(15052,'',8) 
GO
insert into HtmlLabelInfo values(15053,'��Ա��ɫ',7) 
GO
insert into HtmlLabelInfo values(15053,'',8) 
GO
insert into HtmlLabelInfo values(15054,'�ʲ������������',7) 
GO
insert into HtmlLabelInfo values(15054,'',8) 
GO
insert into HtmlLabelInfo values(15055,'�ͻ������������',7) 
GO
insert into HtmlLabelInfo values(15055,'',8) 
GO
insert into HtmlLabelInfo values(15056,'֪ʶ�����������',7) 
GO
insert into HtmlLabelInfo values(15056,'',8) 
GO
insert into HtmlLabelInfo values(15057,'����������',7) 
GO
insert into HtmlLabelInfo values(15057,'',8) 
GO
insert into HtmlLabelInfo values(15058,'��������',7) 
GO
insert into HtmlLabelInfo values(15058,'',8) 
GO
insert into HtmlLabelInfo values(15059,'Ĭ�Ϲ���',7) 
GO
insert into HtmlLabelInfo values(15059,'',8) 
GO
insert into HtmlLabelInfo values(15060,'��',7) 
GO
insert into HtmlLabelInfo values(15060,'',8) 
GO
insert into HtmlLabelInfo values(15061,'��ͻ�',7) 
GO
insert into HtmlLabelInfo values(15061,'',8) 
GO
insert into HtmlLabelInfo values(15062,'���ż�',7) 
GO
insert into HtmlLabelInfo values(15062,'',8) 
GO
insert into HtmlLabelInfo values(15063,'�ֲ���',7) 
GO
insert into HtmlLabelInfo values(15063,'',8) 
GO
insert into HtmlLabelInfo values(15064,'�ܲ���',7) 
GO
insert into HtmlLabelInfo values(15064,'',8) 
GO
insert into HtmlLabelInfo values(15065,'������Դ��������',7) 
GO
insert into HtmlLabelInfo values(15065,'',8) 
GO
insert into HtmlLabelInfo values(15066,'��Ա��ɫ��������',7) 
GO
insert into HtmlLabelInfo values(15066,'',8) 
GO
insert into HtmlLabelInfo values(15067,'ϵͳ��ɫ��������',7) 
GO
insert into HtmlLabelInfo values(15067,'',8) 
GO
insert into HtmlLabelInfo values(15068,'��ɫ����',7) 
GO
insert into HtmlLabelInfo values(15068,'',8) 
GO
insert into HtmlLabelInfo values(15069,'�������̻�������',7) 
GO
insert into HtmlLabelInfo values(15069,'',8) 
GO
insert into HtmlLabelInfo values(15070,'�ڵ�����',7) 
GO
insert into HtmlLabelInfo values(15070,'',8) 
GO
insert into HtmlLabelInfo values(15071,'�޴�����',7) 
GO
insert into HtmlLabelInfo values(15071,'',8) 
GO
insert into HtmlLabelInfo values(15072,'������',7) 
GO
insert into HtmlLabelInfo values(15072,'',8) 
GO
insert into HtmlLabelInfo values(15073,'�����鶨��',7) 
GO
insert into HtmlLabelInfo values(15073,'',8) 
GO
insert into HtmlLabelInfo values(15074,'Ŀ��ڵ�',7) 
GO
insert into HtmlLabelInfo values(15074,'',8) 
GO
insert into HtmlLabelInfo values(15075,'�Ƿ��˻�',7) 
GO
insert into HtmlLabelInfo values(15075,'',8) 
GO
insert into HtmlLabelInfo values(15076,'�˻ؽڵ�',7) 
GO
insert into HtmlLabelInfo values(15076,'',8) 
GO
insert into HtmlLabelInfo values(15077,'�����漰�����Ա',7) 
GO
insert into HtmlLabelInfo values(15077,'',8) 
GO
insert into HtmlLabelInfo values(15078,'�ͻ�״̬',7) 
GO
insert into HtmlLabelInfo values(15078,'',8) 
GO
insert into HtmlLabelInfo values(15079,'�����˱���',7) 
GO
insert into HtmlLabelInfo values(15079,'',8) 
GO
insert into HtmlLabelInfo values(15080,'�����˾���',7) 
GO
insert into HtmlLabelInfo values(15080,'',8) 
GO
insert into HtmlLabelInfo values(15081,'�����˱�����',7) 
GO
insert into HtmlLabelInfo values(15081,'',8) 
GO
insert into HtmlLabelInfo values(15082,'���˻�',7) 
GO
insert into HtmlLabelInfo values(15082,'',8) 
GO
insert into HtmlLabelInfo values(15083,'�����˻�',7) 
GO
insert into HtmlLabelInfo values(15083,'',8) 
GO
insert into HtmlLabelInfo values(15084,'����',7) 
GO
insert into HtmlLabelInfo values(15084,'',8) 
GO
insert into HtmlLabelInfo values(15085,'����',7) 
GO
insert into HtmlLabelInfo values(15085,'',8) 
GO
insert into HtmlLabelInfo values(15086,'��',7) 
GO
insert into HtmlLabelInfo values(15086,'',8) 
GO
insert into HtmlLabelInfo values(15087,'���ʼ�����',7) 
GO
insert into HtmlLabelInfo values(15087,'',8) 
GO
insert into HtmlLabelInfo values(15088,'�����빫��',7) 
GO
insert into HtmlLabelInfo values(15088,'',8) 
GO
insert into HtmlLabelInfo values(15089,'�ҵ�����',7) 
GO
insert into HtmlLabelInfo values(15089,'',8) 
GO
insert into HtmlLabelInfo values(15090,'��������',7) 
GO
insert into HtmlLabelInfo values(15090,'',8) 
GO
insert into HtmlLabelInfo values(15091,'���鰲��',7) 
GO
insert into HtmlLabelInfo values(15091,'',8) 
GO
insert into HtmlLabelInfo values(15092,'��������',7) 
GO
insert into HtmlLabelInfo values(15092,'',8) 
GO
insert into HtmlLabelInfo values(15093,'���Ź���',7) 
GO
insert into HtmlLabelInfo values(15093,'',8) 
GO
insert into HtmlLabelInfo values(15094,'��¼����ͻ',7) 
GO
insert into HtmlLabelInfo values(15094,'',8) 
GO
insert into HtmlLabelInfo values(15095,'��ϵͳ��½��',7) 
GO
insert into HtmlLabelInfo values(15095,'',8) 
GO
insert into HtmlLabelInfo values(15096,'�ⲿϵͳ��½��',7) 
GO
insert into HtmlLabelInfo values(15096,'',8) 
GO
insert into HtmlLabelInfo values(15097,'ȷ��Ҫɾ����?',7) 
GO
insert into HtmlLabelInfo values(15097,'',8) 
GO
insert into HtmlLabelInfo values(15098,'�����б�',7) 
GO
insert into HtmlLabelInfo values(15098,'',8) 
GO
insert into HtmlLabelInfo values(15099,'��ӿͻ�',7) 
GO
insert into HtmlLabelInfo values(15099,'',8) 
GO
insert into HtmlLabelInfo values(15100,'',7) 
GO
insert into HtmlLabelInfo values(15100,'',8) 
GO
insert into HtmlLabelInfo values(15101,'����',7) 
GO
insert into HtmlLabelInfo values(15101,'',8) 
GO
insert into HtmlLabelInfo values(15102,'���ۻ���ʱ��ֲ�����',7) 
GO
insert into HtmlLabelInfo values(15102,'',8) 
GO
insert into HtmlLabelInfo values(15103,'�ɹ��ؼ�����',7) 
GO
insert into HtmlLabelInfo values(15103,'',8) 
GO
insert into HtmlLabelInfo values(15104,'ʧ�ܹؼ�����',7) 
GO
insert into HtmlLabelInfo values(15104,'',8) 
GO
insert into HtmlLabelInfo values(15105,'��Ʒ������',7) 
GO
insert into HtmlLabelInfo values(15105,'',8) 
GO
insert into HtmlLabelInfo values(15106,'��Ʒ���',7) 
GO
insert into HtmlLabelInfo values(15106,'',8) 
GO
insert into HtmlLabelInfo values(15107,'��Ʒά��',7) 
GO
insert into HtmlLabelInfo values(15107,'',8) 
GO
insert into HtmlLabelInfo values(15108,'��Ʒ�б�',7) 
GO
insert into HtmlLabelInfo values(15108,'',8) 
GO
insert into HtmlLabelInfo values(15109,'����',7) 
GO
insert into HtmlLabelInfo values(15109,'',8) 
GO
insert into HtmlLabelInfo values(15110,'�½�����',7) 
GO
insert into HtmlLabelInfo values(15110,'',8) 
GO
insert into HtmlLabelInfo values(15111,'��̨����',7) 
GO
insert into HtmlLabelInfo values(15111,'',8) 
GO
insert into HtmlLabelInfo values(15112,'�鵵״̬',7) 
GO
insert into HtmlLabelInfo values(15112,'',8) 
GO
insert into HtmlLabelInfo values(15113,'ʱ��ֲ�',7) 
GO
insert into HtmlLabelInfo values(15113,'',8) 
GO
insert into HtmlLabelInfo values(15114,'����',7) 
GO
insert into HtmlLabelInfo values(15114,'',8) 
GO
insert into HtmlLabelInfo values(15115,'��Ʒ',7) 
GO
insert into HtmlLabelInfo values(15115,'',8) 
GO
insert into HtmlLabelInfo values(15116,'������Ա',7) 
GO
insert into HtmlLabelInfo values(15116,'',8) 
GO
insert into HtmlLabelInfo values(15117,'��ͬӦ��Ӧ��',7) 
GO
insert into HtmlLabelInfo values(15117,'',8) 
GO
insert into HtmlLabelInfo values(15118,'��ͬ��ز�Ʒ',7) 
GO
insert into HtmlLabelInfo values(15118,'',8) 
GO
insert into HtmlLabelInfo values(15119,'���ݿ����',7) 
GO
insert into HtmlLabelInfo values(15119,'',8) 
GO
insert into HtmlLabelInfo values(15120,'�����ֲ�',7) 
GO
insert into HtmlLabelInfo values(15120,'',8) 
GO
insert into HtmlLabelInfo values(15121,'�ͻ���ϵ����',7) 
GO
insert into HtmlLabelInfo values(15121,'',8) 
GO
insert into HtmlLabelInfo values(15122,'����',7) 
GO
insert into HtmlLabelInfo values(15122,'',8) 
GO
insert into HtmlLabelInfo values(15123,'ǰ��',7) 
GO
insert into HtmlLabelInfo values(15123,'',8) 
GO
insert into HtmlLabelInfo values(15124,'�ͻ���Ƭ���',7) 
GO
insert into HtmlLabelInfo values(15124,'',8) 
GO
insert into HtmlLabelInfo values(15125,'����',7) 
GO
insert into HtmlLabelInfo values(15125,'',8) 
GO
insert into HtmlLabelInfo values(15126,'�����ؼ��ֲ�����ȷ',7) 
GO
insert into HtmlLabelInfo values(15126,'',8) 
GO
insert into HtmlLabelInfo values(15127,'��δ���',7) 
GO
insert into HtmlLabelInfo values(15127,'',8) 
GO
insert into HtmlLabelInfo values(15128,'���һ��',7) 
GO
insert into HtmlLabelInfo values(15128,'',8) 
GO
insert into HtmlLabelInfo values(15129,'��Ʒ����',7) 
GO
insert into HtmlLabelInfo values(15129,'',8) 
GO
insert into HtmlLabelInfo values(15130,'�ۿ�',7) 
GO
insert into HtmlLabelInfo values(15130,'',8) 
GO
insert into HtmlLabelInfo values(15131,'���ʽ',7) 
GO
insert into HtmlLabelInfo values(15131,'',8) 
GO
insert into HtmlLabelInfo values(15132,'������Ŀ',7) 
GO
insert into HtmlLabelInfo values(15132,'',8) 
GO
insert into HtmlLabelInfo values(15133,'��������',7) 
GO
insert into HtmlLabelInfo values(15133,'',8) 
GO
insert into HtmlLabelInfo values(15134,'������',7) 
GO
insert into HtmlLabelInfo values(15134,'',8) 
GO
insert into HtmlLabelInfo values(15135,'��������',7) 
GO
insert into HtmlLabelInfo values(15135,'',8) 
GO
insert into HtmlLabelInfo values(15136,'��������',7) 
GO
insert into HtmlLabelInfo values(15136,'',8) 
GO
insert into HtmlLabelInfo values(15137,'Ӧ��',7) 
GO
insert into HtmlLabelInfo values(15137,'',8) 
GO
insert into HtmlLabelInfo values(15138,'Ӧ��',7) 
GO
insert into HtmlLabelInfo values(15138,'',8) 
GO
insert into HtmlLabelInfo values(15139,'�½��ͻ���ͬ',7) 
GO
insert into HtmlLabelInfo values(15139,'',8) 
GO
insert into HtmlLabelInfo values(15140,'�ͻ���ͬ',7) 
GO
insert into HtmlLabelInfo values(15140,'',8) 
GO
insert into HtmlLabelInfo values(15141,'��',7) 
GO
insert into HtmlLabelInfo values(15141,'',8) 
GO
insert into HtmlLabelInfo values(15142,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(15142,'',8) 
GO
insert into HtmlLabelInfo values(15143,'�ύ����',7) 
GO
insert into HtmlLabelInfo values(15143,'',8) 
GO
insert into HtmlLabelInfo values(15144,'ִ�����',7) 
GO
insert into HtmlLabelInfo values(15144,'',8) 
GO
insert into HtmlLabelInfo values(15145,'ʵ�ʽ�������',7) 
GO
insert into HtmlLabelInfo values(15145,'',8) 
GO
insert into HtmlLabelInfo values(15146,'ʵ�ʽ�������',7) 
GO
insert into HtmlLabelInfo values(15146,'',8) 
GO
insert into HtmlLabelInfo values(15147,'�����',7) 
GO
insert into HtmlLabelInfo values(15147,'',8) 
GO
insert into HtmlLabelInfo values(15148,'����',7) 
GO
insert into HtmlLabelInfo values(15148,'',8) 
GO
insert into HtmlLabelInfo values(15149,'����',7) 
GO
insert into HtmlLabelInfo values(15149,'',8) 
GO
insert into HtmlLabelInfo values(15150,'ʵ�ʸ�������',7) 
GO
insert into HtmlLabelInfo values(15150,'',8) 
GO
insert into HtmlLabelInfo values(15151,'���տ�',7) 
GO
insert into HtmlLabelInfo values(15151,'',8) 
GO
insert into HtmlLabelInfo values(15152,'�Ѹ���',7) 
GO
insert into HtmlLabelInfo values(15152,'',8) 
GO
insert into HtmlLabelInfo values(15153,'��ؽ���',7) 
GO
insert into HtmlLabelInfo values(15153,'',8) 
GO
insert into HtmlLabelInfo values(15154,'����',7) 
GO
insert into HtmlLabelInfo values(15154,'',8) 
GO
insert into HtmlLabelInfo values(15155,'�ͻ��Ż�����',7) 
GO
insert into HtmlLabelInfo values(15155,'',8) 
GO
insert into HtmlLabelInfo values(15156,'�Ż�״̬���',7) 
GO
insert into HtmlLabelInfo values(15156,'',8) 
GO
insert into HtmlLabelInfo values(15157,'�ͻ�״̬���',7) 
GO
insert into HtmlLabelInfo values(15157,'',8) 
GO
insert into HtmlLabelInfo values(15158,'�ͻ�������',7) 
GO
insert into HtmlLabelInfo values(15158,'',8) 
GO
insert into HtmlLabelInfo values(15159,'�ͻ�������',7) 
GO
insert into HtmlLabelInfo values(15159,'',8) 
GO
insert into HtmlLabelInfo values(15160,'ȷ��Ҫ�ϲ���',7) 
GO
insert into HtmlLabelInfo values(15160,'',8) 
GO
insert into HtmlLabelInfo values(15161,'����',7) 
GO
insert into HtmlLabelInfo values(15161,'',8) 
GO
insert into HtmlLabelInfo values(15162,'Ӧ���ܶ�',7) 
GO
insert into HtmlLabelInfo values(15162,'',8) 
GO
insert into HtmlLabelInfo values(15163,'��һ��Ӧ�տ�ʱ��',7) 
GO
insert into HtmlLabelInfo values(16357,'�ĵ�: ������',7) 
GO
insert into HtmlLabelInfo values(16357,'',8) 
GO
insert into HtmlLabelInfo values(16358,'�ĵ�: ����',7) 
GO
insert into HtmlLabelInfo values(16358,'',8) 
GO
insert into HtmlLabelInfo values(16359,'�ĵ�: �Ķ�',7) 
GO
insert into HtmlLabelInfo values(16359,'',8) 
GO
insert into HtmlLabelInfo values(16360,'��� 50: ���Ķ�',7) 
GO
insert into HtmlLabelInfo values(16360,'',8) 
GO
insert into HtmlLabelInfo values(16361,'��� 20: ������',7) 
GO
insert into HtmlLabelInfo values(16361,'',8) 
GO
insert into HtmlLabelInfo values(16362,'��� 20: ����',7) 
GO
insert into HtmlLabelInfo values(16362,'',8) 
GO
insert into HtmlLabelInfo values(16363,'��� 20: CRM',7) 
GO
insert into HtmlLabelInfo values(16363,'',8) 
GO
insert into HtmlLabelInfo values(16364,'��� 20: ������Դ',7) 
GO
insert into HtmlLabelInfo values(16364,'',8) 
GO
insert into HtmlLabelInfo values(16365,'��� 20: ��Ŀ',7) 
GO
insert into HtmlLabelInfo values(16365,'',8) 
GO
insert into HtmlLabelInfo values(16366,'��� 20: ����',7) 
GO
insert into HtmlLabelInfo values(16366,'',8) 
GO
insert into HtmlLabelInfo values(16367,'ģ������',7) 
GO
insert into HtmlLabelInfo values(16367,'',8) 
GO
insert into HtmlLabelInfo values(16368,'����ҳ����',7) 
GO
insert into HtmlLabelInfo values(16368,'',8) 
GO
insert into HtmlLabelInfo values(16369,'�ĵ��༭ģ��',7) 
GO
insert into HtmlLabelInfo values(16369,'',8) 
GO
insert into HtmlLabelInfo values(16370,'�ĵ���ʾģ��',7) 
GO
insert into HtmlLabelInfo values(16370,'',8) 
GO
insert into HtmlLabelInfo values(16371,'��������',7) 
GO
insert into HtmlLabelInfo values(16371,'',8) 
GO
insert into HtmlLabelInfo values(16372,'��������',7) 
GO
insert into HtmlLabelInfo values(16372,'',8) 
GO
insert into HtmlLabelInfo values(16373,'��������',7) 
GO
insert into HtmlLabelInfo values(16373,'',8) 
GO
insert into HtmlLabelInfo values(16374,'���� - ����',7) 
GO
insert into HtmlLabelInfo values(16374,'',8) 
GO
insert into HtmlLabelInfo values(16375,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(16375,'',8) 
GO
insert into HtmlLabelInfo values(16376,'�ͻ���ֵ������׼',7) 
GO
insert into HtmlLabelInfo values(16376,'',8) 
GO
insert into HtmlLabelInfo values(16377,'�ͻ���ֵ������Ŀ',7) 
GO
insert into HtmlLabelInfo values(16377,'',8) 
GO
insert into HtmlLabelInfo values(16378,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(16378,'',8) 
GO
insert into HtmlLabelInfo values(16379,'Ȩ��ת��',7) 
GO
insert into HtmlLabelInfo values(16379,'',8) 
GO
insert into HtmlLabelInfo values(16380,'�����˵�',7) 
GO
insert into HtmlLabelInfo values(16380,'',8) 
GO
insert into HtmlLabelInfo values(16381,'�򿪱����ļ�',7) 
GO
insert into HtmlLabelInfo values(16381,'',8) 
GO
insert into HtmlLabelInfo values(16382,'��Ϊ�����ļ�',7) 
GO
insert into HtmlLabelInfo values(16382,'',8) 
GO
insert into HtmlLabelInfo values(16383,'ǩ��ӡ��',7) 
GO
insert into HtmlLabelInfo values(16383,'',8) 
GO
insert into HtmlLabelInfo values(16384,'�򿪰汾',7) 
GO
insert into HtmlLabelInfo values(16384,'',8) 
GO
insert into HtmlLabelInfo values(16385,'��ʾ/���غۼ�',7) 
GO
insert into HtmlLabelInfo values(16385,'',8) 
GO
insert into HtmlLabelInfo values(16386,'��Ϊ�°汾',7) 
GO
insert into HtmlLabelInfo values(16386,'',8) 
GO
insert into HtmlLabelInfo values(16387,'�½�ǩ��',7) 
GO
insert into HtmlLabelInfo values(16387,'',8) 
GO
insert into HtmlLabelInfo values(16388,'�½�ģ��',7) 
GO
insert into HtmlLabelInfo values(16388,'',8) 
GO
insert into HtmlLabelInfo values(16389,'',8) 
GO
insert into HtmlLabelInfo values(16390,'��������',7) 
GO
insert into HtmlLabelInfo values(16390,'',8) 
GO
insert into HtmlLabelInfo values(16391,'�ҵ�����',7) 
GO
insert into HtmlLabelInfo values(16391,'',8) 
GO
insert into HtmlLabelInfo values(16393,'��ѯ����',7) 
GO
insert into HtmlLabelInfo values(16393,'',8) 
GO
insert into HtmlLabelInfo values(16394,'',8) 
GO
insert into HtmlLabelInfo values(16395,'',8) 
GO
insert into HtmlLabelInfo values(16396,'����֪ʶ',7) 
GO
insert into HtmlLabelInfo values(16396,'',8) 
GO
insert into HtmlLabelInfo values(16397,'�����ĵ�',7) 
GO
insert into HtmlLabelInfo values(16397,'',8) 
GO
insert into HtmlLabelInfo values(16398,'�ĵ�Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(16398,'',8) 
GO
insert into HtmlLabelInfo values(16399,'��ѯ�ĵ�',7) 
GO
insert into HtmlLabelInfo values(16399,'',8) 
GO
insert into HtmlLabelInfo values(16402,'��ϵ�ƻ�',7) 
GO
insert into HtmlLabelInfo values(16402,'',8) 
GO
insert into HtmlLabelInfo values(16403,'��ϵ����',7) 
GO
insert into HtmlLabelInfo values(16405,'��ϵ���',7) 
GO
insert into HtmlLabelInfo values(16407,'��ѯ�ͻ�',7) 
GO
insert into HtmlLabelInfo values(16407,'',8) 
GO
insert into HtmlLabelInfo values(16409,'������Ŀ',7) 
GO
insert into HtmlLabelInfo values(16409,'',8) 
GO
insert into HtmlLabelInfo values(16410,'��������',7) 
GO
insert into HtmlLabelInfo values(16410,'',8) 
GO
insert into HtmlLabelInfo values(16412,'��������',7) 
GO
insert into HtmlLabelInfo values(16413,'',8) 
GO
insert into HtmlLabelInfo values(16415,'�ҵĿ�Ƭ',7) 
GO
insert into HtmlLabelInfo values(16415,'',8) 
GO
insert into HtmlLabelInfo values(16417,'���˽���',7) 
GO
insert into HtmlLabelInfo values(16418,'��ѯ��Ա',7) 
GO
insert into HtmlLabelInfo values(16419,'��������',7) 
GO
insert into HtmlLabelInfo values(16420,'',8) 
GO
insert into HtmlLabelInfo values(16422,'',8) 
GO
insert into HtmlLabelInfo values(16423,'�����ұ���',7) 
GO
insert into HtmlLabelInfo values(16424,'��ѯ����',7) 
GO
insert into HtmlLabelInfo values(16424,'',8) 
GO
insert into HtmlLabelInfo values(16425,'��ѯ�ʲ�',7) 
GO
insert into HtmlLabelInfo values(16425,'',8) 
GO
insert into HtmlLabelInfo values(16426,'�½��ƻ�',7) 
GO
insert into HtmlLabelInfo values(16427,'��ѯ�ƻ�',7) 
GO
insert into HtmlLabelInfo values(16427,'',8) 
GO
insert into HtmlLabelInfo values(16428,'�ҵ��ձ�',7) 
GO
insert into HtmlLabelInfo values(16428,'',8) 
GO
insert into HtmlLabelInfo values(16429,'�ҵ��ܱ�',7) 
GO
insert into HtmlLabelInfo values(16430,'�ҵ��±�',7) 
GO
insert into HtmlLabelInfo values(16431,'�ҵļ���',7) 
GO
insert into HtmlLabelInfo values(16432,'�ҵ��걨',7) 
GO
insert into HtmlLabelInfo values(16433,'��̬����',7) 
GO
insert into HtmlLabelInfo values(16433,'',8) 
GO
insert into HtmlLabelInfo values(16434,'��Ч����',7) 
GO
insert into HtmlLabelInfo values(16434,'',8) 
GO
insert into HtmlLabelInfo values(16435,'',8) 
GO
insert into HtmlLabelInfo values(16436,'',8) 
GO
insert into HtmlLabelInfo values(16437,'�ݸ�����',7) 
GO
insert into HtmlLabelInfo values(16438,'��������',7) 
GO
insert into HtmlLabelInfo values(16439,'',8) 
GO
insert into HtmlLabelInfo values(16441,'',8) 
GO
insert into HtmlLabelInfo values(16442,'',8) 
GO
insert into HtmlLabelInfo values(16443,'',8) 
GO
insert into HtmlLabelInfo values(16444,'',8) 
GO
insert into HtmlLabelInfo values(15790,'>��Ӧģ��',7) 
GO
insert into HtmlLabelInfo values(15790,'',8) 
GO
insert into HtmlLabelInfo values(16445,'',8) 
GO
insert into HtmlLabelInfo values(16446,'�汾����',7) 
GO
insert into HtmlLabelInfo values(16447,'Ŀ¼����',7) 
GO
insert into HtmlLabelInfo values(16447,'',8) 
GO
insert into HtmlLabelInfo values(16448,'ģ������',7) 
GO
insert into HtmlLabelInfo values(16449,'�༭ģ��',7) 
GO
insert into HtmlLabelInfo values(16449,'',8) 
GO
insert into HtmlLabelInfo values(16452,'�û�����',7) 
GO
insert into HtmlLabelInfo values(16452,'',8) 
GO
insert into HtmlLabelInfo values(16453,'�����ƶ�',7) 
GO
insert into HtmlLabelInfo values(16453,'',8) 
GO
insert into HtmlLabelInfo values(16454,'��΢���',7) 
GO
insert into HtmlLabelInfo values(16454,'',8) 
GO
insert into HtmlLabelInfo values(16455,'',8) 
GO
insert into HtmlLabelInfo values(16456,'',8) 
GO
insert into HtmlLabelInfo values(16457,'',8) 
GO
insert into HtmlLabelInfo values(16458,'',8) 
GO
insert into HtmlLabelInfo values(16459,'',8) 
GO
insert into HtmlLabelInfo values(16461,'��λ����',7) 
GO
insert into HtmlLabelInfo values(16464,'',8) 
GO
insert into HtmlLabelInfo values(16465,'��Ա��ְ',7) 
GO
insert into HtmlLabelInfo values(16466,'��Աת��',7) 
GO
insert into HtmlLabelInfo values(16467,'',8) 
GO
insert into HtmlLabelInfo values(16468,'��Ա����',7) 
GO
insert into HtmlLabelInfo values(16469,'��Ա��ְ',7) 
GO
insert into HtmlLabelInfo values(16470,'��Ա����',7) 
GO
insert into HtmlLabelInfo values(16471,'��Ա��Ƹ',7) 
GO
insert into HtmlLabelInfo values(16472,'��Ա��Ƹ',7) 
GO
insert into HtmlLabelInfo values(16472,'',8) 
GO
insert into HtmlLabelInfo values(16473,'ǩ������',7) 
GO
insert into HtmlLabelInfo values(16474,'��������',7) 
GO
insert into HtmlLabelInfo values(16474,'',8) 
GO
insert into HtmlLabelInfo values(16476,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(16476,'',8) 
GO
insert into HtmlLabelInfo values(16477,'��Աʱ��',7) 
GO
insert into HtmlLabelInfo values(16477,'',8) 
GO
insert into HtmlLabelInfo values(16478,'',8) 
GO
insert into HtmlLabelInfo values(16479,'��ͬģ��',7) 
GO
insert into HtmlLabelInfo values(16479,'',8) 
GO
insert into HtmlLabelInfo values(16480,'���ʸ���',7) 
GO
insert into HtmlLabelInfo values(16480,'',8) 
GO
insert into HtmlLabelInfo values(16481,'',8) 
GO
insert into HtmlLabelInfo values(16482,'��������',7) 
GO
insert into HtmlLabelInfo values(16482,'',8) 
GO
insert into HtmlLabelInfo values(16484,'',8) 
GO
insert into HtmlLabelInfo values(16485,'',8) 
GO
insert into HtmlLabelInfo values(16487,'',8) 
GO
insert into HtmlLabelInfo values(16488,'',8) 
GO
insert into HtmlLabelInfo values(16489,'',8) 
GO
insert into HtmlLabelInfo values(16490,'��������',7) 
GO
insert into HtmlLabelInfo values(16490,'',8) 
GO
insert into HtmlLabelInfo values(16491,'��ҵ����',7) 
GO
insert into HtmlLabelInfo values(16492,'��ģ����',7) 
GO
insert into HtmlLabelInfo values(16492,'',8) 
GO
insert into HtmlLabelInfo values(16493,'�������',7) 
GO
insert into HtmlLabelInfo values(16493,'',8) 
GO
insert into HtmlLabelInfo values(16494,'��������',7) 
GO
insert into HtmlLabelInfo values(16495,'״̬����',7) 
GO
insert into HtmlLabelInfo values(16496,'��ֵ����',7) 
GO
insert into HtmlLabelInfo values(16496,'',8) 
GO
insert into HtmlLabelInfo values(16497,'������Ŀ',7) 
GO
insert into HtmlLabelInfo values(16498,'',8) 
GO
insert into HtmlLabelInfo values(16499,'',8) 
GO
insert into HtmlLabelInfo values(16500,'',8) 
GO
insert into HtmlLabelInfo values(16501,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(16501,'',8) 
GO
insert into HtmlLabelInfo values(16502,'����ڼ�',7) 
GO
insert into HtmlLabelInfo values(16502,'',8) 
GO
insert into HtmlLabelInfo values(16503,'�ֶζ���',7) 
GO
insert into HtmlLabelInfo values(16504,'�ڼ�����',7) 
GO
insert into HtmlLabelInfo values(16504,'',8) 
GO
insert into HtmlLabelInfo values(16505,'',8) 
GO
insert into HtmlLabelInfo values(16506,'��������',7) 
GO
insert into HtmlLabelInfo values(16508,'���Ͷ���',7) 
GO
insert into HtmlLabelInfo values(16509,'�½�����',7) 
GO
insert into HtmlLabelInfo values(16510,'��������',7) 
GO
insert into HtmlLabelInfo values(16510,'',8) 
GO
insert into HtmlLabelInfo values(16511,'��λ����',7) 
GO
insert into HtmlLabelInfo values(16511,'',8) 
GO
insert into HtmlLabelInfo values(16515,'',8) 
GO
insert into HtmlLabelInfo values(16516,'',8) 
GO
insert into HtmlLabelInfo values(16517,'����ά��',7) 
GO
insert into HtmlLabelInfo values(16518,'���ά��',7) 
GO
insert into HtmlLabelInfo values(16519,'',8) 
GO
insert into HtmlLabelInfo values(16520,'',8) 
GO
insert into HtmlLabelInfo values(16521,'�û�����',7) 
GO
insert into HtmlLabelInfo values(16522,'',8) 
GO
insert into HtmlLabelInfo values(16523,'ʡ������',7) 
GO
insert into HtmlLabelInfo values(16529,'�ʼ����ļ�',7) 
GO
insert into HtmlLabelInfo values(16529,'',8) 
GO
insert into HtmlLabelInfo values(16530,'���±���',7) 
GO
insert into HtmlLabelInfo values(16531,'',8) 
GO
insert into HtmlLabelInfo values(16534,'',8) 
GO
insert into HtmlLabelInfo values(16535,'�ʲ�����',7) 
GO
insert into HtmlLabelInfo values(16536,'',8) 
GO
insert into HtmlLabelInfo values(16537,'ͨѶ¼��',7) 
GO
insert into HtmlLabelInfo values(16537,'',8) 
GO
insert into HtmlLabelInfo values(16538,'ͳ�Ʊ���',7) 
GO
insert into HtmlLabelInfo values(16539,'�ƻ�����',7) 
GO
insert into HtmlLabelInfo values(16539,'',8) 
GO
insert into HtmlLabelInfo values(16540,'��������',7) 
GO
insert into HtmlLabelInfo values(16540,'',8) 
GO
insert into HtmlLabelInfo values(16541,'����ͳ��',7) 
GO
insert into HtmlLabelInfo values(16541,'',8) 
GO
insert into HtmlLabelInfo values(16542,'���̱���',7) 
GO
insert into HtmlLabelInfo values(16542,'',8) 
GO
insert into HtmlLabelInfo values(16543,'��Ա״��',7) 
GO
insert into HtmlLabelInfo values(16544,'�����б�',7) 
GO
insert into HtmlLabelInfo values(16546,'ְ������',7) 
GO
insert into HtmlLabelInfo values(16546,'',8) 
GO
insert into HtmlLabelInfo values(16548,'',8) 
GO
insert into HtmlLabelInfo values(16549,'',8) 
GO
insert into HtmlLabelInfo values(16550,'ѧ������',7) 
GO
insert into HtmlLabelInfo values(16550,'',8) 
GO
insert into HtmlLabelInfo values(16551,'���ű���',7) 
GO
insert into HtmlLabelInfo values(16552,'��λ����',7) 
GO
insert into HtmlLabelInfo values(16553,'',8) 
GO
insert into HtmlLabelInfo values(16554,'',8) 
GO
insert into HtmlLabelInfo values(16555,'״̬����',7) 
GO
insert into HtmlLabelInfo values(16555,'',8) 
GO
insert into HtmlLabelInfo values(16556,'��ѵ���',7) 
GO
insert into HtmlLabelInfo values(16557,'',8) 
GO
insert into HtmlLabelInfo values(16559,'',8) 
GO
insert into HtmlLabelInfo values(16560,'',8) 
GO
insert into HtmlLabelInfo values(16561,'',8) 
GO
insert into HtmlLabelInfo values(16563,'',8) 
GO
insert into HtmlLabelInfo values(16564,'�������',7) 
GO
insert into HtmlLabelInfo values(16565,'�������',7) 
GO
insert into HtmlLabelInfo values(16569,'�������',7) 
GO
insert into HtmlLabelInfo values(16570,'��ְ���',7) 
GO
insert into HtmlLabelInfo values(16571,'',8) 
GO
insert into HtmlLabelInfo values(16572,'��ͬ���',7) 
GO
insert into HtmlLabelInfo values(16572,'',8) 
GO
insert into HtmlLabelInfo values(16573,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(16573,'',8) 
GO
insert into HtmlLabelInfo values(16575,'�����޸�',7) 
GO
insert into HtmlLabelInfo values(16576,'���ڶ�ȡ',7) 
GO
insert into HtmlLabelInfo values(16577,'δ������',7) 
GO
insert into HtmlLabelInfo values(16579,'��������',7) 
GO
insert into HtmlLabelInfo values(16579,'',8) 
GO
insert into HtmlLabelInfo values(16581,'',8) 
GO
insert into HtmlLabelInfo values(16583,'�ͻ���ҵ',7) 
GO
insert into HtmlLabelInfo values(16583,'',8) 
GO
insert into HtmlLabelInfo values(16584,'�������',7) 
GO
insert into HtmlLabelInfo values(16584,'',8) 
GO
insert into HtmlLabelInfo values(16585,'�����б�',7) 
GO
insert into HtmlLabelInfo values(16585,'',8) 
GO
insert into HtmlLabelInfo values(16586,'',8) 
GO
insert into HtmlLabelInfo values(16587,'',8) 
GO
insert into HtmlLabelInfo values(16588,'Ӧ��Ӧ��',7) 
GO
insert into HtmlLabelInfo values(16589,'��ͬ��Ʒ',7) 
GO
insert into HtmlLabelInfo values(16590,'������',7) 
GO
insert into HtmlLabelInfo values(16591,'��Ʒ���',7) 
GO
insert into HtmlLabelInfo values(16594,'�ۼƽ��',7) 
GO
insert into HtmlLabelInfo values(16594,'',8) 
GO
insert into HtmlLabelInfo values(16595,'��־����',7) 
GO
insert into HtmlLabelInfo values(16596,'���ڵ�¼',7) 
GO
insert into HtmlLabelInfo values(16596,'',8) 
GO
insert into HtmlLabelInfo values(16598,'��Ա�ʲ�',7) 
GO
insert into HtmlLabelInfo values(16599,'',8) 
GO
insert into HtmlLabelInfo values(16600,'�����ĵ�����',7) 
GO
insert into HtmlLabelInfo values(16600,'',8) 
GO
insert into HtmlLabelInfo values(16601,'�����ĵ����� ',7) 
GO
insert into HtmlLabelInfo values(16604,'�ĵ����ı���',7) 
GO
insert into HtmlLabelInfo values(16604,'',8) 
GO
insert into HtmlLabelInfo values(16605,'�ĵ�Ŀ¼����',7) 
GO
insert into HtmlLabelInfo values(16607,'����ĵ�����',7) 
GO
insert into HtmlLabelInfo values(16607,'',8) 
GO
insert into HtmlLabelInfo values(16608,'',8) 
GO
insert into HtmlLabelInfo values(16610,'��������Ա',7) 
GO
insert into HtmlLabelInfo values(16611,'',8) 
GO
insert into HtmlLabelInfo values(16612,'����ĵ�����',7) 
GO
insert into HtmlLabelInfo values(16613,'���鱨��',7) 
GO
insert into HtmlLabelInfo values(16613,'',8) 
GO
insert into HtmlLabelInfo values(16614,'',8) 
GO
insert into HtmlLabelInfo values(16615,'����������',7) 
GO
insert into HtmlLabelInfo values(16616,'������������',7) 
GO
insert into HtmlLabelInfo values(16616,'',8) 
GO
insert into HtmlLabelInfo values(16618,'�ر�Ԥ������',7) 
GO
insert into HtmlLabelInfo values(16618,'OpenFinanceInput',8) 
GO
insert into HtmlLabelInfo values(16619,'OpenFiananceInput',8) 
GO
insert into HtmlLabelInfo values(16620,'��������',7) 
GO
insert into HtmlLabelInfo values(16620,'ChangeConlumn',8) 
GO
insert into HtmlLabelInfo values(16621,'�������',7) 
GO
insert into HtmlLabelInfo values(16621,'ReportItemDefine',8) 
GO
insert into HtmlLabelInfo values(16622,'changesuccessful',8) 
GO
insert into HtmlLabelInfo values(16625,'������',7) 
GO
insert into HtmlLabelInfo values(16625,'monthedit',8) 
GO
insert into HtmlLabelInfo values(16626,'������',7) 
GO
insert into HtmlLabelInfo values(16626,'yearedit',8) 
GO
insert into HtmlLabelInfo values(16627,'ǩ�¹���',7) 
GO
insert into HtmlLabelInfo values(16628,'',8) 
GO
insert into HtmlLabelInfo values(16629,'����ͼ��',7) 
GO
insert into HtmlLabelInfo values(16629,'MakePic',8) 
GO
insert into HtmlLabelInfo values(16630,'�ϴ�Excel',7) 
GO
insert into HtmlLabelInfo values(16632,'�̵�',7) 
GO
insert into HtmlLabelInfo values(16632,'',8) 
GO
insert into HtmlLabelInfo values(16633,'',8) 
GO
insert into HtmlLabelInfo values(16634,'ȷ��',7) 
GO
insert into HtmlLabelInfo values(16636,'',8) 
GO
insert into HtmlLabelInfo values(16637,'',8) 
GO
insert into HtmlLabelInfo values(16638,'�������',7) 
GO
insert into HtmlLabelInfo values(16640,'���Ƶ�������',7) 
GO
insert into HtmlLabelInfo values(16640,'',8) 
GO
insert into HtmlLabelInfo values(15163,'',8) 
GO
insert into HtmlLabelInfo values(15164,'����ͻ���ͬ',7) 
GO
insert into HtmlLabelInfo values(15164,'',8) 
GO
insert into HtmlLabelInfo values(15165,'�������HTML�ļ�',7) 
GO
insert into HtmlLabelInfo values(15165,'',8) 
GO
insert into HtmlLabelInfo values(15166,'����㲻ϣ���ٴ��յ������ʼ�������',7) 
GO
insert into HtmlLabelInfo values(15166,'',8) 
GO
insert into HtmlLabelInfo values(15167,'�˶�',7) 
GO
insert into HtmlLabelInfo values(15167,'',8) 
GO
insert into HtmlLabelInfo values(15168,'ע',7) 
GO
insert into HtmlLabelInfo values(15168,'',8) 
GO
insert into HtmlLabelInfo values(15169,'��������HTML����ճ�����ʼ�ģ����',7) 
GO
insert into HtmlLabelInfo values(15169,'',8) 
GO
insert into HtmlLabelInfo values(15170,'ϵͳ��ʾ���Բ��𣬿ռ�¼���ܽ���ת��',7) 
GO
insert into HtmlLabelInfo values(15170,'',8) 
GO
insert into HtmlLabelInfo values(15171,'�˶�ʧ��',7) 
GO
insert into HtmlLabelInfo values(15171,'',8) 
GO
insert into HtmlLabelInfo values(15172,'ϵͳ��ʾ',7) 
GO
insert into HtmlLabelInfo values(15172,'',8) 
GO
insert into HtmlLabelInfo values(15173,'�ύʧ��',7) 
GO
insert into HtmlLabelInfo values(15173,'',8) 
GO
insert into HtmlLabelInfo values(15174,'���ύ�Ŀͻ�',7) 
GO
insert into HtmlLabelInfo values(15174,'',8) 
GO
insert into HtmlLabelInfo values(15175,'�ύ����',7) 
GO
insert into HtmlLabelInfo values(15175,'',8) 
GO
insert into HtmlLabelInfo values(15176,'���ύ',7) 
GO
insert into HtmlLabelInfo values(15176,'',8) 
GO
insert into HtmlLabelInfo values(15177,'δ�ύ�Ŀͻ�',7) 
GO
insert into HtmlLabelInfo values(15177,'',8) 
GO
insert into HtmlLabelInfo values(15178,'δ�ύ',7) 
GO
insert into HtmlLabelInfo values(15178,'',8) 
GO
insert into HtmlLabelInfo values(15179,'�˶��Ŀͻ�',7) 
GO
insert into HtmlLabelInfo values(15179,'',8) 
GO
insert into HtmlLabelInfo values(15180,'�˶�����',7) 
GO
insert into HtmlLabelInfo values(15180,'',8) 
GO
insert into HtmlLabelInfo values(15181,'���������',7) 
GO
insert into HtmlLabelInfo values(15181,'',8) 
GO
insert into HtmlLabelInfo values(15182,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15182,'',8) 
GO
insert into HtmlLabelInfo values(15183,'���������',7) 
GO
insert into HtmlLabelInfo values(15183,'',8) 
GO
insert into HtmlLabelInfo values(15184,'���뱨��',7) 
GO
insert into HtmlLabelInfo values(15184,'',8) 
GO
insert into HtmlLabelInfo values(15185,'���뱨������',7) 
GO
insert into HtmlLabelInfo values(15185,'',8) 
GO
insert into HtmlLabelInfo values(15186,'���ݱ���',7) 
GO
insert into HtmlLabelInfo values(15186,'',8) 
GO
insert into HtmlLabelInfo values(15187,'���鱨��',7) 
GO
insert into HtmlLabelInfo values(15187,'',8) 
GO
insert into HtmlLabelInfo values(15188,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15188,'',8) 
GO
insert into HtmlLabelInfo values(15189,'���������',7) 
GO
insert into HtmlLabelInfo values(15189,'',8) 
GO
insert into HtmlLabelInfo values(15190,'���ݿ����',7) 
GO
insert into HtmlLabelInfo values(15190,'',8) 
GO
insert into HtmlLabelInfo values(15191,'��ʽΪ',7) 
GO
insert into HtmlLabelInfo values(15191,'',8) 
GO
insert into HtmlLabelInfo values(15192,'����������ظ�',7) 
GO
insert into HtmlLabelInfo values(15192,'',8) 
GO
insert into HtmlLabelInfo values(15193,'������������Ҫ���ӵĵ�ַ',7) 
GO
insert into HtmlLabelInfo values(15193,'',8) 
GO
insert into HtmlLabelInfo values(15194,'��',7) 
GO
insert into HtmlLabelInfo values(15194,'',8) 
GO
insert into HtmlLabelInfo values(15195,'�ʼ���ʽ',7) 
GO
insert into HtmlLabelInfo values(15195,'',8) 
GO
insert into HtmlLabelInfo values(15196,'��ʽ',7) 
GO
insert into HtmlLabelInfo values(15196,'',8) 
GO
insert into HtmlLabelInfo values(15197,'�������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15197,'',8) 
GO
insert into HtmlLabelInfo values(15198,'�ʼ�ģ����',7) 
GO
insert into HtmlLabelInfo values(15198,'',8) 
GO
insert into HtmlLabelInfo values(15199,'��������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15199,'',8) 
GO
insert into HtmlLabelInfo values(15200,'������',7) 
GO
insert into HtmlLabelInfo values(15200,'',8) 
GO
insert into HtmlLabelInfo values(15201,'�����ı���',7) 
GO
insert into HtmlLabelInfo values(15201,'',8) 
GO
insert into HtmlLabelInfo values(15202,'������',7) 
GO
insert into HtmlLabelInfo values(15202,'',8) 
GO
insert into HtmlLabelInfo values(15203,'������',7) 
GO
insert into HtmlLabelInfo values(15203,'',8) 
GO
insert into HtmlLabelInfo values(15204,'��ѡ��',7) 
GO
insert into HtmlLabelInfo values(15204,'',8) 
GO
insert into HtmlLabelInfo values(15205,'��ѡ��',7) 
GO
insert into HtmlLabelInfo values(15205,'',8) 
GO
insert into HtmlLabelInfo values(15206,'�����ı���',7) 
GO
insert into HtmlLabelInfo values(15206,'',8) 
GO
insert into HtmlLabelInfo values(15207,'����������',7) 
GO
insert into HtmlLabelInfo values(15207,'',8) 
GO
insert into HtmlLabelInfo values(15208,'����������',7) 
GO
insert into HtmlLabelInfo values(15208,'',8) 
GO
insert into HtmlLabelInfo values(15209,'�������ֶ���',7) 
GO
insert into HtmlLabelInfo values(15209,'',8) 
GO
insert into HtmlLabelInfo values(15210,'���ֶ��������ظ�',7) 
GO
insert into HtmlLabelInfo values(15210,'',8) 
GO
insert into HtmlLabelInfo values(15211,'�ı��ֶο��',7) 
GO
insert into HtmlLabelInfo values(15211,'',8) 
GO
insert into HtmlLabelInfo values(15212,'С��λ��',7) 
GO
insert into HtmlLabelInfo values(15212,'',8) 
GO
insert into HtmlLabelInfo values(15213,'�������������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15213,'',8) 
GO
insert into HtmlLabelInfo values(15214,'ѡ������ϸֵ',7) 
GO
insert into HtmlLabelInfo values(15214,'',8) 
GO
insert into HtmlLabelInfo values(15215,'ѡ����ʾֵ�����ݱ�ֵӦһ��',7) 
GO
insert into HtmlLabelInfo values(15215,'',8) 
GO
insert into HtmlLabelInfo values(15216,'ѡ����ʾֵ',7) 
GO
insert into HtmlLabelInfo values(15216,'',8) 
GO
insert into HtmlLabelInfo values(15217,'���ݱ�ֵ',7) 
GO
insert into HtmlLabelInfo values(15217,'',8) 
GO
insert into HtmlLabelInfo values(15218,'�����',7) 
GO
insert into HtmlLabelInfo values(15218,'',8) 
GO
insert into HtmlLabelInfo values(15219,'���յ�������',7) 
GO
insert into HtmlLabelInfo values(15219,'',8) 
GO
insert into HtmlLabelInfo values(15220,'Ӧ�ύ���ܿͻ�',7) 
GO
insert into HtmlLabelInfo values(15220,'',8) 
GO
insert into HtmlLabelInfo values(15221,'ʵ���ύ���ܿͻ�',7) 
GO
insert into HtmlLabelInfo values(15221,'',8) 
GO
insert into HtmlLabelInfo values(15222,'�˶����ܿͻ�',7) 
GO
insert into HtmlLabelInfo values(15222,'',8) 
GO
insert into HtmlLabelInfo values(15223,'��Ȩ��ָ�����ܴ���',7) 
GO
insert into HtmlLabelInfo values(15223,'',8) 
GO
insert into HtmlLabelInfo values(15224,'����',7) 
GO
insert into HtmlLabelInfo values(15224,'',8) 
GO
insert into HtmlLabelInfo values(15225,'δ��',7) 
GO
insert into HtmlLabelInfo values(15225,'',8) 
GO
insert into HtmlLabelInfo values(15226,'�Ѹ�',7) 
GO
insert into HtmlLabelInfo values(15226,'',8) 
GO
insert into HtmlLabelInfo values(15227,'δ��',7) 
GO
insert into HtmlLabelInfo values(15227,'',8) 
GO
insert into HtmlLabelInfo values(15228,'Ӧ����',7) 
GO
insert into HtmlLabelInfo values(15228,'',8) 
GO
insert into HtmlLabelInfo values(15229,'�ѽ���',7) 
GO
insert into HtmlLabelInfo values(15229,'',8) 
GO
insert into HtmlLabelInfo values(15230,'δ����',7) 
GO
insert into HtmlLabelInfo values(15230,'',8) 
GO
insert into HtmlLabelInfo values(15231,'�ͻ���',7) 
GO
insert into HtmlLabelInfo values(15231,'',8) 
GO
insert into HtmlLabelInfo values(15232,'�ϴ���ϵʱ��',7) 
GO
insert into HtmlLabelInfo values(15232,'',8) 
GO
insert into HtmlLabelInfo values(15233,'��������',7) 
GO
insert into HtmlLabelInfo values(15233,'',8) 
GO
insert into HtmlLabelInfo values(15234,'��������',7) 
GO
insert into HtmlLabelInfo values(15234,'',8) 
GO
insert into HtmlLabelInfo values(15235,'�ͻ���ͬ��������',7) 
GO
insert into HtmlLabelInfo values(15235,'',8) 
GO
insert into HtmlLabelInfo values(15236,'��ͬ��������',7) 
GO
insert into HtmlLabelInfo values(15236,'',8) 
GO
insert into HtmlLabelInfo values(15237,'�������������',7) 
GO
insert into HtmlLabelInfo values(15237,'',8) 
GO
insert into HtmlLabelInfo values(15238,'�����������Ŀ',7) 
GO
insert into HtmlLabelInfo values(15238,'',8) 
GO
insert into HtmlLabelInfo values(15239,'�н����',7) 
GO
insert into HtmlLabelInfo values(15239,'',8) 
GO
insert into HtmlLabelInfo values(15240,'��Դ',7) 
GO
insert into HtmlLabelInfo values(15240,'',8) 
GO
insert into HtmlLabelInfo values(15241,'������0��1֮�����',7) 
GO
insert into HtmlLabelInfo values(15241,'',8) 
GO
insert into HtmlLabelInfo values(15242,'�ɹ�',7) 
GO
insert into HtmlLabelInfo values(15242,'',8) 
GO
insert into HtmlLabelInfo values(15243,'��������ȷ����������',7) 
GO
insert into HtmlLabelInfo values(15243,'',8) 
GO
insert into HtmlLabelInfo values(15244,'���ۻ���ʱ��',7) 
GO
insert into HtmlLabelInfo values(15244,'',8) 
GO
insert into HtmlLabelInfo values(15245,'����ҵ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15245,'',8) 
GO
insert into HtmlLabelInfo values(15246,'��������',7) 
GO
insert into HtmlLabelInfo values(15246,'',8) 
GO
insert into HtmlLabelInfo values(15247,'����ҵ��',7) 
GO
insert into HtmlLabelInfo values(15247,'',8) 
GO
insert into HtmlLabelInfo values(15248,'ʡ��ҵ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15248,'',8) 
GO
insert into HtmlLabelInfo values(15249,'�½����ۻ���',7) 
GO
insert into HtmlLabelInfo values(15249,'',8) 
GO
insert into HtmlLabelInfo values(15250,'�༭���ۻ���',7) 
GO
insert into HtmlLabelInfo values(15250,'',8) 
GO
insert into HtmlLabelInfo values(15251,'Ԥ������ϼ�',7) 
GO
insert into HtmlLabelInfo values(15251,'',8) 
GO
insert into HtmlLabelInfo values(15252,'����',7) 
GO
insert into HtmlLabelInfo values(15252,'',8) 
GO
insert into HtmlLabelInfo values(15253,'��ǩ����ͬ',7) 
GO
insert into HtmlLabelInfo values(15253,'',8) 
GO
insert into HtmlLabelInfo values(15254,'��������ȷ�ĺ�ͬ�������',7) 
GO
insert into HtmlLabelInfo values(15254,'',8) 
GO
insert into HtmlLabelInfo values(15255,'���۾���',7) 
GO
insert into HtmlLabelInfo values(15255,'',8) 
GO
insert into HtmlLabelInfo values(15256,'����',7) 
GO
insert into HtmlLabelInfo values(15256,'',8) 
GO
insert into HtmlLabelInfo values(15257,'���ۻ���ͳ��',7) 
GO
insert into HtmlLabelInfo values(15257,'',8) 
GO
insert into HtmlLabelInfo values(15258,'�������',7) 
GO
insert into HtmlLabelInfo values(15258,'',8) 
GO
insert into HtmlLabelInfo values(15259,'���ۻ�����',7) 
GO
insert into HtmlLabelInfo values(15259,'',8) 
GO
insert into HtmlLabelInfo values(15260,'���ٷֱ�',7) 
GO
insert into HtmlLabelInfo values(15260,'',8) 
GO
insert into HtmlLabelInfo values(15261,'��Ŀ�����б�',7) 
GO
insert into HtmlLabelInfo values(15261,'',8) 
GO
insert into HtmlLabelInfo values(15262,'�����Ŀ',7) 
GO
insert into HtmlLabelInfo values(15262,'',8) 
GO
insert into HtmlLabelInfo values(15263,'�ͻ��ɼ�',7) 
GO
insert into HtmlLabelInfo values(15263,'',8) 
GO
insert into HtmlLabelInfo values(15264,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(15264,'',8) 
GO
insert into HtmlLabelInfo values(15265,'ʵ������',7) 
GO
insert into HtmlLabelInfo values(15265,'',8) 
GO
insert into HtmlLabelInfo values(15266,'�½�����',7) 
GO
insert into HtmlLabelInfo values(15266,'',8) 
GO
insert into HtmlLabelInfo values(15267,'�½�����ִ�У�',7) 
GO
insert into HtmlLabelInfo values(15267,'',8) 
GO
insert into HtmlLabelInfo values(15268,'�༭����ִ�У�',7) 
GO
insert into HtmlLabelInfo values(15268,'',8) 
GO
insert into HtmlLabelInfo values(15269,'�½����񣨼ƻ���',7) 
GO
insert into HtmlLabelInfo values(15269,'',8) 
GO
insert into HtmlLabelInfo values(15270,'�༭���񣨼ƻ���',7) 
GO
insert into HtmlLabelInfo values(15270,'',8) 
GO
insert into HtmlLabelInfo values(15271,'ɾ������ִ�У�',7) 
GO
insert into HtmlLabelInfo values(15271,'',8) 
GO
insert into HtmlLabelInfo values(15272,'ɾ�����񣨼ƻ���',7) 
GO
insert into HtmlLabelInfo values(15272,'',8) 
GO
insert into HtmlLabelInfo values(15273,'����ʱ�䲻��С����ʼʱ��',7) 
GO
insert into HtmlLabelInfo values(15273,'',8) 
GO
insert into HtmlLabelInfo values(15274,'��ĿԤ��',7) 
GO
insert into HtmlLabelInfo values(15274,'',8) 
GO
insert into HtmlLabelInfo values(15275,'�޸���־',7) 
GO
insert into HtmlLabelInfo values(15275,'',8) 
GO
insert into HtmlLabelInfo values(15276,'��Ŀ֪ͨ',7) 
GO
insert into HtmlLabelInfo values(15276,'',8) 
GO
insert into HtmlLabelInfo values(15277,'ǰ������δ���',7) 
GO
insert into HtmlLabelInfo values(15277,'',8) 
GO
insert into HtmlLabelInfo values(15278,'������ 0��100 ֮�������',7) 
GO
insert into HtmlLabelInfo values(15278,'',8) 
GO
insert into HtmlLabelInfo values(15279,'Ԫ',7) 
GO
insert into HtmlLabelInfo values(15279,'',8) 
GO
insert into HtmlLabelInfo values(15280,'֪ͨ����',7) 
GO
insert into HtmlLabelInfo values(15280,'',8) 
GO
insert into HtmlLabelInfo values(15281,'֪ͨ���⣺',7) 
GO
insert into HtmlLabelInfo values(15281,'',8) 
GO
insert into HtmlLabelInfo values(15282,'֪ͨ���ݣ�',7) 
GO
insert into HtmlLabelInfo values(15282,'',8) 
GO
insert into HtmlLabelInfo values(15283,'�½���Ŀ����',7) 
GO
insert into HtmlLabelInfo values(15283,'',8) 
GO
insert into HtmlLabelInfo values(15284,'�༭����',7) 
GO
insert into HtmlLabelInfo values(15284,'',8) 
GO
insert into HtmlLabelInfo values(15285,'��������',7) 
GO
insert into HtmlLabelInfo values(15285,'',8) 
GO
insert into HtmlLabelInfo values(15286,'����Ƚ�',7) 
GO
insert into HtmlLabelInfo values(15286,'',8) 
GO
insert into HtmlLabelInfo values(15287,'δ��ʼ����',7) 
GO
insert into HtmlLabelInfo values(15287,'',8) 
GO
insert into HtmlLabelInfo values(15288,'����������',7) 
GO
insert into HtmlLabelInfo values(15288,'',8) 
GO
insert into HtmlLabelInfo values(15289,'���������',7) 
GO
insert into HtmlLabelInfo values(15289,'',8) 
GO
insert into HtmlLabelInfo values(15290,'����δ��ʼ����',7) 
GO
insert into HtmlLabelInfo values(15290,'',8) 
GO
insert into HtmlLabelInfo values(15291,'����δ�������',7) 
GO
insert into HtmlLabelInfo values(15291,'',8) 
GO
insert into HtmlLabelInfo values(15292,'(ʵ��/�ƻ�)',7) 
GO
insert into HtmlLabelInfo values(15292,'',8) 
GO
insert into HtmlLabelInfo values(15293,'������',7) 
GO
insert into HtmlLabelInfo values(15293,'',8) 
GO
insert into HtmlLabelInfo values(15294,'��������',7) 
GO
insert into HtmlLabelInfo values(15294,'',8) 
GO
insert into HtmlLabelInfo values(15295,'��ع�����',7) 
GO
insert into HtmlLabelInfo values(15295,'',8) 
GO
insert into HtmlLabelInfo values(15296,'ͳ�Ʊ���',7) 
GO
insert into HtmlLabelInfo values(15296,'',8) 
GO
insert into HtmlLabelInfo values(15297,'���ڻ�����',7) 
GO
insert into HtmlLabelInfo values(15297,'',8) 
GO
insert into HtmlLabelInfo values(15298,'����',7) 
GO
insert into HtmlLabelInfo values(15298,'',8) 
GO
insert into HtmlLabelInfo values(15299,'����',7) 
GO
insert into HtmlLabelInfo values(15299,'',8) 
GO
insert into HtmlLabelInfo values(15300,'���ϵ��ʲ�',7) 
GO
insert into HtmlLabelInfo values(15300,'',8) 
GO
insert into HtmlLabelInfo values(15301,'��ⲿ��',7) 
GO
insert into HtmlLabelInfo values(15301,'',8) 
GO
insert into HtmlLabelInfo values(15302,'�������',7) 
GO
insert into HtmlLabelInfo values(15302,'',8) 
GO
insert into HtmlLabelInfo values(15303,'��������',7) 
GO
insert into HtmlLabelInfo values(15303,'',8) 
GO
insert into HtmlLabelInfo values(15304,'���õ��ʲ�',7) 
GO
insert into HtmlLabelInfo values(15304,'',8) 
GO
insert into HtmlLabelInfo values(15305,'�ʲ��黹',7) 
GO
insert into HtmlLabelInfo values(15305,'',8) 
GO
insert into HtmlLabelInfo values(15306,'�������',7) 
GO
insert into HtmlLabelInfo values(15306,'',8) 
GO
insert into HtmlLabelInfo values(15307,'�������',7) 
GO
insert into HtmlLabelInfo values(15307,'',8) 
GO
insert into HtmlLabelInfo values(15308,'ά�޵��ʲ�',7) 
GO
insert into HtmlLabelInfo values(15308,'',8) 
GO
insert into HtmlLabelInfo values(15309,'�����ʲ�',7) 
GO
insert into HtmlLabelInfo values(15309,'',8) 
GO
insert into HtmlLabelInfo values(15310,'����������',7) 
GO
insert into HtmlLabelInfo values(15310,'',8) 
GO
insert into HtmlLabelInfo values(15311,'��������',7) 
GO
insert into HtmlLabelInfo values(15311,'',8) 
GO
insert into HtmlLabelInfo values(15312,'���õ��ʲ�',7) 
GO
insert into HtmlLabelInfo values(15312,'',8) 
GO
insert into HtmlLabelInfo values(15313,'���õ�����',7) 
GO
insert into HtmlLabelInfo values(15313,'',8) 
GO
insert into HtmlLabelInfo values(15314,'������;',7) 
GO
insert into HtmlLabelInfo values(15314,'',8) 
GO
insert into HtmlLabelInfo values(15315,'չ��',7) 
GO
insert into HtmlLabelInfo values(15315,'',8) 
GO
insert into HtmlLabelInfo values(15316,'�ʲ������б�',7) 
GO
insert into HtmlLabelInfo values(15316,'',8) 
GO
insert into HtmlLabelInfo values(15317,'��һ��',7) 
GO
insert into HtmlLabelInfo values(15317,'',8) 
GO
insert into HtmlLabelInfo values(15318,'����ȫ��Ϊ��',7) 
GO
insert into HtmlLabelInfo values(15318,'',8) 
GO
insert into HtmlLabelInfo values(15319,'����У���',7) 
GO
insert into HtmlLabelInfo values(15319,'',8) 
GO
insert into HtmlLabelInfo values(15320,'�̶��ʲ�',7) 
GO
insert into HtmlLabelInfo values(15320,'',8) 
GO
insert into HtmlLabelInfo values(15321,'��ֵ�׺�Ʒ',7) 
GO
insert into HtmlLabelInfo values(15321,'',8) 
GO
insert into HtmlLabelInfo values(15322,'��',7) 
GO
insert into HtmlLabelInfo values(15322,'',8) 
GO
insert into HtmlLabelInfo values(15323,'��',7) 
GO
insert into HtmlLabelInfo values(15323,'',8) 
GO
insert into HtmlLabelInfo values(15324,'��',7) 
GO
insert into HtmlLabelInfo values(15324,'',8) 
GO
insert into HtmlLabelInfo values(15325,'����',7) 
GO
insert into HtmlLabelInfo values(15325,'',8) 
GO
insert into HtmlLabelInfo values(15326,'ͳ����',7) 
GO
insert into HtmlLabelInfo values(15326,'',8) 
GO
insert into HtmlLabelInfo values(15327,'ͳ������',7) 
GO
insert into HtmlLabelInfo values(15327,'',8) 
GO
insert into HtmlLabelInfo values(15328,'��ʻԱͳ�Ʊ�',7) 
GO
insert into HtmlLabelInfo values(15328,'',8) 
GO
insert into HtmlLabelInfo values(15329,'���ɱ���',7) 
GO
insert into HtmlLabelInfo values(15329,'',8) 
GO
insert into HtmlLabelInfo values(15330,'��ʻԱ',7) 
GO
insert into HtmlLabelInfo values(15330,'',8) 
GO
insert into HtmlLabelInfo values(15331,'��¡����ս��Ͷ�����޹�˾����������ʻԱͳ�Ʊ�',7) 
GO
insert into HtmlLabelInfo values(15331,'',8) 
GO
insert into HtmlLabelInfo values(15332,'�Ʊ���',7) 
GO
insert into HtmlLabelInfo values(15332,'',8) 
GO
insert into HtmlLabelInfo values(15333,'�յ�',7) 
GO
insert into HtmlLabelInfo values(15333,'',8) 
GO
insert into HtmlLabelInfo values(15334,'����ʱ���������',7) 
GO
insert into HtmlLabelInfo values(15334,'',8) 
GO
insert into HtmlLabelInfo values(15335,'ƽʱ����������',7) 
GO
insert into HtmlLabelInfo values(15335,'',8) 
GO
insert into HtmlLabelInfo values(15336,'��Ϣ�ճ�������',7) 
GO
insert into HtmlLabelInfo values(15336,'',8) 
GO
insert into HtmlLabelInfo values(15337,'��س�������',7) 
GO
insert into HtmlLabelInfo values(15337,'',8) 
GO
insert into HtmlLabelInfo values(15338,'��ʻ������',7) 
GO
insert into HtmlLabelInfo values(15338,'',8) 
GO
insert into HtmlLabelInfo values(15339,'ȼ�ͷ�',7) 
GO
insert into HtmlLabelInfo values(15339,'',8) 
GO
insert into HtmlLabelInfo values(15340,'ͣ����·��',7) 
GO
insert into HtmlLabelInfo values(15340,'',8) 
GO
insert into HtmlLabelInfo values(15341,'�����',7) 
GO
insert into HtmlLabelInfo values(15341,'',8) 
GO
insert into HtmlLabelInfo values(15342,'�绰��',7) 
GO
insert into HtmlLabelInfo values(15342,'',8) 
GO
insert into HtmlLabelInfo values(15343,'�Ӱಹ��',7) 
GO
insert into HtmlLabelInfo values(15343,'',8) 
GO
insert into HtmlLabelInfo values(15344,'�������ܷ���',7) 
GO
insert into HtmlLabelInfo values(15344,'',8) 
GO
insert into HtmlLabelInfo values(15345,'����ͳ�Ʊ�',7) 
GO
insert into HtmlLabelInfo values(15345,'',8) 
GO
insert into HtmlLabelInfo values(15346,'��¡����ս��Ͷ�����޹�˾������������ͳ�Ʊ�',7) 
GO
insert into HtmlLabelInfo values(15346,'',8) 
GO
insert into HtmlLabelInfo values(15347,'�������',7) 
GO
insert into HtmlLabelInfo values(15347,'',8) 
GO
insert into HtmlLabelInfo values(15348,'��ʻ�ܹ�����',7) 
GO
insert into HtmlLabelInfo values(15348,'',8) 
GO
insert into HtmlLabelInfo values(15349,'�������ü�ʱ��',7) 
GO
insert into HtmlLabelInfo values(15349,'',8) 
GO
insert into HtmlLabelInfo values(15350,'ά�޷��ü�ʱ��',7) 
GO
insert into HtmlLabelInfo values(15350,'',8) 
GO
insert into HtmlLabelInfo values(15351,'������',7) 
GO
insert into HtmlLabelInfo values(15351,'',8) 
GO
insert into HtmlLabelInfo values(15352,'�ƻ�ʵ�ʱȽϱ�',7) 
GO
insert into HtmlLabelInfo values(15352,'',8) 
GO
insert into HtmlLabelInfo values(15353,'����ͼ��',7) 
GO
insert into HtmlLabelInfo values(15353,'',8) 
GO
insert into HtmlLabelInfo values(15354,'�����ŷ��üƻ�ʵ�ʱȽϱ�',7) 
GO
insert into HtmlLabelInfo values(15354,'',8) 
GO
insert into HtmlLabelInfo values(15355,'��������ͳ�Ʊ�',7) 
GO
insert into HtmlLabelInfo values(15355,'',8) 
GO
insert into HtmlLabelInfo values(15356,'���üƻ�ʵ�ʱȽϱ�',7) 
GO
insert into HtmlLabelInfo values(15356,'',8) 
GO
insert into HtmlLabelInfo values(15357,'��֤',7) 
GO
insert into HtmlLabelInfo values(15357,'',8) 
GO
insert into HtmlLabelInfo values(15358,'����',7) 
GO
insert into HtmlLabelInfo values(15358,'',8) 
GO
insert into HtmlLabelInfo values(15359,'��֤���',7) 
GO
insert into HtmlLabelInfo values(15359,'',8) 
GO
insert into HtmlLabelInfo values(15360,'�б���ʾ',7) 
GO
insert into HtmlLabelInfo values(15360,'',8) 
GO
insert into HtmlLabelInfo values(15361,'�ʲ�������',7) 
GO
insert into HtmlLabelInfo values(15361,'',8) 
GO
insert into HtmlLabelInfo values(15362,'�ּ���ʾ',7) 
GO
insert into HtmlLabelInfo values(15362,'',8) 
GO
insert into HtmlLabelInfo values(15363,'Ԥ�����',7) 
GO
insert into HtmlLabelInfo values(15363,'',8) 
GO
insert into HtmlLabelInfo values(15364,'����',7) 
GO
insert into HtmlLabelInfo values(15364,'',8) 
GO
insert into HtmlLabelInfo values(15365,'Ԥ�����',7) 
GO
insert into HtmlLabelInfo values(15365,'',8) 
GO
insert into HtmlLabelInfo values(15366,'�걨',7) 
GO
insert into HtmlLabelInfo values(15366,'',8) 
GO
insert into HtmlLabelInfo values(15367,'��׼',7) 
GO
insert into HtmlLabelInfo values(15367,'',8) 
GO
insert into HtmlLabelInfo values(15368,'ƫ��',7) 
GO
insert into HtmlLabelInfo values(15368,'',8) 
GO
insert into HtmlLabelInfo values(15369,'�����걨ֵ',7) 
GO
insert into HtmlLabelInfo values(15369,'',8) 
GO
insert into HtmlLabelInfo values(15370,'�¶�Ԥ��',7) 
GO
insert into HtmlLabelInfo values(15370,'',8) 
GO
insert into HtmlLabelInfo values(15371,'Ԥ������',7) 
GO
insert into HtmlLabelInfo values(15371,'',8) 
GO
insert into HtmlLabelInfo values(15372,'��',7) 
GO
insert into HtmlLabelInfo values(15372,'',8) 
GO
insert into HtmlLabelInfo values(15373,'����Ԥ��',7) 
GO
insert into HtmlLabelInfo values(15373,'',8) 
GO
insert into HtmlLabelInfo values(15374,'����Ԥ��',7) 
GO
insert into HtmlLabelInfo values(15374,'',8) 
GO
insert into HtmlLabelInfo values(15375,'���Ԥ��',7) 
GO
insert into HtmlLabelInfo values(15375,'',8) 
GO
insert into HtmlLabelInfo values(15376,'ͨ��',7) 
GO
insert into HtmlLabelInfo values(15376,'',8) 
GO
insert into HtmlLabelInfo values(15377,'��׼�༭',7) 
GO
insert into HtmlLabelInfo values(15377,'',8) 
GO
insert into HtmlLabelInfo values(15378,'����״̬',7) 
GO
insert into HtmlLabelInfo values(15378,'',8) 
GO
insert into HtmlLabelInfo values(15379,'1�����ŵ�Ԥ���걨�ĸ�������ֵ������ڻ���ں�׼ֵ(����û�к�׼ֵ)����������ͨ����',7) 
GO
insert into HtmlLabelInfo values(15379,'',8) 
GO
insert into HtmlLabelInfo values(15380,'2�����ŵ�Ԥ���걨�ĸ���֧��ֵ����С�ڻ���ں�׼ֵ(����û�к�׼ֵ)����������ͨ����',7) 
GO
insert into HtmlLabelInfo values(15380,'',8) 
GO
insert into HtmlLabelInfo values(15381,'3������ͨ���󣬸ò��ű����Ԥ���걨ֵ�ͺ�׼ֵ�㲻�ܸĶ���',7) 
GO
insert into HtmlLabelInfo values(15381,'',8) 
GO
insert into HtmlLabelInfo values(15382,'�Ƿ������',7) 
GO
insert into HtmlLabelInfo values(15382,'',8) 
GO
insert into HtmlLabelInfo values(15383,'�в��������������������걨���ڣ���������ͨ����',7) 
GO
insert into HtmlLabelInfo values(15383,'',8) 
GO
insert into HtmlLabelInfo values(15384,'����',7) 
GO
insert into HtmlLabelInfo values(15384,'',8) 
GO
insert into HtmlLabelInfo values(15385,'��֧����',7) 
GO
insert into HtmlLabelInfo values(15385,'',8) 
GO
insert into HtmlLabelInfo values(15386,'����',7) 
GO
insert into HtmlLabelInfo values(15386,'',8) 
GO
insert into HtmlLabelInfo values(15387,'ƫ������',7) 
GO
insert into HtmlLabelInfo values(15387,'',8) 
GO
insert into HtmlLabelInfo values(15388,'Ԥ������',7) 
GO
insert into HtmlLabelInfo values(15388,'',8) 
GO
insert into HtmlLabelInfo values(15389,'����ƫ��',7) 
GO
insert into HtmlLabelInfo values(15389,'',8) 
GO
insert into HtmlLabelInfo values(15390,'��������',7) 
GO
insert into HtmlLabelInfo values(15390,'',8) 
GO
insert into HtmlLabelInfo values(15391,'���ű��',7) 
GO
insert into HtmlLabelInfo values(15391,'',8) 
GO
insert into HtmlLabelInfo values(15392,'������',7) 
GO
insert into HtmlLabelInfo values(15392,'',8) 
GO
insert into HtmlLabelInfo values(15393,'��������',7) 
GO
insert into HtmlLabelInfo values(15393,'',8) 
GO
insert into HtmlLabelInfo values(15394,'��������',7) 
GO
insert into HtmlLabelInfo values(15394,'',8) 
GO
insert into HtmlLabelInfo values(15395,'���ʽ��',7) 
GO
insert into HtmlLabelInfo values(15395,'',8) 
GO
insert into HtmlLabelInfo values(15396,'������������',7) 
GO
insert into HtmlLabelInfo values(15396,'',8) 
GO
insert into HtmlLabelInfo values(15397,'��������',7) 
GO
insert into HtmlLabelInfo values(15397,'',8) 
GO
insert into HtmlLabelInfo values(15398,'�������',7) 
GO
insert into HtmlLabelInfo values(15398,'',8) 
GO
insert into HtmlLabelInfo values(15399,'��������',7) 
GO
insert into HtmlLabelInfo values(15399,'',8) 
GO
insert into HtmlLabelInfo values(15400,'����Ƿ���ۼ�',7) 
GO
insert into HtmlLabelInfo values(15400,'',8) 
GO
insert into HtmlLabelInfo values(15401,'����Ԥ��',7) 
GO
insert into HtmlLabelInfo values(15401,'',8) 
GO
insert into HtmlLabelInfo values(15402,'����Ԥ��',7) 
GO
insert into HtmlLabelInfo values(15402,'',8) 
GO
insert into HtmlLabelInfo values(15403,'������֧',7) 
GO
insert into HtmlLabelInfo values(15403,'',8) 
GO
insert into HtmlLabelInfo values(15404,'������֧',7) 
GO
insert into HtmlLabelInfo values(15404,'',8) 
GO
insert into HtmlLabelInfo values(15405,'�ͻ���֧',7) 
GO
insert into HtmlLabelInfo values(15405,'',8) 
GO
insert into HtmlLabelInfo values(15406,'��Ŀ��֧',7) 
GO
insert into HtmlLabelInfo values(15406,'',8) 
GO
insert into HtmlLabelInfo values(15407,'���������ϸ����',7) 
GO
insert into HtmlLabelInfo values(15407,'',8) 
GO
insert into HtmlLabelInfo values(15408,'����',7) 
GO
insert into HtmlLabelInfo values(15408,'',8) 
GO
insert into HtmlLabelInfo values(15409,'��Ŀ����',7) 
GO
insert into HtmlLabelInfo values(15409,'',8) 
GO
insert into HtmlLabelInfo values(15410,'���ڷ���',7) 
GO
insert into HtmlLabelInfo values(15410,'',8) 
GO
insert into HtmlLabelInfo values(15411,'�����ۼ�',7) 
GO
insert into HtmlLabelInfo values(15411,'',8) 
GO
insert into HtmlLabelInfo values(15412,'��ĩ���',7) 
GO
insert into HtmlLabelInfo values(15412,'',8) 
GO
insert into HtmlLabelInfo values(15413,'����',7) 
GO
insert into HtmlLabelInfo values(15413,'',8) 
GO
insert into HtmlLabelInfo values(15414,'��ʾ���Ϊ��ļ�¼',7) 
GO
insert into HtmlLabelInfo values(15414,'',8) 
GO
insert into HtmlLabelInfo values(15415,'��ʾ������Ϊ��ļ�¼',7) 
GO
insert into HtmlLabelInfo values(15415,'',8) 
GO
insert into HtmlLabelInfo values(15416,'��ʾ����δ����ƾ֤',7) 
GO
insert into HtmlLabelInfo values(15416,'',8) 
GO
insert into HtmlLabelInfo values(15417,'��Ԫ��',7) 
GO
insert into HtmlLabelInfo values(15417,'',8) 
GO
insert into HtmlLabelInfo values(15418,'�����ʽ𱨱�',7) 
GO
insert into HtmlLabelInfo values(15418,'',8) 
GO
insert into HtmlLabelInfo values(15419,'�������',7) 
GO
insert into HtmlLabelInfo values(15419,'',8) 
GO
insert into HtmlLabelInfo values(15420,'���ڽ跽����',7) 
GO
insert into HtmlLabelInfo values(15420,'',8) 
GO
insert into HtmlLabelInfo values(15421,'���ڴ�������',7) 
GO
insert into HtmlLabelInfo values(15421,'',8) 
GO
insert into HtmlLabelInfo values(15422,'�������',7) 
GO
insert into HtmlLabelInfo values(15422,'',8) 
GO
insert into HtmlLabelInfo values(15423,'�跽����',7) 
GO
insert into HtmlLabelInfo values(15423,'',8) 
GO
insert into HtmlLabelInfo values(15424,'��������',7) 
GO
insert into HtmlLabelInfo values(15424,'',8) 
GO
insert into HtmlLabelInfo values(15425,'������������',7) 
GO
insert into HtmlLabelInfo values(15425,'',8) 
GO
insert into HtmlLabelInfo values(15426,'�������',7) 
GO
insert into HtmlLabelInfo values(15426,'',8) 
GO
insert into HtmlLabelInfo values(15427,'Ԥ������״̬',7) 
GO
insert into HtmlLabelInfo values(15427,'',8) 
GO
insert into HtmlLabelInfo values(15428,'�¶���֧',7) 
GO
insert into HtmlLabelInfo values(15428,'',8) 
GO
insert into HtmlLabelInfo values(15429,'������֧',7) 
GO
insert into HtmlLabelInfo values(15429,'',8) 
GO
insert into HtmlLabelInfo values(15430,'������֧',7) 
GO
insert into HtmlLabelInfo values(15430,'',8) 
GO
insert into HtmlLabelInfo values(15431,'�����֧',7) 
GO
insert into HtmlLabelInfo values(15431,'',8) 
GO
insert into HtmlLabelInfo values(15432,'��ش���',7) 
GO
insert into HtmlLabelInfo values(15432,'',8) 
GO
insert into HtmlLabelInfo values(15433,'����������',7) 
GO
insert into HtmlLabelInfo values(15433,'',8) 
GO
insert into HtmlLabelInfo values(15434,'��������',7) 
GO
insert into HtmlLabelInfo values(15434,'',8) 
GO
insert into HtmlLabelInfo values(15435,'������',7) 
GO
insert into HtmlLabelInfo values(15435,'',8) 
GO
insert into HtmlLabelInfo values(15436,'�̶�����',7) 
GO
insert into HtmlLabelInfo values(15436,'',8) 
GO
insert into HtmlLabelInfo values(15437,'����������',7) 
GO
insert into HtmlLabelInfo values(15437,'',8) 
GO
insert into HtmlLabelInfo values(15438,'����ͼ�༭',7) 
GO
insert into HtmlLabelInfo values(15438,'',8) 
GO
insert into HtmlLabelInfo values(15439,'Ĭ���ܽ��',7) 
GO
insert into HtmlLabelInfo values(15439,'',8) 
GO
insert into HtmlLabelInfo values(15440,'���ֶ����Ѿ���ʹ��',7) 
GO
insert into HtmlLabelInfo values(15440,'',8) 
GO
insert into HtmlLabelInfo values(15441,'�ֶ�������������,���ұ�����Ӣ����ĸ��ͷ(��f4)',7) 
GO
insert into HtmlLabelInfo values(15441,'',8) 
GO
insert into HtmlLabelInfo values(15442,'��ѡ������',7) 
GO
insert into HtmlLabelInfo values(15442,'',8) 
GO
insert into HtmlLabelInfo values(15443,'�������',7) 
GO
insert into HtmlLabelInfo values(15443,'',8) 
GO
insert into HtmlLabelInfo values(15444,'ɾ������',7) 
GO
insert into HtmlLabelInfo values(15444,'',8) 
GO
insert into HtmlLabelInfo values(15445,'û��ѡ��һ��ɾ����',7) 
GO
insert into HtmlLabelInfo values(15445,'',8) 
GO
insert into HtmlLabelInfo values(15446,'ѡ����ֶ�',7) 
GO
insert into HtmlLabelInfo values(15446,'',8) 
GO
insert into HtmlLabelInfo values(15447,'��ѡ�ֶ�',7) 
GO
insert into HtmlLabelInfo values(15447,'',8) 
GO
insert into HtmlLabelInfo values(15448,'��ѡ�ֶ�',7) 
GO
insert into HtmlLabelInfo values(15448,'',8) 
GO
insert into HtmlLabelInfo values(15449,'�༭�ֶ�',7) 
GO
insert into HtmlLabelInfo values(15449,'',8) 
GO
insert into HtmlLabelInfo values(15450,'�༭��ʾ��',7) 
GO
insert into HtmlLabelInfo values(15450,'',8) 
GO
insert into HtmlLabelInfo values(15451,'������',7) 
GO
insert into HtmlLabelInfo values(15451,'',8) 
GO
insert into HtmlLabelInfo values(15452,'������',7) 
GO
insert into HtmlLabelInfo values(15452,'',8) 
GO
insert into HtmlLabelInfo values(15453,'ȫ���ֶ�',7) 
GO
insert into HtmlLabelInfo values(15453,'',8) 
GO
insert into HtmlLabelInfo values(15454,'��û���ֶ���Ϣ',7) 
GO
insert into HtmlLabelInfo values(15454,'',8) 
GO
insert into HtmlLabelInfo values(15455,'ȱʡ',7) 
GO
insert into HtmlLabelInfo values(15455,'',8) 
GO
insert into HtmlLabelInfo values(15456,'�ֶ���ʾ��',7) 
GO
insert into HtmlLabelInfo values(15456,'',8) 
GO
insert into HtmlLabelInfo values(15457,'������ѡ��һ������',7) 
GO
insert into HtmlLabelInfo values(15457,'',8) 
GO
insert into HtmlLabelInfo values(15458,'���������Ѿ�����,������ѡ��һ��',7) 
GO
insert into HtmlLabelInfo values(15458,'',8) 
GO
insert into HtmlLabelInfo values(15459,'ȷ��ɾ��ѡ������Ϣ��',7) 
GO
insert into HtmlLabelInfo values(15459,'',8) 
GO
insert into HtmlLabelInfo values(15460,'���к�',7) 
GO
insert into HtmlLabelInfo values(15460,'',8) 
GO
insert into HtmlLabelInfo values(15461,'�������',7) 
GO
insert into HtmlLabelInfo values(15461,'',8) 
GO
insert into HtmlLabelInfo values(15462,'��������',7) 
GO
insert into HtmlLabelInfo values(15462,'',8) 
GO
insert into HtmlLabelInfo values(15463,'û��ѡ��һ�����嵥��',7) 
GO
insert into HtmlLabelInfo values(15463,'',8) 
GO
insert into HtmlLabelInfo values(15464,'�����½�',7) 
GO
insert into HtmlLabelInfo values(15464,'',8) 
GO
insert into HtmlLabelInfo values(15465,'���ݺ�',7) 
GO
insert into HtmlLabelInfo values(15465,'',8) 
GO
insert into HtmlLabelInfo values(15466,'ӡˢ��˾',7) 
GO
insert into HtmlLabelInfo values(15466,'',8) 
GO
insert into HtmlLabelInfo values(15467,'��Ʊ��˾',7) 
GO
insert into HtmlLabelInfo values(15467,'',8) 
GO
insert into HtmlLabelInfo values(15468,'��Ʊ��',7) 
GO
insert into HtmlLabelInfo values(15468,'',8) 
GO
insert into HtmlLabelInfo values(15469,'��Ʊ����',7) 
GO
insert into HtmlLabelInfo values(15469,'',8) 
GO
insert into HtmlLabelInfo values(15470,'���ڿ��',7) 
GO
insert into HtmlLabelInfo values(15470,'',8) 
GO
insert into HtmlLabelInfo values(15471,'��ݹ�˾',7) 
GO
insert into HtmlLabelInfo values(15471,'',8) 
GO
insert into HtmlLabelInfo values(15472,'�ؿ�ר��',7) 
GO
insert into HtmlLabelInfo values(15472,'',8) 
GO
insert into HtmlLabelInfo values(15473,'��ƱԤ��',7) 
GO
insert into HtmlLabelInfo values(15473,'',8) 
GO
insert into HtmlLabelInfo values(15474,'���ý��',7) 
GO
insert into HtmlLabelInfo values(15474,'',8) 
GO
insert into HtmlLabelInfo values(15475,'������;',7) 
GO
insert into HtmlLabelInfo values(15475,'',8) 
GO
insert into HtmlLabelInfo values(15476,'Ҫ��ʱ��',7) 
GO
insert into HtmlLabelInfo values(15476,'',8) 
GO
insert into HtmlLabelInfo values(15477,'������˾�ϼ�',7) 
GO
insert into HtmlLabelInfo values(15477,'',8) 
GO
insert into HtmlLabelInfo values(15478,'�̶��ʲ�����',7) 
GO
insert into HtmlLabelInfo values(15478,'',8) 
GO
insert into HtmlLabelInfo values(15479,'Ԥ���ܽ��',7) 
GO
insert into HtmlLabelInfo values(15479,'',8) 
GO
insert into HtmlLabelInfo values(15480,'���벿��',7) 
GO
insert into HtmlLabelInfo values(15480,'',8) 
GO
insert into HtmlLabelInfo values(15481,'��������',7) 
GO
insert into HtmlLabelInfo values(15481,'',8) 
GO
insert into HtmlLabelInfo values(15482,'ԭ��',7) 
GO
insert into HtmlLabelInfo values(15482,'',8) 
GO
insert into HtmlLabelInfo values(15483,'�ʲ�״��',7) 
GO
insert into HtmlLabelInfo values(15483,'',8) 
GO
insert into HtmlLabelInfo values(15484,'����ԭ��',7) 
GO
insert into HtmlLabelInfo values(15484,'',8) 
GO
insert into HtmlLabelInfo values(15485,'���¹���С��',7) 
GO
insert into HtmlLabelInfo values(15485,'',8) 
GO
insert into HtmlLabelInfo values(15486,'���',7) 
GO
insert into HtmlLabelInfo values(15486,'',8) 
GO
insert into HtmlLabelInfo values(15487,'����������',7) 
GO
insert into HtmlLabelInfo values(15487,'',8) 
GO
insert into HtmlLabelInfo values(15488,'Ȩ��ָ��',7) 
GO
insert into HtmlLabelInfo values(15488,'',8) 
GO
insert into HtmlLabelInfo values(15489,'��������',7) 
GO
insert into HtmlLabelInfo values(15489,'',8) 
GO
insert into HtmlLabelInfo values(15490,'���¹����ƻ�',7) 
GO
insert into HtmlLabelInfo values(15490,'',8) 
GO
insert into HtmlLabelInfo values(15491,'���¹���Ŀ��',7) 
GO
insert into HtmlLabelInfo values(15491,'',8) 
GO
insert into HtmlLabelInfo values(15492,'��ɽ��',7) 
GO
insert into HtmlLabelInfo values(15492,'',8) 
GO
insert into HtmlLabelInfo values(15493,'���ܹ���С��',7) 
GO
insert into HtmlLabelInfo values(15493,'',8) 
GO
insert into HtmlLabelInfo values(15494,'��Ҫ����',7) 
GO
insert into HtmlLabelInfo values(15494,'',8) 
GO
insert into HtmlLabelInfo values(15495,'��ɵĽ��',7) 
GO
insert into HtmlLabelInfo values(15495,'',8) 
GO
insert into HtmlLabelInfo values(15496,'û�������',7) 
GO
insert into HtmlLabelInfo values(15496,'',8) 
GO
insert into HtmlLabelInfo values(15497,'ԭ���Ľ���ʩ',7) 
GO
insert into HtmlLabelInfo values(15497,'',8) 
GO
insert into HtmlLabelInfo values(15498,'���ܹ����ƻ�',7) 
GO
insert into HtmlLabelInfo values(15498,'',8) 
GO
insert into HtmlLabelInfo values(15499,'��Ҫ�ƻ�����',7) 
GO
insert into HtmlLabelInfo values(15499,'',8) 
GO
insert into HtmlLabelInfo values(15500,'Ԥ�����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15500,'',8) 
GO
insert into HtmlLabelInfo values(15501,'�ؼ�����',7) 
GO
insert into HtmlLabelInfo values(15501,'',8) 
GO
insert into HtmlLabelInfo values(15502,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15502,'',8) 
GO
insert into HtmlLabelInfo values(15503,'��������',7) 
GO
insert into HtmlLabelInfo values(15503,'',8) 
GO
insert into HtmlLabelInfo values(15504,'���',7) 
GO
insert into HtmlLabelInfo values(15504,'',8) 
GO
insert into HtmlLabelInfo values(15505,'��������',7) 
GO
insert into HtmlLabelInfo values(15505,'',8) 
GO
insert into HtmlLabelInfo values(15506,'������',7) 
GO
insert into HtmlLabelInfo values(15506,'',8) 
GO
insert into HtmlLabelInfo values(15507,'������',7) 
GO
insert into HtmlLabelInfo values(15507,'',8) 
GO
insert into HtmlLabelInfo values(15508,'����',7) 
GO
insert into HtmlLabelInfo values(15508,'',8) 
GO
insert into HtmlLabelInfo values(15509,'С��',7) 
GO
insert into HtmlLabelInfo values(15509,'',8) 
GO
insert into HtmlLabelInfo values(15510,'������ʾ��',7) 
GO
insert into HtmlLabelInfo values(15510,'',8) 
GO
insert into HtmlLabelInfo values(15511,'�Ƿ�ͳ��',7) 
GO
insert into HtmlLabelInfo values(15511,'',8) 
GO
insert into HtmlLabelInfo values(15512,'�����ֶ�',7) 
GO
insert into HtmlLabelInfo values(15512,'',8) 
GO
insert into HtmlLabelInfo values(15513,'��ʾ˳��',7) 
GO
insert into HtmlLabelInfo values(15513,'',8) 
GO
insert into HtmlLabelInfo values(15514,'�������',7) 
GO
insert into HtmlLabelInfo values(15514,'',8) 
GO
insert into HtmlLabelInfo values(15515,'��ʾ��',7) 
GO
insert into HtmlLabelInfo values(15515,'',8) 
GO
insert into HtmlLabelInfo values(15516,'�Ƿ������ֶ�',7) 
GO
insert into HtmlLabelInfo values(15516,'',8) 
GO
insert into HtmlLabelInfo values(15517,'��������',7) 
GO
insert into HtmlLabelInfo values(15517,'',8) 
GO
insert into HtmlLabelInfo values(15518,'���²�ѯ',7) 
GO
insert into HtmlLabelInfo values(15518,'',8) 
GO
insert into HtmlLabelInfo values(15519,'�����������',7) 
GO
insert into HtmlLabelInfo values(15519,'',8) 
GO
insert into HtmlLabelInfo values(15520,'��������',7) 
GO
insert into HtmlLabelInfo values(15520,'',8) 
GO
insert into HtmlLabelInfo values(15521,'��������',7) 
GO
insert into HtmlLabelInfo values(15521,'',8) 
GO
insert into HtmlLabelInfo values(15522,'��������',7) 
GO
insert into HtmlLabelInfo values(15522,'',8) 
GO
insert into HtmlLabelInfo values(15523,'���ʱ��',7) 
GO
insert into HtmlLabelInfo values(15523,'',8) 
GO
insert into HtmlLabelInfo values(15524,'�ƻ����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15524,'',8) 
GO
insert into HtmlLabelInfo values(15525,'������',7) 
GO
insert into HtmlLabelInfo values(15525,'',8) 
GO
insert into HtmlLabelInfo values(15526,'Ա���������ͳ��ͼ',7) 
GO
insert into HtmlLabelInfo values(15526,'',8) 
GO
insert into HtmlLabelInfo values(15527,'�̶��������',7) 
GO
insert into HtmlLabelInfo values(15527,'',8) 
GO
insert into HtmlLabelInfo values(15528,'ҳ������',7) 
GO
insert into HtmlLabelInfo values(15528,'',8) 
GO
insert into HtmlLabelInfo values(15529,'��Ӧģ��',7) 
GO
insert into HtmlLabelInfo values(15529,'',8) 
GO
insert into HtmlLabelInfo values(15530,'��ȡ��',7) 
GO
insert into HtmlLabelInfo values(15530,'',8) 
GO
insert into HtmlLabelInfo values(15531,'��������',7) 
GO
insert into HtmlLabelInfo values(15531,'',8) 
GO
insert into HtmlLabelInfo values(15532,'�̶�',7) 
GO
insert into HtmlLabelInfo values(15532,'',8) 
GO
insert into HtmlLabelInfo values(15533,'��Ҫ',7) 
GO
insert into HtmlLabelInfo values(15533,'',8) 
GO
insert into HtmlLabelInfo values(15534,'�����̶�',7) 
GO
insert into HtmlLabelInfo values(15534,'',8) 
GO
insert into HtmlLabelInfo values(15535,'û����ع�����',7) 
GO
insert into HtmlLabelInfo values(15535,'',8) 
GO
insert into HtmlLabelInfo values(15536,'�ڵ�����',7) 
GO
insert into HtmlLabelInfo values(15536,'',8) 
GO
insert into HtmlLabelInfo values(15537,'����',7) 
GO
insert into HtmlLabelInfo values(15537,'',8) 
GO
insert into HtmlLabelInfo values(15538,'���24Сʱ',7) 
GO
insert into HtmlLabelInfo values(15538,'',8) 
GO
insert into HtmlLabelInfo values(15539,'����',7) 
GO
insert into HtmlLabelInfo values(15539,'',8) 
GO
insert into HtmlLabelInfo values(15540,'�������',7) 
GO
insert into HtmlLabelInfo values(15540,'',8) 
GO
insert into HtmlLabelInfo values(15541,'����',7) 
GO
insert into HtmlLabelInfo values(15541,'',8) 
GO
insert into HtmlLabelInfo values(15542,'�����',7) 
GO
insert into HtmlLabelInfo values(15542,'',8) 
GO
insert into HtmlLabelInfo values(15543,'����ѡ����Ҫɾ������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15543,'',8) 
GO
insert into HtmlLabelInfo values(15544,'��������',7) 
GO
insert into HtmlLabelInfo values(15544,'',8) 
GO
insert into HtmlLabelInfo values(15545,'����������',7) 
GO
insert into HtmlLabelInfo values(15545,'',8) 
GO
insert into HtmlLabelInfo values(15546,'���͵Ľڵ�ֻ����һ��',7) 
GO
insert into HtmlLabelInfo values(15546,'',8) 
GO
insert into HtmlLabelInfo values(15547,'�ܷ�ȫ�̸���',7) 
GO
insert into HtmlLabelInfo values(15547,'',8) 
GO
insert into HtmlLabelInfo values(15548,'����������',7) 
GO
insert into HtmlLabelInfo values(15548,'',8) 
GO
insert into HtmlLabelInfo values(15549,'������Դ�ֶ�',7) 
GO
insert into HtmlLabelInfo values(15549,'',8) 
GO
insert into HtmlLabelInfo values(15550,'�ĵ��ֶ�',7) 
GO
insert into HtmlLabelInfo values(15550,'',8) 
GO
insert into HtmlLabelInfo values(15551,'��Ŀ�ֶ�',7) 
GO
insert into HtmlLabelInfo values(15551,'',8) 
GO
insert into HtmlLabelInfo values(15552,'�ʲ��ֶ�',7) 
GO
insert into HtmlLabelInfo values(15552,'',8) 
GO
insert into HtmlLabelInfo values(15553,'�ͻ��ֶ�',7) 
GO
insert into HtmlLabelInfo values(15553,'',8) 
GO
insert into HtmlLabelInfo values(15554,'�Ż����',7) 
GO
insert into HtmlLabelInfo values(15554,'',8) 
GO
insert into HtmlLabelInfo values(15555,'������Դ�ֶα���',7) 
GO
insert into HtmlLabelInfo values(15555,'',8) 
GO
insert into HtmlLabelInfo values(15556,'�ǻ�ǩ',7) 
GO
insert into HtmlLabelInfo values(15556,'',8) 
GO
insert into HtmlLabelInfo values(15557,'��ǩ',7) 
GO
insert into HtmlLabelInfo values(15557,'',8) 
GO
insert into HtmlLabelInfo values(15558,'�����������',7) 
GO
insert into HtmlLabelInfo values(15558,'',8) 
GO
insert into HtmlLabelInfo values(15559,'������Դ�ֶξ���',7) 
GO
insert into HtmlLabelInfo values(15559,'',8) 
GO
insert into HtmlLabelInfo values(15560,'������Դ�ֶ�����',7) 
GO
insert into HtmlLabelInfo values(15560,'',8) 
GO
insert into HtmlLabelInfo values(15561,'������Դ�ֶα��ֲ�',7) 
GO
insert into HtmlLabelInfo values(15561,'',8) 
GO
insert into HtmlLabelInfo values(15562,'������Դ�ֶα�����',7) 
GO
insert into HtmlLabelInfo values(15562,'',8) 
GO
insert into HtmlLabelInfo values(15563,'������Դ�ֶ��ϼ�����',7) 
GO
insert into HtmlLabelInfo values(15563,'',8) 
GO
insert into HtmlLabelInfo values(15564,'�ĵ��ֶ�������',7) 
GO
insert into HtmlLabelInfo values(15564,'',8) 
GO
insert into HtmlLabelInfo values(15565,'�ĵ��ֶηֲ�',7) 
GO
insert into HtmlLabelInfo values(15565,'',8) 
GO
insert into HtmlLabelInfo values(15566,'�ĵ��ֶβ���',7) 
GO
insert into HtmlLabelInfo values(15566,'',8) 
GO
insert into HtmlLabelInfo values(15567,'��Ŀ�ֶξ���',7) 
GO
insert into HtmlLabelInfo values(15567,'',8) 
GO
insert into HtmlLabelInfo values(15568,'��Ŀ�ֶηֲ�',7) 
GO
insert into HtmlLabelInfo values(15568,'',8) 
GO
insert into HtmlLabelInfo values(15569,'��Ŀ�ֶβ���',7) 
GO
insert into HtmlLabelInfo values(15569,'',8) 
GO
insert into HtmlLabelInfo values(15570,'��Ŀ�ֶγ�Ա',7) 
GO
insert into HtmlLabelInfo values(15570,'',8) 
GO
insert into HtmlLabelInfo values(15571,'�ʲ��ֶι���Ա',7) 
GO
insert into HtmlLabelInfo values(15571,'',8) 
GO
insert into HtmlLabelInfo values(15572,'�ʲ��ֶηֲ�',7) 
GO
insert into HtmlLabelInfo values(15572,'',8) 
GO
insert into HtmlLabelInfo values(15573,'�ʲ��ֶβ���',7) 
GO
insert into HtmlLabelInfo values(15573,'',8) 
GO
insert into HtmlLabelInfo values(15574,'�ͻ��ֶξ���',7) 
GO
insert into HtmlLabelInfo values(15574,'',8) 
GO
insert into HtmlLabelInfo values(15575,'�ͻ��ֶ���ϵ�˾���',7) 
GO
insert into HtmlLabelInfo values(15575,'',8) 
GO
insert into HtmlLabelInfo values(15576,'����������',7) 
GO
insert into HtmlLabelInfo values(15576,'',8) 
GO
insert into HtmlLabelInfo values(15577,'�����˱��ֲ�',7) 
GO
insert into HtmlLabelInfo values(15577,'',8) 
GO
insert into HtmlLabelInfo values(15578,'�������ϼ�����',7) 
GO
insert into HtmlLabelInfo values(15578,'',8) 
GO
insert into HtmlLabelInfo values(15579,'�ͻ�����',7) 
GO
insert into HtmlLabelInfo values(15579,'',8) 
GO
insert into HtmlLabelInfo values(15580,'�ͻ��ֶα���',7) 
GO
insert into HtmlLabelInfo values(15580,'',8) 
GO
insert into HtmlLabelInfo values(15581,'���пͻ�',7) 
GO
insert into HtmlLabelInfo values(15581,'',8) 
GO
insert into HtmlLabelInfo values(15582,'�������',7) 
GO
insert into HtmlLabelInfo values(15582,'',8) 
GO
insert into HtmlLabelInfo values(15583,'ɾ������',7) 
GO
insert into HtmlLabelInfo values(15583,'',8) 
GO
insert into HtmlLabelInfo values(15584,'����ѡ����������ֵ',7) 
GO
insert into HtmlLabelInfo values(15584,'',8) 
GO
insert into HtmlLabelInfo values(15585,'����ǩ',7) 
GO
insert into HtmlLabelInfo values(15585,'',8) 
GO
insert into HtmlLabelInfo values(15586,'�ڵ�',7) 
GO
insert into HtmlLabelInfo values(15586,'',8) 
GO
insert into HtmlLabelInfo values(15587,'����',7) 
GO
insert into HtmlLabelInfo values(15587,'',8) 
GO
insert into HtmlLabelInfo values(15588,'�Ƿ��Ż����',7) 
GO
insert into HtmlLabelInfo values(15588,'',8) 
GO
insert into HtmlLabelInfo values(15589,'���Ż����',7) 
GO
insert into HtmlLabelInfo values(15589,'',8) 
GO
insert into HtmlLabelInfo values(15590,'����',7) 
GO
insert into HtmlLabelInfo values(15590,'',8) 
GO
insert into HtmlLabelInfo values(15591,'�Ƿ���Ч',7) 
GO
insert into HtmlLabelInfo values(15591,'',8) 
GO
insert into HtmlLabelInfo values(15592,'�Ƿ���',7) 
GO
insert into HtmlLabelInfo values(15592,'',8) 
GO
insert into HtmlLabelInfo values(15593,'�����ĵ�',7) 
GO
insert into HtmlLabelInfo values(15593,'',8) 
GO
insert into HtmlLabelInfo values(15594,'����������',7) 
GO
insert into HtmlLabelInfo values(15594,'',8) 
GO
insert into HtmlLabelInfo values(15595,'���͵Ľڵ�����ֻ����һ��',7) 
GO
insert into HtmlLabelInfo values(15595,'',8) 
GO
insert into HtmlLabelInfo values(15596,'�������ڵ�',7) 
GO
insert into HtmlLabelInfo values(15596,'',8) 
GO
insert into HtmlLabelInfo values(15597,'��ѡ��ڵ�����',7) 
GO
insert into HtmlLabelInfo values(15597,'',8) 
GO
insert into HtmlLabelInfo values(15598,'��ӽڵ�',7) 
GO
insert into HtmlLabelInfo values(15598,'',8) 
GO
insert into HtmlLabelInfo values(15599,'ɾ���ڵ�',7) 
GO
insert into HtmlLabelInfo values(15599,'',8) 
GO
insert into HtmlLabelInfo values(15600,'��Ӧ��',7) 
GO
insert into HtmlLabelInfo values(15600,'',8) 
GO
insert into HtmlLabelInfo values(15601,'�ֶ���Ϣ',7) 
GO
insert into HtmlLabelInfo values(15601,'',8) 
GO
insert into HtmlLabelInfo values(15602,'��ѡ��ǰ�ڵ�',7) 
GO
insert into HtmlLabelInfo values(15602,'',8) 
GO
insert into HtmlLabelInfo values(15603,'�Ƿ���ʾ',7) 
GO
insert into HtmlLabelInfo values(15603,'',8) 
GO
insert into HtmlLabelInfo values(15604,'�Ƿ�ɱ༭',7) 
GO
insert into HtmlLabelInfo values(15604,'',8) 
GO
insert into HtmlLabelInfo values(15605,'�Ƿ��������',7) 
GO
insert into HtmlLabelInfo values(15605,'',8) 
GO
insert into HtmlLabelInfo values(15606,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15606,'',8) 
GO
insert into HtmlLabelInfo values(15607,'��ӳ���',7) 
GO
insert into HtmlLabelInfo values(15607,'',8) 
GO
insert into HtmlLabelInfo values(15608,'ɾ������',7) 
GO
insert into HtmlLabelInfo values(15608,'',8) 
GO
insert into HtmlLabelInfo values(15609,'�Ƿ�reject',7) 
GO
insert into HtmlLabelInfo values(15609,'',8) 
GO
insert into HtmlLabelInfo values(15610,'���ӹ���',7) 
GO
insert into HtmlLabelInfo values(15610,'',8) 
GO
insert into HtmlLabelInfo values(15611,'��������',7) 
GO
insert into HtmlLabelInfo values(15611,'',8) 
GO
insert into HtmlLabelInfo values(15612,'��ѡ��Ŀ��ڵ�',7) 
GO
insert into HtmlLabelInfo values(15612,'',8) 
GO
insert into HtmlLabelInfo values(15613,'���ȱ����²���Ľڵ����',7) 
GO
insert into HtmlLabelInfo values(15613,'',8) 
GO
insert into HtmlLabelInfo values(15614,'����ҳʹ���˿�ܣ��������������֧�ֿ�ܡ�',7) 
GO
insert into HtmlLabelInfo values(15614,'',8) 
GO
insert into HtmlLabelInfo values(15615,'�ڵ���Ϣ',7) 
GO
insert into HtmlLabelInfo values(15615,'',8) 
GO
insert into HtmlLabelInfo values(15616,'���Ӳ���',7) 
GO
insert into HtmlLabelInfo values(15616,'',8) 
GO
insert into HtmlLabelInfo values(15617,'ɾ����������ɾ���ù������µ���������,�����ܵ���ϵͳ�������Щ��������ӳ��ִ���!',7) 
GO
insert into HtmlLabelInfo values(15617,'',8) 
GO
insert into HtmlLabelInfo values(15618,'��һ�ֶ�',7) 
GO
insert into HtmlLabelInfo values(15618,'',8) 
GO
insert into HtmlLabelInfo values(15619,'�ڶ��ֶ�',7) 
GO
insert into HtmlLabelInfo values(15619,'',8) 
GO
insert into HtmlLabelInfo values(15620,'Ŀ���ֶ�',7) 
GO
insert into HtmlLabelInfo values(15620,'',8) 
GO
insert into HtmlLabelInfo values(15621,'��',7) 
GO
insert into HtmlLabelInfo values(15621,'',8) 
GO
insert into HtmlLabelInfo values(15622,'��',7) 
GO
insert into HtmlLabelInfo values(15622,'',8) 
GO
insert into HtmlLabelInfo values(15623,'��',7) 
GO
insert into HtmlLabelInfo values(15623,'',8) 
GO
insert into HtmlLabelInfo values(15624,'��',7) 
GO
insert into HtmlLabelInfo values(15624,'',8) 
GO
insert into HtmlLabelInfo values(15625,'��ǰ����',7) 
GO
insert into HtmlLabelInfo values(15625,'',8) 
GO
insert into HtmlLabelInfo values(15626,'��ǰʱ��',7) 
GO
insert into HtmlLabelInfo values(15626,'',8) 
GO
insert into HtmlLabelInfo values(15627,'��ʱʱ�����',7) 
GO
insert into HtmlLabelInfo values(15627,'',8) 
GO
insert into HtmlLabelInfo values(15628,'��ʱ���ڱ���',7) 
GO
insert into HtmlLabelInfo values(15628,'',8) 
GO
insert into HtmlLabelInfo values(15629,'��ʱ�ı�����',7) 
GO
insert into HtmlLabelInfo values(15629,'',8) 
GO
insert into HtmlLabelInfo values(15630,'��ʱ���ͱ���',7) 
GO
insert into HtmlLabelInfo values(15630,'',8) 
GO
insert into HtmlLabelInfo values(15631,'��ʱ�����ͱ���',7) 
GO
insert into HtmlLabelInfo values(15631,'',8) 
GO
insert into HtmlLabelInfo values(15632,'�Զ���ֵ',7) 
GO
insert into HtmlLabelInfo values(15632,'',8) 
GO
insert into HtmlLabelInfo values(15633,'�Ƿ�������ĩ',7) 
GO
insert into HtmlLabelInfo values(15633,'',8) 
GO
insert into HtmlLabelInfo values(15634,'�Ƿ�������������',7) 
GO
insert into HtmlLabelInfo values(15634,'',8) 
GO
insert into HtmlLabelInfo values(15635,'���㷨��',7) 
GO
insert into HtmlLabelInfo values(15635,'',8) 
GO
insert into HtmlLabelInfo values(15636,'���ʽ',7) 
GO
insert into HtmlLabelInfo values(15636,'',8) 
GO
insert into HtmlLabelInfo values(15637,'��������',7) 
GO
insert into HtmlLabelInfo values(15637,'',8) 
GO
insert into HtmlLabelInfo values(15638,'������ĩ',7) 
GO
insert into HtmlLabelInfo values(15638,'',8) 
GO
insert into HtmlLabelInfo values(15639,'������������',7) 
GO
insert into HtmlLabelInfo values(15639,'',8) 
GO
insert into HtmlLabelInfo values(15640,'����ѡ���һ���ֶ�',7) 
GO
insert into HtmlLabelInfo values(15640,'',8) 
GO
insert into HtmlLabelInfo values(15641,'����ѡ���������',7) 
GO
insert into HtmlLabelInfo values(15641,'',8) 
GO
insert into HtmlLabelInfo values(15642,'Ŀ���ֶβ���Ϊ��',7) 
GO
insert into HtmlLabelInfo values(15642,'',8) 
GO
insert into HtmlLabelInfo values(15643,'�������Ͳ�ƥ��',7) 
GO
insert into HtmlLabelInfo values(15643,'',8) 
GO
insert into HtmlLabelInfo values(15644,'���������Ͳ�ƥ��',7) 
GO
insert into HtmlLabelInfo values(15644,'',8) 
GO
insert into HtmlLabelInfo values(15645,'�������Ͳ�ƥ��',7) 
GO
insert into HtmlLabelInfo values(15645,'',8) 
GO
insert into HtmlLabelInfo values(15646,'ʱ�����Ͳ�ƥ��',7) 
GO
insert into HtmlLabelInfo values(15646,'',8) 
GO
insert into HtmlLabelInfo values(15647,'����������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15647,'',8) 
GO
insert into HtmlLabelInfo values(15648,'��������',7) 
GO
insert into HtmlLabelInfo values(15648,'',8) 
GO
insert into HtmlLabelInfo values(15649,'�ܳɼ�',7) 
GO
insert into HtmlLabelInfo values(15649,'',8) 
GO
insert into HtmlLabelInfo values(15650,'�ܿ�����',7) 
GO
insert into HtmlLabelInfo values(15650,'',8) 
GO
insert into HtmlLabelInfo values(15651,'�ѿ�����',7) 
GO
insert into HtmlLabelInfo values(15651,'',8) 
GO
insert into HtmlLabelInfo values(15652,'��ǰ����',7) 
GO
insert into HtmlLabelInfo values(15652,'',8) 
GO
insert into HtmlLabelInfo values(15653,'��������',7) 
GO
insert into HtmlLabelInfo values(15653,'',8) 
GO
insert into HtmlLabelInfo values(15654,'�ܵı�������',7) 
GO
insert into HtmlLabelInfo values(15654,'',8) 
GO
insert into HtmlLabelInfo values(15655,'�ܵĿ�����',7) 
GO
insert into HtmlLabelInfo values(15655,'',8) 
GO
insert into HtmlLabelInfo values(15656,'����ɿ���',7) 
GO
insert into HtmlLabelInfo values(15656,'',8) 
GO
insert into HtmlLabelInfo values(15657,'�ɼ�',7) 
GO
insert into HtmlLabelInfo values(15657,'',8) 
GO
insert into HtmlLabelInfo values(15658,'����',7) 
GO
insert into HtmlLabelInfo values(15658,'',8) 
GO
insert into HtmlLabelInfo values(15659,'�ϸ�',7) 
GO
insert into HtmlLabelInfo values(15659,'',8) 
GO
insert into HtmlLabelInfo values(15660,'��',7) 
GO
insert into HtmlLabelInfo values(15660,'',8) 
GO
insert into HtmlLabelInfo values(15661,'����',7) 
GO
insert into HtmlLabelInfo values(15661,'',8) 
GO
insert into HtmlLabelInfo values(15662,'������',7) 
GO
insert into HtmlLabelInfo values(15662,'',8) 
GO
insert into HtmlLabelInfo values(15663,'�ܷ�',7) 
GO
insert into HtmlLabelInfo values(15663,'',8) 
GO
insert into HtmlLabelInfo values(15664,'������Ա',7) 
GO
insert into HtmlLabelInfo values(15664,'',8) 
GO
insert into HtmlLabelInfo values(15665,'���ͱ���',7) 
GO
insert into HtmlLabelInfo values(15665,'',8) 
GO
insert into HtmlLabelInfo values(15666,'��������',7) 
GO
insert into HtmlLabelInfo values(15666,'',8) 
GO
insert into HtmlLabelInfo values(15667,'�������',7) 
GO
insert into HtmlLabelInfo values(15667,'',8) 
GO
insert into HtmlLabelInfo values(15668,'��Ƹ����',7) 
GO
insert into HtmlLabelInfo values(15668,'',8) 
GO
insert into HtmlLabelInfo values(15669,'֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(15669,'',8) 
GO
insert into HtmlLabelInfo values(15670,'��Ա����ְ����',7) 
GO
insert into HtmlLabelInfo values(15670,'',8) 
GO
insert into HtmlLabelInfo values(15671,'ӦƸ��λ',7) 
GO
insert into HtmlLabelInfo values(15671,'',8) 
GO
insert into HtmlLabelInfo values(15672,'���θ�λ',7) 
GO
insert into HtmlLabelInfo values(15672,'',8) 
GO
insert into HtmlLabelInfo values(15673,'��н����',7) 
GO
insert into HtmlLabelInfo values(15673,'',8) 
GO
insert into HtmlLabelInfo values(15674,'����',7) 
GO
insert into HtmlLabelInfo values(15674,'',8) 
GO
insert into HtmlLabelInfo values(15675,'ӦƸ�����',7) 
GO
insert into HtmlLabelInfo values(15675,'',8) 
GO
insert into HtmlLabelInfo values(15676,'�뿪ԭ��',7) 
GO
insert into HtmlLabelInfo values(15676,'',8) 
GO
insert into HtmlLabelInfo values(15677,'��ѵ���',7) 
GO
insert into HtmlLabelInfo values(15677,'',8) 
GO
insert into HtmlLabelInfo values(15678,'��ѵ����',7) 
GO
insert into HtmlLabelInfo values(15678,'',8) 
GO
insert into HtmlLabelInfo values(15679,'��ѵ��ʼ����',7) 
GO
insert into HtmlLabelInfo values(15679,'',8) 
GO
insert into HtmlLabelInfo values(15680,'��ѵ��������',7) 
GO
insert into HtmlLabelInfo values(15680,'',8) 
GO
insert into HtmlLabelInfo values(15681,'�䷢��λ',7) 
GO
insert into HtmlLabelInfo values(15681,'',8) 
GO
insert into HtmlLabelInfo values(15682,'�������',7) 
GO
insert into HtmlLabelInfo values(15682,'',8) 
GO
insert into HtmlLabelInfo values(15683,'����',7) 
GO
insert into HtmlLabelInfo values(15683,'',8) 
GO
insert into HtmlLabelInfo values(15684,'�����Ա',7) 
GO
insert into HtmlLabelInfo values(15684,'',8) 
GO
insert into HtmlLabelInfo values(15685,'��ס֤����',7) 
GO
insert into HtmlLabelInfo values(15685,'',8) 
GO
insert into HtmlLabelInfo values(15686,'��ͥ״��',7) 
GO
insert into HtmlLabelInfo values(15686,'',8) 
GO
insert into HtmlLabelInfo values(15687,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15687,'',8) 
GO
insert into HtmlLabelInfo values(15688,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15688,'',8) 
GO
insert into HtmlLabelInfo values(15689,'����',7) 
GO
insert into HtmlLabelInfo values(15689,'',8) 
GO
insert into HtmlLabelInfo values(15690,'��̭',7) 
GO
insert into HtmlLabelInfo values(15690,'',8) 
GO
insert into HtmlLabelInfo values(15691,'�ʼ�֪ͨ',7) 
GO
insert into HtmlLabelInfo values(15691,'',8) 
GO
insert into HtmlLabelInfo values(15692,'��Ƹ��Ϣ����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15692,'',8) 
GO
insert into HtmlLabelInfo values(15693,'���п���',7) 
GO
insert into HtmlLabelInfo values(15693,'',8) 
GO
insert into HtmlLabelInfo values(15694,'��������',7) 
GO
insert into HtmlLabelInfo values(15694,'',8) 
GO
insert into HtmlLabelInfo values(15695,'������',7) 
GO
insert into HtmlLabelInfo values(15695,'',8) 
GO
insert into HtmlLabelInfo values(15696,'��������',7) 
GO
insert into HtmlLabelInfo values(15696,'',8) 
GO
insert into HtmlLabelInfo values(15697,'�������',7) 
GO
insert into HtmlLabelInfo values(15697,'',8) 
GO
insert into HtmlLabelInfo values(15698,'����',7) 
GO
insert into HtmlLabelInfo values(15698,'',8) 
GO
insert into HtmlLabelInfo values(15699,'���ϸ�',7) 
GO
insert into HtmlLabelInfo values(15699,'',8) 
GO
insert into HtmlLabelInfo values(15700,'��',7) 
GO
insert into HtmlLabelInfo values(15700,'',8) 
GO
insert into HtmlLabelInfo values(15701,'���п���',7) 
GO
insert into HtmlLabelInfo values(15701,'',8) 
GO
insert into HtmlLabelInfo values(15702,'��������',7) 
GO
insert into HtmlLabelInfo values(15702,'',8) 
GO
insert into HtmlLabelInfo values(15703,'���˽��',7) 
GO
insert into HtmlLabelInfo values(15703,'',8) 
GO
insert into HtmlLabelInfo values(15704,'����',7) 
GO
insert into HtmlLabelInfo values(15704,'',8) 
GO
insert into HtmlLabelInfo values(15705,'�Ƿ���֪ͨ',7) 
GO
insert into HtmlLabelInfo values(15705,'',8) 
GO
insert into HtmlLabelInfo values(15706,'δ����',7) 
GO
insert into HtmlLabelInfo values(15706,'',8) 
GO
insert into HtmlLabelInfo values(15707,'��Ƭ',7) 
GO
insert into HtmlLabelInfo values(15707,'',8) 
GO
insert into HtmlLabelInfo values(15708,'ְ������',7) 
GO
insert into HtmlLabelInfo values(15708,'',8) 
GO
insert into HtmlLabelInfo values(15709,'ֱ���ϼ�',7) 
GO
insert into HtmlLabelInfo values(15709,'',8) 
GO
insert into HtmlLabelInfo values(15710,'����',7) 
GO
insert into HtmlLabelInfo values(15710,'',8) 
GO
insert into HtmlLabelInfo values(15711,'��ʽ',7) 
GO
insert into HtmlLabelInfo values(15711,'',8) 
GO
insert into HtmlLabelInfo values(15712,'�칫�ص�',7) 
GO
insert into HtmlLabelInfo values(15712,'',8) 
GO
insert into HtmlLabelInfo values(15713,'�칫�绰',7) 
GO
insert into HtmlLabelInfo values(15713,'',8) 
GO
insert into HtmlLabelInfo values(15714,'�����绰',7) 
GO
insert into HtmlLabelInfo values(15714,'',8) 
GO
insert into HtmlLabelInfo values(15715,'ˮƽ',7) 
GO
insert into HtmlLabelInfo values(15715,'',8) 
GO
insert into HtmlLabelInfo values(15716,'��ְǰ��������',7) 
GO
insert into HtmlLabelInfo values(15716,'',8) 
GO
insert into HtmlLabelInfo values(15717,'��ְǰ��ѵ',7) 
GO
insert into HtmlLabelInfo values(15717,'',8) 
GO
insert into HtmlLabelInfo values(15718,'��ְǰ����',7) 
GO
insert into HtmlLabelInfo values(15718,'',8) 
GO
insert into HtmlLabelInfo values(15719,'���Ϸ���',7) 
GO
insert into HtmlLabelInfo values(15719,'',8) 
GO
insert into HtmlLabelInfo values(15720,'��Ƹ�ճ�',7) 
GO
insert into HtmlLabelInfo values(15720,'',8) 
GO
insert into HtmlLabelInfo values(15721,'�����',7) 
GO
insert into HtmlLabelInfo values(15721,'',8) 
GO
insert into HtmlLabelInfo values(15722,'��˿�ʼ����',7) 
GO
insert into HtmlLabelInfo values(15722,'',8) 
GO
insert into HtmlLabelInfo values(15723,'��˽�������',7) 
GO
insert into HtmlLabelInfo values(15723,'',8) 
GO
insert into HtmlLabelInfo values(15724,'֪ͨ����',7) 
GO
insert into HtmlLabelInfo values(15724,'',8) 
GO
insert into HtmlLabelInfo values(15725,'֪ͨ����',7) 
GO
insert into HtmlLabelInfo values(15725,'',8) 
GO
insert into HtmlLabelInfo values(15726,'ȷ��Ҫ֪ͨ�������?',7) 
GO
insert into HtmlLabelInfo values(15726,'',8) 
GO
insert into HtmlLabelInfo values(15727,'���Կ���֪ͨ',7) 
GO
insert into HtmlLabelInfo values(15727,'',8) 
GO
insert into HtmlLabelInfo values(15728,'�ܽὨ��',7) 
GO
insert into HtmlLabelInfo values(15728,'',8) 
GO
insert into HtmlLabelInfo values(15729,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15729,'',8) 
GO
insert into HtmlLabelInfo values(15730,'��������',7) 
GO
insert into HtmlLabelInfo values(15730,'',8) 
GO
insert into HtmlLabelInfo values(15731,'���Բ���',7) 
GO
insert into HtmlLabelInfo values(15731,'',8) 
GO
insert into HtmlLabelInfo values(15732,'��������',7) 
GO
insert into HtmlLabelInfo values(15732,'',8) 
GO
insert into HtmlLabelInfo values(15733,'��������',7) 
GO
insert into HtmlLabelInfo values(15733,'',8) 
GO
insert into HtmlLabelInfo values(15734,'����ʱ��',7) 
GO
insert into HtmlLabelInfo values(15734,'',8) 
GO
insert into HtmlLabelInfo values(15735,'���Եص�',7) 
GO
insert into HtmlLabelInfo values(15735,'',8) 
GO
insert into HtmlLabelInfo values(15736,'ע������',7) 
GO
insert into HtmlLabelInfo values(15736,'',8) 
GO
insert into HtmlLabelInfo values(15737,'���Խ��',7) 
GO
insert into HtmlLabelInfo values(15737,'',8) 
GO
insert into HtmlLabelInfo values(15738,'�������',7) 
GO
insert into HtmlLabelInfo values(15738,'',8) 
GO
insert into HtmlLabelInfo values(15739,'������',7) 
GO
insert into HtmlLabelInfo values(15739,'',8) 
GO
insert into HtmlLabelInfo values(15740,'ȷ��Ҫ��̭��',7) 
GO
insert into HtmlLabelInfo values(15740,'',8) 
GO
insert into HtmlLabelInfo values(15741,'ȷ��Ҫͨ����',7) 
GO
insert into HtmlLabelInfo values(15741,'',8) 
GO
insert into HtmlLabelInfo values(15742,'ȷ��Ҫת�뱸�ÿ���',7) 
GO
insert into HtmlLabelInfo values(15742,'',8) 
GO
insert into HtmlLabelInfo values(15743,'��Ƹ����֪ͨ',7) 
GO
insert into HtmlLabelInfo values(15743,'',8) 
GO
insert into HtmlLabelInfo values(15744,'��Ƹʱ��',7) 
GO
insert into HtmlLabelInfo values(15744,'',8) 
GO
insert into HtmlLabelInfo values(15745,'��Ƹ����',7) 
GO
insert into HtmlLabelInfo values(15745,'',8) 
GO
insert into HtmlLabelInfo values(15746,'δ����',7) 
GO
insert into HtmlLabelInfo values(15746,'',8) 
GO
insert into HtmlLabelInfo values(15747,'������Ƹ',7) 
GO
insert into HtmlLabelInfo values(15747,'',8) 
GO
insert into HtmlLabelInfo values(15748,'������',7) 
GO
insert into HtmlLabelInfo values(15748,'',8) 
GO
insert into HtmlLabelInfo values(15749,'����',7) 
GO
insert into HtmlLabelInfo values(15749,'',8) 
GO
insert into HtmlLabelInfo values(15750,'ʧЧ',7) 
GO
insert into HtmlLabelInfo values(15750,'',8) 
GO
insert into HtmlLabelInfo values(15751,'ȷ��Ҫ�ر���',7) 
GO
insert into HtmlLabelInfo values(15751,'',8) 
GO
insert into HtmlLabelInfo values(15752,'����˵��',7) 
GO
insert into HtmlLabelInfo values(15752,'',8) 
GO
insert into HtmlLabelInfo values(15753,'����������',7) 
GO
insert into HtmlLabelInfo values(15753,'',8) 
GO
insert into HtmlLabelInfo values(15754,'������˵��',7) 
GO
insert into HtmlLabelInfo values(15754,'',8) 
GO
insert into HtmlLabelInfo values(15755,'������������',7) 
GO
insert into HtmlLabelInfo values(15755,'',8) 
GO
insert into HtmlLabelInfo values(15756,'��������',7) 
GO
insert into HtmlLabelInfo values(15756,'',8) 
GO
insert into HtmlLabelInfo values(15757,'������',7) 
GO
insert into HtmlLabelInfo values(15757,'',8) 
GO
insert into HtmlLabelInfo values(15758,'���˿�ʼ����',7) 
GO
insert into HtmlLabelInfo values(15758,'',8) 
GO
insert into HtmlLabelInfo values(15759,'��������',7) 
GO
insert into HtmlLabelInfo values(15759,'',8) 
GO
insert into HtmlLabelInfo values(15760,'���˲�����',7) 
GO
insert into HtmlLabelInfo values(15760,'',8) 
GO
insert into HtmlLabelInfo values(15761,'������',7) 
GO
insert into HtmlLabelInfo values(15761,'',8) 
GO
insert into HtmlLabelInfo values(15762,'�����ϼ�',7) 
GO
insert into HtmlLabelInfo values(15762,'',8) 
GO
insert into HtmlLabelInfo values(15763,'����',7) 
GO
insert into HtmlLabelInfo values(15763,'',8) 
GO
insert into HtmlLabelInfo values(15764,'ֱ���¼�',7) 
GO
insert into HtmlLabelInfo values(15764,'',8) 
GO
insert into HtmlLabelInfo values(15765,'�����¼�',7) 
GO
insert into HtmlLabelInfo values(15765,'',8) 
GO
insert into HtmlLabelInfo values(15766,'������������',7) 
GO
insert into HtmlLabelInfo values(15766,'',8) 
GO
insert into HtmlLabelInfo values(15767,'ȫ��',7) 
GO
insert into HtmlLabelInfo values(15767,'',8) 
GO
insert into HtmlLabelInfo values(15768,'��˾��վ',7) 
GO
insert into HtmlLabelInfo values(15768,'',8) 
GO
insert into HtmlLabelInfo values(15769,'�����ֳɱ�����',7) 
GO
insert into HtmlLabelInfo values(15769,'',8) 
GO
insert into HtmlLabelInfo values(15770,'�½��ɱ�����',7) 
GO
insert into HtmlLabelInfo values(15770,'',8) 
GO
insert into HtmlLabelInfo values(15771,'���Ʋ��Žṹͼ����',7) 
GO
insert into HtmlLabelInfo values(15771,'',8) 
GO
insert into HtmlLabelInfo values(15772,'�ϼ�����',7) 
GO
insert into HtmlLabelInfo values(15772,'',8) 
GO
insert into HtmlLabelInfo values(15773,'�ϼ����Ų���Ϊ������!',7) 
GO
insert into HtmlLabelInfo values(15773,'',8) 
GO
insert into HtmlLabelInfo values(15774,'��������',7) 
GO
insert into HtmlLabelInfo values(15774,'',8) 
GO
insert into HtmlLabelInfo values(15775,'��ͬ����',7) 
GO
insert into HtmlLabelInfo values(15775,'',8) 
GO
insert into HtmlLabelInfo values(15776,'��ͬ��',7) 
GO
insert into HtmlLabelInfo values(15776,'',8) 
GO
insert into HtmlLabelInfo values(15777,'��ͬ��ֹ����',7) 
GO
insert into HtmlLabelInfo values(15777,'',8) 
GO
insert into HtmlLabelInfo values(15778,'�����ڽ�������',7) 
GO
insert into HtmlLabelInfo values(15778,'',8) 
GO
insert into HtmlLabelInfo values(15779,'�������ͬ�ˣ���',7) 
GO
insert into HtmlLabelInfo values(15779,'',8) 
GO
insert into HtmlLabelInfo values(15780,'��ͬ���',7) 
GO
insert into HtmlLabelInfo values(15780,'',8) 
GO
insert into HtmlLabelInfo values(15781,'֪ͨ',7) 
GO
insert into HtmlLabelInfo values(15781,'',8) 
GO
insert into HtmlLabelInfo values(15782,'ȷ��Ҫ֪ͨ��',7) 
GO
insert into HtmlLabelInfo values(15782,'',8) 
GO
insert into HtmlLabelInfo values(15783,'������Դ��ͬ����֪ͨ',7) 
GO
insert into HtmlLabelInfo values(15783,'',8) 
GO
insert into HtmlLabelInfo values(15784,'�����ڵ���֪ͨ',7) 
GO
insert into HtmlLabelInfo values(15784,'',8) 
GO
insert into HtmlLabelInfo values(15785,'ѡ���ͬ���',7) 
GO
insert into HtmlLabelInfo values(15785,'',8) 
GO
insert into HtmlLabelInfo values(15786,'��ͬģ��',7) 
GO
insert into HtmlLabelInfo values(15786,'',8) 
GO
insert into HtmlLabelInfo values(15787,'���Ŀ¼',7) 
GO
insert into HtmlLabelInfo values(15787,'',8) 
GO
insert into HtmlLabelInfo values(15788,'��ְ��ͬ',7) 
GO
insert into HtmlLabelInfo values(15788,'',8) 
GO
insert into HtmlLabelInfo values(15789,'������ǰ������',7) 
GO
insert into HtmlLabelInfo values(15789,'',8) 
GO
insert into HtmlLabelInfo values(16445,'�汾���к�',7) 
GO
insert into HtmlLabelInfo values(15791,'�Ƿ�Ϊ��ְ��ͬ',7) 
GO
insert into HtmlLabelInfo values(15791,'',8) 
GO
insert into HtmlLabelInfo values(15792,'������ǰ����',7) 
GO
insert into HtmlLabelInfo values(15792,'',8) 
GO
insert into HtmlLabelInfo values(15793,'������',7) 
GO
insert into HtmlLabelInfo values(15793,'',8) 
GO
insert into HtmlLabelInfo values(15794,'�������ͬģ��',7) 
GO
insert into HtmlLabelInfo values(15794,'',8) 
GO
insert into HtmlLabelInfo values(15795,'��������',7) 
GO
insert into HtmlLabelInfo values(15795,'',8) 
GO
insert into HtmlLabelInfo values(15796,'�鿴��Ա��',7) 
GO
insert into HtmlLabelInfo values(15796,'',8) 
GO
insert into HtmlLabelInfo values(15797,'��ְ����',7) 
GO
insert into HtmlLabelInfo values(15797,'',8) 
GO
insert into HtmlLabelInfo values(15798,'������ְ�趨',7) 
GO
insert into HtmlLabelInfo values(15798,'',8) 
GO
insert into HtmlLabelInfo values(15799,'�ʼ��ʻ�',7) 
GO
insert into HtmlLabelInfo values(15799,'',8) 
GO
insert into HtmlLabelInfo values(15800,'һ��ͨ',7) 
GO
insert into HtmlLabelInfo values(15800,'',8) 
GO
insert into HtmlLabelInfo values(15801,'��λ��',7) 
GO
insert into HtmlLabelInfo values(15801,'',8) 
GO
insert into HtmlLabelInfo values(15802,'�ֻ�ֱ��',7) 
GO
insert into HtmlLabelInfo values(15802,'',8) 
GO
insert into HtmlLabelInfo values(15803,'������ȷ�����벻����',7) 
GO
insert into HtmlLabelInfo values(15803,'',8) 
GO
insert into HtmlLabelInfo values(15804,'ϵͳ��Ϣ',7) 
GO
insert into HtmlLabelInfo values(15804,'',8) 
GO
insert into HtmlLabelInfo values(15805,'������Ϣ',7) 
GO
insert into HtmlLabelInfo values(15805,'',8) 
GO
insert into HtmlLabelInfo values(15806,'�ʲ���Ϣ',7) 
GO
insert into HtmlLabelInfo values(15806,'',8) 
GO
insert into HtmlLabelInfo values(15807,'��������Ա',7) 
GO
insert into HtmlLabelInfo values(15807,'',8) 
GO
insert into HtmlLabelInfo values(15808,'δ����',7) 
GO
insert into HtmlLabelInfo values(15808,'',8) 
GO
insert into HtmlLabelInfo values(15809,'������',7) 
GO
insert into HtmlLabelInfo values(15809,'',8) 
GO
insert into HtmlLabelInfo values(15810,'ȷ��Ҫ�����Ա��������',7) 
GO
insert into HtmlLabelInfo values(15810,'',8) 
GO
insert into HtmlLabelInfo values(15811,'��һЩ����û����ɣ�ȷ��Ҫǿ�������Ա��������',7) 
GO
insert into HtmlLabelInfo values(15811,'',8) 
GO
insert into HtmlLabelInfo values(15812,'��������',7) 
GO
insert into HtmlLabelInfo values(15812,'',8) 
GO
insert into HtmlLabelInfo values(15813,'��������Դ�����ʻ�ʹ�ø�����,�����в���ɾ��',7) 
GO
insert into HtmlLabelInfo values(15813,'',8) 
GO
insert into HtmlLabelInfo values(15814,'н�����',7) 
GO
insert into HtmlLabelInfo values(15814,'',8) 
GO
insert into HtmlLabelInfo values(15815,'������Ŀ',7) 
GO
insert into HtmlLabelInfo values(15815,'',8) 
GO
insert into HtmlLabelInfo values(15816,'�ı�Ϊ',7) 
GO
insert into HtmlLabelInfo values(15816,'',8) 
GO
insert into HtmlLabelInfo values(15817,'������ʷ',7) 
GO
insert into HtmlLabelInfo values(15817,'',8) 
GO
insert into HtmlLabelInfo values(15818,'��������',7) 
GO
insert into HtmlLabelInfo values(15818,'',8) 
GO
insert into HtmlLabelInfo values(15819,'������Ŀ',7) 
GO
insert into HtmlLabelInfo values(15819,'',8) 
GO
insert into HtmlLabelInfo values(15820,'��������',7) 
GO
insert into HtmlLabelInfo values(15820,'',8) 
GO
insert into HtmlLabelInfo values(15821,'��������',7) 
GO
insert into HtmlLabelInfo values(15821,'',8) 
GO
insert into HtmlLabelInfo values(15822,'����н��',7) 
GO
insert into HtmlLabelInfo values(15822,'',8) 
GO
insert into HtmlLabelInfo values(15823,'������',7) 
GO
insert into HtmlLabelInfo values(15823,'',8) 
GO
insert into HtmlLabelInfo values(15824,'���ʱ���ʾ',7) 
GO
insert into HtmlLabelInfo values(15824,'',8) 
GO
insert into HtmlLabelInfo values(15825,'����',7) 
GO
insert into HtmlLabelInfo values(15825,'',8) 
GO
insert into HtmlLabelInfo values(15826,'˰��',7) 
GO
insert into HtmlLabelInfo values(15826,'',8) 
GO
insert into HtmlLabelInfo values(15827,'˰�ջ�׼��Ŀ',7) 
GO
insert into HtmlLabelInfo values(15827,'',8) 
GO
insert into HtmlLabelInfo values(15828,'���㹫ʽ',7) 
GO
insert into HtmlLabelInfo values(15828,'',8) 
GO
insert into HtmlLabelInfo values(15829,'�����������',7) 
GO
insert into HtmlLabelInfo values(15829,'',8) 
GO
insert into HtmlLabelInfo values(15830,'ע�⣺ ����ֻ��ΪӢ����ĸ�Ͱ�������ֵ��Ӣ����ĸ��Сд���У�',7) 
GO
insert into HtmlLabelInfo values(15830,'',8) 
GO
insert into HtmlLabelInfo values(15831,'1�����㹫ʽΪ�����������ļӼ��˳����ʽ�����磬�������ʴ���Ϊ S001, ��λ���ʵĴ���Ϊ S002��ʵ����',7) 
GO
insert into HtmlLabelInfo values(15831,'',8) 
GO
insert into HtmlLabelInfo values(15831,'1�����㹫ʽΪ�����������ļӼ��˳����ʽ�����磬�������ʴ���Ϊ S001, ��λ���ʵĴ���Ϊ S002��ʵ����',7) 
GO
insert into HtmlLabelInfo values(15831,'',8) 
GO
insert into HtmlLabelInfo values(15831,'ְ����',7) 
GO
insert into HtmlLabelInfo values(15831,'',8) 
GO
insert into HtmlLabelInfo values(15832,'ְ����',7) 
GO
insert into HtmlLabelInfo values(15832,'',8) 
GO
insert into HtmlLabelInfo values(15833,'����',7) 
GO
insert into HtmlLabelInfo values(15833,'',8) 
GO
insert into HtmlLabelInfo values(15834,'˰��',7) 
GO
insert into HtmlLabelInfo values(15834,'',8) 
GO
insert into HtmlLabelInfo values(15835,'˰�ջ���',7) 
GO
insert into HtmlLabelInfo values(15835,'',8) 
GO
insert into HtmlLabelInfo values(15836,'����',7) 
GO
insert into HtmlLabelInfo values(15836,'',8) 
GO
insert into HtmlLabelInfo values(15837,'��˰����(��)',7) 
GO
insert into HtmlLabelInfo values(15837,'',8) 
GO
insert into HtmlLabelInfo values(15838,'��˰����(��)',7) 
GO
insert into HtmlLabelInfo values(15838,'',8) 
GO
insert into HtmlLabelInfo values(15839,'������',7) 
GO
insert into HtmlLabelInfo values(15839,'',8) 
GO
insert into HtmlLabelInfo values(15840,'���������ո������õĹ�����������������Դ���ʱ�,',7) 
GO
insert into HtmlLabelInfo values(15840,'',8) 
GO
insert into HtmlLabelInfo values(15841,'��ǰ���������иĶ������ı�,�Ƿ����',7) 
GO
insert into HtmlLabelInfo values(15841,'',8) 
GO
insert into HtmlLabelInfo values(15842,'������Դ״̬',7) 
GO
insert into HtmlLabelInfo values(15842,'',8) 
GO
insert into HtmlLabelInfo values(15843,'��׼����',7) 
GO
insert into HtmlLabelInfo values(15843,'',8) 
GO
insert into HtmlLabelInfo values(15844,'��������',7) 
GO
insert into HtmlLabelInfo values(15844,'',8) 
GO
insert into HtmlLabelInfo values(15845,'���ɹ��ʵ�',7) 
GO
insert into HtmlLabelInfo values(15845,'',8) 
GO
insert into HtmlLabelInfo values(15846,'��������',7) 
GO
insert into HtmlLabelInfo values(15846,'',8) 
GO
insert into HtmlLabelInfo values(15847,'�޸Ĺ��ʵ�',7) 
GO
insert into HtmlLabelInfo values(15847,'',8) 
GO
insert into HtmlLabelInfo values(15848,'���͹��ʵ�',7) 
GO
insert into HtmlLabelInfo values(15848,'',8) 
GO
insert into HtmlLabelInfo values(15849,'���ʵ�����',7) 
GO
insert into HtmlLabelInfo values(15849,'',8) 
GO
insert into HtmlLabelInfo values(15850,'δ���ɵ�ǰ�¹��ʵ�',7) 
GO
insert into HtmlLabelInfo values(15850,'',8) 
GO
insert into HtmlLabelInfo values(15851,'�������ɹ��ʵ�����ʧ�Ըù��ʵ��������޸���Ϣ���Ƿ������',7) 
GO
insert into HtmlLabelInfo values(15851,'',8) 
GO
insert into HtmlLabelInfo values(15852,'���ʵ����ͽ�ʹϵͳ��Ա�����Լ����µĹ��ʣ��Ƿ������',7) 
GO
insert into HtmlLabelInfo values(15852,'',8) 
GO
insert into HtmlLabelInfo values(15853,'�Ƿ���Ҫ���¼���˰����ͼ����',7) 
GO
insert into HtmlLabelInfo values(15853,'',8) 
GO
insert into HtmlLabelInfo values(15854,'ְ������',7) 
GO
insert into HtmlLabelInfo values(15854,'',8) 
GO
insert into HtmlLabelInfo values(15855,'����ְ��',7) 
GO
insert into HtmlLabelInfo values(15855,'',8) 
GO
insert into HtmlLabelInfo values(15856,'��λְ��',7) 
GO
insert into HtmlLabelInfo values(15856,'',8) 
GO
insert into HtmlLabelInfo values(15857,'�������� /����',7) 
GO
insert into HtmlLabelInfo values(15857,'',8) 
GO
insert into HtmlLabelInfo values(15858,'��ϵ��ʽ',7) 
GO
insert into HtmlLabelInfo values(15858,'',8) 
GO
insert into HtmlLabelInfo values(15859,'��Ҫ��Ϣ��������',7) 
GO
insert into HtmlLabelInfo values(15859,'',8) 
GO
insert into HtmlLabelInfo values(15860,'��������',7) 
GO
insert into HtmlLabelInfo values(15860,'',8) 
GO
insert into HtmlLabelInfo values(15861,'������',7) 
GO
insert into HtmlLabelInfo values(15861,'',8) 
GO
insert into HtmlLabelInfo values(15862,'��Ա����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15862,'',8) 
GO
insert into HtmlLabelInfo values(15863,'��',7) 
GO
insert into HtmlLabelInfo values(15863,'',8) 
GO
insert into HtmlLabelInfo values(15864,'��',7) 
GO
insert into HtmlLabelInfo values(15864,'',8) 
GO
insert into HtmlLabelInfo values(15865,'��Ա�ɱ�����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15865,'',8) 
GO
insert into HtmlLabelInfo values(15866,'��Ա����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15866,'',8) 
GO
insert into HtmlLabelInfo values(15867,'��Աѧ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15867,'',8) 
GO
insert into HtmlLabelInfo values(15868,'��Աְ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15868,'',8) 
GO
insert into HtmlLabelInfo values(15869,'��Աְ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15869,'',8) 
GO
insert into HtmlLabelInfo values(15870,'��Աְ�����ͳ��',7) 
GO
insert into HtmlLabelInfo values(15870,'',8) 
GO
insert into HtmlLabelInfo values(15871,'ְ������',7) 
GO
insert into HtmlLabelInfo values(15871,'',8) 
GO
insert into HtmlLabelInfo values(15872,'��',7) 
GO
insert into HtmlLabelInfo values(15872,'',8) 
GO
insert into HtmlLabelInfo values(15873,'��Աְ��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15873,'',8) 
GO
insert into HtmlLabelInfo values(15874,'��Ա��λͳ��',7) 
GO
insert into HtmlLabelInfo values(15874,'',8) 
GO
insert into HtmlLabelInfo values(15875,'��Ա����״��ͳ��',7) 
GO
insert into HtmlLabelInfo values(15875,'',8) 
GO
insert into HtmlLabelInfo values(15876,'�������ͳ��',7) 
GO
insert into HtmlLabelInfo values(15876,'',8) 
GO
insert into HtmlLabelInfo values(15877,'������Դ״��',7) 
GO
insert into HtmlLabelInfo values(15877,'',8) 
GO
insert into HtmlLabelInfo values(15878,'����',7) 
GO
insert into HtmlLabelInfo values(15878,'',8) 
GO
insert into HtmlLabelInfo values(15879,'��ѵ��Դ',7) 
GO
insert into HtmlLabelInfo values(15879,'',8) 
GO
insert into HtmlLabelInfo values(15880,'����',7) 
GO
insert into HtmlLabelInfo values(15880,'',8) 
GO
insert into HtmlLabelInfo values(15881,'������ʹ�����',7) 
GO







delete ErrorMsgIndex
GO

delete ErrorMsgInfo
GO

delete HtmlNoteIndex
GO

delete HtmlNoteInfo
GO


insert into ErrorMsgIndex values (4,'��ȫ����') 
GO
insert into ErrorMsgIndex values (20,'����ɾ��') 
GO
insert into ErrorMsgIndex values (12,'�����¼ʧ��') 
GO
insert into ErrorMsgIndex values (19,'��ʱ�����µ�¼') 
GO
insert into ErrorMsgIndex values (30,'��½���ظ�') 
GO
insert into ErrorMsgIndex values (18,'��¼���벻��ȷ') 
GO
insert into ErrorMsgIndex values (25,'���ʲ��ɹ�') 
GO
insert into ErrorMsgIndex values (31,'�ñ���ѱ�����') 
GO
insert into ErrorMsgIndex values (24,'�ÿ�Ŀ���ܽ����¼���Ŀ') 
GO
insert into ErrorMsgIndex values (28,'�����Ͳ��ܽ����¼�����') 
GO
insert into ErrorMsgIndex values (11,'��ɫɾ������') 
GO
insert into ErrorMsgIndex values (22,'�����ƽ��,����ͨ������') 
GO
insert into ErrorMsgIndex values (16,'�������') 
GO
insert into ErrorMsgIndex values (8,'ģ��ɾ������Ĭ��') 
GO
insert into ErrorMsgIndex values (9,'ģ��ɾ��������Ŀ¼') 
GO
insert into ErrorMsgIndex values (10,'Ŀ����Ŀ¼����Ϊ��') 
GO
insert into ErrorMsgIndex values (26,'�ڼ�رղ��ɹ�') 
GO
insert into ErrorMsgIndex values (21,'�ڼ�رջ򲻴��ڣ�����Ծ��,���ܲ���') 
GO
insert into ErrorMsgIndex values (14,'Ȩ��ɾ������') 
GO
insert into ErrorMsgIndex values (23,'��������') 
GO
insert into ErrorMsgIndex values (1,'�ĵ�ɾ������') 
GO
insert into ErrorMsgIndex values (29,'�޸ļ�¼�ɹ�') 
GO
insert into ErrorMsgIndex values (13,'�޸ļ�¼ʧ��') 
GO
insert into ErrorMsgIndex values (15,'�û�������') 
GO
insert into ErrorMsgIndex values (17,'�û���Ч') 
GO
insert into ErrorMsgIndex values (3,'��Ŀ¼Ϊ��') 
GO
insert into ErrorMsgIndex values (27,'�Զ���ϸ�²����ֶ�������ϸ') 
GO



insert into ErrorMsgInfo values (1,'���ĵ��ѱ�ʹ��,���ܱ�ɾ��',7) 
GO
insert into ErrorMsgInfo values (1,'Can\''t be deleted',8) 
GO
insert into ErrorMsgInfo values (3,'��Ŀ¼�µ���Ŀ¼Ϊ��',7) 
GO
insert into ErrorMsgInfo values (3,'SubCategory is Empty',8) 
GO
insert into ErrorMsgInfo values (4,'��ȫ������ڸ���Ŀ¼����߰�ȫ����',7) 
GO
insert into ErrorMsgInfo values (4,'SecLevel is too larger',8) 
GO
insert into ErrorMsgInfo values (8,'��ģ���ѱ�����ΪĬ��ģ�壬���ܱ�ɾ����',7) 
GO
insert into ErrorMsgInfo values (8,'Default mould cann\''t be deleted!',8) 
GO
insert into ErrorMsgInfo values (9,'��ģ���ѱ���Ŀ¼ʹ�ã����ܱ�ɾ����',7) 
GO
insert into ErrorMsgInfo values (9,'SecCategory mould cann\''t be deleted!',8) 
GO
insert into ErrorMsgInfo values (10,'Ŀ����Ŀ¼��ѡ���ĵ�����Ϊ�գ�',7) 
GO
insert into ErrorMsgInfo values (10,'TargetSecCategory or Selected Doc is null ',8) 
GO
insert into ErrorMsgInfo values (11,'�ý�ɫ�³�Ա��Ϊ�գ����ܱ�ɾ��',7) 
GO
insert into ErrorMsgInfo values (11,'The role cann\''t delete for it contains some members',8) 
GO
insert into ErrorMsgInfo values (12,'�����в����ظ�������ڻ�����ԭ��,�����¼ʧ��',7) 
GO
insert into ErrorMsgInfo values (12,'Insert record failure',8) 
GO
insert into ErrorMsgInfo values (13,'�޸ļ�¼ʧ��',7) 
GO
insert into ErrorMsgInfo values (13,'modify record failure',8) 
GO
insert into ErrorMsgInfo values (14,'��Ȩ�����³�Ա��Ϊ�գ����ܱ�ɾ��',7) 
GO
insert into ErrorMsgInfo values (14,'System right group can\''t delete for it contain some members',8) 
GO
insert into ErrorMsgInfo values (15,'�û�������',7) 
GO
insert into ErrorMsgInfo values (15,'user is not exist',8) 
GO
insert into ErrorMsgInfo values (16,'�������',7) 
GO
insert into ErrorMsgInfo values (16,'Password wrong',8) 
GO
insert into ErrorMsgInfo values (17,'�û���Ч',7) 
GO
insert into ErrorMsgInfo values (17,'User Unvalidaty',8) 
GO
insert into ErrorMsgInfo values (18,'��¼���벻��ȷ',7) 
GO
insert into ErrorMsgInfo values (18,'Login id or password is wrong',8) 
GO
insert into ErrorMsgInfo values (19,'��ʱ�������µ�¼',7) 
GO
insert into ErrorMsgInfo values (19,'Time out',8) 
GO
insert into ErrorMsgInfo values (20,'�ü�¼������,����ɾ��.',7) 
GO
insert into ErrorMsgInfo values (20,'Current record is referenced,Can\''t be deleted.',8) 
GO
insert into ErrorMsgInfo values (21,'���ڼ��ѹرջ򲻴��ڣ�����Ծ��,���ܽ�����ز���',7) 
GO
insert into ErrorMsgInfo values (21,'The period is closed ,exchange rate can\''t be operate',8) 
GO
insert into ErrorMsgInfo values (22,'�����ƽ��,����ͨ������',7) 
GO
insert into ErrorMsgInfo values (22,'debit not equal credit , can\''t be approved',8) 
GO
insert into ErrorMsgInfo values (23,'��׼�߲����Ǽ�¼�Ĵ�����',7) 
GO
insert into ErrorMsgInfo values (23,'approver can\''t be creater',8) 
GO
insert into ErrorMsgInfo values (24,'�ÿ�Ŀ�����ڳ�����֧,���ܽ����¼���Ŀ',7) 
GO
insert into ErrorMsgInfo values (24,'can\''t create sub ledger',8) 
GO
insert into ErrorMsgInfo values (25,'���ڼ�ǰ��δ�رյ��ڼ�,���ܽ��е���',7) 
GO
insert into ErrorMsgInfo values (25,'can\''t process',8) 
GO
insert into ErrorMsgInfo values (26,'���ڼ�ǰ��δ�رյĻ�Ծ�ڼ�,���߸��ڼ���δ���ʵķ�¼��Ԥ��,�ڼ�δ�ܹر�',7) 
GO
insert into ErrorMsgInfo values (26,'Periods can\''t close',8) 
GO
insert into ErrorMsgInfo values (27,'�Զ���ϸ��Ŀ�²����ֶ�������ϸ��Ŀ',7) 
GO
insert into ErrorMsgInfo values (27,'can\''t create ledger manully',8) 
GO
insert into ErrorMsgInfo values (28,'�����Ͳ��ܽ����¼�����',7) 
GO
insert into ErrorMsgInfo values (28,'No subassortment creation permitted',8) 
GO
insert into ErrorMsgInfo values (29,'�޸ļ�¼�ɹ�',7) 
GO
insert into ErrorMsgInfo values (29,'Change Success',8) 
GO
insert into ErrorMsgInfo values (30,'��½���ظ�',7) 
GO
insert into ErrorMsgInfo values (30,'Login name conflict',8) 
GO
insert into ErrorMsgInfo values (31,'�ñ���ѱ�����!',7) 
GO
insert into ErrorMsgInfo values (31,'this mark has already being used !',8) 
GO


insert into HtmlNoteIndex values (14,'�������Ϊ��') 
GO
insert into HtmlNoteIndex values (20,'���������ͬ') 
GO
insert into HtmlNoteIndex values (18,'����Ҫ������ɾ������') 
GO
insert into HtmlNoteIndex values (35,'���ʲ�����ʾ') 
GO
insert into HtmlNoteIndex values (45,'��Ŀ¼����ɾ���������¼���Ŀ¼����') 
GO
insert into HtmlNoteIndex values (10,'��Ŀ¼ɾ������') 
GO
insert into HtmlNoteIndex values (41,'����������Ϊ��') 
GO
insert into HtmlNoteIndex values (32,'���ʲ���Ϊ0') 
GO
insert into HtmlNoteIndex values (31,'�����ƽ��') 
GO
insert into HtmlNoteIndex values (17,'�����벻��ȷ') 
GO
insert into HtmlNoteIndex values (30,'û�������Ϣ') 
GO
insert into HtmlNoteIndex values (12,'û���ҵ�����Ĳ���') 
GO
insert into HtmlNoteIndex values (15,'���벻��Ϊ��') 
GO
insert into HtmlNoteIndex values (16,'����ȷ�ϲ���ȷ') 
GO
insert into HtmlNoteIndex values (29,'Ĭ�ϻ���ѡ��') 
GO
insert into HtmlNoteIndex values (25,'�����벻��ȷ') 
GO
insert into HtmlNoteIndex values (28,'�ڼ����벻��ȷ') 
GO
insert into HtmlNoteIndex values (23,'���֪') 
GO
insert into HtmlNoteIndex values (24,'���Ե�Ƭ��') 
GO
insert into HtmlNoteIndex values (33,'��ѡ����(�������)') 
GO
insert into HtmlNoteIndex values (34,'��ѡ���ڼ�(�������)') 
GO
insert into HtmlNoteIndex values (42,'��ѡ������һ���ʲ�') 
GO
insert into HtmlNoteIndex values (22,'Ȩ��ת�Ƴɹ�') 
GO
insert into HtmlNoteIndex values (8,'ȷ��ɾ��ͼƬ') 
GO
insert into HtmlNoteIndex values (26,'ȷ�Ϲر��ڼ�') 
GO
insert into HtmlNoteIndex values (7,'ȷ��ɾ��') 
GO
insert into HtmlNoteIndex values (27,'ȷ�����´��ڼ�') 
GO
insert into HtmlNoteIndex values (13,'ɾ��ϵͳĬ�ϵķ�Ŀ¼') 
GO
insert into HtmlNoteIndex values (5,'ͼƬ��ʽ') 
GO
insert into HtmlNoteIndex values (19,'δ������ϱ�׼������') 
GO
insert into HtmlNoteIndex values (11,'ϵͳĬ�Ϸֲ�ɾ��') 
GO
insert into HtmlNoteIndex values (38,'ѡ��������Ŀ') 
GO
insert into HtmlNoteIndex values (43,'�����˲���Ϊ�ɹ��ˣ�') 
GO
insert into HtmlNoteIndex values (37,'Ԥ�㴦����ʾ') 
GO
insert into HtmlNoteIndex values (6,'��Ŀ¼ɾ������') 
GO
insert into HtmlNoteIndex values (39,'�ʲ�(�����ƶ�)') 
GO
insert into HtmlNoteIndex values (40,'�ʲ�(�����ƶ�) ��ʾ') 
GO



insert into HtmlNoteInfo values (5,'ͼƬ��ʽ����Ϊ��*.gif, *.jpeg ����ͼƬ��СΪ300*300 pixels ',7) 
GO
insert into HtmlNoteInfo values (5,'Supply the local path to the previously scanned image file in *.gif, *.jpeg format:The recommended size is maximal 300*300 pixels ',8) 
GO
insert into HtmlNoteInfo values (6,'����Ŀ¼���з�Ŀ¼����,���ܱ�ɾ��!',7) 
GO
insert into HtmlNoteInfo values (6,'Unable to delete group,This group contains 1 or more documents!',8) 
GO
insert into HtmlNoteInfo values (7,'��ȷ��Ҫɾ��������¼��?',7) 
GO
insert into HtmlNoteInfo values (7,'Are you sure to delete this record?',8) 
GO
insert into HtmlNoteInfo values (8,'��ȷ��Ҫɾ������ͼƬ��?',7) 
GO
insert into HtmlNoteInfo values (8,'Are you sure to delete this picture?',8) 
GO
insert into HtmlNoteInfo values (10,'�÷�Ŀ¼������Ŀ¼����,���ܱ�ɾ��!',7) 
GO
insert into HtmlNoteInfo values (10,'Unable to delete group,This group contains 1 or more documents!',8) 
GO
insert into HtmlNoteInfo values (11,'����ɾ��ϵͳĬ�ϵķֲ�!',7) 
GO
insert into HtmlNoteInfo values (11,'This item can not be deleted because it has a refence.',8) 
GO
insert into HtmlNoteInfo values (12,'û���ҵ�����Ĳ���',7) 
GO
insert into HtmlNoteInfo values (12,'No division found ',8) 
GO
insert into HtmlNoteInfo values (13,'����ɾ��ϵͳĬ�ϵķ�Ŀ¼!',7) 
GO
insert into HtmlNoteInfo values (13,'This item can not be deleted because it has a refence.',8) 
GO
insert into HtmlNoteInfo values (14,'��Ҫ��Ϣ������',7) 
GO
insert into HtmlNoteInfo values (14,'Please check the integrity of your data, and fill in the form.',8) 
GO
insert into HtmlNoteInfo values (15,'���벻��Ϊ��',7) 
GO
insert into HtmlNoteInfo values (15,'Password can\''t be null',8) 
GO
insert into HtmlNoteInfo values (16,'����ȷ�ϲ���ȷ',7) 
GO
insert into HtmlNoteInfo values (16,'Confirm password is wrong',8) 
GO
insert into HtmlNoteInfo values (17,'�����벻��ȷ',7) 
GO
insert into HtmlNoteInfo values (17,'Old password is wrong',8) 
GO
insert into HtmlNoteInfo values (18,'����Ҫ�����岻Ϊ�գ�ɾ������',7) 
GO
insert into HtmlNoteInfo values (18,'SalaryComponentTypes Not Null,Can Not Delete',8) 
GO
insert into HtmlNoteInfo values (19,'δ������ϱ�׼������',7) 
GO
insert into HtmlNoteInfo values (19,'Not input standard data yet',8) 
GO
insert into HtmlNoteInfo values (20,'���������ͬ',7) 
GO
insert into HtmlNoteInfo values (20,'Must not the same',8) 
GO
insert into HtmlNoteInfo values (22,'Ȩ��ת�Ƴɹ�',7) 
GO
insert into HtmlNoteInfo values (22,'RightTransfer success',8) 
GO
insert into HtmlNoteInfo values (23,'���֪',7) 
GO
insert into HtmlNoteInfo values (23,'Please inform',8) 
GO
insert into HtmlNoteInfo values (24,'���Ե�Ƭ��',7) 
GO
insert into HtmlNoteInfo values (24,'Please wait a moment',8) 
GO
insert into HtmlNoteInfo values (25,'�����벻��ȷ',7) 
GO
insert into HtmlNoteInfo values (25,'Year is wrong',8) 
GO
insert into HtmlNoteInfo values (26,'�ڼ�رպ���ڼ佫����¼���µķ�¼,��ȷ��Ҫ�رո��ڼ���?',7) 
GO
insert into HtmlNoteInfo values (26,'Are you sure close the period?',8) 
GO
insert into HtmlNoteInfo values (27,'�ڼ�򿪽�ɾ�����ڼ������ͳ����Ϣ,��ȷ�����´򿪸��ڼ���?',7) 
GO
insert into HtmlNoteInfo values (27,'Are you sure reopen the period?',8) 
GO
insert into HtmlNoteInfo values (28,'�ڼ����벻��ȷ',7) 
GO
insert into HtmlNoteInfo values (28,'Period is wrong',8) 
GO
insert into HtmlNoteInfo values (29,'��ѡ��û���ΪĬ�ϻ���,��ʹԭ����Ĭ�ϻ���ʧȥĬ��,�Ƿ����?',7) 
GO
insert into HtmlNoteInfo values (29,'The currency will replace the old default currency!',8) 
GO
insert into HtmlNoteInfo values (30,'û�������Ϣ',7) 
GO
insert into HtmlNoteInfo values (30,'No relative information found',8) 
GO
insert into HtmlNoteInfo values (31,'�����ƽ��,�Ƿ񱣴����Ϣ',7) 
GO
insert into HtmlNoteInfo values (31,'credit and debit not equal',8) 
GO
insert into HtmlNoteInfo values (32,'���ʲ���Ϊ0',7) 
GO
insert into HtmlNoteInfo values (32,'Exchange rate cannot be 0',8) 
GO
insert into HtmlNoteInfo values (33,'��ѡ����',7) 
GO
insert into HtmlNoteInfo values (33,'Please select Department',8) 
GO
insert into HtmlNoteInfo values (34,'��ѡ���ڼ�',7) 
GO
insert into HtmlNoteInfo values (34,'Please select periods',8) 
GO
insert into HtmlNoteInfo values (35,'�˴β������������ѡ���ڼ�Ͳ��ŵ�����׼��¼����,��¼���ʺ�,�������ٸ���,�Ƿ�ȷ�����е���?',7) 
GO
insert into HtmlNoteInfo values (35,'confirm process?',8) 
GO
insert into HtmlNoteInfo values (37,'�˴β������������ѡ���ڼ�Ͳ��ŵ�����׼Ԥ�㴦��,Ԥ�㴦���,�������ٸ���,�Ƿ�ȷ�����д���?',7) 
GO
insert into HtmlNoteInfo values (37,'confirm process',8) 
GO
insert into HtmlNoteInfo values (38,'����ѡ��������߿�Ŀ',7) 
GO
insert into HtmlNoteInfo values (38,'Please select a category or a ledger',8) 
GO
insert into HtmlNoteInfo values (39,'��ѡ����ȷ���ƶ���',7) 
GO
insert into HtmlNoteInfo values (39,'Please select right ',8) 
GO
insert into HtmlNoteInfo values (40,'�����ƶ���Ӱ��ļ�¼��Ϊ',7) 
GO
insert into HtmlNoteInfo values (40,'the recorder count is ',8) 
GO
insert into HtmlNoteInfo values (41,'����������Ϊ��',7) 
GO
insert into HtmlNoteInfo values (41,'can\''t purchase null',8) 
GO
insert into HtmlNoteInfo values (42,'��ѡ������һ���ʲ�',7) 
GO
insert into HtmlNoteInfo values (42,'Please choose at lease one capital',8) 
GO
insert into HtmlNoteInfo values (43,'�����˲���Ϊ�ɹ��ˣ�',7) 
GO
insert into HtmlNoteInfo values (43,'The checher can''''t be the buyer!',8) 
GO
insert into HtmlNoteInfo values (45,'�÷�Ŀ¼�����¼���Ŀ¼����,���ܱ�ɾ��!',7) 
GO
insert into HtmlNoteInfo values (45,'Unable to delete group,This group contains 1 or more other groups!',8) 
GO

delete SystemRights
GO

insert into SystemRights (id,rightdesc,righttype) values (1,'�ĵ���Ŀ¼ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (4,'�ĵ���Ŀ¼ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (8,'�ĵ���Ŀ¼ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (9,'�ĵ�����ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (10,'�ĵ�ģ��ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (11,'�ĵ�����ҳ����ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (12,'�ĵ�ϵͳĬ������ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (13,'�ĵ�ͼƬ�ϴ�ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (14,'�ĵ������ƶ�ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (15,'�����¼��׼','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (16,'�ĵ�ά��','1') 
GO
insert into SystemRights (id,rightdesc,righttype) values (17,'�ܲ�ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (18,'�ֲ�ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (19,'����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (20,'�ɱ�����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (21,'�ɱ��������ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (22,'������Դά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (23,'����ʱ���ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (24,'���ڼ���ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (25,'��ɫά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (26,'����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (27,'λ��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (28,'��������ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (29,'ְ��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (30,'ְλά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (31,'����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (32,'Ȩ��ά��','7') 
GO
insert into SystemRights (id,rightdesc,righttype) values (33,'��ɫ��Աά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (34,'Ȩ��ת��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (35,'Ĭ��ʱ���ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (36,'������Դʱ���ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (37,'��һ�¹���ʱ��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (38,' ��������ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (39,'����Ҫ��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (40,'��ϵ�˳ƺ�ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (41,'��ַ����ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (42,'��ϵ����ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (43,'�ͻ���ʽά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (44,'��ҵά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (45,'��˾��ģά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (46,'�ͻ����ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (47,'�ۼƺ�ͬ���ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (48,'���õȼ�ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (49,'�ͻ�״��ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (50,'�ͻ�����ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (51,'�ͻ�����ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (52,'֧������ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (53,'����Ԥ����׼','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (54,'��Ŀ����ά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (55,'�������ά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (56,'��Ŀ״̬ά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (57,'�ƻ�����ά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (58,'�ƻ�����ά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (59,'�������ά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (60,'Ԥ��ģ��ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (61,'����ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (62,'����ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (63,'ָʾ��ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (64,'����Ŀ¼ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (65,'�����Ŀά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (66,'�����ڼ�ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (67,'����Ԥ��鿴','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (68,'����Ԥ��ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (69,'������֧�鿴','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (70,'������֧ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (71,'������֧����','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (72,'������֧����','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (73,'����Ԥ�����','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (74,'�����ڼ����','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (75,'�ʲ�����ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (76,'�ʲ�����ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (77,'������λά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (78,'��������ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (79,'���㷽��ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (80,'�ո��ʽά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (81,'�ֿ�ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (82,'�����ⷽʽά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (83,'�ʲ�Ŀ¼ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (84,'�ʲ�ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (85,'�ʲ���Ӧ��ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (86,'�ʲ��ڳ�ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (87,'�ʲ����ù�ϵά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (88,'�ʲ��۸�ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (89,'�鿴���񱨱�','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (90,'ϵͳ����','7') 
GO
insert into SystemRights (id,rightdesc,righttype) values (91,'������ά��','5') 
GO
insert into SystemRights (id,rightdesc,righttype) values (92,'��Ŀ�����ֶ�ά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (93,'�ͻ���Ϣ�����ֶ�ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (94,'������Դ�����ֶ�ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (95,'������Դ����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (96,'������Դ����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (97,'����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (98,'��Ŀά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (99,'��Ŀ�鿴','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (100,'��Ŀ��Աά��','6') 
GO
insert into SystemRights (id,rightdesc,righttype) values (101,'�ͻ�ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (102,'�ͻ���ַ��Ϣά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (103,'�ͻ���ϵ���ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (104,'�ͻ��鿴','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (105,'�ͻ���ϵ��ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (106,'ϵͳȨ�޽�ɫά��','7') 
GO
insert into SystemRights (id,rightdesc,righttype) values (107,'�ؽ����ݿ�ά��','7') 
GO
insert into SystemRights (id,rightdesc,righttype) values (108,'����ά��','7') 
GO
insert into SystemRights (id,rightdesc,righttype) values (109,'������Դ����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (110,'��Ƹ��Ϣά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (111,'ӦƸ��Ϣά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (112,'������Ϣ����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (113,'������Դ�����ʻ�ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (114,'������Դ������Ϣά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (115,'������Դ�ʼ�Ⱥ��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (116,'CRM�ʼ�Ⱥ��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (117,'�鿴������Դ�ƻ�','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (118,'�鿴������Դ���','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (119,'�ʲ������ֶ�ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (120,'ӦƸ�����','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (121,'ӦƸ��¼��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (122,'��ѵ����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (123,'��������ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (124,'ְ��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (125,'רҵά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (126,'ְ�����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (127,'�ù�����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (128,'��������ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (129,'�������ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (130,'��ͥ���ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (131,'��������ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (132,'��ѵ��¼ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (133,'���ͼ�¼ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (134,'ʡ��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (135,'����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (136,'�ʲ�ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (137,'�ʲ���ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (138,'�ʲ�����ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (139,'�ʲ�״̬ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (140,'�ʲ�������λά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (141,'�ʲ��۾ɷ���ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (142,'�ʲ��̵�ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (143,'�ʲ��̵�����','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (144,'�ʲ����ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (145,'�ʲ�����ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (146,'�ʲ�����ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (147,'�ʲ�����ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (148,'�ʲ����ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (149,'�ʲ�����ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (150,'�ʲ���ת�鿴ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (151,'�ʲ��ƽ�ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (152,'�ʲ�ά��ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (153,'�ʲ��黹ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (154,'�ʲ���ʧά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (155,'�ʲ�����ά��','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (156,'�ʸ�֤��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (157,'��ְ����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (158,'н�긣��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (159,'���ݼټ�¼ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (160,'�ʲ��ܱ�鿴','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (161,'�ʲ�����鿴','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (162,'�ʲ���ת����鿴','8') 
GO
insert into SystemRights (id,rightdesc,righttype) values (163,'������������ά��','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (164,'Ԥ���������ά��','4') 
GO
insert into SystemRights (id,rightdesc,righttype) values (200,'��������ά��','9') 
GO
insert into SystemRights (id,rightdesc,righttype) values (300,'����������ά��','5') 
GO
insert into SystemRights (id,rightdesc,righttype) values (301,'����Ԥ��ά��','5') 
GO
insert into SystemRights (id,rightdesc,righttype) values (302,'���������ϸ�鿴','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (303,'�����ʽ�鿴','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (304,'���������鿴','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (305,'��Ƭӡ�Ʒ����½�','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (306,'��ƱԤ�������½�','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (307,'�ؿ�ר�ݷ����½�','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (308,'���ڿ�ݷ����½�','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (309,'��ʾ��Ƭ��Ŀ','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (310,'��־�鿴','2') 
GO
insert into SystemRights (id,rightdesc,righttype) values (350,'������ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (380,'��Ʒά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (351,'�ͻ���ֵ����ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (352,'�ͻ���ͬ����ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (353,'�ͻ����ö��/�ڼ�ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (370,'��ѵ�滮ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (371,'��ѵ����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (372,'��ѵ��Դά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (373,'��ѵ�ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (374,'�ù�����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (375,'��Ƹ�ƻ�ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (381,'����ά��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (382,'ѧ��ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (383,'��ͬ����ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (384,'��ͬά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (385,'CRM����ά��','0') 
GO
insert into SystemRights (id,rightdesc,righttype) values (386,'������Դ��������ά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (387,'������Դ������Ŀά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (388,'������Դ����ʵʩά��','3') 
GO
insert into SystemRights (id,rightdesc,righttype) values (389,'�ʼ�ģ��ά��','3') 
GO



delete SystemRightsLanguage
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1,7,'�ĵ���Ŀ¼ά��','�ĵ���Ŀ¼���,ɾ��,�޸�,��־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (8,7,'�ĵ���Ŀ¼ά��','�ĵ���Ŀ¼���,ɾ��,�޸�,�鿴��־') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (9,7,'�ĵ�����ά��','�ĵ��������,ɾ��,�޸�,��־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (10,7,'�ĵ�ģ��ά��','�ĵ�ģ�����ӣ�ɾ�������º���־�ı�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (11,7,'�ĵ�����ҳ����ά��','�ĵ�����ҳ���õ���ӣ�ɾ�������£���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (13,7,'�ĵ�ͼƬ�ϴ�ά��','�ĵ�ͼƬ�ϴ�����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (14,7,'�ĵ������ƶ�ά��','�ĵ��ĸ��ƣ��ƶ��Ͳ鿴��־��Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (16,7,'�ĵ�ά��','�ĵ�����ʾ���༭��ɾ�����鵵������Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (21,7,'�ɱ��������ά��','�ɱ�����������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (23,7,'����ʱ���ά��','����ʱ������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (25,7,'��ɫά��','��ɫ����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (31,7,'����ά��','���ܵ���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (33,7,'��ɫ��Աά��','��ɫ��Ա����ӣ�ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (34,7,'Ȩ��ת��ά��','Ȩ��ת�Ƶ����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (37,7,'��һ�¹���ʱ��ά��','��һ�¹���ʱ�����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (42,7,'��ϵ����ά��','��ϵ��������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (43,7,'�ͻ���ʽά��','�ͻ���ʽ����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (45,7,'��˾��ģά��','��˾��ģ����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (46,7,'�ͻ����ά��','�ͻ�������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (47,7,'�ۼƺ�ͬ���ά��','�ۼƺ�ͬ������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (48,7,'���õȼ�ά��','���õȼ�����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (50,7,'�ͻ�����ά��','�ͻ���������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (52,7,'֧������ά��','֧����������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (53,7,'����Ԥ����׼','����Ԥ��Ĳ鿴������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (54,7,'��Ŀ����ά��','��Ŀ���͵���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (55,7,'�������ά��','����������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (57,7,'�ƻ�����ά��','�ƻ����͵���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (60,7,'Ԥ��ģ��ά��','Ԥ��ģ����½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (63,7,'ָʾ��ά��','ָʾ�����½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (65,7,'�����Ŀά��','�����Ŀ���½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (66,7,'�����ڼ�ά��','�����ڼ���½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (69,7,'������֧�鿴','������֧�Ĳ鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (70,7,'������֧ά��','������֧���½�,�༭��ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (75,7,'�ʲ�����ά��','�ʲ�������½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (77,7,'������λά��','������λ���½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (79,7,'���㷽��ά��','�ʲ����㷽�����½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (80,7,'�ո��ʽά��','�ո��ʽ�����,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (81,7,'�ֿ�ά��','�ֿ���½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (82,7,'�����ⷽʽά��','�����ⷽʽ���½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (83,7,'�ʲ�Ŀ¼ά��','�ʲ�Ŀ¼���½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (84,7,'�ʲ�ά��','�ʲ����½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (85,7,'�ʲ���CRMά��','�ʲ���CRM���½�,�༭,ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (86,7,'�ʲ��ڳ�ά��','�ʲ��ڳ����½�,�༭,ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (87,7,'�ʲ����ù�ϵά��','�ʲ����ù�ϵ�Ľ���,�༭��ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (89,7,'�鿴���񱨱�','�鿴�ʲ���ծ��������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (90,7,'ϵͳ����','ϵͳ����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (91,7,'������ά��','������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (92,7,'��Ŀ�����ֶ�ά��','��Ŀ�����ֶ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (93,7,'�ͻ���Ϣ�����ֶ�','�ͻ���Ϣ�����ֶα༭') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (94,7,'������Դ�����ֶ�ά��','������Դ�����ֶ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (95,7,'������Դ����ά��','������Դ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (96,7,'������Դ����ά��','������Դ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (97,7,'����ά��','����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (98,7,'��Ŀά��','��Ŀά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (99,7,'��Ŀ�鿴','��Ŀ�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (101,7,'�ͻ�ά��','�ͻ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (102,7,'�ͻ���ַ��Ϣά��','�ͻ���ַ��Ϣά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (103,7,'�ͻ���ϵ���ά��','�ͻ���ϵ���ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (107,7,'�ؽ����ݿ�ά��','�ؽ����ݿ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (108,7,'����ά��','����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (109,7,'������Դ����ά��','������Դ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (110,7,'��Ƹ��Ϣά��','��Ƹ��Ϣά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (111,7,'ӦƸ��Ϣά��','ӦƸ��Ϣά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (112,7,'������Ϣ����ά��','������Ϣ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (4,7,'�ĵ���Ŀ¼ά��','�ĵ���Ŀ¼���,ɾ��,�޸�,�鿴��־') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (12,7,'�ĵ�ϵͳĬ������ά��','�ĵ�ϵͳĬ�����õı༭����־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (20,7,'�ɱ�����ά��','�ɱ����ĵ���ӣ�ɾ�������º���־��ͳ��ͼ��Ĳ鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (22,7,'������Դά��','������Դ����ӣ����º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (24,7,'���ڼ���ά��','���ڼ��յ���ӣ����ƣ���ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (26,7,'����ά��','���ҵ���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (27,7,'λ��ά��','λ�õ���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (30,7,'ְλά��','ְλ����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (39,7,'����Ҫ��ά��','����Ҫ�ص���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (40,7,'��ϵ�˳ƺ�ά��','��ϵ�˳ƺ�����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (44,7,'��ҵά��','��ҵ����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (49,7,'�ͻ�״��ά��','�ͻ�״������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (58,7,'�ƻ�����ά��','�ƻ��������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (61,7,'����ά��','���ֵ��½�,�༭����־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (62,7,'����ά��','���ʵ��½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (64,7,'����Ŀ¼ά��','����Ŀ¼���½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (76,7,'�ʲ�����ά��','�ʲ����͵��½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (100,7,'��Ŀ��Աά��','��Ŀ��Աά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (104,7,'�ͻ��鿴','�ͻ��鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (105,7,'�ͻ���ϵ��ά��','�ͻ���ϵ��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (106,7,'ϵͳȨ�޽�ɫά��','ϵͳȨ�޽�ɫά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (15,7,'�����¼ά��','�����¼�Ĳ鿴������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (17,7,'�ܲ�ά��','�ܲ��ı༭����־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (18,7,'�ֲ�ά��','�ֲ�����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (28,7,'��������ά��','�������͵���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (29,7,'ְ��ά��','ְ�����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (41,7,'��ַ����ά��','��ַ���͵���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (51,7,'�ͻ�����ά��','�ͻ��������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (19,7,'����ά��','���ŵ���ӣ�ɾ�������ºͲ鿴��־���ɱ�����ͳ��ͼ�����ʣ���֧��Ԥ���Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (32,7,'Ȩ��ά��','Ȩ�޵���ӣ�ɾ��������,��־�鿴�����Ȩ�޽�ɫ') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (35,7,'Ĭ��ʱ���ά��','Ĭ��ʱ���ı༭����־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (36,7,'������Դʱ���ά��','������Դʱ������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (38,7,'��������ά��','�����������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (56,7,'��Ŀ״̬ά��','��Ŀ״̬����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (67,7,'����Ԥ��鿴','����Ԥ��鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (68,7,'����Ԥ��ά��','����Ԥ����½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (78,7,'��������ά��','�������͵��½�,�༭,ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (88,7,'�ʲ��۸�ά��','�ʲ��۸�Ľ���,�༭��ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (59,7,'�������ά��','������͵���ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (113,7,'������Դ�����ʻ�ά��','������Դ�����ʻ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (71,7,'������֧����','������֧�Ĳ鿴������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (72,7,'������֧����','������֧�ĵ���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (73,7,'����Ԥ�����','����Ԥ��ĵ���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (74,7,'�����ڼ����','�����ڼ�Ĺرպ����´�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (114,7,'������Դ������Ϣά��','������Դ������Ϣ�Ĳ鿴,�½�,�༭��ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (115,7,'������Դ�ʼ�Ⱥ��','������Դ�ʼ���Ⱥ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (116,7,'CRM�ʼ�Ⱥ��','CRM�ʼ���Ⱥ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (117,7,'�鿴������Դ�ƻ�','�鿴������Դ�ƻ�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (118,7,'�鿴������Դ���','�鿴������Դ���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (119,7,'�ʲ������ֶ�ά��','�ʲ������ֶ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (120,7,'ӦƸ�����','ӦƸ�����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (121,7,'ӦƸ��¼��','ӦƸ��¼��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (122,7,'��ѵ����ά��','��ѵ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (123,7,'��������ά��','��������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (124,7,'ְ��ά��','ְ��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (125,7,'רҵά��','רҵά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (126,7,'ְ�����ά��','ְ�����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (127,7,'�ù�����ά��','�ù�����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (128,7,'��������ά��','��������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (129,7,'�������ά��','�������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (130,7,'��ͥ���ά��','��ͥ���ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (131,7,'��������ά��','��������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (132,7,'��ѵ��¼ά��','��ѵ��¼ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (133,7,'���ͼ�¼ά��','���ͼ�¼ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (134,7,'ʡ��ά��','ʡ��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (135,7,'����ά��','����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (136,7,'�ʲ�ά��','�ʲ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (137,7,'�ʲ���ά��','�ʲ���ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (138,7,'�ʲ�����ά��','�ʲ�����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (139,7,'�ʲ�״̬ά��','�ʲ�״̬ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (140,7,'�ʲ�������λά��','�ʲ�������λά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (141,7,'�ʲ��۾ɷ���ά��','�ʲ��۾ɷ���ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (142,7,'�ʲ��̵�ά��','�ʲ��̵�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (143,7,'�ʲ��̵�����','�ʲ��̵�����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (144,7,'�ʲ����ά��','�ʲ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (145,7,'�ʲ�����ά��','�ʲ�����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (146,7,'�ʲ�����ά��','�ʲ�����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (147,7,'�ʲ�����ά��','�ʲ�����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (148,7,'�ʲ����ά��','�ʲ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (149,7,'�ʲ�����ά��','�ʲ�����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (150,7,'�ʲ���ת�鿴ά��','�ʲ���ת�鿴ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (151,7,'�ʲ��ƽ�ά��','�ʲ��ƽ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (152,7,'�ʲ�ά��ά��','�ʲ�ά��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (153,7,'�ʲ��黹ά��','�ʲ��黹ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (154,7,'�ʲ���ʧά��','�ʲ���ʧά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (155,7,'�ʲ�����ά��','�ʲ�����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (156,7,'�ʸ�֤��ά��','�ʸ�֤��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (157,7,'��ְ����ά��','��ְ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (158,7,'н�긣��ά��','н�긣��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (159,7,'���ݼټ�¼ά��','���ݼټ�¼ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (160,7,'�ʲ��ܱ�鿴','�ʲ��ܱ�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (161,7,'�ʲ�����鿴','�ʲ�����鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (162,7,'�ʲ���ת����鿴','�ʲ���ת����鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (163,7,'������������ά��','������������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (164,7,'Ԥ���������ά��','Ԥ���������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (200,7,'��������ά��','�������ͼ���ز�������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (300,7,'�������������','�������������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (301,7,'����Ԥ��ά��','����Ԥ��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (302,7,'���������ϸ�鿴','���������ϸ�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (303,7,'�����ʽ�鿴','�����ʽ�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (304,7,'���������鿴','���������鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (305,7,'��Ƭӡ�Ʒ����½�','��Ƭӡ�Ʒ����½�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (306,7,'��ƱԤ�������½�','��ƱԤ�������½�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (307,7,'�ؿ�ר�ݷ����½�','�ؿ�ר�ݷ����½�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (308,7,'���ڿ�ݷ����½�','���ڿ�ݷ����½�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (309,7,'��ʾ��Ƭ��Ŀ','��ʾ��Ƭ��Ŀ') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (310,7,'��־�鿴','��־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (350,7,'������ά��','������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (380,7,'��Ʒά��','��Ʒά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (351,7,'�ͻ���ֵ����ά��','�ͻ���ֵ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (352,7,'�ͻ���ͬ����ά��','�ͻ���ͬ����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (353,7,'�ͻ����ö��/�ڼ�ά��','�ͻ����ö��/�ڼ�ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (382,7,'ѧ��ά��','ѧ��ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (370,7,'��ѵ�滮ά��','��ѵ�滮��ӣ��༭��ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (371,7,'��ѵ����ά��','��ѵ������ӣ��༭��ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (372,7,'��ѵ��Դά��','��ѵ��Դ��ӣ��༭��ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (373,7,'��ѵ�ά��','��ѵ���ӣ��༭��ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (374,7,'�ù�����ά��','�ù�������ӣ��༭��ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (375,7,'��Ƹ�ƻ�ά��','��Ƹ�ƻ���ӣ��༭��ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (383,7,'��ͬ����ά��','��ͬ������ӣ��༭��ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (384,7,'��ͬά��','��ͬ��ӣ��༭��ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (385,7,'CRM����ά��','CRM����ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (386,7,'������Դ��������ά��','������Դ���������½����༭��ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (387,7,'������Դ������Ŀά��','������Դ������Ŀ�½����༭��ɾ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (388,7,'������Դ����ʵʩά��','������Դ����ʵʩά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (389,7,'�ʼ�ģ��ά��','�ʼ�ģ���½����༭��ɾ������־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (381,7,'����ά��','����ά����ӣ��༭��ɾ������־�鿴') 
GO


insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (1,8,'Doc Maincategory maintenance','Add,update,delete and log doc maincategory') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (8,8,'Doc Seccategory maintenance','Add,update,delete and log doc Seccategory') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (9,8,'Doc Type maintenance','Add,update,delete and log doc type') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (10,8,'Doc Mould maintenance','Add,update,delete and log doc Mould') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (11,8,'Doc Frontpage maintenance','Add,update,delete and log doc Frontpage') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (12,8,'Doc SystemDefault maintenance','Update and log doc Syetem default') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (13,8,'Doc PicUpload maintenance','Add,delete,update and log pic upload') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (14,8,'Doc copy and move maintenance','Doc copy,move and log ') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (15,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (16,8,'Doc maintenance','Display,update,delete,archive and reload Doc') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (21,8,'Cost center category maintenance','Add,delete,update and log costcenter category') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (22,8,'Hrm resource maintenance','Add,update and log Hrmresource') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (23,8,'HrmDepartmentSchedule maintenance','Add,delete,update and log HrmDepartmentSchedule') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (25,8,'HrmRoles','Add,delete,update and log HrmRoles') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (31,8,'HrmCompetency','Add,delete,update and log HrmCompetency') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (33,8,'HrmRoleMembers','Add,delete and log HrmRoleMembers') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (34,8,'HrmRrightTransfer','HrmRrightTransfer permission') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (37,8,'HrmScheduleDiff','Add,delete,update and log HrmScheduleDiff') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (42,8,'ContactWay','Add,delete,update and log ContactWay') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (43,8,'DeliverType','Add,delete,update and log DeliverType') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (45,8,'CustomerSize','Add,delete,update and log CustomerSize') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (46,8,'CustomerType','Add,delete,update and log CustomerType') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (47,8,'TradeInfo','Add,delete,update and log TradeInfo') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (48,8,'CreditInfo','Add,delete,update and log CreditInfo') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (50,8,'CustomerDesc','Add,delete,update and log CustomerDesc') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (52,8,'PaymentTerm','Add,delete,update and log PaymentTerm') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (53,8,'FnaBudget Approve','View and approve FnaBudget') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (54,8,'ProjectType Maintenance','Add,delete,update and log ProjectType') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (55,8,'WorkType Maintenance','Add,delete,update and log WorkType') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (57,8,'PlanType Maintenance','Add,delete,update and log PlanType') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (65,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (66,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (69,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (70,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (75,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (77,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (79,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (80,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (81,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (82,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (83,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (84,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (85,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (86,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (87,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (89,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (90,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (91,8,'workflow maintenance','workflow maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (92,8,'project freefeild maintenance','project freefeild maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (93,8,'customerfreefeild','customerfreefeild edit') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (95,8,'HrmResource skill maintenance','HrmResource skill maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (96,8,'Hrm resource competency maintenance','Hrm resource competency maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (97,8,'competency maintenance','competency maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (98,8,'Project maintenance','Project maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (99,8,'Project View','Project View') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (101,8,'Customer maintenance','Customer maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (102,8,'Customer address maintenance','Customer address maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (103,8,'Customer contact maintenance','Customer contact maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (107,8,'CreateDB','Create DB') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (108,8,'title maintenance','title maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (109,8,'hrm resource component maintenance','hrm resource component maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (110,8,'Career invite maintenance','Career invite maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (111,8,'Career apply maintenance','Career apply maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (112,8,'other info type maintenance','other info type maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (4,8,'Doc Subcategory maintenance','Add,update,delete and log doc Subcategory') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (63,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (94,8,'Hrm resource free feild  maintenance','Hrm resource free feild  maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (20,8,'Cost center maintenance','Add,delete,update and log ,chart view of cost center') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (24,8,'HrmPubHoliday','Add(dup),delete,update and log HrmPubHoliday') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (26,8,'HrmCountries','Add,delete,update and log HrmCountries') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (27,8,'HrmLocations','Add,delete,update and log HrmLocations') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (30,8,'HrmJobTitles','Add,delete,update and log HrmJobTitles') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (39,8,'HrmSalaryComponent','Add,delete,update and log HrmSalaryComponent') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (40,8,'ContactorTitle','Add,delete,update and log ContactorTitle') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (44,8,'SectorInfo','Add,delete,update and log SectorInfo') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (49,8,'CustomerStatus','Add,delete,update and log CustomerStatus') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (58,8,'PlanSort Maintenance','Add,delete,update and log PlanSort') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (60,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (61,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (62,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (64,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (76,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (100,8,'Project member Maintenance','Project member Maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (104,8,'Customer View','Customer View') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (105,8,'Customer contactor maintenance','Customer contactor maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (106,8,'System right roles','System right roles') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (17,8,'HrmCompany maintenance','Update and log HrmCompany') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (18,8,'Subcompany maintenance ','Add,delete,update and log subcompany') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (28,8,'HrmJobGroups','Add,delete,update and log HrmJobGroups') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (29,8,'HrmJobActiveties','Add,delete,update and log HrmJobActiveties') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (41,8,'AddressType','Add,delete,update and log AddressType') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (51,8,'CustomerRating','Add,delete,update and log CustomerRating') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (19,8,'Hrmdepartment maintenance','Add,delete,update and view log,costcenter,fnaledger,fnacredence,fnabudget of Hrmdepartment') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (32,8,'SystemRightGroup','Add,delete,update,log SystemRightGroup and add SystermRightRoles') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (35,8,'HrmDefaultSchedule','Update and log HrmDefaultSchedule') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (36,8,'HrmResouceScheduleList','Add,delete,update and log HrmResouceScheduleList') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (38,8,'HrmSalaryComponentTypes','Add,delete,update and log HrmSalaryComponentTypes') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (56,8,'ProjectStatus Maintenance','Add,delete,update and log ProjectStatus') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (67,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (68,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (78,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (88,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (59,8,'ProcessingType Maintenance','Add,delete,update and log ProcessingType') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (113,8,'Hrm resource bank account maintenance','Hrm resource bank account maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (71,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (72,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (73,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (74,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (114,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (115,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (116,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (117,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (118,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (119,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (120,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (121,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (122,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (123,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (124,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (125,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (126,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (127,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (128,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (129,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (130,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (131,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (132,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (133,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (134,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (135,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (136,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (137,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (138,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (139,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (140,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (141,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (142,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (143,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (144,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (145,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (146,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (147,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (148,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (149,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (150,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (151,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (152,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (153,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (154,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (155,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (156,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (157,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (158,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (159,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (160,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (161,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (162,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (163,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (164,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (200,8,'Meeting type maintenance','Add,delete meeting type') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (300,8,'workflow report manage','workflow report manage') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (301,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (302,8,'ManageFeeDetail','ManageFeeDetail') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (303,8,'MoneyWeek','MoneyWeek') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (304,8,'OtherArPerson','OtherArPerson') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (305,8,'MonthFeeNamecard','MonthFeeNamecard') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (306,8,'MonthFeePlane','MonthFeePlane') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (307,8,'MonthFeeEMS','MonthFeeEMS') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (308,8,'MonthFeeSNKD','MonthFeeSNKD') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (309,8,'ShowColumn','ShowColumn') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (310,8,'LogView','LogView') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (350,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (380,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (351,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (352,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (353,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (382,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (370,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (371,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (372,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (373,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (374,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (375,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (381,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (383,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (384,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (385,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (386,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (387,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (388,8,'','') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (389,8,'','') 
GO
