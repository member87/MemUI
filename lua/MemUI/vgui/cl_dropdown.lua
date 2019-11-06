local PANEL = {}


MemUI:CreateFont("MemUI.DropdownText", 24)

AccessorFunc(PANEL, "m_expanded", "Expanded", FORCE_BOOL)
AccessorFunc(PANEL, "m_title", "Title", FORCE_STRING)

function PANEL:Init()
	self:SetExpanded(false)
	self:DockMargin(5, 5, 5, 5)
	self:SetTitle("Dropdown Title")


	self.header = vgui.Create("DPanel", self)
	self.header:SetCursor("hand")
	self.header:Dock(TOP)
	self.header:SetTall(50)
	self.header.Paint = function(s, w, h)
		draw.RoundedBox(8, 0, 0, w, h, MemUI.colors.background.navbar)
		draw.SimpleText(self:GetTitle(), "MemUI.DropdownText", 10, h/2, MemUI.colors.text.primary, 0, 1)
	end

	self.header.OnMousePressed = function()
		self:SetExpanded(!self:GetExpanded())
		if self:GetExpanded() then
			self:Stop()
			self:SizeTo(-1, self.container:GetTall() + self.header:GetTall() + 10, 3, 0, 0.1)
		else
			self:Stop()
			self:SizeTo(-1, self.header:GetTall(), 3, 0, 0.1)
		end
	end

	self.header:AddRippleEffects(Color(10, 10, 10), 0.5)

	self.container = vgui.Create("DPanel", self)
	self.container:Dock(TOP)
	self.container:DockMargin(0, 5, 0, 0)
	self.container.Paint = function(s, w, h)
		draw.RoundedBox(8, 0, 0, w, h, ColorAlpha(MemUI.colors.background.header, 80))
	end

	self:SetTall(self.header:GetTall())
end


function PANEL:SetContent(pnl)
	pnl:SetParent(self.container)
	pnl:Dock(FILL)
	pnl:InvalidateLayout( true )
	pnl:SizeToChildren(true, true)
	self.container:SetTall(pnl:GetTall())
end

vgui.Register("MemUI.DropDown", PANEL)