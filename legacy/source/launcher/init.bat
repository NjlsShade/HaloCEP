set init=0.0.1

:network
echo ' Set your settings > "%temp%\download.vbs"
echo	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/version.txt" >> "%temp%\download.vbs"
echo	strHDLocation = "%temp%\version.txt" >> "%temp%\download.vbs"
echo ' Fetch the file >> "%temp%\download.vbs"
echo	Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> "%temp%\download.vbs"
echo	objXMLHTTP.open "GET", strFileURL, false >> "%temp%\download.vbs"
echo	objXMLHTTP.send() >> "%temp%\download.vbs"
echo If objXMLHTTP.Status = 200 Then >> "%temp%\download.vbs"
echo Set objADOStream = CreateObject("ADODB.Stream") >> "%temp%\download.vbs"
echo objADOStream.Open >> "%temp%\download.vbs"
echo objADOStream.Type = 1 'adTypeBinary >> "%temp%\download.vbs"
echo objADOStream.Write objXMLHTTP.ResponseBody >> "%temp%\download.vbs"
echo objADOStream.Position = 0    'Set the stream position to the start >> "%temp%\download.vbs"
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> "%temp%\download.vbs"
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> "%temp%\download.vbs"
echo Set objFSO = Nothing >> "%temp%\download.vbs"
echo objADOStream.SaveToFile strHDLocation >> "%temp%\download.vbs"
echo objADOStream.Close >> "%temp%\download.vbs"
echo Set objADOStream = Nothing >> "%temp%\download.vbs"
echo End if >> "%temp%\download.vbs"
echo Set objXMLHTTP = Nothing >> "%temp%\download.vbs"
cscript.exe "%temp%\download.vbs"
del "%temp%\download.vbs"

if exist "%temp%\version.txt" (
	grabcore.dll -n "/init/p" "%temp%\version.txt" | grabcore.dll "s/\<init\>//g" | grabcore.dll "s/ //g" > "%temp%\init.txt"
	set /p initver= < "%temp%\init.txt"
	if "%initver%" gtr "%init%" (
		echo ' Set your settings > "%temp%\update.vbs"
		echo	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/launcher/launch/init.dll" >> "%temp%\update.vbs"
		echo	strHDLocation = "%CD%\init.new" >> "%temp%\update.vbs"
		echo ' Fetch the file >> "%temp%\update.vbs"
		echo	Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> "%temp%\update.vbs"
		echo	objXMLHTTP.open "GET", strFileURL, false >> "%temp%\update.vbs"
		echo	objXMLHTTP.send() >> "%temp%\update.vbs"
		echo If objXMLHTTP.Status = 200 Then >> "%temp%\update.vbs"
		echo Set objADOStream = CreateObject("ADODB.Stream") >> "%temp%\update.vbs"
		echo objADOStream.Open >> "%temp%\update.vbs"
		echo objADOStream.Type = 1 'adTypeBinary >> "%temp%\update.vbs"
		echo objADOStream.Write objXMLHTTP.ResponseBody >> "%temp%\update.vbs"
		echo objADOStream.Position = 0    'Set the stream position to the start >> "%temp%\update.vbs"
		echo Set objFSO = Createobject("Scripting.FileSystemObject") >> "%temp%\update.vbs"
		echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> "%temp%\update.vbs"
		echo Set objFSO = Nothing >> "%temp%\update.vbs"
		echo objADOStream.SaveToFile strHDLocation >> "%temp%\update.vbs"
		echo objADOStream.Close >> "%temp%\update.vbs"
		echo Set objADOStream = Nothing >> "%temp%\update.vbs"
		echo End if >> "%temp%\update.vbs"
		echo Set objXMLHTTP = Nothing >> "%temp%\update.vbs"
		cscript.exe "%temp%\update.vbs"
		del "%temp%\update.vbs"
		
		echo move init.dll init.old > "%CD%\update.bat"
		echo move init.new init.dll >> "%CD%\update.bat"
		echo if exist "%CD%\init.dll" start init.dll >> "%CD%\update.bat"
		echo exit >> "%CD%\update.bat"
		start /b update.bat
		exit
	) else (
		echo Checking for ups
		pause
	)
) else (
	echo Checking for ups
		pause
)