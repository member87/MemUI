local PANEL = {}


AccessorFunc(PANEL, "m_title", "Title")


function PANEL:Init()
	self:SetTitle("MemUI Container")

	self.header = vgui.Create("MemUI.ContainerHeader", self)
	self.header:Dock(TOP)
	self.header:SetTall(40)
end

function PANEL:PerformLayout(w, h)
	self.radius = math.sqrt(w*w + h*h)

	local x, y = self.header.close:GetPos()
	self.tx, self.ty = w/2, h/2 -- x + self.header.close:GetWide()/2, y + self.header.close:GetTall()/2
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

function PANEL:PaintContents(w, h)
	if self.closing then
		draw.RoundedBoxEx(8, 0, 0, w, h, Color(20, 20, 20), true, true)
		
	else
		local x, y = self:LocalToScreen(0, 0)
		BSHADOWS.BeginShadow()
			draw.RoundedBoxEx(8, x, y, w, h, Color(20, 20, 20), true, true)
		BSHADOWS.EndShadow(1, 5, 5, 255, 0, 0)
	end
end

function PANEL:Paint(w, h)
	if self.closing then
		render.SetStencilWriteMask( 0xFF )
		render.SetStencilTestMask( 0xFF )
		render.SetStencilReferenceValue( 0 )
		render.SetStencilZFailOperation( STENCIL_KEEP )
		render.ClearStencil()

		render.SetStencilEnable( true )
		render.SetStencilReferenceValue( 1 )
		render.SetStencilCompareFunction( STENCIL_NEVER )
		render.SetStencilFailOperation( STENCIL_REPLACE )

		local target = -100


		self.radius = Lerp(FrameTime()*6, self.radius, target)
		MemUI:DrawCircle( self.tx, self.ty, self.radius)

		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.SetStencilFailOperation( STENCIL_KEEP )

		self:PaintContents(w, h)
		self:PaintChildren(self:GetChildren())

		render.SetStencilEnable( false )

		if self.radius < self.header.close:GetActualRadius() then
			self:Remove()
		end
	else
		self:PaintContents(w, h)
	end
end

vgui.Register("MemUI.Container", PANEL, "EditablePanel")