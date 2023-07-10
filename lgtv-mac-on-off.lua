-- -------------------------------------------------------------------
-- 1. Install all requirements as well as properly setting up LGWebOSRemote (instructions on their project page)
-- 2. Select 'Open Config' option from the HammerSpoon menu bar icon
-- 3. Paste this project's lua script
-- 4. Input your LG TV's MAC address and IP address ('mac_address' and 'lgtv_ip') - 
--    You can find this information (on an LG CX) by holding the setting remote button for 3 seconds, then navigating to: 
--    Connection > Network Connection Settings > Wired Connection (For Ethernet)
--    Connection > Network Connection Settings > Wi-Fi Connection > Advanced Wi-Fi Settings (For WiFi)
-- 5. Save file
-- 6. Select the 'Reload Config' option from the HammerSpoon menu bar icon
-- 
-- This solution was based off of these existing projects:
-- https://gist.github.com/cmer/bd40d9da0055d257c5aab2e0143ee17b
-- https://github.com/cmer/lg-tv-control-macos
-- 
-- Requirements for this script to work:
-- HomeBrew (https://brew.sh/)
-- wakeonlan (via HomeBrew) (https://formulae.brew.sh/formula/wakeonlan)
-- LGWebOSRemote (https://github.com/klattimer/LGWebOSRemote)
-- HammerSpoon (https://github.com/Hammerspoon/hammerspoon)
-- -------------------------------------------------------------------

-- Input your LG TV's MAC address and local IP address
local mac_address = ""
local lgtv_ip = ""

-- Modifying below this should not be required
local tv_identifier = "LG TV"
local tv_found = (hs.screen.find(tv_identifier) ~= nil)
local debug = false  -- Set to true to enable debug messages

if debug then
  print("List of all screens: " .. hs.inspect(hs.screen.allScreens()))
  if tv_found then print("TV with identifier '"..tv_identifier.."' was detected.") end
end

watcher = hs.caffeinate.watcher.new(function(eventType)
  if (eventType == hs.caffeinate.watcher.screensDidWake or
      eventType == hs.caffeinate.watcher.systemDidWake or
      eventType == hs.caffeinate.watcher.screensDidUnlock) and tv_found then

    if debug then print("TV was turned on.") end
    hs.execute("/opt/homebrew/bin/wakeonlan -i "..lgtv_ip.." "..mac_address) -- command that turns on your LG TV on wake
  end
  if (eventType == hs.caffeinate.watcher.screensDidSleep or
      eventType == hs.caffeinate.watcher.systemWillPowerOff) then
    hs.execute("/opt/lgtv-venv/bin/lgtv MyTV off ssl") -- command that turns off your LG TV on sleep
  end
end)
watcher:start()