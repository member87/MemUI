local PANEL = {}

AccessorFunc(PANEL, "m_activePanel", "Active", FORCE_BOOL)

function PANEL:Init()
	self:SetHeight(42)
	self:SetCursor("hand")

	self.fontColor = Color(100, 100, 100)
	self.hoverColor = Color(150, 150, 150, 200)
	self.activeColor = Color(0,128,128)
	self.clickColor = Color(200, 200, 200)

	self:AddRippleEffects(Color(100, 100, 100))
end

function PANEL:SetText(text)
	self.text = text or ""
end

function PANEL:Paint(w, h)
	if self:GetActive() then
		draw.SimpleText( self.text, "MemUI.NavOptionFont", w/2, h/2, self.activeColor, 1, 1)
		surface.SetDrawColor(self.activeColor)
		surface.DrawRect(0, 0, 3, h)
	elseif self:IsHovered() then
		draw.SimpleText( self.text, "MemUI.NavOptionFont", w/2, h/2, self.hoverColor, 1, 1)
	else
		draw.SimpleText( self.text, "MemUI.NavOptionFont", w/2, h/2, self.fontColor, 1, 1)
	end
end


function PANEL:OnMousePressed()
	if self:GetActive() then return end

	self:GetParent():SetActive(self.text)
end


vgui.Register("MemUI.SideNavButton", PANEL)