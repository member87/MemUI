local PANEL = {}

function PANEL:Init()
	self.navbuttons = {}
	
end

function PANEL:SetBody(body)
	self.body = body
end


function PANEL:Paint(w, h)
	surface.SetDrawColor(MemUI.colors.background.navbar)
	surface.DrawRect(0, 0, w, h)
end

function PANEL:AddButton(text, panel)
	if self.navbuttons[text] then
		error("Trying to add an allready existing button")
		return
	else
		self.navbuttons[text] = {}
	end
	self.navbuttons[text]["nav"] = vgui.Create("MemUI.SideNavButton", self)
	self.navbuttons[text]["nav"]:SetText(text)
	self.navbuttons[text]["nav"]:Dock(TOP)
	self.navbuttons[text]["nav"]:SetWide(self:GetWide())

	self.navbuttons[text]["panel"] = panel
end

function PANEL:SetActive(text)
	for k, v in pairs(self.navbuttons) do
		v["nav"]:SetActive(false)
	end
	self.navbuttons[text]["nav"]:SetActive(true)

	self.body:Clear()
	self.panel = vgui.Create(self.navbuttons[text]["panel"], self.body)
	self.panel:Dock(FILL)
end

vgui.Register("MemUI.SideNav", PANEL)