# Temp Core Image
FROM mcr.microsoft.com/windows/servercore AS core

ENV RUBY_VERSION 2.2.4
ENV DEVKIT_VERSION 4.7.2
ENV DEVKIT_BUILD 20130224-1432

RUN mkdir C:\\tmp
ADD https://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-${RUBY_VERSION}-x64.exe C:\\tmp
RUN C:\\tmp\\rubyinstaller-%RUBY_VERSION%-x64.exe /silent /dir="C:\Ruby_%RUBY_VERSION%_x64" /tasks="assocfiles,modpath"

ADD https://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.3.3-x64.exe C:\\tmp
RUN C:\\tmp\\rubyinstaller-2.3.3-x64.exe /silent /dir="C:\Ruby_2.3.3_x64" /tasks="assocfiles,modpath"

# RUN powershell -Command \
# 	$ErrorActionPreference = 'Stop'; \
# 	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; \
# 	Invoke-WebRequest -Method Get -Uri https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.4.5-1/rubyinstaller-2.4.5-1-x64.exe -OutFile c:\rubyinstaller-2.4.5-1-x64.exe ; \
# 	Start-Process c:\rubyinstaller-2.4.5-1-x64.exe -ArgumentList '/verysilent' -Wait ;

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Method Get -Uri https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.1-1/rubyinstaller-2.6.1-1-x64.exe -OutFile c:\rubyinstaller-2.6.1-1-x64.exe ; \
	Start-Process c:\rubyinstaller-2.6.1-1-x64.exe -ArgumentList '/verysilent' -Wait ;


# ADD https://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-${DEVKIT_VERSION}-${DEVKIT_BUILD}-sfx.exe C:\\tmp
# RUN C:\\tmp\\DevKit-mingw64-64-%DEVKIT_VERSION%-%DEVKIT_BUILD%-sfx.exe -o"C:\DevKit" -y

# RUN powershell -Command \
# 	$ErrorActionPreference = 'Stop'; \
# 	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; \
# 	Invoke-WebRequest -Method Get -Uri https://www.sqlite.org/2018/sqlite-amalgamation-3240000.zip -OutFile c:\sqlite-amalgamation-3240000.zip ; \
# 	Expand-Archive -Path C:\sqlite-amalgamation-3240000.zip -DestinationPath \ -Force ; \
# 	Remove-Item C:\sqlite-amalgamation-3240000.zip -Force

# RUN powershell -Command \
# 	$ErrorActionPreference = 'Stop'; \
# 	[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; \
# 	Invoke-WebRequest -Method Get -Uri https://www.sqlite.org/2018/sqlite-dll-win64-x64-3240000.zip -OutFile c:\sqlite-dll-win64-x64-3240000.zip ; \
# 	Expand-Archive -Path C:\sqlite-dll-win64-x64-3240000.zip -DestinationPath \ -Force ; \
# 	Remove-Item C:\sqlite-dll-win64-x64-3240000.zip -Force

# Final Nano Image
FROM mcr.microsoft.com/windows/nanoserver AS nano

ENV RUBY_VERSION 2.2.4
ENV RUBYGEMS_VERSION 2.6.13
ENV BUNDLER_VERSION 1.15.4

COPY --from=core C:\\Ruby_${RUBY_VERSION}_x64 C:\\Ruby_${RUBY_VERSION}_x64
RUN setx PATH %PATH%;C:\Ruby_%RUBY_VERSION%_x64\bin -m
RUN ["ruby --version"]

# Final Nano Image
FROM mcr.microsoft.com/windows/nanoserver AS nano2

ENV RUBY_VERSION 2.3.3
ENV RUBYGEMS_VERSION 2.6.13
ENV BUNDLER_VERSION 1.15.4

COPY --from=core C:\\Ruby_${RUBY_VERSION}_x64 C:\\Ruby_${RUBY_VERSION}_x64
RUN setx PATH %PATH%;C:\Ruby_%RUBY_VERSION%_x64\bin -m
RUN ["ruby --version"]

FROM mcr.microsoft.com/windows/nanoserver AS nano3

COPY --from=core C:\\Ruby24-x64 C:\\Ruby24-x64
RUN setx PATH %PATH%;C:\Ruby24-x64\bin -m
RUN ["ruby --version"]

FROM mcr.microsoft.com/windows/nanoserver AS nano4

COPY --from=core C:\\Ruby26-x64 C:\\Ruby26-x64
RUN setx PATH %PATH%;C:\Ruby26-x64\bin -m
RUN ["ruby --version"]


# RUN ruby C:\\DevKit\\dk.rb init
# RUN echo - C:\\Ruby_%RUBY_VERSION%_x64 > C:\\config.yml
# RUN ruby C:\\DevKit\\dk.rb install

# RUN mkdir C:\\tmp
# ADD https://rubygems.org/gems/rubygems-update-${RUBYGEMS_VERSION}.gem C:\\tmp
# RUN gem install --local C:\tmp\rubygems-update-%RUBYGEMS_VERSION%.gem --no-ri --no-rdoc
# RUN rmdir C:\\tmp /s /q

# RUN update_rubygems --no-ri --no-rdoc
# RUN gem install bundler --version %BUNDLER_VERSION% --no-ri --no-rdoc

#RUN gem install sqlite3 --no-ri --no-rdoc -v "=1.3.13" --platform=ruby -- --with-sqlite3-include=C:\sqlite-amalgamation-3240000 --with-sqlite3-lib=C:\Ruby_%RUBY_VERSION%_x64\bin

# RUN gem install mailcatcher -v 0.6.5 --no-ri --no-rdoc

# # smtp port
# EXPOSE 1025

# # webserver port
# EXPOSE 1080

CMD ["ruby --version"]
