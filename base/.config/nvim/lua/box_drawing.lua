UP = '╵'
RIGHT = '╶'
DOWN = '╷'
LEFT = '╴'

--    ┌────────────────────╴display
--    │                ┌───╴up?
--    │                │┌──╴right?
--    │                ││┌─╴down?
--    │                │││┌╴left?
--    │                ││││
char_to_bits = {
    [' '] = 0x00, -- 0b0000
    ['╴'] = 0x01, -- 0b0001
    ['╷'] = 0x02, -- 0b0010
    ['┐'] = 0x03, -- 0b0011
    ['╶'] = 0x04, -- 0b0100
    ['─'] = 0x05, -- 0b0101
    ['┌'] = 0x06, -- 0b0110
    ['┬'] = 0x07, -- 0b0111
    ['╵'] = 0x08, -- 0b1000
    ['┘'] = 0x09, -- 0b1001
    ['│'] = 0x0A, -- 0b1010
    ['┤'] = 0x0B, -- 0b1011
    ['└'] = 0x0C, -- 0b1100
    ['┴'] = 0x0D, -- 0b1101
    ['├'] = 0x0E, -- 0b1110
    ['┼'] = 0x0F, -- 0b1111
}

bits_to_char = {}
for char, bits in pairs(char_to_bits) do
    bits_to_char[bits] = char
end

function box_add(a, b)
    if char_to_bits[a] == nil then
        a = " "
    end
    if char_to_bits[b] == nil then
        b = " "
    end

    return bits_to_char[bit.bor(char_to_bits[a], char_to_bits[b])]
end

function cursor_add(c)
    vim.cmd("normal! r" .. box_add(cursor_char(), c))
end

function cursor_char()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row = cursor_pos[1]
    local col = cursor_pos[2]
    return char_at(row, col)
end

function char_at(row, col)
    return vim.api.nvim_eval("matchstr(getline(" .. row .. "), '\\%" .. (col+1) .. "c.')")
end

function cursor_col()
    return tonumber(vim.api.nvim_eval("virtcol('.')"))
end

function box_drawing_move(direction)
    cursor_add(direction)
    if direction == UP then
        before_col = cursor_col()
        vim.cmd("normal! k")
        after_col = cursor_col()
        if after_col < before_col then
            vim.cmd("normal! " .. (before_col - after_col) .. "a ")
        end
        cursor_add(DOWN)
    elseif direction == RIGHT then
        before_col = cursor_col()
        vim.cmd("normal! l")
        after_col = cursor_col()
        if before_col == after_col then
            vim.cmd("normal! a ")
        end
        cursor_add(LEFT)
    elseif direction == DOWN then
        before_col = cursor_col()
        vim.cmd("normal! j")
        after_col = cursor_col()
        if after_col < before_col then
            vim.cmd("normal! " .. (before_col - after_col) .. "a ")
        end
        cursor_add(UP)
    elseif direction == LEFT then
        vim.cmd("normal! h")
        cursor_add(RIGHT)
    end
end

NORMAL = "n"
function find_keymap(key)
    local keymaps = vim.api.nvim_get_keymap(NORMAL)
    for _, keymap in pairs(keymaps) do
        if keymap.lhs == key then
            -- vim.api returns these as 1/0 instead of true/false, as vim.keymap.set takes
            return {
                callback = keymap.callback,
                rhs = keymap.rhs,
                expr = keymap.expr == 1,
                nowait = keymap.nowait == 1,
                remap = keymap.noremap == 0,
                script = keymap.script == 1,
                silent = keymap.silent == 1,
                desc = keymap.desc,
            }
        end
    end
end

function find_keymaps(keys)
    local mappings = {}
    for _, key in ipairs(keys) do
        mappings[key] = find_keymap(key)
        if mappings[key] == nil then
            mappings[key] = { default = true }
        end
    end
    return mappings
end

function restore_keymaps(saved, bufnr)
    for key, keymap in pairs(saved) do
        if keymap.default then
            vim.keymap.del(NORMAL, key, { buf = bufnr })
        else
            vim.keymap.set(NORMAL, key, keymap.callback or keymap.rhs, {
                buf = bufnr,
                expr = keymap.expr,
                nowait = keymap.nowait,
                remap = keymap.remap,
                script = keymap.script,
                silent = keymap.silent,
                desc = keymap.desc,
            })
        end
    end
end

function box_drawing_start()
    local saved_keymaps = find_keymaps({"h", "j", "k", "l", "<ENTER>", "<ESC>"})
    local bufnr = vim.api.nvim_get_current_buf()

    local function box_drawing_end()
        restore_keymaps(saved_keymaps, bufnr)
    end

    local keymap_opts = {
        buffer = bufnr,
        noremap = true,
        nowait = true,
    }
    vim.keymap.set(NORMAL, "h", function() box_drawing_move(LEFT) end, keymap_opts)
    vim.keymap.set(NORMAL, "j", function() box_drawing_move(DOWN) end, keymap_opts)
    vim.keymap.set(NORMAL, "k", function() box_drawing_move(UP) end, keymap_opts)
    vim.keymap.set(NORMAL, "l", function() box_drawing_move(RIGHT) end, keymap_opts)
    vim.keymap.set(NORMAL, "<ENTER>", box_drawing_end, keymap_opts)
    vim.keymap.set(NORMAL, "<ESC>", box_drawing_end, keymap_opts)
end

return {
    start = box_drawing_start,
}
