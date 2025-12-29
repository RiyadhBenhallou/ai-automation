#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Set-Location "C:\Users\riadh\ai-automation\n8n"

$script:n8nJob = $null
$script:ngrokProcess = $null

function Cleanup {
    Write-Host "`nStopping processes..."
    
    if ($script:n8nJob) {
        Write-Host "Stopping n8n job..."
        Stop-Job -Job $script:n8nJob -ErrorAction SilentlyContinue
        Remove-Job -Job $script:n8nJob -Force -ErrorAction SilentlyContinue
    }
    
    Write-Host "Killing n8n process on port 5678..."
    $port = Get-NetTCPConnection -LocalPort 5678 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess
    if ($port) {
        Stop-Process -Id $port -Force -ErrorAction SilentlyContinue
    }
    
    if ($script:ngrokProcess -and !$script:ngrokProcess.HasExited) {
        Write-Host "Stopping ngrok..."
        Stop-Process -Id $script:ngrokProcess.Id -Force -ErrorAction SilentlyContinue
    }
    
    Get-Process -Name "node" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    Get-Process -Name "ngrok" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    Get-Process -Name "npx" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    
    Write-Host "All processes stopped."
}

$ctrlCHandler = {
    Cleanup
    exit 0
}
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action $ctrlCHandler | Out-Null

try {
    Write-Host "Starting n8n in background..."
    
    $script:n8nJob = Start-Job -ScriptBlock {
        Set-Location "C:\Users\riadh\ai-automation\n8n"
        npx n8n start
    }
    
    Write-Host "Waiting for n8n to start..."
    Start-Sleep -Seconds 5
    
    $n8nRunning = Get-NetTCPConnection -LocalPort 5678 -ErrorAction SilentlyContinue
    if ($n8nRunning) {
        Write-Host "n8n started successfully"
    } else {
        Write-Warning "n8n might not be running yet"
        Receive-Job -Job $script:n8nJob
    }
    
    Write-Host "Starting ngrok..."
    $script:ngrokProcess = Start-Process -FilePath "ngrok" -ArgumentList "http", "--url=chicken-apt-dinosaur.ngrok-free.app", "5678" -WindowStyle Minimized -PassThru
    
    Write-Host "`nServices started!"
    Write-Host "n8n: http://localhost:5678"
    Write-Host "ngrok: https://chicken-apt-dinosaur.ngrok-free.app"
    Write-Host "`nPress CTRL+C to stop...`n"
    
    while ($true) {
        if ($script:n8nJob.State -ne "Running") {
            Write-Host "`nn8n job stopped"
            Receive-Job -Job $script:n8nJob
            break
        }
        
        if ($script:ngrokProcess.HasExited) {
            Write-Host "`nngrok process exited"
            break
        }
        
        Start-Sleep -Milliseconds 500
    }
}
catch {
    Write-Error "Error: $_"
}
finally {
    Cleanup
}