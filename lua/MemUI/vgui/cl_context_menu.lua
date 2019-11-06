local PANEL = {}

MemUI:CreateFont("MemUI.ContextMenuFont", 18, "Roboto Bold")

AccessorFunc(PANEL, "m_text", "Text", FORCE_STRING)
AccessorFunc(PANEL, "m_isTop", "IsTop", FORCE_BOOL)
AccessorFunc(PANEL, "m_isBottom", "IsBottom", FORCE_BOOL)

function PANEL:Init()
	self:SetTall(40)
	self:SetText("Placeholder")
	self:SetIsTop(false)
	self:SetIsBottom(false)
	self:SetCursor("hand")
	self.mat = surface.GetTextureID("particle/particle_glow_01_additive")	
end

function PANEL:Paint(w, h)
	if self:IsHovered() then
		draw.RoundedBoxEx(8, 0, 0, w, h, Color(0, 0, 0), self:GetIsTop(), self:GetIsTop(), self:GetIsBottom(), self:GetIsBottom())
		draw.SimpleText(self:GetText(), "MemUI.ContextMenuFont", 10, h/2, MemUI.colors.text.primary, 0, 1)
	else
		draw.SimpleText(self:GetText(), "MemUI.ContextMenuFont", 10, h/2, MemUI.colors.text.disabled, 0, 1)
	end
	
	if !self:GetIsBottom() then
		draw.RoundedBox(0, 0, h-1, w, 1, MemUI.colors.background.body)
	end
end

vgui.Register("MemUI.ContextMenuItem", PANEL)










local PANEL = {}
function PANEL:Init()
	self.items = {}
	self.minWidth = 0

	self.radius = 0
	self.opening = true
	self.buttonPressed = false
end

function PANEL:PaintContents(w, h)
	self:AddShadow(1, 2, 2, 255, 0, 0)
	draw.RoundedBox(8, 0, 0, w, h, MemUI.colors.background.header)
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

function PANEL:Paint(w, h)
	self:PaintContents(w, h)
	self:PaintChildren(self:GetChildren())
end

function PANEL:PerformLayout(w, h)
end

function PANEL:OnFocusChanged(b)
	if b then return end
	self:Remove()
end



function PANEL:SetStartPos(x, y)
	self.tx, self.ty = x, y
	self:SetPos(x, y)
end

function PANEL:AddItem(text, callback)
	text = text or ""
	callback = callback or function() return false end

	self.items[#self.items+1] = vgui.Create("MemUI.ContextMenuItem", self)
	self.items[#self.items]:SetText(text)
	self.items[#self.items]:Dock(TOP)
	self.items[#self.items]:DockPadding(5, 0, 5, 0)
	self.items[#self.items].OnMousePressed = function()
		callback()

		local x, y = input.GetCursorPos()
		self.bx, self.by = self:ScreenToLocal(x, y)
		self.buttonPressed = true

		self.closing = true
	end

	self.height = 0
	for i = 1, #self.items do
		self.height = self.height + self.items[i]:GetTall()
		self.items[i]:SetIsTop(false)
		self.items[i]:SetIsBottom(false)
	end

	self.items[1]:SetIsTop(true)
	self.items[#self.items]:SetIsBottom(true)

	surface.SetFont("MemUI.ContextMenuFont")
	local w, h = surface.GetTextSize(text)
	if w > self.minWidth then
		self:SetWide(w + 44)
		self.minWidth = w
	end

	self:SetHeight(self.height)
end

vgui.Register("MemUI.ContextMenu", PANEL)









function MemUI:CreateContextMenu(x, y)
	local menu = vgui.Create("MemUI.ContextMenu")
	menu:SetStartPos(x, y)
	//menu:SetSize(100, 100)
	menu:SetDrawOnTop(true)
  	menu:MakePopup()

  	return menu
end