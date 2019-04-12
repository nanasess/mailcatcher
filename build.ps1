$ErrorActionPreference = 'Stop';
Write-Host Starting build

docker build --pull -t nanasess/mailcatcher:windowsnanoserver -f Dockerfile .
docker images