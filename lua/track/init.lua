local M = {}

local A = vim.api
M.GROUP = vim.api.nvim_create_augroup("TrackGroup", { clear = false })

-- TODO: Implement focused for commands and manpages as well.
-- NOTE: Use something like util.parse_current_buf_name()

function M.setup(opts)
  require("track.config").merge(opts)
  require("track.log").info("setup(): plugin configured")
  require("track.core")(require("track.util").cwd())
  A.nvim_create_autocmd("DirChanged", {
    group = M.GROUP,
    callback = function() require("track.core")(require("track.util").cwd()) end,
  })
end

return setmetatable(M, {
  __index = function(_, key) return require("track.core")[key] end,
})
