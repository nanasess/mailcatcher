FROM mcr.microsoft.com/windows/servercore:1809

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	Invoke-WebRequest -Method Get -Uri https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.1-1/rubyinstaller-2.6.1-1-x64.exe -OutFile c:\rubyinstaller-2.6.1-1-x64.exe ; \
	Start-Process c:\rubyinstaller-2.6.1-1-x64.exe -ArgumentList '/verysilent' -Wait ; \
	Remove-Item c:\rubyinstaller-2.6.1-1-x64.exe -Force

RUN C:\Ruby26-x64\bin\gem install mailcatcher -v 0.6.5
RUN ls C:\Ruby26-x64\bin
# smtp port
EXPOSE 1025

# webserver port
EXPOSE 1080

CMD ["C:\Ruby26-x64\bin\mailcatcher", "--ip=0.0.0.0"]
