New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack -Name ShowedToastAtLevel -PropertyType DWord -Value 1 -Force
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Windows Error Reporting" -Name Disabled -Force -ErrorAction Ignore
Set-Policy -Scope User -Path "Software\Policies\Microsoft\Windows\Windows Error Reporting" -Name Disabled -Type CLEAR
Get-ScheduledTask -TaskName QueueReporting -ErrorAction Ignore | Disable-ScheduledTask
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name Disabled -PropertyType DWord -Value 1 -Force
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Siuf\Rules))
{
    New-Item -Path HKCU:\Software\Microsoft\Siuf\Rules -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Siuf\Rules -Name NumberOfSIUFInPeriod -PropertyType DWord -Value 0 -Force

Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Siuf\Rules -Name PeriodInNanoSeconds -Force -ErrorAction Ignore

# WindowsWelcomeExperience
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-310093Enabled -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-338389Enabled -PropertyType DWord -Value 0 -Force

# SettingsSuggestedContent
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-338393Enabled -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-353694Enabled -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-353696Enabled -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SilentInstalledAppsEnabled -PropertyType DWord -Value 0 -Force
# WhatsNewInWindows -Disable
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement))
{
    New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement -Name ScoobeSystemSettingEnabled -PropertyType DWord -Value 0 -Force
# TailoredExperiences -Disable
# Remove all policies in order to make changes visible in UI only if it's possible
Remove-ItemProperty -Path HKCU:\Software\Policies\Microsoft\Windows\CloudContent -Name DisableTailoredExperiencesWithDiagnosticData -Force -ErrorAction Ignore
Set-Policy -Scope User -Path Software\Policies\Microsoft\Windows\CloudContent -Name DisableTailoredExperiencesWithDiagnosticData -Type CLEAR
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy -Name TailoredExperiencesWithDiagnosticDataEnabled -PropertyType DWord -Value 0 -Force
# BingSearch -Disable
if (-not (Test-Path -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer))
{
    New-Item -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer -Force
}
New-ItemProperty -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -PropertyType DWord -Value 1 -Force

Set-Policy -Scope User -Path Software\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -Type DWORD -Value 1
# StartRecommendationsTips -Hide
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Start_IrisRecommendations -PropertyType DWord -Value 0 -Force

# StartAccountNotifications -Hide
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Start_AccountNotifications -PropertyType DWord -Value 0 -Force

# OneDriveFileExplorerAd -Hide
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowSyncProviderNotifications -PropertyType DWord -Value 0 -Force
# FileTransferDialog -Detailed
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager))
{
    New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager -Name EnthusiastMode -PropertyType DWord -Value 1 -Force
# QuickAccessRecentFiles -Hide
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -PropertyType DWord -Value 0 -Force

# QuickAccessFrequentFolders -Hide
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -PropertyType DWord -Value 0 -Force

# TaskbarWidgets -Hide
if (Get-AppxPackage -Name MicrosoftWindows.Client.WebExperience)
{
    # Microsoft blocked access for editing TaskbarDa key in KB5041585
    try
    {
        New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarDa -PropertyType DWord -Value 0 -Force -ErrorAction Stop
    }
    catch [System.UnauthorizedAccessException]
    {
        Write-Warning -Message ($Global:Error.Exception.Message | Select-Object -First 1)
        Write-Error -Message ($Global:Error.Exception.Message | Select-Object -First 1) -ErrorAction SilentlyContinue
    }
}

# TaskbarSearch -Hide
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name SearchboxTaskbarMode -PropertyType DWord -Value 0 -Force
# SearchHighlights -Hide
# Check whether "Ask Copilot" and "Find results in Web" (Web) were disabled. They also disable Search Highlights automatically
# Due to "Set-StrictMode -Version Latest" we have to use GetValue()
$BingSearchEnabled = ([Microsoft.Win32.Registry]::GetValue("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search", "BingSearchEnabled", $null))
$DisableSearchBoxSuggestions = ([Microsoft.Win32.Registry]::GetValue("HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer", "DisableSearchBoxSuggestions", $null))
if (($BingSearchEnabled -eq 1) -or ($DisableSearchBoxSuggestions -eq 1))
{
Write-Information -MessageData "" -InformationAction Continue
Write-Verbose -Message $Localization.Skipped -Verbose

return
}
else
{
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings -Name IsDynamicSearchBoxEnabled -PropertyType DWord -Value 0 -Force
}

# CopilotButton -Hide
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowCopilotButton -PropertyType DWord -Value 0 -Force

# TaskViewButton -Hide
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -PropertyType DWord -Value 0 -Force

# ControlPanelView -LargeIcons
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel))
{
    New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel -Name AllItemsIconView -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel -Name StartupPage -PropertyType DWord -Value 1 -Force

# WindowsColorMode -Dark
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -PropertyType DWord -Value 0 -Force

# AppColorMode -Light
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -PropertyType DWord -Value 1 -Force
# ShortcutsSuffix -Disable
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates))
{
    New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates -Name ShortcutNameTemplate -PropertyType String -Value "%s.lnk" -Force

# FolderGroupBy -None
# Clear any Common Dialog views
Get-ChildItem -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\*\Shell" -Recurse | Where-Object -FilterScript {$_.PSChildName -eq "{885A186E-A440-4ADA-812B-DB871B942259}"} | Remove-Item -Force

# https://learn.microsoft.com/en-us/windows/win32/properties/props-system-null
if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}"))
{
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Force
}
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name ColumnList -PropertyType String -Value "System.Null" -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name GroupBy -PropertyType String -Value "System.Null" -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name LogicalViewMode -PropertyType DWord -Value 1 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name Name -PropertyType String -Value NoName -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name Order -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name PrimaryProperty -PropertyType String -Value "System.ItemNameDisplay" -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name SortByList -PropertyType String -Value "prop:System.ItemNameDisplay" -Force
# TeamsAutostart -Disable
if (Get-AppxPackage -Name MSTeams)
{
    New-ItemProperty -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MSTeams_8wekyb3d8bbwe\TeamsTfwStartupTask" -Name State -PropertyType DWord -Value 1 -Force
}
# DismissMSAccount
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Name AccountProtection_MicrosoftAccount_Disconnected -PropertyType DWord -Value 1 -Force

