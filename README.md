# LGTV Mac On/Off
Automatically turning a LG TV on and off with sleep/wake when used as a monitor. 

Tested on a 14" M1 Macbook Pro and 48" LG CX.

# Requirements
- HomeBrew (https://brew.sh/)
- wakeonlan (via HomeBrew) (https://formulae.brew.sh/formula/wakeonlan)
- LGWebOSRemote (https://github.com/klattimer/LGWebOSRemote)
- HammerSpoon (https://github.com/Hammerspoon/hammerspoon)
- MacOS Ventura
- Enable wake-on-lan on your LG TV: Settings > Connection > Mobile Connection Management > TV On With Mobile > Turn on via Wi-Fi (enabled)
- IMPORTANT: WiFi must be enabled on your LG TV for this to work even if only using ethernet
- You should reserve a fixed IP for your LG TV on your router beforehand
- Your LG TV's MAC address and fixed IP address

Using either ethernet or WiFi IP address works.
    You can find this information (on an LG CX) by holding the setting remote button for 3 seconds, then navigating to: 
    
    Connection > Network Connection Settings > Wired Connection (For Ethernet)
    Connection > Network Connection Settings > Wi-Fi Connection > Advanced Wi-Fi Settings (For WiFi)

# How to use this Lua script
1. Install all requirements as well as properly setting up LGWebOSRemote (instructions on their project page)
2. Select 'Open Config' option from the HammerSpoon menu bar icon
3. Paste this project's lua script
4. Input your LG TV's MAC address and IP address ('mac_address' and 'lgtv_ip')
5. Save file
6. IMPORTANT: Select the 'Reload Config' option from the HammerSpoon menu bar icon

# Additional Notes
If your TV's IP address changes, you have to re-authorize via LGWebOSRemote.
    
Example (If 192.168.1.31 is your TV's new IP address, then you have to re-authenticate that IP address):

    source lgtv-venv/bin/activate
    lgtv auth 192.168.1.31 MyTV ssl
An authentication prompt should pop up on your TV and you have to accept using your TV's remote.

# Credits
This solution was heavily based off of these existing projects:
- https://gist.github.com/cmer/bd40d9da0055d257c5aab2e0143ee17b
- https://github.com/cmer/lg-tv-control-macos

I couldn't get my 48" LG CX to turn on with just the MAC address in cmer's earlier gist and after messing around, I found that an IP flag (-i) was required as well as an IP address to get the on function to work. Using cmer's newest script, the off function worked for me, but the on function didn't. I modified cmer's earlier gist, fixed the on function, and implimented a simplified off command based on cmer's newest LGTV Control MacOS script.
