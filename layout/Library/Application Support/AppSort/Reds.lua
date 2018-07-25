function sort(apps)
	a = {}
	local appcount = 0
	for _ in ipairs(apps) do appcount = appcount + 1 end
	currentColor = tonumber("FF",16)
	i = 1
	while i <= appcount do
		for key,table in ipairs(apps) do
			x = tonumber(string.sub(table["color"],5,6),16) - tonumber(string.sub(table["color"],1,2),16)
			if x == currentColor then
				a[i] = table
				i = i + 1
			end
		end
		currentColor = currentColor - 1
	end
	apps = a
	return apps
end