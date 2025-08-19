-- ~/.config/nvim/colors/catppuccin.lua
vim.g.colors_name = "catppuccin"

local mocha = {
    rosewater = "#F5E0DC",
    flamingo = "#F2CDCD",
    pink = "#F5C2E7",
    mauve = "#CBA6F7",
    red = "#F38BA8",
    maroon = "#EBA0AC",
    peach = "#FAB387",
    yellow = "#F9E2AF",
    green = "#A6E3A1",
    teal = "#94E2D5",
    sky = "#89DCEB",
    sapphire = "#74C7EC",
    blue = "#89B4FA",
    lavender = "#B4BEFE",
    text = "#CDD6F4",
    subtext1 = "#BAC2DE",
    subtext0 = "#A6ADC8",
    overlay2 = "#9399B2",
    overlay1 = "#7F849C",
    overlay0 = "#6C7086",
    surface2 = "#585B70",
    surface1 = "#45475A",
    surface0 = "#313244",
    base = "#1E1E2E",
    mantle = "#181825",
    crust = "#11111B",
}

-- Grundlegende Highlights
vim.api.nvim_set_hl(0, "Normal", { fg = mocha.text, bg = mocha.base })
vim.api.nvim_set_hl(0, "Comment", { fg = mocha.overlay1, italic = true })

-- Syntax Highlights
vim.api.nvim_set_hl(0, "Identifier", { fg = mocha.lavender })
vim.api.nvim_set_hl(0, "Function", { fg = mocha.peach })
vim.api.nvim_set_hl(0, "String", { fg = mocha.green })
vim.api.nvim_set_hl(0, "Number", { fg = mocha.peach })
vim.api.nvim_set_hl(0, "Keyword", { fg = mocha.red })
vim.api.nvim_set_hl(0, "Type", { fg = mocha.yellow })
vim.api.nvim_set_hl(0, "Constant", { fg = mocha.peach })

-- UI Elements
vim.api.nvim_set_hl(0, "LineNr", { fg = mocha.overlay0 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = mocha.rosewater })
vim.api.nvim_set_hl(0, "StatusLine", { fg = mocha.text, bg = mocha.mantle })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = mocha.overlay0, bg = mocha.base })
