local PANEL = {}

function PANEL:Init()
	self.scollamount = 0
	self.scrollingEnabled = false
	self.newPos = 0
	self.sbar = self:GetVBar()
	self.sbar.Paint = function(s, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
	end

	self.sbar.btnGrip.Paint = function(s, w, h)
		if string.sub(tostring(self.sbar:GetOffset()),1,1) == "0" then return end
		draw.RoundedBox( 6, 0, 0, w-4, h, MemUI.colors.background.scrollbar )
	end

	self.sbar:SetHideButtons(true)
end


function PANEL:Paint(w, h)
	//draw.RoundedBox(0, 0, 0, w, h, Color(240, 240, 240))
end

function PANEL:Think()
	if !self.scrollingEnabled then return end
	if self.scollamount ~= 0 then
		local y = self.sbar:GetScroll()
		self.newPos = (y + self.scollamount * 250)
		self.scollamount = 0
	end
	if math.abs(self.sbar:GetScroll() - self.newPos) < 25 then
		self.scrollingEnabled = false
	end
	self.sbar:SetScroll(Lerp(FrameTime()*4, self.sbar:GetScroll(), self.newPos))
	self.nextPos = Lerp(FrameTime()*4, self.sbar:GetScroll(), self.newPos)
end


function PANEL:OnMouseWheeled(dlta)
	if (self.scollamount > 0 && dlta < 0) or (self.scollamount > 0 && dlta < 0) then
		self.scollamount = 0
		self.newPos = self.sbar:GetScroll()
	end
	self.scollamount = self.scollamount - dlta
	self.scrollingEnabled = true
end

vgui.Register("MemUI.ScrollBar", PANEL, "DScrollPanel")