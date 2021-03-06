#
# Module manifest for module 'ezcert'
#
# Generated by: Austin Montoya
#
# Generated on: 3/3/2016
#

@{

# Script module or binary module file associated with this manifest
ModuleToProcess = 'ezcert.psm1'

# Version number of this module.
ModuleVersion = '0.0.1'

# ID used to uniquely identify this module
GUID = '38d79e66-cbc1-46d4-926b-182edb3fe641'

# Author of this module
Author = 'Austin Montoya'

# Company or vendor of this module
CompanyName = 'Navex Global, Inc.'

# Copyright statement for this module
Copyright = 'Copyright (c) Navex Global, Inc. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A PowerShell module for setting up client certificate authentication locally.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
#PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
#PowerShellHostVersion = ''

# Minimum version of the .NET Framework required by this module
DotNetFrameworkVersion = '4.6'

# Minimum version of the common language runtime (CLR) required by this module
#CLRVersion = ''

# Processor architecture (None, X86, Amd64, IA64) required by this module
#ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
#RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
#RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module
#ScriptsToProcess = ''

# Type files (.ps1xml) to be loaded when importing this module
#TypesToProcess     = @()

# Format files (.ps1xml) to be loaded when importing this module
#FormatsToProcess   = @()

# Modules to import as nested modules of the module specified in ModuleToProcess
#NestedModules      = ''  

# Functions to export from this module
FunctionsToExport = @(
  'New-LocalCA',
  'New-LocalClientCert',
  'Initialize-ClientCertConfig',
  'Initialize-LocalClientCerts',
  'Unlock-AppHostSecuritySection'
)

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = @('ezcertExecutablePath')

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in ModuleToProcess
PrivateData = ''

}