# Dismiss Microsoft Defender offer in the Windows Security about turning on the SmartScreen filter for Microsoft Edge
# DismissSmartScreenFilter
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Name AppAndBrowser_EdgeSmartScreenOff -PropertyType DWord -Value 0 -Force

function PostActions
{
	#region Refresh Environment
	$Signature = @{
		Namespace          = "WinAPI"
		Name               = "UpdateEnvironment"
		Language           = "CSharp"
		CompilerParameters = $CompilerParameters
		MemberDefinition   = @"
private static readonly IntPtr HWND_BROADCAST = new IntPtr(0xffff);
private const int WM_SETTINGCHANGE = 0x1a;
private const int SMTO_ABORTIFHUNG = 0x0002;

[DllImport("shell32.dll", CharSet = CharSet.Auto, SetLastError = false)]
private static extern int SHChangeNotify(int eventId, int flags, IntPtr item1, IntPtr item2);

[DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = false)]
private static extern IntPtr SendMessageTimeout(IntPtr hWnd, int Msg, IntPtr wParam, string lParam, int fuFlags, int uTimeout, IntPtr lpdwResult);

[DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = false)]
static extern bool SendNotifyMessage(IntPtr hWnd, uint Msg, IntPtr wParam, string lParam);

public static void Refresh()
{
	// Update desktop icons
	SHChangeNotify(0x8000000, 0x1000, IntPtr.Zero, IntPtr.Zero);

	// Update environment variables
	SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, IntPtr.Zero, null, SMTO_ABORTIFHUNG, 100, IntPtr.Zero);

	// Update taskbar
	SendNotifyMessage(HWND_BROADCAST, WM_SETTINGCHANGE, IntPtr.Zero, "TraySettings");
}

private static readonly IntPtr hWnd = new IntPtr(65535);
private const int Msg = 273;
// Virtual key ID of the F5 in File Explorer
private static readonly UIntPtr UIntPtr = new UIntPtr(41504);

[DllImport("user32.dll", SetLastError=true)]
public static extern int PostMessageW(IntPtr hWnd, uint Msg, UIntPtr wParam, IntPtr lParam);

