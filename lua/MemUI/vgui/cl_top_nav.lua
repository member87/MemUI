local PANEL = {}

function PANEL:Init()
	self.navbuttons = {}
	self.dopdown = {}
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(MemUI.colors.background.navbar)
	surface.DrawRect(0, 0, w, h)
end

function PANEL:SetBody(body)
	self.body = body
end

function PANEL:AddButton(text, panel)
	if self.navbuttons[text] then
		error("Tried creating an allready existing button")
		return
	else
		self.navbuttons[text] = {}
	end
	self.navbuttons[text]["nav"] = vgui.Create("MemUI.TopNavButton", self)
	self.navbuttons[text]["nav"]:SetText(text)
	self.navbuttons[text]["nav"]:SetHeight(self:GetTall())

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

vgui.Register("MemUI.TopNav", PANEL)