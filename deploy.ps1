Write-Host Starting deploy
docker login -u="$env:DOCKER_USER" -p="$env:DOCKER_PASS"

docker push nanasess/mailcatcher:windowsservercore
