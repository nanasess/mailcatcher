FROM mcr.microsoft.com/windows/servercore AS installer-env

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Method Get -Uri https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.5.3-1/rubyinstaller-devkit-2.5.3-1-x64.exe -OutFile c:\rubyinstaller-devkit-2.5.3-1-x64.exe ; \
	Start-Process c:\rubyinstaller-devkit-2.5.3-1-x64.exe -ArgumentList '/verysilent' -Wait ; \
	Remove-Item c:\rubyinstaller-devkit-2.5.3-1-x64.exe -Force

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Method Get -Uri https://www.sqlite.org/2018/sqlite-amalgamation-3240000.zip -OutFile c:\sqlite-amalgamation-3240000.zip ; \
	Expand-Archive -Path C:\sqlite-amalgamation-3240000.zip -DestinationPath \ -Force ; \
	Remove-Item C:\sqlite-amalgamation-3240000.zip -Force

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Method Get -Uri https://www.sqlite.org/2018/sqlite-dll-win64-x64-3240000.zip -OutFile c:\sqlite-dll-win64-x64-3240000.zip ; \
	Expand-Archive -Path C:\sqlite-dll-win64-x64-3240000.zip -DestinationPath \ -Force ; \
	Remove-Item C:\sqlite-dll-win64-x64-3240000.zip -Force
RUN copy /B /Y C:\sqlite3.dll C:\Ruby25-x64\bin

RUN set PATH=%PATH%;C:\Ruby25-x64\bin;C:\Ruby25-x64\msys64\usr\bin

RUN gem install sqlite3 -v "=1.3.13" --platform=ruby -- --with-sqlite3-include=C:\sqlite-amalgamation-3240000 --with-sqlite3-lib=C:\Ruby25-x64\bin
#RUN gem specific_install -l https://github.com/larskanis/sqlite3-ruby -b add-gemspec

RUN gem install mailcatcher -v 0.6.5

RUN rd /s /q C:\Ruby25-x64\msys64

FROM mcr.microsoft.com/windows/nanoserver

COPY --from=installer-env ["C:\Ruby25-x64", "C:\Ruby25-x64"]

# smtp port
EXPOSE 1025

# webserver port
EXPOSE 1080

CMD ["C:\Ruby25-x64\bin\mailcatcher", "--ip=0.0.0.0"]
