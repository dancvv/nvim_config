local db = function()
  local status, db = pcall(require, "dashboard")
  if not status then
    vim.notify("Not found dashboard")
    return
  end
  db.setup{
    theme = 'doom',
    config = {
      header = {
        [[]],
        [[]],
        [[]],
        [[⣿⠟⣽⣿⣿⣿⣿⣿⢣⠟⠋⡜⠄⢸⣿⣿⡟⣬⢁⠠⠁⣤⠄⢰⠄⠇⢻⢸]],
        [[⢏⣾⣿⣿⣿⠿⣟⢁⡴⡀⡜⣠⣶⢸⣿⣿⢃⡇⠂⢁⣶⣦⣅⠈⠇⠄⢸⢸]],
        [[⣹⣿⣿⣿⡗⣾⡟⡜⣵⠃⣴⣿⣿⢸⣿⣿⢸⠘⢰⣿⣿⣿⣿⡀⢱⠄⠨⢸]],
        [[⣿⣿⣿⣿⡇⣿⢁⣾⣿⣾⣿⣿⣿⣿⣸⣿⡎⠐⠒⠚⠛⠛⠿⢧⠄⠄⢠⣼]],
        [[⣿⣿⣿⣿⠃⠿⢸⡿⠭⠭⢽⣿⣿⣿⢂⣿⠃⣤⠄⠄⠄⠄⠄⠄⠄⠄⣿⡾]],
        [[⣼⠏⣿⡏⠄⠄⢠⣤⣶⣶⣾⣿⣿⣟⣾⣾⣼⣿⠒⠄⠄⠄⡠⣴⡄⢠⣿⣵]],
        [[⣳⠄⣿⠄⠄⢣⠸⣹⣿⡟⣻⣿⣿⣿⣿⣿⣿⡿⡻⡖⠦⢤⣔⣯⡅⣼⡿⣹]],
        [[⡿⣼⢸⠄⠄⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣕⡜⡌⡝⡸⠙⣼⠟⢱⠏]],
        [[⡇⣿⣧⡰⡄⣿⣿⣿⣿⡿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣋⣪⣥⢠⠏⠄]],
        [[⣧⢻⣿⣷⣧⢻⣿⣿⣿⡇⠄⢀⣀⣀⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠂⠄⠄]],
        [[⢹⣼⣿⣿⣿⣧⡻⣿⣿⣇⣴⣿⣿⣿⣷⢸⣿⣿⣿⣿⣿⣿⣿⣿⣰⠄⠄⠄]],
        [[⣼⡟⡟⣿⢸⣿⣿⣝⢿⣿⣾⣿⣿⣿⢟⣾⣿⣿⣿⣿⣿⣿⣿⣿⠟⠄⡀⡀]],
        [[⣿⢰⣿⢹⢸⣿⣿⣿⣷⣝⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠉⠄⠄⣸⢰⡇]],
        [[⣿⣾⣹⣏⢸⣿⣿⣿⣿⣿⣷⣍⡻⣛⣛⣛⡉⠁⠄⠄⠄⠄⠄⠄⢀⢇⡏⠄]],
        [[]],
        [[]],
        [[]],
      }, --your header
      center = {
        {
          icon = ' ',
          icon_hl = 'Title',
          desc = 'Find File           ',
          desc_hl = 'String',
          key = 'b',
          keymap = 'SPC f f',
          key_hl = 'Number',
          action = 'Telescope find_files'
        },
        {
          icon = ' ',
          icon_hl = 'group',
          desc = 'Find Dotfiles',
          desc_hl = 'group',
          key = 'f',
          keymap = 'SPC f d',
          action = 'lua print(3)'
        },
      },
      footer = {
        "Life shouldn’t be a lifetime of waiting.",
        "                              - Cixin Liu",
      },  --your footer
      packages = { enable = true },
    }
  }
end

return db
