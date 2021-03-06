# BatchX
![](https://github.com/franzageek/BatchX/blob/resources/batchx.png)

[Introduction](https://github.com/franzageek/BatchX#a-new-way-to-use-the-batch) • [Guide](https://github.com/franzageek/BatchX#guide) • [Plugins](https://github.com/franzageek/BatchX#plugins) • [Disclaimer](https://github.com/franzageek/BatchX#disclaimer) • [Credits](https://github.com/franzageek/BatchX#credits)

### A new way to use the Batch

BatchX includes a bunch of **Batch plugins** for your PC. These scripts can add some features **to your normal use of the computer** and _simplify it_.
You can **even use them in your Batch files**. These plugins are **hosted on this repository**, and they can be downloaded by **the integrated shell**, written in Batch too, which allows you to **dowload and manage** the plugins you want. The plugins are open-source, so **you can modify them at your convenience**.

### Guide
This is how to use the shell:

```bash
# Usage

$ batchx [command] [input]

# Shell commands

-inst <name>, --i <name>          With this command you can download the plugin called "name".
e.g. batchx --i ascii2unicode     Replace "name" with the plugin you want to download.

-del <name>, --d <name>           Delete the "name" plugin from the PC. Don't worry: you will be able to download it again.
e.g. batchx --d ascii2unicode     Replace "name" with the plugin you want to download.

-upd, --u                         Install the latest & updated version of the shell. Use this command whenever you think
                                  there's a new update available. You can check our repository to stay updated.
                                  
-plg, --p                         Display the list of the already installed BatchX plugins. 

-help, --h, /?                    Show the help message.
```

### Plugins
Here are the BatchX plugins. For now they are not many, but more will be added over time.

**ascii2unicode**: Convert ascii text file to Unicode text file.

**bin2dec**: Convert a binary value to a decimal number.

**bootstate**: Display the boot state (normal, safe mode, WinPE ecc.).

**cdromdrives**: List all CDROM drives for the local computer.

**dec2bin**: Convert decimal number to binary.

**dec2hex**: Convert decimal number to hexadecimal.

**defprinter**: Prints the default printer's name.

**drives**: List disk drives and their drive types

**enablecad**: Enable the CTRL+ALT+DEL feature to unlock the PC at the logon screen.

**findunins**: List the uninstall command/program to the specified program.

**getres**: Read and display the resolution settings from the registry.

**lastfile**: Open the last file used in Documents folder.

**num2bin**: Convert the specified number to binary.

**num2hex**: Convert the specified number to hexadecimal.

**num2oct**: Convert the specified number to octal.

**reverse**: Return the specified string in the reverse order.

**setdefwp**: Set the specified .bmp file to the default Windows' wallpapers.

**viewowner**: Display the owner of the specified file.


### Disclaimer
I am not responsible for any use you will make of these plugins. Use them at your own risk.

### Credits
GNU WGET is a GNU project -  discover it at https://www.gnu.org/software/wget/ 

