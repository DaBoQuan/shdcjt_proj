			function getUserPIN()
				Dim vbsserial
				dim hCard
				hCard = 0
				on   error   resume   next
				hCard = htactx.OpenDevice(1)'���豸
				If Err.number<>0 or hCard = 0 then
					'alert("��ȷ�����Ѿ���ȷ�ذ�װ���������򲢲�����usb����")
					Exit function
				End if
				dim UserName
				on   error   resume   next
				UserName = htactx.GetUserName(hCard)'��ȡ�û���
				If Err.number<>0 Then
					'alert("��ȷ�����Ѿ���ȷ�ذ�װ���������򲢲�����usb����2")
					htactx.CloseDevice hCard
					Exit function
				End if

				vbsserial = UserName
				htactx.CloseDevice hCard
				getUserPIN = vbsserial
			End function

			function getRandomKey(randnum)
				dim hCard
				hCard = 0	
				hCard = htactx.OpenDevice(1)'���豸
				If Err.number<>0 or hCard = 0 then
					'alert("��ȷ�����Ѿ���ȷ�ذ�װ���������򲢲�����usb����4")
					Exit function
				End if
				dim Digest
				Digest = 0
				on error resume next
					Digest = htactx.HTSHA1(randnum, len(randnum))
				if err.number<>0 then
						htactx.CloseDevice hCard
						Exit function
				end if

				on error resume next
					Digest = Digest&"04040404"'��SHA1���ݽ��в���
				if err.number<>0 then
						htactx.CloseDevice hCard
						Exit function
				end if

				htactx.VerifyUserPin hCard, CStr(password) 'У�����
				'alert HRESULT
				If Err.number<>0 Then
					'alert("HashToken compute")
					htactx.CloseDevice hCard
					Exit function
				End if
				dim EnData
				EnData = 0
				EnData = htactx.HTCrypt(hCard, 0, 0, Digest, len(Digest))'DES3����SHA1�������
				If Err.number<>0 Then 
					'alert("HashToken compute")
					htactx.CloseDevice hCard
					Exit function
				End if
				htactx.CloseDevice hCard
				getRandomKey = EnData
				'alert "EnData = "&EnData
			End function
