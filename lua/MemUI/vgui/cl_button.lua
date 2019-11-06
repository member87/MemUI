local PANEL = {}

AccessorFunc(PANEL, "m_text", "Text")
MemUI:CreateFont("MemUI.ButtonText", 20)

function PANEL:Init()
	self:SetTall(30)
	self:DockMargin(5, 5, 5, 5)
	self:SetText("Button Text")
	self:AddRippleEffects(Color(10, 10, 10), 0.5)
	self.DoClick = function(s) return true end
	self:SetCursor("hand")
end

function PANEL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, MemUI.colors.background.navbar)
	draw.SimpleText(self:GetText(), "MemUI.ButtonText", w/2, h/2, Color(255, 255,255), 1, 1)

	
end

function PANEL:OnMousePressed(mouse)
	if mouse ~= MOUSE_LEFT then return end
	self.DoClick()
end

vgui.Register("MemUI.Button", PANEL)