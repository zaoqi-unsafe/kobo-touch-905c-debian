-- {{{ Setup environment
local setmetatable = setmetatable

-- Vicious: widgets for the awesome window manager
module("marek.widgets")
-- }}}

-- Load modules at runtime as needed
setmetatable(_M, { __index = wrequire })
