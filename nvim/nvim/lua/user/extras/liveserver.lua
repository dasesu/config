local M = {
  "barrett-ruth/live-server.nvim",
  build = "npm add -g live-server",
  cmd = { 'LiveServerStart', 'LiveServerStop' },
}

function M.config()
  require('live-server').setup(opts)
end

return M
