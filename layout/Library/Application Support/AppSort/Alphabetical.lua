function sort(apps)
    table.sort(apps, function(app1, app2) return cap(app1["name"]) < cap(app2["name"] end)
    return apps
end
function cap(str)
    return  string.gsub(str, "^%l", string.upper)
end