local PANEL = {}

AccessorFunc(PANEL, "m_hoverEnabled", "HoverEnabled", FORCE_BOOL)
AccessorFunc(PANEL, "m_hoverColor", "HoverColor")
AccessorFunc(PANEL, "m_color", "Color")
AccessorFunc(PANEL, "m_radius", "ActualRadius", FORCE_NUMBER)
AccessorFunc(PANEL, "m_text", "Text", FORCE_STRING)

function PANEL:IsHovered()
	local mx, my = gui.MouseX(), gui.MouseY()
	local x, y = self:LocalToScreen(0, 0)
	x, y = x + self:GetWide()/2, y + self:GetTall()/2

	local distance = math.sqrt((x-mx)*(x-mx) + (y-my)*(y-my))
	if distance < self:GetActualRadius()/2 then
		return true
	end
	return false
end



function PANEL:Init()
	self:SetColor(Color(28, 28, 28, 255))
	self:SetRadius(50)
	self:SetText("×")
	self:SetHoverEnabled(true)
	self:SetHoverColor(Color(28, 28, 28, 100))	
end

function PANEL:SetRadius(radius)
	self:SetActualRadius(radius)
	self:SetSize(self:GetActualRadius(), self:GetActualRadius())
end

function PANEL:OnMousePressed()

	if !self:IsHovered() then return end
	self.DoClick()
end

function PANEL:Paint(w,h)
	if self:GetHoverEnabled() then
		if self:IsHovered() then
			MemUI:DrawCircle(w/2, h/2, self:GetActualRadius()/2, self:GetHoverColor())
		else
			MemUI:DrawCircle(w/2, h/2, self:GetActualRadius()/2, self:GetColor())
		end
	else
		MemUI:DrawCircle(w/2, h/2, self:GetActualRadius()/2, self:GetColor())
	end

	if self:IsHovered() then
		self:SetCursor("hand")
	else
		self:SetCursor("arrow")
	end
	draw.SimpleText("×", "MemUI.CloseFont", w/2, h/2, Color(255, 255, 255), 1, 1)
end

vgui.Register("MemUI.CircleButton", PANEL)