Write-Host Starting build

#docker build --pull -t nanasess/mailcatcher:windowsnanoserver -f windowsservercore/Dockerfile .
#docker images

docker build --pull -t nanasess/mailcatcher:nanoserver -f nanoserver/Dockerfile .
docker images