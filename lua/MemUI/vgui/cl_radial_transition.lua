local PANEL = {}
function PANEL:Init()
	self.CompletedTransition = false
	self.Radius = 0
end

function PANEL:PerformLayout(w, h)
	self:SetSize(w, h)
end

function PANEL:PaintChildren(panels)
	for k, v in pairs(panels) do
		v:SetPaintedManually(true)
		v:PaintManual()
		if v:HasChildren() then
			self:PaintChildren(v:GetChildren())
		end
	end
end

function PANEL:PaintContent(w, h)
	surface.SetDrawColor(MemUI.colors.background.body)
	surface.DrawRect(0, 0, w, h)
end

function PANEL:Paint(w, h)

	if !self.CompletedTransition then
		render.SetStencilWriteMask( 0xFF )
		render.SetStencilTestMask( 0xFF )
		render.SetStencilReferenceValue( 0 )
		render.SetStencilZFailOperation( STENCIL_KEEP )
		render.ClearStencil()

		render.SetStencilEnable( true )
		render.SetStencilReferenceValue( 1 )
		render.SetStencilCompareFunction( STENCIL_NEVER )
		render.SetStencilFailOperation( STENCIL_REPLACE )

		local target = math.sqrt((w/2)*(w/2) + (h/2)*(h/2))*2
		self.Radius = Lerp(FrameTime()*3.5, self.Radius, target)
		MemUI:DrawCircle( w/2, h/2, self.Radius)

		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.SetStencilFailOperation( STENCIL_KEEP )

		self:PaintContent(w, h)
		self:PaintChildren(self:GetChildren())
		render.SetStencilEnable( false )

		if(self.Radius*2 > target) then
			self.CompletedTransition = true
		end
	else
		self:PaintContent(w, h)
		self:PaintChildren(self:GetChildren())
	end


end

vgui.Register("MemUI.RadialTransition", PANEL)