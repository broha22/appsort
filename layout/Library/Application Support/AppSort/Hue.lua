function sort(apps)
	a = {}
	i = 1
	z = #apps
	while i <= z do
		x = apps[1]
		oHue = 0
		for key,app in ipairs(apps) do
			r = tonumber(string.sub(app["color"],1,2),16)/255
			g = tonumber(string.sub(app["color"],3,4),16)/255
			b = tonumber(string.sub(app["color"],5,6),16)/255
			max = math.max(r,g,b)
			min = math.max(r,g,b)
			if r == max then
				hue = (g - b)/(max - min)
			elseif g == max then
				hue = 2 + (b - r)/(max - min)
			elseif b == max then
				hue = 4 + (r - g)/(max - min)
			end
			if hue >= oHue then
				oHue = hue
				x = app
			end
		end
		table.remove(apps,indexOfObject(apps,x))
		a[i] = x
		i = i + 1
	end
	return a
end
function indexOfObject(table,objectWanted)
	for index,object in ipairs(table) do
		if object == objectWanted then
			return index
		end
	end
end