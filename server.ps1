﻿<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.178
	 Created on:   	8/25/2020 6:42 PM
	 Created by:   	jvaughan
	 Organization: 	Connectria, LLC
	 Filename:     	server.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

Start-PodeServer {
    Add-PodeEndpoint -Address * -Port 9001 -Protocol Http
    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging -Levels @('Error', 'Warning', 'Informational', 'Verbose', 'Debug')
    #Set-PodeViewEngine -Type Pode
    
    Add-PodeRoute -Method Get -Path '/members' -ScriptBlock {
        $apiToken = 'NzQ3OTQ4MjAzNzY4NDE0MzA5.X0WTCw.5lajWuJXMBa37kD8BZGgFCkH2E8'
        $apiHeader = @{
            "Authorization" = "Bot $apiToken"
            "User-Agent"    = "MadKatsKoH"
            "Content-Type"  = 'application/json'
        }
        $apiBaseUrl = "https://discord.com/api"
        $guildId = '585422242872164353'
        $guildDetails = Invoke-RestMethod -Method Get -Uri "$apiBaseUrl/guilds/$guildId" -Headers $apiHeader
        $guildRoleList = $guildDetails.roles
        $memberDetails = Invoke-RestMethod -Method Get -Uri "$apiBaseUrl/guilds/$guildId/members?limit=1000" -Headers $apiHeader
        $memberDetails = $memberDetails | Where-Object { $_.user.bot -ne $true }
        [pscustomobject]$memberRoles = ForEach ($member In $memberDetails) {
            $roleList = @()
            ForEach ($memberRole In $member.roles) {
                $role = $guildRoleList | Where-Object { $_.id -eq $memberRole }
                $roleList += $role.name
            }
            If ($member.nick -ne $null) { $nickName = $member.nick }
            Else { $nickName = $member.user.username }
            $output = @{
                "name" = $member.user.username
                "nickname" = $nickName
                "joined" = $member.joined_at
                "mute" = $member.mute
                "deaf" = $member.deaf
                "roles" = $roleList
            }
            If ($output.roles -contains 'Mob Level 4') { $output.mob = '<div class="mob04"></div>' }
            If ($output.roles -contains 'Mob Level 5') { $output.mob = '<div class="mob05"></div>' }
            If ($output.roles -contains 'Mob Level 6') { $output.mob = '<div class="mob06"></div>' }
            If ($output.roles -contains 'Mob Level 7') { $output.mob = '<div class="mob07"></div>' }
            If ($output.roles -contains 'Mob Level 8') { $output.mob = '<div class="mob08"></div>' }
            If ($output.roles -contains 'Mob Level 9') { $output.mob = '<div class="mob09"></div>' }
            If ($output.roles -contains 'Mob Level 10') { $output.mob = '<div class="mob10"></div>' }
            If ($output.roles -contains 'Mob Level 11') { $output.mob = '<div class="mob11"></div>' }
            If ($output.roles -contains 'Mob Level 12') { $output.mob = '<div class="mob12"></div>' }
            If ($output.roles -contains 'TH 15') { $output.th = '<div class="th15"></div>' }
            If ($output.roles -contains 'TH 16') { $output.th = '<div class="th16"></div>' }
            If ($output.roles -contains 'TH 17') { $output.th = '<div class="th17"></div>' }
            If ($output.roles -contains 'TH 18') { $output.th = '<div class="th18"></div>' }
            If ($output.roles -contains 'TH 19') { $output.th = '<div class="th19"></div>' }
            If ($output.roles -contains 'TH 20') { $output.th = '<div class="th20"></div>' }
            If ($output.roles -contains 'TH 21') { $output.th = '<div class="th21"></div>' }
            If ($output.roles -contains 'TH 22') { $output.th = '<div class="th22"></div>' }
            If ($output.roles -contains 'TH 23') { $output.th = '<div class="th23"></div>' }
            If ($output.roles -contains 'TH 24') { $output.th = '<div class="th24"></div>' }
            If ($output.roles -contains 'TH 25') { $output.th = '<div class="th25"></div>' }
            If ($output.roles -contains 'TH 26') { $output.th = '<div class="th26"></div>' }
            If ($output.roles -contains 'Biome - Grasslands') { $output.biome = '<div class="grassy"></div>' }
            If ($output.roles -contains 'Biome - Badlands') { $output.biome = '<div class="baddy"></div>' }
            If ($output.roles -contains 'Biome - Swamp') { $output.biome = '<div class="swampy"></div>' }
            $output | Where-Object { $_.roles -contains 'KAT MEMBERS' }
        }
        Write-PodeJsonResponse -Value $memberRoles
    }
    
    Add-PodeRoute -Method Get -Path '/memberview' -ScriptBlock {
        $apiToken = 'NzQ3OTQ4MjAzNzY4NDE0MzA5.X0WTCw.5lajWuJXMBa37kD8BZGgFCkH2E8'
        $apiHeader = @{
            "Authorization" = "Bot $apiToken"
            "User-Agent"    = "MadKatsKoH"
            "Content-Type"  = 'application/json'
        }
        $apiBaseUrl = "https://discord.com/api"
        $guildId = '585422242872164353'
        $guildDetails = Invoke-RestMethod -Method Get -Uri "$apiBaseUrl/guilds/$guildId" -Headers $apiHeader
        $guildRoleList = $guildDetails.roles
        $memberDetails = Invoke-RestMethod -Method Get -Uri "$apiBaseUrl/guilds/$guildId/members?limit=1000" -Headers $apiHeader
        $memberDetails = $memberDetails | Where-Object { $_.user.bot -ne $true }
        [pscustomobject]$memberRoles = ForEach ($member In $memberDetails) {
            $roleList = @()
            ForEach ($memberRole In $member.roles) {
                $role = $guildRoleList | Where-Object { $_.id -eq $memberRole }
                $roleList += $role.name
            }
            If ($member.nick -ne $null) { $nickName = $member.nick }
            Else { $nickName = $member.user.username }
            $output = @{
                "name" = $member.user.username
                "nickname" = $nickName
                "joined" = $member.joined_at
                "mute" = $member.mute
                "deaf" = $member.deaf
                "roles" = $roleList
            }
            If ($output.roles -contains 'Mob Level 4') { $output.mob4 = $true }
            If ($output.roles -contains 'Mob Level 5') { $output.mob5 = $true }
            If ($output.roles -contains 'Mob Level 6') { $output.mob6 = $true }
            If ($output.roles -contains 'Mob Level 7') { $output.mob7 = $true }
            If ($output.roles -contains 'Mob Level 8') { $output.mob8 = $true }
            If ($output.roles -contains 'Mob Level 9') { $output.mob9 = $true }
            If ($output.roles -contains 'Mob Level 10') { $output.mob10 = $true }
            If ($output.roles -contains 'Biome - Grasslands') { $output.grass = $true }
            If ($output.roles -contains 'Biome - Badlands') { $output.bads = $true }
            If ($output.roles -contains 'Biome - Swamp') { $output.swamp = $true }
            $output | Where-Object { $_.roles -contains 'KAT MEMBERS' }
        }
        Write-PodeViewResponse -Path 'memberview' -Data @{ 'members' = $memberRoles }
        #Write-PodeJsonResponse -Value $memberRoles
    }
    
    Add-PodeRoute -Method Get -Path '/membertable' -ScriptBlock {
        Write-PodeViewResponse -Path 'membertable'
    }
}

