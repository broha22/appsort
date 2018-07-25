function sort(apps)
	a = {}
	count = 1
	for key,table in ipairs(apps) do
		count = count + 1 
	end
	i = 1
	while i <= count do
		p = findBiggestUser(apps)
		table.remove(apps,indexOfObject(apps,p))
		a[i] = p
		i = i + 1
	end
	apps = a
	return apps
end

function findBiggestUser(apps)
	biggest = apps[1]
	for key,table in ipairs(apps) do
		if tonumber(table["badge"]) > tonumber(biggest["badge"]) then
			biggest = table
		end
	end
	return biggest
end

function indexOfObject(table,objectWanted)
	for index,object in ipairs(table) do
		if object == objectWanted then
			return index
		end
	end
end