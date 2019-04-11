FROM mcr.microsoft.com/windows/servercore:1809

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	Invoke-WebRequest -Method Get -Uri https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.5.3-1/rubyinstaller-devkit-2.5.3-1-x64.exe -OutFile c:\rubyinstaller-devkit-2.5.3-1-x64.exe ; \
	Start-Process c:\rubyinstaller-devkit-2.5.3-1-x64.exe -ArgumentList '/verysilent' -Wait ; \
	Remove-Item c:\rubyinstaller-devkit-2.5.3-1-x64.exe -Force

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	Invoke-WebRequest -Method Get -Uri https://www.sqlite.org/2019/sqlite-amalgamation-3270200.zip -OutFile c:\sqlite-amalgamation-3270200.zip ; \
        Expand-Archive -Path C:\sqlite-amalgamation-3270200.zip -DestinationPath \ -Force ; \
        Remove-Item C:\sqlite-amalgamation-3270200.zip -Force

RUN set PATH=%PATH%;C:\Ruby25-x64\bin;C:\Ruby25-x64\msys64\usr\bin;C:\tools\msys64\bin;C:\tools\msys64\usr\bin;C:\sqlite-amalgamation-3270200

RUN pacman -r C:\Ruby25-x64\msys64 -S --noconfirm libsqlite-devel gmp-devel libcrypt-devel mingw-w64-x86_64-sqlite3

RUN gem install sqlite3 --platform=ruby -- --with-sqlite3-include=C:\sqlite-amalgamation-3270200 --with-sqlite3-lib=C:\sqlite-amalgamation-3270200
#RUN gem specific_install -l https://github.com/larskanis/sqlite3-ruby -b add-gemspec 
RUN gem install mailcatcher -v 0.6.5
RUN ls C:\Ruby26-x64\bin
# smtp port
EXPOSE 1025

# webserver port
EXPOSE 1080

CMD ["C:\Ruby26-x64\bin\mailcatcher", "--ip=0.0.0.0"]
