local scrw, scrh = ScrW(), ScrH()

MemUI = MemUI or {}
MemUI.colors = {
	primary = Color(0,32,128),
	accent = Color(0,128,128),

	background = {
		header = Color(20, 20, 20),
		navbar = Color(28, 28, 28),
		body = Color(33, 33, 33),
		scrollbar = Color(45, 45, 45)
	},
	text = {
		primary = Color(255, 255, 255),
		secondary = Color(255, 255, 255, 70),
		disabled = Color(255, 255, 255, 50)
	}
}

-- 33,33,33
-- 48,48,48
-- 66,66,66



local function MemUIMain()

	

	local menu = vgui.Create("MemUI.Container")
	menu:SetSize(scrw*.6, scrh*.6)
	menu:Center()
	menu:MakePopup()

	local nav = vgui.Create("MemUI.TopNav", menu)
	nav:Dock(TOP)
	nav:SetHeight(40)

	local body = vgui.Create("DPanel", menu)
	body:Dock(FILL)
	body.Paint = function(s, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(16, 16, 16))
	end

	nav:AddButton("Test", "MemUI.TestPanel11")
	nav:AddButton("Some Long Text", "MemUI.RadialTransition")
	nav:AddButton("Test2", "MemUI.RadialTransition")
	nav:SetBody(body)
	nav:SetActive("Test")


	


end
net.Receive("MEM::UI::MAIN", MemUIMain)
