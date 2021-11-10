local M = {}

function M.ReplaceAll(pattern)
  -- ack -l 'pattern' | xargs perl -pi -E 's/pattern/replacement/g'
  -- ack -l pattern | xargs perl -pi -E 's/' .. pattern .. '/' .. replacement .. '/g'

  -- vim.cmd [[:!ack -l 'hello' | xargs perl -pi -E 's/hello/hi/g']]

  --test = ':!ack -l' .. "'" .. pattern "' | xargs -pi -E 's/hello/hi/g'"

  -- vim.cmd [[:!ack -l pattern | xargs perl -pi -E 's/hello/hi/g']]

  local pattern = 'hi'

  local bobby = string.format(":!ack -l '%s' | xargs perl -pi -E 's/hi/hello/g'", pattern)

  print(pattern)

  -- :execute ":!ack -l '" . a:pattern . "' | xargs perl -pi -E 's/hi/hello/g'"

  -- vim.cmd [[string.format(":!ack -l '%s' | xargs perl -pi -E 's/hi/hello/g'", pattern)]]

  -- print("Hello World")

  -- vim.cmd [[:wq]]

  -- vim.cmd [[:!ack -l 'hello' | xargs perl -pi -E 's/hello/hi/g']]
end

return M
