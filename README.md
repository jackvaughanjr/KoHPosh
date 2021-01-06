# KoHPosh

KoHPosh is both an experience API built on the Discord API and a visual display of clan metrics using Pode and Bootstrap.

## Requirements
- PowerShell version 5 or higher
- Latest PowerShellGet version
```powershell
Install-Module PowershellGet -Force
```
- [Pode](https://badgerati.github.io/Pode/) PowerShell module version 1.8.2
```powershell
Install-Module -Name Pode -RequiredVersion 1.8.2
```
- [Microsoft.PowerShell.SecretManagement](https://www.powershellgallery.com/packages/Microsoft.PowerShell.SecretManagement/0.5.5-preview6) PowerShell module
```powershell
Install-Module -Name Microsoft.PowerShell.SecretManagement -AllowPrerelease
```

## Configuration Required

### Web Server

- localhost port to be used (set in line 17 of `.\server.ps1`)

### Discord

- API Key stashed in a secret
```powershell
Set-Secret -Name 'KoHDiscord' -Secret 'YOUR SECRET HERE'
```
- UserAgent - name of the Bot used (set in line 25 of `.\server.ps1`)
- GuildId (set in line 29 of `.\server.ps1`)

## Usage

Navigate to the repo's home directory and run
```powershell
Start-PodeServer -FilePath .\server.ps1
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