public static void PostMessage()
{
	// Simulate pressing F5 to refresh the desktop
	PostMessageW(hWnd, Msg, UIntPtr, IntPtr.Zero);
}
"@
	}
	if (-not ("WinAPI.UpdateEnvironment" -as [type]))
	{
		Add-Type @Signature
	}

	# Simulate pressing F5 to refresh the desktop
	[WinAPI.UpdateEnvironment]::PostMessage()

	# Refresh desktop icons, environment variables, taskbar
	[WinAPI.UpdateEnvironment]::Refresh()

	# Restart Start menu
	Stop-Process -Name StartMenuExperienceHost -Force -ErrorAction Ignore
	#endregion Refresh Environment

	#region Other actions
	# Turn on Controlled folder access if it was turned off
	if ($Script:DefenderEnabled)
	{
		if ($Script:ControlledFolderAccess)
		{
			Set-MpPreference -EnableControlledFolderAccess Enabled
		}
	}

	# Apply policies found in registry to re-build database database due to gpedit.msc relies in its own database
	if ((Test-Path -Path "$env:TEMP\Computer.txt") -or (Test-Path -Path "$env:TEMP\User.txt"))
	{
		if (Test-Path -Path "$env:TEMP\Computer.txt")
		{
			& "$PSScriptRoot\..\bin\LGPO.exe" /t "$env:TEMP\Computer.txt"
		}
		if (Test-Path -Path "$env:TEMP\User.txt")
		{
			& "$PSScriptRoot\..\bin\LGPO.exe" /t "$env:TEMP\User.txt"
		}

		gpupdate /force
	}

	# PowerShell 5.1 (7.5 too) interprets 8.3 file name literally, if an environment variable contains a non-Latin word
	# https://github.com/PowerShell/PowerShell/issues/21070
	Get-ChildItem -Path "$env:TEMP\Computer.txt", "$env:TEMP\User.txt" -Force -ErrorAction Ignore | Remove-Item -Recurse -Force -ErrorAction Ignore

	# Kill all explorer instances in case "launch folder windows in a separate process" enabled
	Get-Process -Name explorer | Stop-Process -Force
	Start-Sleep -Seconds 3

	# Restoring closed folders
	if (Get-Variable -Name OpenedFolder -ErrorAction Ignore)
	{
		foreach ($Script:OpenedFolder in $Script:OpenedFolders)
		{
			if (Test-Path -Path $Script:OpenedFolder)
			{
				Start-Process -FilePath explorer -ArgumentList $Script:OpenedFolder
			}
		}
	}

	# Check whether any of scheduled tasks were created. Unless open Task Scheduler
	if ($Script:ScheduledTasks)
	{
		# Find and close taskschd.msc by its argument
		$taskschd_Process_ID = (Get-CimInstance -ClassName CIM_Process | Where-Object -FilterScript {$_.Name -eq "mmc.exe"} | Where-Object -FilterScript {
			$_.CommandLine -match "taskschd.msc"
		}).Handle
		# Due to "Set-StrictMode -Version Latest" we have to check before executing
		if ($taskschd_Process_ID)
		{
			Get-Process -Id $taskschd_Process_ID | Stop-Process -Force
		}

		# Open Task Scheduler
		Start-Process -FilePath taskschd.msc
	}
	#endregion Other actions

	#region Toast notifications
	# Persist Sophia notifications to prevent to immediately disappear from Action Center
	# Remove registry keys if notifications and Action Center are disabled
	Remove-ItemProperty -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer, HKLM:\Software\Policies\Microsoft\Windows\Explorer -Name DisableNotificationCenter -Force -ErrorAction Ignore

	# Enable notifications
	Remove-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications -Name ToastEnabled -Force -ErrorAction Ignore

	if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Sophia))
	{
		New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Sophia -Force
	}
	New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Sophia -Name ShowInActionCenter -PropertyType DWord -Value 1 -Force

	if (-not (Test-Path -Path Registry::HKEY_CLASSES_ROOT\AppUserModelId\Sophia))
	{
		New-Item -Path Registry::HKEY_CLASSES_ROOT\AppUserModelId\Sophia -Force
	}
	# Register app
	New-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\AppUserModelId\Sophia -Name DisplayName -Value Sophia -PropertyType String -Force
	# Determines whether the app can be seen in Settings where the user can turn notifications on or off
	New-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\AppUserModelId\Sophia -Name ShowInSettings -Value 0 -PropertyType DWord -Force
	
}

PostActions

