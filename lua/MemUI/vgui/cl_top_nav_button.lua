local PANEL = {}

AccessorFunc(PANEL, "m_activePanel", "Active", FORCE_BOOL)

function PANEL:Init()
	self.fontColor = MemUI.colors.text.disabled
	self.hoverColor = MemUI.colors.text.secondary
	self.activeColor = MemUI.colors.primary
	self.clickColor = Color(200, 200, 200)
	self:Dock(LEFT)
	self:SetCursor("hand")
	self:AddRippleEffects(Color(100, 100, 100))
end

function PANEL:Paint(w, h)
	if self:GetActive() then
		draw.SimpleText( self.text, "MemUI.NavOptionFont", w/2, h/2, self.activeColor, 1, 1)
		surface.SetDrawColor(self.activeColor)
		surface.DrawRect(0, h-3, w, 3)
	elseif self:IsHovered() then
		draw.SimpleText( self.text, "MemUI.NavOptionFont", w/2, h/2, self.hoverColor, 1, 1)
	else
		draw.SimpleText( self.text, "MemUI.NavOptionFont", w/2, h/2, self.fontColor, 1, 1)
	end
end

function PANEL:SetText(text)
	text = text or ""
	self.text = text

	surface.SetFont( "MemUI.NavOptionFont" )
	local w, _ = surface.GetTextSize(text)
	self:SetWide(w + 50)
end



function PANEL:OnMousePressed()
	if self:GetActive() then return end
	self:GetParent():SetActive(self.text)
end

vgui.Register("MemUI.TopNavButton", PANEL)