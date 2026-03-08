local M = {}

local loaded = false

local function build_table_body(size, filled)
  local parts = {}
  local index = 1

  local header = {}
  for col = 1, size do
    header[#header + 1] = "${" .. index .. ":Column" .. col .. "}"
    index = index + 1
  end
  parts[#parts + 1] = "| " .. table.concat(header, " | ") .. " |"

  local separator = {}
  for _ = 1, size do
    separator[#separator + 1] = "---"
  end
  parts[#parts + 1] = "| " .. table.concat(separator, " | ") .. " |"

  for row = 1, size do
    local cells = {}
    for col = 1, size do
      local default = filled and ("Item" .. col .. "." .. row) or ""
      cells[#cells + 1] = "${" .. index .. ":" .. default .. "}"
      index = index + 1
    end
    parts[#parts + 1] = "| " .. table.concat(cells, " | ") .. " |"
  end

  parts[#parts + 1] = "$0"
  return table.concat(parts, "\n")
end

local function build_code_block(language)
  return table.concat({
    "```" .. language,
    "$0",
    "```",
  }, "\n")
end

local function build_callout_block(kind)
  local upper = string.upper(kind)
  return table.concat({
    "> [!" .. upper .. "]",
    "> $0",
  }, "\n")
end

function M.setup()
  if loaded then
    return
  end

  local luasnip = require("luasnip")
  local parse = luasnip.parser.parse_snippet

  local snippets = {
    parse("table", build_table_body(2, false)),
    parse("tabled", build_table_body(2, true)),
    parse({ trig = "code", name = "Code block", dscr = "Generic fenced code block" }, "```$1\n$0\n```"),
    parse({ trig = "callout", name = "Callout", dscr = "Generic GitHub-style callout" }, "> [!${1:WARNING}]\n> $0"),
  }

  local code_languages = {
    "bash",
    "sh",
    "zsh",
    "lua",
    "python",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "yaml",
    "toml",
    "markdown",
    "go",
    "sql",
  }

  for _, language in ipairs(code_languages) do
    snippets[#snippets + 1] = parse({
      trig = language,
      name = language .. " code block",
      dscr = "Insert fenced " .. language .. " code block",
    }, build_code_block(language))
  end

  local callout_types = {
    "warning",
    "note",
    "tip",
    "important",
    "caution",
  }

  for _, kind in ipairs(callout_types) do
    snippets[#snippets + 1] = parse({
      trig = kind,
      name = kind .. " callout",
      dscr = "Insert " .. kind .. " callout",
    }, build_callout_block(kind))
  end

  for size = 2, 10 do
    snippets[#snippets + 1] = parse("table" .. size, build_table_body(size, false))
    snippets[#snippets + 1] = parse("table" .. size .. "d", build_table_body(size, true))
  end

  luasnip.add_snippets("neowiki", snippets)
  loaded = true
end

return M
