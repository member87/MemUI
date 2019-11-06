local PANEL = {}

MemUI:CreateFont("MemUI.TextEntryFont", 20)

function PANEL:Init()
	self:SetTall(40)
	self:SetPlaceholder("Placeholder Text")

	self.te = vgui.Create("DTextEntry", self)
	self.te:SetFont("MemUI.TextEntryFont")
	self.te:Dock(FILL)

	self.te.Paint = function(s, w, h)
		if self.placeholder && !s:IsEditing() && string.len(s:GetValue()) <= 0 then
			draw.SimpleText(self.placeholder, "MemUI.TextEntryFont", 0, h/2, Color(150, 150, 150), 0, 1)
		else
			s:DrawTextEntryText(Color(70, 70, 70), Color(150, 150,150), Color(70, 70, 70))
		end
	end

end

function PANEL:Paint(w, h)
	draw.RoundedBox(h/2, 0, 0, w, h, Color(255, 255, 255))
end

function PANEL:SetPlaceholder(text)
	self.placeholder = text or ""
end

function PANEL:PerformLayout(w, h)
	self.te:DockMargin(h/2, 0, h/2, 0)
	self.te:Dock(FILL)
end

vgui.Register("MemUI.TextEntry", PANEL)