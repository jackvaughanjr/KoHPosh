<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.178
	 Created on:   	8/25/2020 6:42 PM
	 Created by:   	jvaughan
     Updated on:    12/23/2020 5:08 PM
     Updated by:    jvaughan
	 Organization: 	The Mad Kats
	 Filename:     	server.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

Start-PodeServer {
    Add-PodeEndpoint -Address heckinkats.ngrok.io -Port 9001 -Protocol Http
    ### FOR TESTING LOCALLY
    # Add-PodeEndpoint -Address * -Port 9001 -Protocol Http
    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging -Levels @('Error', 'Warning', 'Informational', 'Verbose', 'Debug')
    #Set-PodeViewEngine -Type Pode
    
    
    
    Add-PodeRoute -Method Get -Path '/members' -ScriptBlock {
        $apiToken = (Get-Secret -Name 'KoHDiscord' -AsPlainText)
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
            ### MEMBER NAME
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
            ### MOB LEVEL
            If ($output.roles -like 'Mob Level*') { $output.mob = $($output.roles -like 'Mob Level*').Substring(10, $($output.roles -like 'Mob Level*').Length - 10) }
            Else { $output.mob = '-' }
            ### TOWN HALL LEVEL
            If ($output.roles -like 'TH*') { $output.th = $($output.roles -like 'TH*').Substring(3, 2) }
            Else { $output.th = '-' }
            ### BIOME SPECIALTY
            If ($output.roles -contains 'Biome - Grasslands') { $output.biomediv = '<div class="grassy"></div>' }
            ElseIf ($output.roles -contains 'Biome - Badlands') { $output.biomediv = '<div class="baddy"></div>' }
            ElseIf ($output.roles -contains 'Biome - Swamp') { $output.biomediv = '<div class="swampy"></div>' }
            Else { $output.biomediv = '-' }
            ### RAID DRAGONS
            $raidGatherBonus = 0
            If ($output.roles -like 'Smaak*') {
                $output.smaak = ($output.roles | Where-Object { $_ -like 'Smaak*' }).replace('Smaak - Rank ', '')
                $raidGatherBonus = $raidGatherBonus + 50 + (50 * $output.smaak)
            }
            Else { $output.smaak = '-' }
            If ($output.roles -like 'Gourdon*') {
                $output.gourdon = ($output.roles | Where-Object { $_ -like 'Gourdon*' }).replace('Gourdon - Rank ', '')
                $raidGatherBonus = $raidGatherBonus + 50 + (50 * $output.gourdon)
            }
            Else { $output.gourdon = '-' }
            $output.gather = $raidGatherBonus
            ### ACCEPTED POLICIES
            If ($output.roles -contains 'Accepted Policies') { $output.accepted = '<i class="fas fa-check-circle" aria-hidden="true"></i>' }
            Else { $output.accepted = '' }
            ### SHRINE TEAMS
            If ($output.roles -contains 'Grass Shrine Team') { $output.shrinediv = '<div class="grassy"></div>' }
            ElseIf ($output.roles -contains 'BL Shrine Team') { $output.shrinediv = '<div class="baddy"></div>' }
            ElseIf ($output.roles -contains 'Swamp Shrine Team') { $output.shrinediv = '<div class="swampy"></div>' }
            Else { $output.shrinediv = '-' }
            ### HYDRA 2 GRASS
            If ($output.roles -contains 'H2G - Minion 4') { $output.h2grass = 'M4' }
            ElseIf ($output.roles -contains 'H2G - Minion 5') { $output.h2grass = 'M5' }
            ElseIf ($output.roles -contains 'H2G - Minion 6') { $output.h2grass = 'M6' }
            ElseIf ($output.roles -contains 'H2G - Worm 2') { $output.h2grass = 'W2' }
            ElseIf ($output.roles -contains 'H2G - Worm 3') { $output.h2grass = 'W3' }
            ElseIf ($output.roles -contains 'H2G - Worm 4') { $output.h2grass = 'W4' }
            ElseIf ($output.roles -contains 'H2G - Solo') { $output.h2grass = '<i class="fas fa-check-circle" aria-hidden="true"></i>' }
            Else { $output.h2grass = '-' }
            ### HYDRA 2 BADLANDS
            If ($output.roles -contains 'H2B - Minion 4') { $output.h2bad = 'M4' }
            ElseIf ($output.roles -contains 'H2B - Minion 5') { $output.h2bad = 'M5' }
            ElseIf ($output.roles -contains 'H2B - Minion 6') { $output.h2bad = 'M6' }
            ElseIf ($output.roles -contains 'H2B - Worm 2') { $output.h2bad = 'W2' }
            ElseIf ($output.roles -contains 'H2B - Worm 3') { $output.h2bad = 'W3' }
            ElseIf ($output.roles -contains 'H2B - Worm 4') { $output.h2bad = 'W4' }
            ElseIf ($output.roles -contains 'H2B - Solo') { $output.h2bad = '<i class="fas fa-check-circle" aria-hidden="true"></i>' }
            Else { $output.h2bad = '-' }
            ### HYDRA 2 SWAMP
            If ($output.roles -contains 'H2S - Minion 4') { $output.h2swamp = 'M4' }
            ElseIf ($output.roles -contains 'H2S - Minion 5') { $output.h2swamp = 'M5' }
            ElseIf ($output.roles -contains 'H2S - Minion 6') { $output.h2swamp = 'M6' }
            ElseIf ($output.roles -contains 'H2S - Worm 2') { $output.h2swamp = 'W2' }
            ElseIf ($output.roles -contains 'H2S - Worm 3') { $output.h2swamp = 'W3' }
            ElseIf ($output.roles -contains 'H2S - Worm 4') { $output.h2swamp = 'W4' }
            ElseIf ($output.roles -contains 'H2S - Solo') { $output.h2swamp = '<i class="fas fa-check-circle" aria-hidden="true"></i>' }
            Else { $output.h2swamp = '-' }
            $output | Where-Object { $_.roles -contains 'KAT MEMBERS' }
        }
        Write-PodeJsonResponse -Value $memberRoles
    }
    
    Add-PodeRoute -Method Get -Path '/membertable' -ScriptBlock {
        Write-PodeViewResponse -Path 'membertable'
    }
}

