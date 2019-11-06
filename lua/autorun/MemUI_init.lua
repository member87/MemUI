local files, folders = file.Find('MemUI/*', 'LUA')

MemUI = {}

function loadFile(file, folder)
	folder = folder or ''
	if string.StartWith(file, 'cl_') then
		AddCSLuaFile('MemUI/' .. folder .. file)
		if CLIENT then
			include('MemUI/' .. folder .. file)
			return 
		end
	elseif string.StartWith(file, 'sv_') then
		if SERVER then
			include('MemUI/' .. folder .. file)
			return
		end
	else
		AddCSLuaFile('MemUI/' .. folder .. file)
		include('MemUI/' .. folder .. file)
		return
	end	
end

function loadFolder(folder)	
	local files, folders = file.Find('MemUI/' .. folder .. '/*', 'LUA')
	for k, v in pairs(files) do
		loadFile(v, folder .. '/')
	end
	for k, v in pairs(folders) do
		loadFolder(v)
	end
end


for k, v in pairs(files) do
	loadFile(v)
end

for k, v in pairs(folders) do
	loadFolder(v)
end