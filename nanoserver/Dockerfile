FROM nanasess/mailcatcher:windowsservercore AS installer-env
FROM mcr.microsoft.com/windows/nanoserver

COPY --from=installer-env C:\Ruby25-x64 C:\Ruby25-x64
RUN rd /s /q C:\Ruby25-x64\msys64

# smtp port
EXPOSE 1025

# webserver port
EXPOSE 1080

CMD ["C:\Ruby25-x64\bin\mailcatcher", "--ip=0.0.0.0"]
