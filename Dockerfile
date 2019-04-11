FROM mcr.microsoft.com/windows/servercore:1809

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	Invoke-WebRequest -Method Get -Uri http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.2.4-x64.exe -OutFile c:\rubyinstaller-2.2.4-x64.exe ; \
	Start-Process c:\rubyinstaller-2.2.4-x64.exe -ArgumentList '/verysilent' -Wait ; \
	Remove-Item c:\rubyinstaller-2.2.4-x64.exe -Force

RUN C:\Ruby22-x64\bin\gem install mailcatcher

# smtp port
EXPOSE 1025

# webserver port
EXPOSE 1080

CMD ["mailcatcher", "--no-quit", "--foreground", "--ip=0.0.0.0"]
