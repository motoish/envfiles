local function findFortiTray()
	for _, screen in ipairs(hs.screen.allScreens()) do
		local frame = screen:fullFrame()

		local y = frame.y + 12

		for x = frame.x + frame.w - 4, frame.x, -6 do
			local element = hs.axuielement.systemElementAtPosition(x, y)

			if element then
				local role = element:attributeValue("AXRole")
				local help = element:attributeValue("AXHelp") or ""

				if role == "AXMenuBarItem" and string.find(help, "FortiClient", 1, true) then
					return element
				end
			end
		end
	end

	return nil
end

local function clickFortiTray()
	local item = findFortiTray()

	if not item then
		hs.alert.show("FortiClient icon not found")
		return
	end

	local result, err = item:performAction("AXPress")

	if not result then
		hs.alert.show("AXPress failed: " .. tostring(err))
	end
end

-- option+v
hs.hotkey.bind({ "alt" }, "v", clickFortiTray)
