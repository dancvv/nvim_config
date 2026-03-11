-- ============================================================================
-- VSCode Neovim Keymaps
-- Only loaded when running inside VSCode (vim.g.vscode == true)
-- Uses vscode-neovim extension API to call VSCode commands
-- ============================================================================

local keymap = vim.keymap.set
local vscode = require("vscode")

-- Helper: call a VSCode command
local function call(cmd)
  return function() vscode.action(cmd) end
end

-- ============================================================================
-- LSP / Code Navigation → VSCode built-in
-- ============================================================================

keymap("n", "gd", call("editor.action.revealDefinition"),          { desc = "Go to definition" })
keymap("n", "gD", call("editor.action.revealDeclaration"),         { desc = "Go to declaration" })
keymap("n", "gi", call("editor.action.goToImplementation"),        { desc = "Go to implementation" })
keymap("n", "gr", call("editor.action.goToReferences"),            { desc = "Go to references" })
keymap("n", "gt", call("editor.action.goToTypeDefinition"),        { desc = "Go to type definition" })
keymap("n", "K",  call("editor.action.showHover"),                 { desc = "Hover documentation" })

-- Code actions & refactoring
keymap({ "n", "v" }, "<leader>ca", call("editor.action.quickFix"),       { desc = "Code action" })
keymap("n",          "<leader>rn", call("editor.action.rename"),          { desc = "Rename symbol" })
keymap("n",          "<leader>fm", call("editor.action.formatDocument"),  { desc = "Format document" })

-- Diagnostics
keymap("n", "[d",        call("editor.action.marker.prevInFiles"), { desc = "Previous diagnostic" })
keymap("n", "]d",        call("editor.action.marker.nextInFiles"), { desc = "Next diagnostic" })
keymap("n", "<leader>dl", call("workbench.actions.view.problems"), { desc = "List diagnostics" })
keymap("n", "<leader>df", call("editor.action.showHover"),         { desc = "Show diagnostic float" })

-- Signature help
keymap("i", "<C-k>", call("editor.action.triggerParameterHints"), { desc = "Signature help" })

-- ============================================================================
-- File Search / Navigation → VSCode command palette
-- ============================================================================

keymap("n", "<leader>ff", call("workbench.action.quickOpen"),               { desc = "Find files" })
keymap("n", "<leader>fg", call("workbench.action.findInFiles"),             { desc = "Live grep" })
keymap("n", "<leader>fb", call("workbench.action.showAllEditorsByMostRecentlyUsed"), { desc = "Find buffers" })
keymap("n", "<leader>fr", call("workbench.action.openRecent"),              { desc = "Recent files" })
keymap("n", "<leader>fc", call("editor.action.addSelectionToNextFindMatch"),{ desc = "Find under cursor" })
keymap("n", "<leader>fh", call("workbench.action.showCommands"),            { desc = "Command palette" })
keymap("n", "<leader>fp", call("workbench.action.openRecent"),              { desc = "Find projects" })

-- ============================================================================
-- File Explorer
-- ============================================================================

keymap("n", "<leader>e",  call("workbench.action.toggleSidebarVisibility"), { desc = "Toggle sidebar" })
keymap("n", "<leader>o",  call("workbench.view.explorer"),                  { desc = "Focus explorer" })
keymap("n", "<leader>nf", call("revealInExplorer"),                         { desc = "Reveal in explorer" })

-- ============================================================================
-- Git → VSCode Source Control
-- ============================================================================

keymap("n", "<leader>gg", call("workbench.view.scm"),                          { desc = "Git SCM panel" })
keymap("n", "<leader>gd", call("git.openChange"),                              { desc = "Git diff" })
keymap("n", "<leader>gb", call("git.checkout"),                                { desc = "Git checkout branch" })
keymap("n", "<leader>gh", call("git.viewFileHistory"),                         { desc = "Git file history" })
keymap("n", "<leader>gs", call("workbench.view.scm"),                          { desc = "Git status" })
keymap("n", "]h",         call("workbench.action.editor.nextChange"),          { desc = "Next hunk" })
keymap("n", "[h",         call("workbench.action.editor.previousChange"),      { desc = "Previous hunk" })
keymap("n", "<leader>hs", call("git.stageSelectedRanges"),                     { desc = "Stage hunk" })
keymap("n", "<leader>hr", call("git.revertSelectedRanges"),                    { desc = "Reset hunk" })
keymap("n", "<leader>hb", call("editor.action.showHover"),                     { desc = "Blame line" })

-- ============================================================================
-- Terminal → VSCode integrated terminal
-- ============================================================================

keymap("n", "<C-\\>",       call("workbench.action.terminal.toggleTerminal"),  { desc = "Toggle terminal" })
keymap("n", "<leader>th",   call("workbench.action.terminal.toggleTerminal"),  { desc = "Toggle terminal" })

-- ============================================================================
-- Buffer / Tab Navigation → VSCode editor tabs
-- ============================================================================

keymap("n", "<S-l>",      call("workbench.action.nextEditor"),          { desc = "Next buffer" })
keymap("n", "<S-h>",      call("workbench.action.previousEditor"),      { desc = "Previous buffer" })
keymap("n", "<leader>bd", call("workbench.action.closeActiveEditor"),   { desc = "Close buffer" })
keymap("n", "<leader>bp", call("workbench.action.pinEditor"),           { desc = "Pin editor" })

-- ============================================================================
-- Window / Split → VSCode editor groups
-- ============================================================================

keymap("n", "<leader>sv", call("workbench.action.splitEditorRight"),    { desc = "Split vertical" })
keymap("n", "<leader>sh", call("workbench.action.splitEditorDown"),     { desc = "Split horizontal" })
keymap("n", "<leader>sx", call("workbench.action.closeEditorsInGroup"), { desc = "Close group" })
keymap("n", "<C-h>",      call("workbench.action.focusLeftGroup"),      { desc = "Focus left group" })
keymap("n", "<C-l>",      call("workbench.action.focusRightGroup"),     { desc = "Focus right group" })

-- ============================================================================
-- Problems / Diagnostics panel
-- ============================================================================

keymap("n", "<leader>xx", call("workbench.actions.view.problems"),          { desc = "Problems panel" })
keymap("n", "<leader>xX", call("workbench.actions.view.problems"),          { desc = "Workspace problems" })

-- ============================================================================
-- Comments → VSCode built-in (works in all languages)
-- ============================================================================

keymap("n", "gcc",   call("editor.action.commentLine"),         { desc = "Comment line" })
keymap("v", "gc",    call("editor.action.commentLine"),         { desc = "Comment selection" })
keymap("n", "<C-/>", call("editor.action.commentLine"),         { desc = "Comment line" })
keymap("v", "<C-/>", call("editor.action.commentLine"),         { desc = "Comment selection" })

-- ============================================================================
-- UI Extras
-- ============================================================================

-- Open settings
keymap("n", "<leader>us", call("workbench.action.openSettings"),    { desc = "Open settings" })
-- Zen mode
keymap("n", "<leader>uz", call("workbench.action.toggleZenMode"),   { desc = "Toggle zen mode" })
-- Fold / unfold
keymap("n", "za", call("editor.toggleFold"),                        { desc = "Toggle fold" })
keymap("n", "zM", call("editor.foldAll"),                           { desc = "Fold all" })
keymap("n", "zR", call("editor.unfoldAll"),                         { desc = "Unfold all" })
