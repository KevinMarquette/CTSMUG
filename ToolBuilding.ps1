#region DemoPrep
break;  # F5 trap
#region Demo Prep

$root = "C:\Users\kevin.marquette\Documents\kevmar\PesterInAction" # My working directory
pushd $root

function prompt
{
    $currentDirectory = (get-location).Path.Replace($root, "Demo:")
    "PS $currentDirectory>"
}


Clear-Host

& '.\Powershell is Awesome.pptx'

#endregion

# Powershell Scripting Roadmap

# The cheatsheet script : Powershell.txt on the desktop
# We all start here. As we learn commands and things, we create this handy cheat sheet that we copy and past into the console.

# The non-script script : Lots of commands ran one after the other
# This is where we pull several commands together to do something. But still copy paste and lots of hard coded paths. 

# Single purpose scripts : Scrpts that perform a specific action. Often installer wrappers, scheduled tasks or quick fixes. 
# You tend to edit the script for different tasks to change hard coded values. Often have multiple copies around with minor changes

# Everything but the kitchen sink script : Starting to get hundreds of lines long. It may take input or offer options.
# Still self contained, but contains many funcitons. Defines variables at the top.  


## Controller scripts and Tools
# Tools : Are flexible functions that are reusable across scripts 
# They do one thing really well. Uses Powershell best practices. 

# Controller scripts : wrap together tools. They let the tools do all the work. 
# This is where user interaction happens. 
# OK to ask for input, OK to fuss over output formatting, OK to break best practices.
 
 
 # What makes a good tool
 # It is an advanced function/script.
 #   makes use of parameter attributes for all user input. No popups or read-host
 #   Uses Write-Verbose over Write-Host for information output. Allow it to be silent.
 # It does one thing an does it really well. The name should tell you what that things is.
 #   Gathering data and making it look good are two different things. Should be two different functions.
 # If you copy and Paste or repeat code, it should be a function
 

 # A function can be really really small
 #  Don't feel bad if its only one or two lines
 #  It can hide complexity and make scripts easier to read


 # Advice for better tools:  
 #  Create a snippet for your advanced functions
 ISE .\Snippets.ps1
 #  Include a basic help comment
 #  Put each function in its own file
 #    Tree view makes it easy to find and jump to a function
 #    Scales really well as your library grows
 #    This pattern works really well with source control allowing you to track and roll back changes on individual functions
 #    This pattern works really well with automated testing with Pester. 
 
 
 #  Gather your tools into modules.
 #    Modules makes all your tools available on the command shell. 
 #    Very clean way to include your tools into your controller scripts.



#region Show a basic script and Pester test
# & '.\1 Basic Script\RemoveDesktopShortcut.ps1'
ise '.\1 Basic Script\createdesktopshortcut.ps1'


# Show an advanced script
ise '.\2 Advanced Script\NewShortcut.ps1'


# Show an advanced function
ise '.\3 Advanced Functions\New-Shortcut.ps1'
ise '.\3 Advanced Functions\Get-Shortcut.ps1'

. '.\3 Advanced Functions\New-Shortcut.ps1'
Get-Command New-Shortcut
Get-Help New-Shortcut -ShowWindow
Show-Command New-Shortcut
#endregion

#region Show a module
<#
Demo
│   Demo.psd1       # module manifest
│   Demo.psm1       # root module
│
└───functions
        Get-Shortcut.ps1       # function
        New-Shortcut.ps1       # function
#>
Start '.\4 Module\Demo'
ise '.\4 Module\Demo\Demo.psm1'
ise '.\4 Module\Demo\Demo.psd1'
#endregion

#region Build a module on the fly
# Create a module folder and add the Pester tests
$name = 'DemoModule3'
$path = Join-Path (resolve-path '.\5 Module (Interactive Demo)') -ChildPath $name
MD $path
Copy-Item '.\4 Module\Demo\Demo.Tests.ps1' "$path\$name.Tests.ps1"

# Create root module and manifest
Copy-Item '.\4 Module\Demo\Demo.psm1' "$path\$name.psm1"
New-ModuleManifest -Path "$path\$name.psd1" -RootModule ".\$name.psm1"
MD "$path\functions"

# Create a function file
Set-Content -Value '' -Path "$path\functions\test-item.ps1"
ise "$path\functions\test-item.ps1"

# Add more functions
Copy-Item '.\4 Module\Demo\functions\*.ps1' "$path\functions"
ls "$path\functions" | Format-Table Name

#endregion


#Other notes

# sample tool from my library
# Set-VMVLan
. .\Set-VMVlan.ps1
Get-Help Set-VMVLan -ShowWindow
ise .\Set-VMVlan.ps1

# my functions
Get-Command -Module (Get-Module -ListAvailable | where name -match 'everi|mgam') | ogv
Get-Command -Module (Get-Module -ListAvailable | where name -match 'everi|mgam') | Measure-Object
