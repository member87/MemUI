hook.Add("PlayerSay", "MEM::UI::PLAYERSAY", function(ply, text)
	text = text:lower()
	if text == "!memui" then
		net.Start("MEM::UI::MAIN")
		net.Send(ply)
	end
end)