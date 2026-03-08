local M = {}

local pairs_by_opener = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
  ['"'] = '"',
  ["'"] = "'",
}

local closers = {
  [")"] = true,
  ["]"] = true,
  ["}"] = true,
  [">"] = true,
}

local function get_visual_range()
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")

  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]

  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end

  return start_line, start_col, end_line, end_col
end

local function build_candidates(line)
  local stack = {}
  local candidates = {}

  for col = 1, #line do
    local char = line:sub(col, col)

    if pairs_by_opener[char] then
      if char == '"' or char == "'" then
        local top = stack[#stack]

        if top and top.char == char then
          stack[#stack] = nil

          local content_start = top.col + 1
          local content_end = col - 1

          if content_start <= content_end then
            candidates[#candidates + 1] = {
              opener = top.char,
              closer = char,
              start_col = content_start,
              end_col = content_end,
            }
          end
        else
          stack[#stack + 1] = { char = char, col = col }
        end
      else
        stack[#stack + 1] = { char = char, col = col }
      end
    elseif closers[char] then
      local top = stack[#stack]
      if top and pairs_by_opener[top.char] == char then
        stack[#stack] = nil

        local content_start = top.col + 1
        local content_end = col - 1

        if top.char == "<" and line:sub(content_start, content_start) == "/" then
          content_start = content_start + 1
        end

        if content_start <= content_end then
          candidates[#candidates + 1] = {
            opener = top.char,
            closer = char,
            start_col = content_start,
            end_col = content_end,
          }
        end
      end
    end
  end

  table.sort(candidates, function(a, b)
    local a_width = a.end_col - a.start_col
    local b_width = b.end_col - b.start_col

    if a_width == b_width then
      return a.start_col > b.start_col
    end

    return a_width < b_width
  end)

  return candidates
end

local function find_target(candidates, anchor_start, anchor_end, expand)
  local exact_index
  local fallback

  for index, candidate in ipairs(candidates) do
    if candidate.start_col == anchor_start and candidate.end_col == anchor_end then
      exact_index = index
      break
    end

    if candidate.start_col <= anchor_start and candidate.end_col >= anchor_end and not fallback then
      fallback = candidate
    end
  end

  if expand and exact_index then
    return candidates[exact_index + 1]
  end

  if fallback then
    return fallback
  end

  return candidates[1]
end

local function select_target(line_nr, start_col, end_col)
  vim.fn.setpos("'<", { 0, line_nr, start_col, 0 })
  vim.fn.setpos("'>", { 0, line_nr, end_col, 0 })
  vim.cmd("normal! gv")
end

function M.select_or_expand()
  local mode = vim.fn.mode()
  local line_nr
  local anchor_start
  local anchor_end
  local expand = false

  if mode:match("[vV\22]") then
    local start_line, start_col, end_line, end_col = get_visual_range()

    if start_line ~= end_line then
      vim.notify("Smart surround fungerar bara på en rad just nu", vim.log.levels.WARN)
      return
    end

    line_nr = start_line
    anchor_start = start_col
    anchor_end = end_col
    expand = true
  else
    local cursor = vim.api.nvim_win_get_cursor(0)
    line_nr = cursor[1]
    anchor_start = cursor[2] + 1
    anchor_end = anchor_start
  end

  local line = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, false)[1] or ""
  local candidates = build_candidates(line)

  local containing = {}
  for _, candidate in ipairs(candidates) do
    if candidate.start_col <= anchor_start and candidate.end_col >= anchor_end then
      containing[#containing + 1] = candidate
    end
  end

  local target = find_target(containing, anchor_start, anchor_end, expand)

  if not target then
    vim.notify("Ingen omslutning hittades", vim.log.levels.INFO)
    return
  end

  select_target(line_nr, target.start_col, target.end_col)
end

return M
