local bind = vim.keymap.set

-- 复用 opt 参数
local opt = {noremap = true, silent = true }

vim.g.mapleader = ';'

-- Search
bind('n', '<LEADER>ff', '<CMD>call VSCodeNotify("workbench.action.quickOpen")<CR>', opt)
bind('n', '<LEADER>fw', '<CMD>call VSCodeNotify("workbench.action.findInFiles")<CR>', opt)

-- Navigation
-- bind('n', '<C-j>', '<CMD>call VSCodeNotify("workbench.action.navigateDown")<CR>', opt)
-- bind('x', '<C-j>', '<CMD>call VSCodeNotify("workbench.action.navigateDown")<CR>', opt)
bind('n', '<C-k>', '<CMD>call VSCodeNotify("workbench.action.navigateUp")<CR>', opt)
bind('x', '<C-k>', '<CMD>call VSCodeNotify("workbench.action.navigateUp")<CR>', opt)
bind('n', '<C-h>', '<CMD>call VSCodeNotify("workbench.action.navigateLeft")<CR>', opt)
bind('x', '<C-h>', '<CMD>call VSCodeNotify("workbench.action.navigateLeft")<CR>', opt)
bind('n', '<C-l>', '<CMD>call VSCodeNotify("workbench.action.navigateRight")<CR>', opt)
bind('x', '<C-l>', '<CMD>call VSCodeNotify("workbench.action.navigateRight")<CR>', opt)


-- Move down and up 5 lines
bind('n', '<C-j>', '5j', opt)
bind('n', '<C-k>', '5k', opt)
bind('v', '<C-j>', '5j', opt)
bind('v', '<C-k>', '5k', opt)

-- Active editor
bind('n', '<S-w>', '<CMD>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>', opt)
bind('n', '<Tab>', '<CMD>call VSCodeNotify("workbench.action.nextEditor")<CR>', opt)
bind('n', '<S-Tab>', '<CMD>call VSCodeNotify("workbench.action.previousEditor")<CR>', opt)
-- bind('n', '<S-h>', '<CMD>call VSCodeNotify("workbench.action.moveEditorLeftInGroup")<CR>', opt)
-- bind('n', '<S-l>', '<CMD>call VSCodeNotify("workbench.action.moveEditorRightInGroup")<CR>', opt)

-- Toggles
bind('n', '<LEADER>e', '<CMD>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>', opt)

-- Hover
bind('n', 'K', '<CMD>call VSCodeNotify("editor.action.showHover")<CR>', opt)
bind('n', '<LEADER>k', '<CMD>call VSCodeNotify("editor.action.showHover")<CR>', opt)

-- VSCode definitions/references
bind('n', 'gd', '<CMD>call VSCodeNotify("editor.action.revealDefinition")<CR>', opt)
bind('n', 'gr', '<CMD>call VSCodeNotify("editor.action.goToReferences")<CR>', opt)


