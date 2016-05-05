setlocal enabledelayedexpansion
set USERPROFILE=%CD%\data\
if exist "%CD%\data\config\update_lock.ns" (
	set /p lock= < "%CD%\data\config\update_lock.ns"
) else (
	set lock=0
)
:network
echo ' Set your settings > "%temp%\download.vbs"
echo 	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/version.txt" >> "%temp%\download.vbs"
echo 	strHDLocation = "%temp%\version.txt" >> "%temp%\download.vbs"
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
	if exist "%CD%\data\Documents\My Games\Halo CE\dat\versions\base.ns" (
		if "%lock%"=="1" goto var
	)
	goto ver
)
:nonet
set nonet=1
goto start
:var
grabcore.dll -n "/a/p" "%temp%\version.txt" | grabcore.dll "s/\<base\>//g" | grabcore.dll "s/ //g" > "%temp%\base.txt"
set /p basecon= < "%temp%\base.txt"
set /p base= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\base.ns"
:start
if exist "%CD%\base.dll" (
	if not "%nonet%"=="1" (
		if "%basecon%" gtr "%base%" (
			del "%CD%\base.dll"
			grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/launcher/base.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing base.dll"
			move /Y "%temp%\base.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\base.ns"
		)
	)
	if exist "%CD%\binkw32.dll" (
		if exist "%CD%\config.txt" (
			if exist "%CD%\eula.dll" (
				if exist "%CD%\Keystone.dll" (
					if exist "%CD%\ksimeui.dll" (
						if exist "%CD%\msvcr71.dll" (
							if exist "%CD%\ogg.dll" (
								if exist "%CD%\strings.dll" (
									if exist "%CD%\vorbis.dll" (
										if exist "%CD%\vorbisfile.dll" (
											if exist "%CD%\spread.dll" (
												call :core
												if not exist "%CD%\data\Documents\My Games\Halo CE\dat\packs\medals.zip" (
													mkdir "%CD%\data\Documents\My Games\Halo CE\dat\packs"
													call :compat
													grabup.dll -O "%CD%\data\Documents\My Games\Halo CE\dat\packs\medals.zip" "https://bitbucket.org/NjlsShade/halocep/raw/master/source/dat/packs/medals.zip" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing medals.zip"
													grabup.dll -O "%CD%\data\Documents\My Games\Halo CE\dat\preferences.ini" "https://bitbucket.org/NjlsShade/halocep/raw/master/source/dat/preferences.ini" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing preferences.ini"
												)
												"%CD%\base.dll" -console -use21
												reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Games\Halo CE" /f
												reg delete "HKEY_CURRENT_USER\Software\Microsoft\Microsoft Games\Halo CE" /f
												reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Microsoft Games\Halo CE" /f
												reg delete "HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\Microsoft Games\Halo CE" /f
												goto exit
											) else (
												if "%nonet%"=="1" (
													call :MessageBox "spread.dll was not found." "Notice"
													goto exit
												) else (
													call :YesNoBox "spread.dll was not found. Would you like to automatically download it?" "Notice"
													if "!YesNo!"=="6" goto spread
													goto exit
													:spread
													call :compat
													grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/spread.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing spread.dll"
													goto start
												)
											)
										) else (
											if "%nonet%"=="1" (
												call :MessageBox "vorbisfile.dll was not found." "Notice"
												goto exit
											) else (
												call :YesNoBox "vorbisfile.dll was not found. Would you like to automatically download it?" "Notice"
												if "!YesNo!"=="6" goto vorbisfile
												goto exit
												:vorbisfile
												call :compat
												grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/vorbisfile.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing vorbisfile.dll"
												goto start
											)
										)
									) else (
										if "%nonet%"=="1" (
											call :MessageBox "vorbis.dll was not found." "Notice"
											goto exit
										) else (
											call :YesNoBox "vorbis.dll was not found. Would you like to automatically download it?" "Notice"
											if "!YesNo!"=="6" goto vorbis
											goto exit
											:vorbis
											call :compat
											grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/vorbis.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing vorbis.dll"
											goto start
										)
									)
								) else (
									if "%nonet%"=="1" (
										call :MessageBox "strings.dll was not found." "Notice"
										goto exit
									) else (
										call :YesNoBox "strings.dll was not found. Would you like to automatically download it?" "Notice"
										if "!YesNo!"=="6" goto strings
										goto exit
										:strings
										call :compat
										grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/splash/strings.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing strings.dll"
										goto start
									)
								)
							) else (
								if "%nonet%"=="1" (
									call :MessageBox "ogg.dll was not found." "Notice"
									goto exit
								) else (
									call :YesNoBox "ogg.dll was not found. Would you like to automatically download it?" "Notice"
									if "!YesNo!"=="6" goto ogg
									goto exit
									:ogg
									call :compat
									grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/ogg.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing ogg.dll"
									goto start
								)
							)
						) else (
							if "%nonet%"=="1" (
								call :MessageBox "msvcr71.dll was not found." "Notice"
								goto exit
							) else (
								call :YesNoBox "msvcr71.dll was not found. Would you like to automatically download it?" "Notice"
								if "!YesNo!"=="6" goto msvcr71
								goto exit
								:msvcr71
								call :compat
								grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/msvcr71.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing msvcr71.dll"
								goto start
							)
						)
					) else (
						if "%nonet%"=="1" (
							call :MessageBox "ksimeui.dll was not found." "Notice"
							goto exit
						) else (
							call :YesNoBox "ksimeui.dll was not found. Would you like to automatically download it?" "Notice"
							if "!YesNo!"=="6" goto ksimeui
							goto exit
							:ksimeui
							call :compat
							grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/ksimeui.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing ksimeui.dll"
							goto start
						)
					)
				) else (
					if "%nonet%"=="1" (
						call :MessageBox "Keystone.dll was not found." "Notice"
						goto exit
					) else (
						call :YesNoBox "Keystone.dll was not found. Would you like to automatically download it?" "Notice"
						if "!YesNo!"=="6" goto Keystone
						goto exit
						:Keystone
						call :compat
						grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/Keystone.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing Keystone.dll"
						goto start
					)
				)
			) else (
				if "%nonet%"=="1" (
					call :MessageBox "eula.dll was not found." "Notice"
					goto exit
				) else (
					call :YesNoBox "eula.dll was not found. Would you like to automatically download it?" "Notice"
					if "!YesNo!"=="6" goto eula
					goto exit
					:eula
					call :compat
					grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/eula/eula.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing eula.dll"
					goto start
				)
			)
		) else (
			if "%nonet%"=="1" (
				call :MessageBox "config.txt was not found." "Notice"
				goto exit
			) else (
				call :YesNoBox "config.txt was not found. Would you like to automatically download it?" "Notice"
				if "!YesNo!"=="6" goto config
				goto exit
				:config
				call :compat
				grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/config.txt" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing config.txt"
				goto start
			)
		)
	) else (
		if "%nonet%"=="1" (
			call :MessageBox "binkw32.dll was not found." "Notice"
			goto exit
		) else (
			call :YesNoBox "binkw32.dll was not found. Would you like to automatically download it?" "Notice"
			if "!YesNo!"=="6" goto binkw32
			goto exit
			:binkw32
			call :compat
			grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/binkw32.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing binkw32.dll"
			goto start
		)
	)
) else (
	if "%nonet%"=="1" (
		call :MessageBox "base.dll was not found." "Notice"
		goto exit
	) else (
		call :YesNoBox "base.dll was not found. Would you like to automatically download it?" "Notice"
		if "!YesNo!"=="6" goto base
		goto exit
		:base
		call :compat
		grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/launcher/base.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing base.dll"
		goto start
	)
)
:compat
if exist "%CD%\grabup.dll" (
	if exist "%CD%\grabcore.dll" (
		if exist "%CD%\dialog.dll" (
			exit /b
		)
	)
)
goto core
:core
if not exist "%CD%\grabup.dll" (
	call :YesNoBox "grabup.dll was not found, and is used to automatically download files. You can automatically download grabup.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto grabup
	goto exit
	:grabup
	echo ' Set your settings > "%temp%\download.vbs"
    echo 	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/grabup.dll" >> "%temp%\download.vbs"
    echo 	strHDLocation = "grabup.dll" >> "%temp%\download.vbs"
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
	del "%temp%\download.vbs"
)
if not exist "%CD%\grabcore.dll" (
	call :YesNoBox "grabcore.dll was not found, and is used to assist automatic download of files. You can automatically download grabcore.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto grabcore
	goto exit
	:grabcore
	grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/grabcore.dll"
)
if not exist "%CD%\dialog.dll" (
	call :YesNoBox "dialog.dll was not found, and is used to display progress of automatically downloaded files. You can automatically download dialog.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto dialog
	goto exit
	:dialog
	grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/dialog.dll"
)
if not exist "%CD%\libiconv2.dll" (
	call :YesNoBox "libiconv2.dll was not found, and is used to assist automatic download of files. You can automatically download libiconv2.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto libiconv2
	goto exit
	:libiconv2
	echo ' Set your settings > "%temp%\download.vbs"
    echo 	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/libiconv2.dll" >> "%temp%\download.vbs"
    echo 	strHDLocation = "libiconv2.dll" >> "%temp%\download.vbs"
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
)
if not exist "%CD%\libintl3.dll" (
	call :YesNoBox "libintl3.dll was not found, and is used to assist automatic download of files. You can automatically download libintl3.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto libintl3
	goto exit
	:libintl3
	echo ' Set your settings > "%temp%\download.vbs"
    echo 	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/libintl3.dll" >> "%temp%\download.vbs"
    echo 	strHDLocation = "libintl3.dll" >> "%temp%\download.vbs"
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
)
if not exist "%CD%\regex2.dll" (
	call :YesNoBox "regex2.dll was not found, and is used to assist automatic download of files. You can automatically download regex2.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto regex2
	goto exit
	:regex2
	echo ' Set your settings > "%temp%\download.vbs"
    echo 	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/regex2.dll" >> "%temp%\download.vbs"
    echo 	strHDLocation = "regex2.dll" >> "%temp%\download.vbs"
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
)
exit /b
:ver
call :YesNoBox "A full update is needed. Would you like to automatically update now?" "Notice"
if "!YesNo!"=="6" goto upgrade
goto start
:upgrade
echo ' Set your settings > "%temp%\download.vbs"
echo 	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/versions.ns" >> "%temp%\download.vbs"
echo 	strHDLocation = "%temp%\versions.ns" >> "%temp%\download.vbs"
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
if not exist "%temp%\versions.ns" goto nonet
del "%CD%\base.dll"
del "%CD%\binkw32.dll"
del "%CD%\config.txt"
del "%CD%\dialog.dll"
del "%CD%\eula.dll"
del "%CD%\grabcore.dll"
del "%CD%\grabup.dll"
del "%CD%\Keystone.dll"
del "%CD%\ksimeui.dll"
del "%CD%\libiconv2.dll"
del "%CD%\libintl3.dll"
del "%CD%\msvcr71.dll"
del "%CD%\ogg.dll"
del "%CD%\regex2.dll"
del "%CD%\strings.dll"
del "%CD%\vorbis.dll"
del "%CD%\vorbisfile.dll"
del "%CD%\spread.dll"
call :compat
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/launcher/base.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing base.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/binkw32.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing binkw32.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/config.txt" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing config.txt"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/eula/eula.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing eula.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/Keystone.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing Keystone.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/ksimeui.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing ksimeui.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/msvcr71.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing msvcr71.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/ogg.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing ogg.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/splash/strings.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing strings.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/vorbis.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing vorbis.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/vorbisfile.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing vorbisfile.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/spread.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing spread.dll"
mkdir "%CD%\data\Documents\My Games\Halo CE\dat\versions"
spread.dll x "%temp%\versions.ns" -aoa -y -o"%CD%\data\Documents\My Games\Halo CE\dat\versions"
mkdir "%CD%\data\config"
> "%CD%\data\config\update_lock.ns" echo 1
goto start
:MessageBox
set heading=%~2
set message=%~1
echo msgbox WScript.Arguments(0),0,WScript.Arguments(1) >"%temp%\input.vbs"
cscript //nologo "%temp%\input.vbs" "%message%" "%heading%"
exit /b
:YesNoBox
REM returns 6 = Yes, 7 = No. Type=4 = Yes/No
set YesNo=
set MsgType=4
set heading=%~2
set message=%~1
echo wscript.echo msgbox(WScript.Arguments(0),%MsgType%,WScript.Arguments(1)) >"%temp%\input.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\input.vbs" "%message%" "%heading%"') do set YesNo=%%a
exit /b
:exit
del "%temp%\input.vbs"
del "%temp%\download.vbs"
del "%temp%\version.txt"
exit