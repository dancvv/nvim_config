local status, code_runner = pcall(require, "code_runner")
if not status then
  vim.notify("Not found code_runner")
  return
end

code_runner.setup({
  filetype = {
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python3 -u",
    typescript = "deno run",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
  }
})
