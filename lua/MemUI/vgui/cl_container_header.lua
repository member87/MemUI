local PANEL = {}

AccessorFunc(PANEL, "m_title", "Title", FORCE_STRING)

function PANEL:Init()
	self:SetTitle("MemUI Container")

	self.close = vgui.Create("MemUI.CircleButton", self)
	self.close:SetRadius(30)
	self.close:SetColor(Color(60, 60, 60))
	self.close:SetHoverEnabled(true)
	self.close:SetHoverColor(Color(60, 60, 60, 50))

	self.close.DoClick = function()
		self:GetParent():AlphaTo(0, 0.45)
		self:GetParent().closing = true
	end
end


function PANEL:PerformLayout(w, h)
	self.close:SetRadius(h-10)
	self.close:SetPos(w-self.close:GetWide()-5, 5)
end

function PANEL:Paint(w, h)
	draw.RoundedBoxEx(8, 0, 0, w, h, MemUI.colors.background.header, true, true)
	draw.SimpleText(self:GetTitle(), "MemUI.TitleFont", 10, h/2, MemUI.colors.text.primary, 0, 1)
end

vgui.Register("MemUI.ContainerHeader", PANEL, "DPanel")