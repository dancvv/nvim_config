vim.g.mapleader = ";"
local gmap = vim.keymap.set
-- vscode config
-- Folding
gmap("n", "za", function() vim.fn.VSCodeNotify("editor.toggleFold") end)
gmap("n", "zc", function() vim.fn.VSCodeNotify("editor.foldRecursively") end)
gmap("n", "zC", function() vim.fn.VSCodeNotify("editor.foldAll") end)
gmap("n", "zO", function() vim.fn.VSCodeNotify("editor.unfoldAll") end)
gmap("n", "zo", function() vim.fn.VSCodeNotify("editor.unfoldRecursively") end)
gmap("n", "zp", function() vim.fn.VSCodeNotify("editor.gotoParentFold") end)

-- Normal remaps
gmap("n", "[f", function() vim.fn.VSCodeNotify("workbench.view.search.focus") end)
gmap("n", "]f", function() vim.fn.VSCodeNotify("workbench.action.replaceInFiles") end)
gmap("n", "gD", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end)
gmap("n", ";s", function() vim.fn.VSCodeNotify("editor.action.toggleStickyScroll") end)
gmap("n", "=<", function() vim.fn.VSCodeNotify("editor.action.trimTrailingWhitespace") end)
gmap("n", "gl", function() vim.fn.VSCodeNotify("editor.action.openLink") end)
gmap("n", "<C-k>", function()
  vim.fn.VSCodeCall("editor.action.insertLineBefore")
  vim.cmd("norm k")
end)
gmap("n", "<<", function() vim.fn.VSCodeNotify("editor.action.outdentLines") end)
gmap("n", ">>", function() vim.fn.VSCodeNotify("editor.action.indentLines") end)

-- Visual remaps
gmap("v", "gs", function() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end)
gmap("v", "<", function() vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false) end)
gmap("v", ">", function() vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false) end)

-- Insert remaps
gmap("i", "<C-k>", function() vim.fn.VSCodeNotify("editor.action.insertLineBefore") end)
-- Move editor
gmap("n", "<leader>h", function() vim.fn.VSCodeNotify("workbench.action.moveEditorToPreviousGroup") end)
gmap("n", "<leader>l", function() vim.fn.VSCodeNotify("workbench.action.moveEditorToNextGroup") end)

--gmap('n', '<leader>q', '<Cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>')
-- gmap("n", ";q", function() vim.fn.VSCodeNotify("workbench.action.closeActiveEditor", true) end)
gmap("n", "<leader>q", function() vim.fn.VSCodeNotify("workbench.action.closeActiveEditor") end)
-- gmap("n", "E", "gT")
gmap("n", "<leader>v", function() vim.fn.VSCodeNotify("workbench.action.splitEditor") end)
gmap("n", "<leader>b", function() vim.fn.VSCodeCall("workbench.action.toggleSidebarVisibility", true) end)
gmap("n", "<leader>e", function() vim.fn.VSCodeCall("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup", true) end)
gmap("n", "<leader>r", function() vim.fn.VSCodeCall("workbench.action.openNextRecentlyUsedEditorInGroup", true) end)
