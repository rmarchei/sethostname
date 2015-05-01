# Set the hostname of a Windows 8 Hyper-V VM to match the VM name
# Inspired by http://blogs.msdn.com/b/virtual_pc_guy/archive/2013/05/13/rename-the-guest-os-to-match-the-virtual-machine-name-on-hyper-v.aspx

# To run it as a scheduled task:
# PowerShell -Version 3.0 -ExecutionPolicy Unrestricted C:\Scripts\sethostname.ps1

# Get the virtual machine name from the parent partition
$vmName = (Get-ItemProperty –path “HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters”).VirtualMachineName
# Replace any non-alphanumeric characters with a dash
$vmName = [Regex]::Replace($vmName,"\W","-")
# Trim names that are longer than 15 characters
$vmName = $vmName.Substring(0,[System.Math]::Min(15, $vmName.Length))
# Check the trimmed and cleaned VM name against the guest OS name
# If it is different, change the guest OS name and reboot
if ($env:computername -ne $vmName) { Rename-Computer -NewName $vmName -Force -Restart }
