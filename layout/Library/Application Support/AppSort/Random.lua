function sort(apps)
  a = {}
  local appCount = 0
  for _ in ipairs(apps) do appCount = appCount + 1 end
  math.randomseed(os.time())
  local start = math.random(appCount)
  local amount = math.random(2,10)
  i = 1
  p = start
  looped = 0
  while i <= appCount do
    a[i] = apps[p]
    p = p + amount
    while p > appCount do
      if p - appCount == start then
        start = start - 1
        if start == 0 then
          start = appCount
        end
        p = start
      else
        p = p - appCount
      end
    end
    i = i + 1
  end
  apps = a
  return apps
end