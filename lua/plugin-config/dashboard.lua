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
          icon = ' ',
          desc = 'File History           ',
          key = 'h',
          keymap = 'SPC f e',
          action = 'Telescope oldfiles'
        },
        {
          icon = ' ',
          desc = 'Project Find',
          key = 'f',
          keymap = 'SPC f p',
          action = 'Telescope projects'
        },
        {
          icon = ' ',
          desc = 'File New',
          key = 'n',
          keymap = 'SPC f d',
          action = 'enew'
        },
        {
          icon = ' ',
          desc = 'Word Find',
          key = 'l',
          keymap = 'SPC f w',
          action = 'Telescope live_grep'
        }

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
