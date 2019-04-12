$ErrorActionPreference = 'Stop';
Write-Host Starting build

docker build --pull -t nanasess/mailcatcher:windowsservercore -f Dockerfile .
docker images