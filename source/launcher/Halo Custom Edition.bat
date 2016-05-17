setlocal enabledelayedexpansion
set USERPROFILE=%CD%\data\
if exist "%CD%\data\config\update_lock.ns" (
	set /p lock= < "%CD%\data\config\update_lock.ns"
) else (
	set lock=0
)
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
	if exist "%CD%\data\Documents\My Games\Halo CE\dat\versions\base.ns" (
		if "%lock%"=="1" goto var
	)
	goto ver
)
:nonet
set nonet=1
goto start
:var
grabcore.dll -n "/base/p" "%temp%\version.txt" | grabcore.dll "s/\<base\>//g" | grabcore.dll "s/ //g" > "%temp%\base.txt"
set /p basecon= < "%temp%\base.txt"
set /p base= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\base.ns"
grabcore.dll -n "/binkw32/p" "%temp%\version.txt" | grabcore.dll "s/\<binkw32\>//g" | grabcore.dll "s/ //g" > "%temp%\binkw32.txt"
set /p binkw32con= < "%temp%\binkw32.txt"
set /p binkw32= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\config.ns"
grabcore.dll -n "/config/p" "%temp%\version.txt" | grabcore.dll "s/\<config\>//g" | grabcore.dll "s/ //g" > "%temp%\config.txt"
set /p configcon= < "%temp%\config.txt"
set /p config= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\config.ns"
grabcore.dll -n "/eula/p" "%temp%\version.txt" | grabcore.dll "s/\<eula\>//g" | grabcore.dll "s/ //g" > "%temp%\eula.txt"
set /p eulacon= < "%temp%\eula.txt"
set /p eula= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\eula.ns"
grabcore.dll -n "/Keystone/p" "%temp%\version.txt" | grabcore.dll "s/\<Keystone\>//g" | grabcore.dll "s/ //g" > "%temp%\Keystone.txt"
set /p Keystonecon= < "%temp%\Keystone.txt"
set /p Keystone= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\Keystone.ns"
grabcore.dll -n "/ksimeui/p" "%temp%\version.txt" | grabcore.dll "s/\<ksimeui\>//g" | grabcore.dll "s/ //g" > "%temp%\ksimeui.txt"
set /p ksimeuicon= < "%temp%\ksimeui.txt"
set /p ksimeui= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\ksimeui.ns"
grabcore.dll -n "/msvcr71/p" "%temp%\version.txt" | grabcore.dll "s/\<msvcr71\>//g" | grabcore.dll "s/ //g" > "%temp%\msvcr71.txt"
set /p msvcr71con= < "%temp%\msvcr71.txt"
set /p msvcr71= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\msvcr71.ns"
grabcore.dll -n "/ogg/p" "%temp%\version.txt" | grabcore.dll "s/\<ogg\>//g" | grabcore.dll "s/ //g" > "%temp%\ogg.txt"
set /p oggcon= < "%temp%\ogg.txt"
set /p ogg= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\ogg.ns"
grabcore.dll -n "/strings/p" "%temp%\version.txt" | grabcore.dll "s/\<strings\>//g" | grabcore.dll "s/ //g" > "%temp%\strings.txt"
set /p stringscon= < "%temp%\strings.txt"
set /p strings= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\strings.ns"
grabcore.dll -n "/vorbis/p" "%temp%\version.txt" | grabcore.dll "s/\<vorbis\>//g" | grabcore.dll "s/ //g" > "%temp%\vorbis.txt"
set /p vorbiscon= < "%temp%\vorbis.txt"
set /p vorbis= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\vorbis.ns"
grabcore.dll -n "/vorbisfile/p" "%temp%\version.txt" | grabcore.dll "s/\<vorbisfile\>//g" | grabcore.dll "s/ //g" > "%temp%\vorbisfile.txt"
set /p vorbisfilecon= < "%temp%\vorbisfile.txt"
set /p vorbisfile= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\vorbisfile.ns"
grabcore.dll -n "/spread/p" "%temp%\version.txt" | grabcore.dll "s/\<spread\>//g" | grabcore.dll "s/ //g" > "%temp%\spread.txt"
set /p spreadcon= < "%temp%\spread.txt"
set /p spread= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\spread.ns"
grabcore.dll -n "/dat/p" "%temp%\version.txt" | grabcore.dll "s/\<dat\>//g" | grabcore.dll "s/ //g" > "%temp%\dat.txt"
set /p datcon= < "%temp%\dat.txt"
set /p dat= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\dat.ns"
grabcore.dll -n "/asset/p" "%temp%\version.txt" | grabcore.dll "s/\<asset\>//g" | grabcore.dll "s/ //g" > "%temp%\asset.txt"
set /p assetcon= < "%temp%\asset.txt"
set /p asset= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\asset.ns"
grabcore.dll -n "/medals/p" "%temp%\version.txt" | grabcore.dll "s/\<medals\>//g" | grabcore.dll "s/ //g" > "%temp%\medals.txt"
set /p medalscon= < "%temp%\medals.txt"
set /p medals= < "%CD%\data\Documents\My Games\Halo CE\dat\versions\medals.ns"
:start
if exist "%CD%\base.dll" (
	if not "%nonet%"=="1" (
		if "%basecon%" gtr "%base%" (
			call :ynb "An update is needed for base.dll. Would you like to download it now?" "Update"
			if "!YesNo!"=="6" (
				del "%CD%\base.dll"
				grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/launcher/base.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing base.dll"
				move /Y "%temp%\base.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\base.ns"
			)
		)
	)
	if exist "%CD%\binkw32.dll" (
		if not "%nonet%"=="1" (
			if "%binkw32con%" gtr "%binkw32%" (
				call :ynb "An update is needed for binkw32.dll. Would you like to download it now?" "Update"
				if "!YesNo!"=="6" (
					del "%CD%\binkw32.dll"
					grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/binkw32.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing binkw32.dll"
					move /Y "%temp%\binkw32.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\binkw32.ns"
				)
			)
		)
		if exist "%CD%\config.txt" (
			if not "%nonet%"=="1" (
				if "%configcon%" gtr "%config%" (
					call :ynb "An update is needed for config.dll. Would you like to download it now?" "Update"
					if "!YesNo!"=="6" (
						del "%CD%\config.dll"
						grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/config.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing config.dll"
						move /Y "%temp%\config.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\config.ns"
					)
				)
			)
			if exist "%CD%\eula.dll" (
				if not "%nonet%"=="1" (
					if "%eulacon%" gtr "%eula%" (
						call :ynb "An update is needed for eula.dll. Would you like to download it now?" "Update"
						if "!YesNo!"=="6" (
							del "%CD%\eula.dll"
							grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/eula/eula.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing eula.dll"
							move /Y "%temp%\eula.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\eula.ns"
						)
					)
				)
				if exist "%CD%\Keystone.dll" (
					if not "%nonet%"=="1" (
						if "%Keystonecon%" gtr "%Keystone%" (
							call :ynb "An update is needed for Keystone.dll. Would you like to download it now?" "Update"
							if "!YesNo!"=="6" (
								del "%CD%\Keystone.dll"
								grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/Keystone.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing Keystone.dll"
								move /Y "%temp%\Keystone.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\Keystone.ns"
							)
						)
					)
					if exist "%CD%\ksimeui.dll" (
						if not "%nonet%"=="1" (
							if "%ksimeuicon%" gtr "%ksimeui%" (
								call :ynb "An update is needed for ksimeui.dll. Would you like to download it now?" "Update"
								if "!YesNo!"=="6" (
									del "%CD%\ksimeui.dll"
									grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/ksimeui.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing ksimeui.dll"
									move /Y "%temp%\ksimeui.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\ksimeui.ns"
								)
							)
						)
						if exist "%CD%\msvcr71.dll" (
							if not "%nonet%"=="1" (
								if "%msvcr71con%" gtr "%msvcr71%" (
									call :ynb "An update is needed for msvcr71.dll. Would you like to download it now?" "Update"
									if "!YesNo!"=="6" (
										del "%CD%\msvcr71.dll"
										grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/msvcr71.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing msvcr71.dll"
										move /Y "%temp%\msvcr71.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\msvcr71.ns"
									)
								)
							)
							if exist "%CD%\ogg.dll" (
								if not "%nonet%"=="1" (
									if "%oggcon%" gtr "%ogg%" (
										call :ynb "An update is needed for ogg.dll. Would you like to download it now?" "Update"
										if "!YesNo!"=="6" (
											del "%CD%\ogg.dll"
											grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/ogg.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing ogg.dll"
											move /Y "%temp%\ogg.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\ogg.ns"
										)
									)
								)
								if exist "%CD%\strings.dll" (
									if not "%nonet%"=="1" (
										if "%stringscon%" gtr "%strings%" (
											call :ynb "An update is needed for strings.dll. Would you like to download it now?" "Update"
											if "!YesNo!"=="6" (
												del "%CD%\strings.dll"
												grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/splash/strings.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing strings.dll"
												move /Y "%temp%\strings.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\strings.ns"
											)
										)
									)
									if exist "%CD%\vorbis.dll" (
										if not "%nonet%"=="1" (
											if "%vorbiscon%" gtr "%vorbis%" (
												call :ynb "An update is needed for vorbis.dll. Would you like to download it now?" "Update"
												if "!YesNo!"=="6" (
													del "%CD%\vorbis.dll"
													grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/vorbis.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing vorbis.dll"
													move /Y "%temp%\vorbis.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\vorbis.ns"
												)
											)
										)
										if exist "%CD%\vorbisfile.dll" (
											if not "%nonet%"=="1" (
												if "%vorbisfilecon%" gtr "%vorbisfile%" (
													call :ynb "An update is needed for vorbisfile.dll. Would you like to download it now?" "Update"
													if "!YesNo!"=="6" (
														del "%CD%\vorbisfile.dll"
														grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/vorbisfile.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing vorbisfile.dll"
														move /Y "%temp%\vorbisfile.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\vorbisfile.ns"
													)
												)
											)
											if exist "%CD%\spread.dll" (
												if not "%nonet%"=="1" (
													if "%spreadcon%" gtr "%spread%" (
														call :ynb "An update is needed for spread.dll. Would you like to download it now?" "Update"
														if "!YesNo!"=="6" (
															del "%CD%\spread.dll"
															grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/spread.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing spread.dll"
															move /Y "%temp%\spread.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\spread.ns"
														)
													)
												)
												if exist "%CD%\dat.dll" (
													if not "%nonet%"=="1" (
														if "%datcon%" gtr "%dat%" (
															call :ynb "An update is needed for dat.dll. Would you like to download it now?" "Update"
															if "!YesNo!"=="6" (
																del "%CD%\dat.dll"
																grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/asset/dat.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing dat.dll"
																move /Y "%temp%\dat.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\dat.ns"
															)
														)
													)
													if exist "%CD%\controls\asset.dll" (
														if not "%nonet%"=="1" (
															if "%assetcon%" gtr "%asset%" (
																call :ynb "An update is needed for asset.dll. Would you like to download it now?" "Update"
																if "!YesNo!"=="6" (
																	del "%CD%\controls\asset.dll"
																	grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/asset/asset.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing asset.dll"
																	move /Y "%CD%\asset.dll" "%CD%\controls\asset.dll"
																	move /Y "%temp%\asset.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\asset.ns"
																)
															)
														)
														call :core
														if not exist "%CD%\data\Documents\My Games\Halo CE\dat\packs\medals.zip" (
															mkdir "%CD%\data\Documents\My Games\Halo CE\dat\packs"
															call :compat
															grabup.dll -O "%CD%\data\Documents\My Games\Halo CE\dat\packs\medals.zip" "https://bitbucket.org/NjlsShade/halocep/raw/master/source/dat/packs/medals.zip" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing medals.zip"
															grabup.dll -O "%CD%\data\Documents\My Games\Halo CE\dat\preferences.ini" "https://bitbucket.org/NjlsShade/halocep/raw/master/source/dat/preferences.ini" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing preferences.ini"
														)
														if "%medalscon%" gtr "%medals%" (
															del "%CD%\data\Documents\My Games\Halo CE\dat\packs\medals.zip"
															grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/dat/packs/medals.zip" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing medals.zip"
															move /Y "%CD%\medals.zip" "%CD%\data\Documents\My Games\Halo CE\dat\packs\medals.zip"
															move /Y "%temp%\medals.txt" "%CD%\data\Documents\My Games\Halo CE\dat\versions\medals.ns"
														)
														copy /Y "%CD%\dat.dll" "%temp%\dat.dll"
														"%CD%\base.dll" -console -use21
														reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Games\Halo CE" /f
														reg delete "HKEY_CURRENT_USER\Software\Microsoft\Microsoft Games\Halo CE" /f
														reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Microsoft Games\Halo CE" /f
														reg delete "HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\Microsoft Games\Halo CE" /f
														goto exit
													) else (
														if "%nonet%"=="1" (
															call :mb "asset.dll was not found." "Notice"
															goto exit
														) else (
															call :ynb "asset.dll was not found. Would you like to automatically download it?" "Notice"
															if "!YesNo!"=="6" goto asset
															goto exit
															:asset
															call :compat
															grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/asset/asset.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing asset.dll"
															move /Y "%CD%\asset.dll" "%CD%\controls\asset.dll"
															goto start
														)
													)
												) else (
													if "%nonet%"=="1" (
														call :mb "dat.dll was not found." "Notice"
														goto exit
													) else (
														call :ynb "dat.dll was not found. Would you like to automatically download it?" "Notice"
														if "!YesNo!"=="6" goto dat
														goto exit
														:dat
														call :compat
														grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/asset/dat.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing dat.dll"
														goto start
													)
												)
											) else (
												if "%nonet%"=="1" (
													call :mb "spread.dll was not found." "Notice"
													goto exit
												) else (
													call :ynb "spread.dll was not found. Would you like to automatically download it?" "Notice"
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
												call :mb "vorbisfile.dll was not found." "Notice"
												goto exit
											) else (
												call :ynb "vorbisfile.dll was not found. Would you like to automatically download it?" "Notice"
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
											call :mb "vorbis.dll was not found." "Notice"
											goto exit
										) else (
											call :ynb "vorbis.dll was not found. Would you like to automatically download it?" "Notice"
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
										call :mb "strings.dll was not found." "Notice"
										goto exit
									) else (
										call :ynb "strings.dll was not found. Would you like to automatically download it?" "Notice"
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
									call :mb "ogg.dll was not found." "Notice"
									goto exit
								) else (
									call :ynb "ogg.dll was not found. Would you like to automatically download it?" "Notice"
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
								call :mb "msvcr71.dll was not found." "Notice"
								goto exit
							) else (
								call :ynb "msvcr71.dll was not found. Would you like to automatically download it?" "Notice"
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
							call :mb "ksimeui.dll was not found." "Notice"
							goto exit
						) else (
							call :ynb "ksimeui.dll was not found. Would you like to automatically download it?" "Notice"
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
						call :mb "Keystone.dll was not found." "Notice"
						goto exit
					) else (
						call :ynb "Keystone.dll was not found. Would you like to automatically download it?" "Notice"
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
					call :mb "eula.dll was not found." "Notice"
					goto exit
				) else (
					call :ynb "eula.dll was not found. Would you like to automatically download it?" "Notice"
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
				call :mb "config.txt was not found." "Notice"
				goto exit
			) else (
				call :ynb "config.txt was not found. Would you like to automatically download it?" "Notice"
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
			call :mb "binkw32.dll was not found." "Notice"
			goto exit
		) else (
			call :ynb "binkw32.dll was not found. Would you like to automatically download it?" "Notice"
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
		call :mb "base.dll was not found." "Notice"
		goto exit
	) else (
		call :ynb "base.dll was not found. Would you like to automatically download it?" "Notice"
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
	call :ynb "grabup.dll was not found, and is used to automatically download files. You can automatically download grabup.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto grabup
	goto exit
	:grabup
	echo ' Set your settings > "%temp%\download.vbs"
	echo	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/grabup.dll" >> "%temp%\download.vbs"
	echo	strHDLocation = "grabup.dll" >> "%temp%\download.vbs"
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
	call :ynb "grabcore.dll was not found, and is used to assist automatic download of files. You can automatically download grabcore.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto grabcore
	goto exit
	:grabcore
	grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/grabcore.dll"
)
if not exist "%CD%\dialog.dll" (
	call :ynb "dialog.dll was not found, and is used to display progress of automatically downloaded files. You can automatically download dialog.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto dialog
	goto exit
	:dialog
	grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/dialog.dll"
)
if not exist "%CD%\libiconv2.dll" (
	call :ynb "libiconv2.dll was not found, and is used to assist automatic download of files. You can automatically download libiconv2.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto libiconv2
	goto exit
	:libiconv2
	echo ' Set your settings > "%temp%\download.vbs"
	echo	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/libiconv2.dll" >> "%temp%\download.vbs"
	echo	strHDLocation = "libiconv2.dll" >> "%temp%\download.vbs"
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
	call :ynb "libintl3.dll was not found, and is used to assist automatic download of files. You can automatically download libintl3.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto libintl3
	goto exit
	:libintl3
	echo ' Set your settings > "%temp%\download.vbs"
	echo	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/libintl3.dll" >> "%temp%\download.vbs"
	echo	strHDLocation = "libintl3.dll" >> "%temp%\download.vbs"
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
	call :ynb "regex2.dll was not found, and is used to assist automatic download of files. You can automatically download regex2.dll, however, you will not be able to see the file's download progress. Would you like to automatically download it anyway?" "Notice"
	if "!YesNo!"=="6" goto regex2
	goto exit
	:regex2
	echo ' Set your settings > "%temp%\download.vbs"
	echo	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/regex2.dll" >> "%temp%\download.vbs"
	echo	strHDLocation = "regex2.dll" >> "%temp%\download.vbs"
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
call :ynb "A full update is needed. Would you like to automatically update now?" "Notice"
if "!YesNo!"=="6" goto upgrade
goto start
:upgrade
echo ' Set your settings > "%temp%\download.vbs"
echo	strFileURL = "https://bitbucket.org/NjlsShade/halocep/raw/master/source/update/versions.ns" >> "%temp%\download.vbs"
echo	strHDLocation = "%temp%\versions.ns" >> "%temp%\download.vbs"
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
del "%CD%\dat.dll"
del "%CD%\controls\asset.dll"
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
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/asset/dat.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing dat.dll"
grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/asset/asset.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Grabbing asset.dll"
move /Y "%CD%\asset.dll" "%CD%\controls\asset.dll"
mkdir "%CD%\data\Documents\My Games\Halo CE\dat\versions"
spread.dll x "%temp%\versions.ns" -aoa -y -o"%CD%\data\Documents\My Games\Halo CE\dat\versions"
mkdir "%CD%\data\config"
> "%CD%\data\config\update_lock.ns" echo 1
goto start
:mb
set heading=%~2
set message=%~1
echo msgbox WScript.Arguments(0),0,WScript.Arguments(1) >"%temp%\input.vbs"
cscript //nologo "%temp%\input.vbs" "%message%" "%heading%"
exit /b
:ynb
REM 6 = Yes; 7 = No. Type=4 = Yes/No
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
del "%temp%\dat.dll"
del "%temp%\versions.ns"
del "%temp%\version.txt"
del "%temp%\asset.txt"
del "%temp%\base.txt"
del "%temp%\binkw32.txt"
del "%temp%\config.txt"
del "%temp%\dat.txt"
del "%temp%\dialog.txt"
del "%temp%\eula.txt"
del "%temp%\grabcore.txt"
del "%temp%\grabup.txt"
del "%temp%\Halo Custom Edition.txt"
del "%temp%\Keystone.txt"
del "%temp%\ksimeui.txt"
del "%temp%\libiconv2.txt"
del "%temp%\libintl3.txt"
del "%temp%\msvcr71.txt"
del "%temp%\ogg.txt"
del "%temp%\regex2.txt"
del "%temp%\spread.txt"
del "%temp%\strings.txt"
del "%temp%\vorbis.txt"
del "%temp%\vorbisfile.txt"
del "%temp%\medals.txt"
exit