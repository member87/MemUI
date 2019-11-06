local PANEL = {}


function PANEL:Init()
	self.transition = vgui.Create("MemUI.RadialTransition", self)
	self.transition:Dock(FILL)

	self.scroll = vgui.Create("MemUI.ScrollBar", self.transition)
	self.scroll:Dock(FILL)

	self.dropdown = vgui.Create("MemUI.DropDown", self.scroll)
	self.dropdown:Dock(TOP)
	self.dropdown:SetTitle("Test Title")
	local pnl = vgui.Create("DPanel")
	pnl.Paint = function() return false end
	for i = 0, 10 do
		local lbl = vgui.Create("DLabel", pnl)
		lbl:Dock(TOP)
		lbl:SetText(i)
	end
	self.dropdown:SetContent(pnl)

	self.dropdown = vgui.Create("MemUI.DropDown", self.scroll)
	self.dropdown:Dock(TOP)
	self.dropdown:SetTitle("Another Title")
	local pnl = vgui.Create("DPanel")
	pnl.Paint = function() return false end
	for i = 0, 10 do
		local lbl = vgui.Create("DLabel", pnl)
		lbl:Dock(TOP)
		lbl:SetText(10 - i)
	end
	self.dropdown:SetContent(pnl)

	self.button = vgui.Create("MemUI.Button", self.scroll)
	self.button:Dock(TOP)

	self.button.DoClick = function()
		local x, y = gui.MousePos()
		local cm = MemUI:CreateContextMenu(x, y)
		cm:AddItem("Test", function() print("yep") end)
		cm:AddItem("Test2", function() print("yep") end)
		cm:AddItem("Test3", function() print("yep") end)
		cm:AddItem("SOME LONGER TEXT", function() print("yep") end)
	end
end

function PANEL:PerformLayout(w, h)
	//self.TextEntry:SetWide(self.body:GetWide())
end

vgui.Register("MemUI.TestPanel11", PANEL)