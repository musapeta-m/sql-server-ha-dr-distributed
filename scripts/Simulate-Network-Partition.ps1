<#
.SYNOPSIS
    Simulates a network partition between Subnet A (Primary) and Subnet B (DR).
.DESCRIPTION
    This script creates temporary firewall rules to block SQL Server 
    Availability Group traffic (Port 5022) to the DR replica.
#>

$DR_Node_IP = "192.168.1.50" # Update with your DR Node IP
$AG_Port = "5022"

Write-Host "--- STARTING NETWORK PARTITION SIMULATION ---" -ForegroundColor Yellow

# 1. Block Outbound traffic to DR Site
Write-Host "[1/3] Blocking outbound traffic to DR Node: $DR_Node_IP"
New-NetFirewallRule -DisplayName "BLOCK_DR_WAN_TEST" `
    -Direction Outbound `
    -RemoteAddress $DR_Node_IP `
    -LocalPort $AG_Port `
    -Protocol TCP `
    -Action Block

# 2. Check AG Health Status
Write-Host "[2/3] Waiting for AG to report 'NOT SYNCHRONIZING'..."
Start-Sleep -Seconds 10

# Logic to check DMV for disconnection
$SQLQuery = "SELECT synchronization_health_desc FROM sys.dm_hadr_availability_replica_states WHERE replica_server_name = 'SQL-03'"
# Invoke-Sqlcmd -Query $SQLQuery (Requires SqlServer module)

# 3. Cleanup: Restore Communication
Write-Host "[3/3] Restoration: Removing simulated block..." -ForegroundColor Green
Remove-NetFirewallRule -DisplayName "BLOCK_DR_WAN_TEST"

Write-Host "--- SIMULATION COMPLETE: Check SQL Logs for connection timeout events ---"