# Send-Keys extension for Chocolatey (helper to send keystrokes to a window) (`sendkeys.extension`)

**This project is *not* associated with the official [Chocolatey](https://chocolatey.org/) product or team, nor with [Chocolatey Software, Inc.](https://chocolatey.org/contact/).**

A [Chocolatey extension](https://docs.chocolatey.org/en-us/features/extensions) providing helper functions to send keystrokes to the active application window. These functions may be used in Chocolatey install and uninstall scripts by declaring this package a dependency in your package's `.nuspec`.


## Installation

As the package is an extension, it gets usually installed automatically as a dependency. However, you can still install it manually:

```console
choco install sendkeys.extension
```


## Usage

To create a package with the ability to use a function from this extension, add the following to your `.nuspec` specification:

```xml
<dependencies>
  <dependency id="sendkeys.extension" version="REPLACE_WITH_MINIMUM_VERSION_USUALLY_CURRENT_LATEST" />
</dependencies>
```

It is possible to import the module directly in your `PS >`, so you can try out the main functionality directly:

```powershell
# import the modules
Import-Module "${env:ChocolateyInstall}\helpers\chocolateyInstaller.psm1"
Import-Module "${env:ChocolateyInstall}\extensions\sendkeys\*.psm1"

# get a list of all functions
Get-Command -Module 'sendkeys.extension'

# get help and examples for a specific function
Get-Help Send-Keys -Detailed

# See https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.sendkeys.send
# for a list of codes to specify characters that aren't displayed or represent
# actions rather than characters (like ENTER, DOWN or TAB).

# Send the keystrokes "ABC" to the currently active window; wait 2 seconds
# afterwards
Send-Keys -Keys 'ABC'

# Bring the first window that contains the name 'foo' to the front, focus it
# and send different keystrokes to it. By default, the functions waits two
# seconds after each keystroke.
Send-Keys -Keys 'a' -Query 'foo' # send a; wait 2 seconds
Send-Keys -Keys '{TAB}' -Query 'foo' # send tab; wait 2 seconds
Send-Keys -Keys ' ' -Query 'foo' # sends space bar; wait 2 seconds
Send-Keys -Keys '{ENTER}' -Query 'foo' -Delay @(0, 5) # send enter; wait 5 seconds
Send-Keys -Keys '%A' -Query 'foo' # send ALT + A; wait 2 seconds
Send-Keys -Keys '%w' -Query 'foo' # send ALT + w; wait 2 seconds
Send-Keys -Keys 'abC{TAB}D' -Query 'foo' # send a, b, C, tab, D; wait 2 seconds


# Bring the first window that starts with the name 'bar' to the front, focus it
# and send different keystrokes to it. By default, the functions waits two
# seconds after each keystroke.
Send-Keys -Keys 'a' -Query '^bar.+$' # send a; wait 2 seconds
Send-Keys -Keys '{DOWN}' -Query '^bar.+$' # send down; wait 2 seconds
```

But keep in mind that functions of Chocolatey extension may only work correctly in the context of Chocolatey install and uninstall scripts.


## License, copyright

This project is under [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0). See [`LICENSE`](./LICENSE) and [`NOTICE`](./NOTICE) for details.


## Author information

This Chocolatey extension was created and is maintained by [foundata](https://foundata.com/). If you like it, you might [buy them a coffee](https://buy-me-a.coffee/chocolatey-sendkeys.extension/). This is a community project and *not* associated with the official [Chocolatey](https://chocolatey.org/) product or team, nor with [Chocolatey Software, Inc.](https://chocolatey.org/contact/).
