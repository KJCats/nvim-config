-- ============================================================================
-- STATUSLINE
-- ============================================================================

local M = {}

-- Git branch function
function git_branch()
  local handle = io.popen("git branch --show-current 2>/dev/null | tr -d '\n'")
  if not handle then return "" end
  local branch = handle:read("*a")
  handle:close()
  if branch and branch ~= "" then
    return "   " .. branch .. " "
  end
  return ""
end

-- File type with icon
function file_type()
  local ft = vim.bo.filetype
  if ft == "" then return "" end
  
  local icons = {
    lua = "",
    python = "",
    javascript = "",
    typescript = "",
    html = "",
    css = "",
    json = "",
    markdown = "",
    vim = "",
    sh = "",
    rust = "",
    go = "",
    java = "",
    c = "",
    cpp = "",
  }
  
  return " " .. (icons[ft] or "") .. " "
end

-- LSP status
function lsp_status()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    return " 慄"
  end
  return ""
end

-- File size
function file_size()
  local filename = vim.fn.expand('%:p')
  if filename == "" then return "" end
  
  local size = vim.fn.getfsize(filename)
  if size <= 0 then return "" end
  
  if size < 1024 then
    return string.format(" %dB ", size)
  elseif size < 1024 * 1024 then
    return string.format(" %.1fK ", size / 1024)
  else
    return string.format(" %.1fM ", size / 1024 / 1024)
  end
end

-- Mode indicators with icons
function mode_icon()
  local mode = vim.fn.mode()
  local modes = {
    n = "🅝 ",
    i = "🅘 ",
    v = "🅥 ",
    V = "🅥 ",
    ["\22"] = "🅥 ",  -- Ctrl-V
    c = "🅒 ",
    s = "🅢 ",
    S = "🅢 ",
    ["\19"] = "🅢 ",  -- Ctrl-S
    R = "🅡 ",
    r = "🅡 ",
    ["!"] = "🅢 ",
    t = "🅣 "
  }
  return modes[mode] or "? "
end

-- Set global functions for statusline
vim.g.mode_icon = mode_icon
vim.g.git_branch = git_branch
vim.g.file_type = file_type
vim.g.file_size = file_size
vim.g.lsp_status = lsp_status

-- Setup statusline
function M.setup()
  -- Highlight groups
  vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })
  vim.api.nvim_set_hl(0, "StatusLineGit", { fg = "#a6e3a1" })
  vim.api.nvim_set_hl(0, "StatusLineLSP", { fg = "#74c7ec" })
  vim.api.nvim_set_hl(0, "StatusLineFile", { fg = "#f5c2e7" })
  
  local statusline = table.concat({
    "%#StatusLineBold#",
    "%{v:lua.mode_icon()}",
    "%*",
    "%#StatusLine#",
    " %f %h%m%r",
    "%#StatusLineGit#",
    "%{v:lua.git_branch()}",
    "%*",
    "%#StatusLineFile#",
    "%{v:lua.file_type()}",
    "%*",
    "%{v:lua.file_size()}",
    "%#StatusLineLSP#",
    "%{v:lua.lsp_status()}",
    "%*",
    "%=%{&fileencoding?&fileencoding:&encoding}",
    " %l:%c %P "
  })
  
  vim.opt.statusline = statusline
  
  -- Dynamic statusline for focused/unfocused windows
  vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
    callback = function()
      vim.opt_local.statusline = statusline
    end
  })
  
  vim.api.nvim_create_autocmd({"WinLeave"}, {
    callback = function()
      vim.opt_local.statusline = " %f %h%m%r "
    end
  })
end

return M
