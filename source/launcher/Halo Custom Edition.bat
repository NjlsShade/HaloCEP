setlocal enabledelayedexpansion
set USERPROFILE=%CD%\data\
:start
if exist "%CD%\base.dll" (
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
											if exist "%CD%\dialog.dll" (
												if exist "%CD%\grabcore.dll" (
													if not exist "%CD%\data\Documents" (
														mkdir "%CD%\data\Documents\My Games\Halo CE\hac\packs"
														grabup.dll -O "%CD%\data\Documents\My Games\Halo CE\hac\packs\medals.zip" "https://bitbucket.org/NjlsShade/halocep/raw/master/source/hac/packs/medals.zip" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Downloading File..."
														grabup.dll -O "%CD%\data\Documents\My Games\Halo CE\hac\preferences.ini" "https://bitbucket.org/NjlsShade/halocep/raw/master/source/hac/preferences.ini" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Downloading File..."
													)
													"%CD%\base.dll" -console -use21
													reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Games\Halo CE" /f
													reg delete "HKEY_CURRENT_USER\Software\Microsoft\Microsoft Games\Halo CE" /f
													reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Microsoft Games\Halo CE" /f
													reg delete "HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\Microsoft Games\Halo CE" /f
													exit
												) else (
													call :MessageBox "grabcore.dll was not found!" "Notice"
													del "%temp%\input.vbs"
													exit
												)
											) else (
												call :MessageBox "dialog.dll was not found!" "Notice"
												del "%temp%\input.vbs"
												exit
											)
										) else (
											call :MessageBox "vorbisfile.dll was not found!" "Notice"
											del "%temp%\input.vbs"
											exit
										)
									) else (
										call :MessageBox "vorbis.dll was not found!" "Notice"
										del "%temp%\input.vbs"
										exit
									)
								) else (
									call :MessageBox "strings.dll was not found!" "Notice"
									del "%temp%\input.vbs"
									exit
								)
							) else (
								call :MessageBox "ogg.dll was not found!" "Notice"
								del "%temp%\input.vbs"
								exit
							)
						) else (
							call :MessageBox "msvcr71.dll was not found!" "Notice"
							del "%temp%\input.vbs"
							exit
						)
					) else (
						call :MessageBox "ksimeui.dll was not found!" "Notice"
						del "%temp%\input.vbs"
						exit
					)
				) else (
					call :MessageBox "Keystone.dll was not found!" "Notice"
					del "%temp%\input.vbs"
					exit
				)
			) else (
				call :MessageBox "eula.dll was not found!" "Notice"
				del "%temp%\input.vbs"
				exit
			)
		) else (
			call :MessageBox "config.txt was not found!" "Notice"
			del "%temp%\input.vbs"
			exit
		)
	) else (
		call :YesNoBox "binkw32.dll was not found. Would you like to automaticly download it?" "Notice"
		if "!YesNo!"=="6" goto binkw32
		goto exit
		:binkw32
		grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/binkw32.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Downloading File..."
		goto start
	)
) else (
	call :YesNoBox "base.dll was not found. Would you like to automaticly download it?" "Notice"
	if "!YesNo!"=="6" goto base
	goto exit
	:base
	grabup.dll "https://bitbucket.org/NjlsShade/halocep/raw/master/source/launcher/base.dll" 2>&1 | grabcore.dll -u "s/.*\ \([0-9]\+%%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/" | dialog.dll --no-cancel --progress --auto-close --title="Downloading File..."
	goto start
)

:exit
del "%temp%\input.vbs"
exit
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