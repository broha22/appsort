function sort(apps)
	z = {}
	i = 1
	a = #apps
	--print("Hello "..tostring(a))
	while i <= a do
		max = 0
		appToAdd = apps[1]
		for key,table in ipairs(apps) do
			r = tonumber(string.sub(table["color"],1,2),16)
			g = tonumber(string.sub(table["color"],3,4),16)
			b = tonumber(string.sub(table["color"],5,6),16)
			combined = 0.299 * r + 0.587 * g + 0.114 * b
			if combined >= max then
				max = combined
				appToAdd = table
				--print("uhhh "..appToAdd["id"])
			end
		end
		--print(appToAdd)
		
		table.remove(apps,indexOfObject(apps,appToAdd))
		--print("fuck "..tostring(i).." "..appToAdd["name"])
		z[i] = appToAdd
		--print("yea")
		i = i + 1
		print("um")
	end
	apps = z
	return apps
end

function indexOfObject(table,objectWanted)
	for index,object in ipairs(table) do
		if object == objectWanted then
			--print(index)
			return index
		end
	end
end
