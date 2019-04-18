Write-Host Starting build

docker build --pull -t nanasess/mailcatcher:windowsservercore -f windowsservercore/Dockerfile .
docker images
