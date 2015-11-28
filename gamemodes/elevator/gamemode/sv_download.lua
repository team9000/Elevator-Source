local ResourceList = {}
local ValidExtensions = {"vmt", "mdl", "wav","mp3"}

local function AddResourceDir( dir )
	local files, dirs = file.Find( dir .. "/*", "GAME" )

	for _, fdir in pairs( dirs ) do
		if fdir != ".svn" then
			AddResourceDir( dir .. "/" .. fdir )
		end
	end
	
	local resources = -1

	for k,v in pairs( files ) do
		resources = resources + 1
		
		local string = string.Replace( dir, "gamemodes/elevator/content/", "" ) .. "/" .. v
		
		resource.AddSingleFile( string )
		ResourceList[resources] = { path = string }
	end
end

-- Resources
AddResourceDir("gamemodes/elevator/content")

local function AddPrecacheResources()

	for k, v in pairs(ResourceList) do
		local ext = string.GetExtensionFromFilename(v.path)

		if table.HasValue(ValidExtensions, ext) then

			local PrecacheFile = string.lower( string.sub( v.path, 1 ) )				

			if ( ext == "mp3" || ext == "wav" ) then
				util.PrecacheSound( PrecacheFile )
			end

			if ( ext == "mdl" ) then
				util.PrecacheModel( PrecacheFile )
			end

		end

	end

end

AddPrecacheResources()
resource.AddWorkshop( 158915836 )