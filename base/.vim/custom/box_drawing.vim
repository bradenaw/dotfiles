python3 <<EOF
import vim

UP = '╵'
RIGHT = '╶'
DOWN = '╷'
LEFT = '╴'

#     ┌─────────╴display
#     │     ┌───╴up?
#     │     │┌──╴right?
#     │     ││┌─╴down?
#     │     │││┌╴left?
#     │     ││││
m = [
    (' ', 0b0000),
    ('╵', 0b1000),
    ('╶', 0b0100),
    ('╷', 0b0010),
    ('╴', 0b0001),
    ('│', 0b1010),
    ('─', 0b0101),
    ('┌', 0b0110),
    ('┐', 0b0011),
    ('└', 0b1100),
    ('┘', 0b1001),
    ('├', 0b1110),
    ('┬', 0b0111),
    ('┤', 0b1011),
    ('┴', 0b1101),
    ('┼', 0b1111),
]

char_to_bits = {char: bits for (char, bits) in m}
bits_to_char = {bits: char for (char, bits) in m}

def __box_add(a, b):
    if a not in char_to_bits:
        a = " "
    if b not in char_to_bits:
        b = " "
    return bits_to_char[char_to_bits[a] | char_to_bits[b]]

def __cursor_add(c):
    vim.command("normal! r" + __box_add(__get_cursor_char(), c))

def __get_cursor_char():
    (row, col) = vim.current.window.cursor
    return __get_char(row, col)

def __get_char(row, col):
    return vim.eval("matchstr(getline(" + str(row) + "), '\%" + str(col+1) + "c.')")

def __move(direction):
    (row, col) = vim.current.window.cursor

def __col():
    return int(vim.eval("virtcol('.')"))


def box_drawing_move(direction):
    __cursor_add(direction)
    if direction == UP:
        before_col = __col()
        vim.command("normal! k")
        after_col = __col()
        if after_col < before_col:
            vim.command("normal! " + str(before_col - after_col) + "a ")
        __cursor_add(DOWN)
    elif direction == RIGHT:
        before_col = vim.current.window.cursor[1]
        vim.command("normal! l")
        after_col = vim.current.window.cursor[1]
        if before_col == after_col:
            vim.command("normal! a ")
        __cursor_add(LEFT)
    elif direction == DOWN:
        before_col = __col()
        vim.command("normal! j")
        after_col = __col()
        if after_col < before_col:
            vim.command("normal! " + str(before_col - after_col) + "a ")
        __cursor_add(UP)
    elif direction == LEFT:
        vim.command("normal! h")
        __cursor_add(RIGHT)
EOF

" https://vi.stackexchange.com/questions/7734/how-to-save-and-restore-a-mapping
fu! SaveMappings(keys, mode, global) abort
    let mappings = {}

    if a:global
        for l:key in a:keys
            let buf_local_map = maparg(l:key, a:mode, 0, 1)

            sil! exe a:mode.'unmap <buffer> '.l:key

            let map_info        = maparg(l:key, a:mode, 0, 1)
            let mappings[l:key] = !empty(map_info)
                                \     ? map_info
                                \     : {
                                        \ 'unmapped' : 1,
                                        \ 'buffer'   : 0,
                                        \ 'lhs'      : l:key,
                                        \ 'mode'     : a:mode,
                                        \ }

            call RestoreMappings({l:key : buf_local_map})
        endfor

    else
        for l:key in a:keys
            let map_info        = maparg(l:key, a:mode, 0, 1)
            let mappings[l:key] = !empty(map_info)
                                \     ? map_info
                                \     : {
                                        \ 'unmapped' : 1,
                                        \ 'buffer'   : 1,
                                        \ 'lhs'      : l:key,
                                        \ 'mode'     : a:mode,
                                        \ }
        endfor
    endif

    return mappings
endfu
fu! RestoreMappings(mappings) abort

    for mapping in values(a:mappings)
        if !has_key(mapping, 'unmapped') && !empty(mapping)
            exe     mapping.mode
               \ . (mapping.noremap ? 'noremap   ' : 'map ')
               \ . (mapping.buffer  ? ' <buffer> ' : '')
               \ . (mapping.expr    ? ' <expr>   ' : '')
               \ . (mapping.nowait  ? ' <nowait> ' : '')
               \ . (mapping.silent  ? ' <silent> ' : '')
               \ .  mapping.lhs
               \ . ' '
               \ . substitute(mapping.rhs, '<SID>', '<SNR>'.mapping.sid.'_', 'g')

        elseif has_key(mapping, 'unmapped')
            sil! exe mapping.mode.'unmap '
                                \ .(mapping.buffer ? ' <buffer> ' : '')
                                \ . mapping.lhs
        endif
    endfor

endfu

function! BoxDrawingEnd()
    call RestoreMappings(g:box_drawing_saved_mappings)
    let g:box_drawing_saved_mappings = {}
endfunction

function! BoxDrawingStart()
    let g:box_drawing_saved_mappings = SaveMappings(['h', 'j', 'k', 'l', '<ENTER>', '<ESC>'], 'n', 1)
    nnoremap h :python3 box_drawing_move(LEFT)<cr>
    nnoremap j :python3 box_drawing_move(DOWN)<cr>
    nnoremap k :python3 box_drawing_move(UP)<cr>
    nnoremap l :python3 box_drawing_move(RIGHT)<cr>
    nnoremap <ENTER> :call BoxDrawingEnd()<cr>
    nnoremap <ESC> :call BoxDrawingEnd()<cr>
endfunction

command! -nargs=0 BoxDrawingStart call BoxDrawingStart()
