<#
.SYNOPSIS
    Function file.

.NOTES
    SPDX-License-Identifier: Apache-2.0
    SPDX-FileCopyrightText: foundata GmbH (https://foundata.com)
#>

function Send-Keys {
    <#
    .SYNOPSIS
        Sends keystrokes to the active application with optional, automatic window
        focus and optional delays (before and after sending keys). Mostly a wrapper
        around [System.Windows.Forms.SendKeys]::SendWait()

    .LINK
        https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.sendkeys.send
    #>

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True,
                   HelpMessage = 'The key(s) to send via [System.Windows.Forms.SendKeys]::SendWait()')]
        [String]$Keys,

        [Parameter(Mandatory = $False,
                   HelpMessage = 'Array of integers. Seconds to wait before sending the keys and afterwards. Defaults to (0, 2)')]
        [ValidateScript({
            if (!($Delay -is [array]) -or ($Delay.count -ne 2)) {
                Throw 'Send-Keys: -Delay has to be an array of integers with two elements.'
            } else {
                $True
            }
        })]
        [Array]$Delay = @(0, 2),

        [Parameter(Mandatory = $False,
                   HelpMessage = 'An optional -Query for Use-Window (which will be called before the keys will be sent if a query is given).')]
        [String]$Query = ''
    )

    Begin {
        if (!(Test-Path variable:SendKeysInitDone -ErrorAction 'SilentlyContinue')) {
            Add-Type -AssemblyName System.Windows.Forms
            Set-Variable -Name 'SendKeysInitDone' -Value $True -Option 'Constant' -Scope 'Global' -Force
        }
    }

    Process {
        # force integer casting
        $Delay[0] = [int]$Delay[0]
        $Delay[1] = [int]$Delay[1]

        # delay before
        if ($Delay[0] -gt 0) {
            Write-Host ('Send-Keys: Will wait {0} seconds (delay before sending the key(s)).' -f $Delay[0])
            Start-Sleep $Delay[0]
        }

        # bring to front and activate a target window
        if ($Query -ne $False -and !([string]::IsNullOrEmpty($Query))) {
            Use-Window -Query $Query
        }

        Write-Host ('Send-Keys: Sending "{0}"' -f "${Keys}")
        [System.Windows.Forms.SendKeys]::SendWait("${Keys}")

        # delay after
        if ($Delay[1] -gt 0) {
            Write-Host ('Send-Keys: Will wait {0} seconds (delay after sending the key(s)).' -f $Delay[1])
            Start-Sleep $Delay[1]
        }
    }

    End { }
}