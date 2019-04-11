$ErrorActionPreference = 'Stop';
Write-Host Starting build

docker build --pull -t nanasess/mailcatcher -f Dockerfile .
docker images