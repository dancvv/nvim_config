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
      }, --your header
      center = {
        {
          icon = "  ",
          desc = "Find  File                              ",
          action = "Leaderf file --popup",
          shortcut = "<Leader> f f",
        },
        {
          icon = "  ",
          desc = "Recently opened files                   ",
          action = "Leaderf mru --popup",
          shortcut = "<Leader> f r",
        },
        {
          icon = "  ",
          desc = "Project grep                            ",
          action = "Leaderf rg --popup",
          shortcut = "<Leader> f g",
        },
        {
          icon = "  ",
          desc = "Open Nvim config                        ",
          action = "tabnew $MYVIMRC | tcd %:p:h",
          shortcut = "<Leader> e v",
        },
        {
          icon = "  ",
          desc = "New file                                ",
          action = "enew",
          shortcut = "e           ",
        },
        {
          icon = "  ",
          desc = "Quit Nvim                               ",
          -- desc = "Quit Nvim                               ",
          action = "qa",
          shortcut = "q           ",
        },
      },
      footer = {
        "Life shouldn’t be a lifetime of waiting. from Cixin liu",
      },  --your footer
      packages = { enable = true },
    }
  }
end

return db
