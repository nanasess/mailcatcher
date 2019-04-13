FROM nanasess/mailcatcher:windowsservercore AS installer-env

RUN ["C:/Ruby25-x64/bin/ruby.exe --version"]
RUN rd /s /q C:\Ruby25-x64\msys64
RUN ["C:/Ruby25-x64/bin/ruby.exe --version"]
RUN ["C:/Ruby25-x64/bin/mailcatcher.bat --help"]

FROM mcr.microsoft.com/windows/nanoserver

COPY --from=installer-env ["C:/Ruby25-x64", "C:/Ruby25-x64"]
COPY --from=installer-env ["C:/rubyinstaller-2.5.3-1-x64.exe", "C:/rubyinstaller-2.5.3-1-x64.exe"]

RUN powershell -Command \
	Start-Process c:\rubyinstaller-2.5.3-1-x64.exe -ArgumentList '/verysilent' -Wait ; \
	Remove-Item c:\rubyinstaller-2.5.3-1-x64.exe -Force

RUN ["C:/Ruby25-x64/bin/ruby.exe --version"]
RUN ["C:/Ruby25-x64/bin/mailcatcher.bat --help"]

# smtp port
EXPOSE 1025

# webserver port
EXPOSE 1080

CMD ["C:/Ruby25-x64/bin/mailcatcher --ip=0.0.0.0"]
