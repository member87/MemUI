

local PANEL = FindMetaTable("Panel")

function PANEL:AddRippleEffects(color, speed)
	self.speed = speed or 3
	self.rippleColor = color
	self.ripples = {}

	self.oldPaint = self.Paint
	function self:Paint(w, h)
		if self.oldPaint then
			self:oldPaint(w, h)
		end

		for _, ripple in pairs(self.ripples) do
			ripple.alpha = Lerp(FrameTime()*self.speed, ripple.alpha, -5)
			ripple.radius = Lerp(FrameTime()*self.speed, ripple.radius, w+h)

			MemUI:DrawCircle(ripple.x, ripple.y, ripple.radius, ColorAlpha(self.rippleColor, ripple.alpha))
		end

		for i = 1, #self.ripples do
			if self.ripples[i] then
				if self.ripples[i].alpha < 1 then
					table.remove(self.ripples, i)
				end
			end
		end
	end

	function self:AddRipple(x, y, color)
		self.ripples = self.ripples or {}
		table.insert(self.ripples, {
			x = x,
			y = y,
			alpha = 100,
			color = color,
			radius = 0
		})
	end


	self.oldMousePressed = self.OnMousePressed
	function self:OnMousePressed(code)
		if code ~= MOUSE_LEFT then return end
		self.mx, self.my = self:CursorPos()

		self:AddRipple(self.mx, self.my, self.rippleColor)

		if self.oldMousePressed then
			self:oldMousePressed(code)
		end
	end
end