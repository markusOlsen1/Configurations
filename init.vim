if exists('g:vscode')
    " TODO there is a more contemporary version of this file
    "VSCode
    function! s:split(...) abort
        let direction = a:1
        let file = a:2
        call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
        if file != ''
            call VSCodeExtensionNotify('open-file', expand(file), 'all')
        endif
    endfunction
    
    function! s:splitNew(...)
        let file = a:2
        call s:split(a:1, file == '' ? '__vscode_new__' : file)
    endfunction
    
    function! s:closeOtherEditors()
        call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
        call VSCodeNotify('workbench.action.closeOtherEditors')
    endfunction
    
    function! s:manageEditorSize(...)
        let count = a:1
        let to = a:2
        for i in range(1, count ? count : 1)
            call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
        endfor
    endfunction
    
    command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
    command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
    command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
    command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
    command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif
    
    nnoremap <silent> <C-w>s :call <SID>split('h')<CR>
    xnoremap <silent> <C-w>s :call <SID>split('h')<CR>
    
    nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
    nnoremap <silent> <C-w>v :call <SID>split('v')<CR>
    xnoremap <silent> <C-w>v :call <SID>split('v')<CR>
    
    nnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>
    xnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>
    
    
    nnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
    xnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
    
    nnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    nnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>

    " Better Navigation
    nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
    xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
    
    " Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
    xnoremap <silent> <C-/> :call Comment()<CR>
    nnoremap <silent> <C-/> :call Comment()<CR>
    
    nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>
    
    nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
    xnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
else
    lua require "user.copilot"
    lua require "user.transparent"
    lua require "user.plugins"
    lua require "user.colorscheme"
    lua require "user.cmp"
    lua require "user.lsp"
    lua require "user.telescope"
    lua require "user.gitsigns"
    lua require "user.treesitter"
    lua require "user.autopairs"
    lua require "user.nvim-tree"
    lua require "user.bufferline"
    lua require "user.lualine"
    lua require "user.toggleterm"
    lua require "user.project"
    lua require "user.impatient"
    lua require "user.indentline"
    lua require "user.autocommands"
    lua require "user.options"
    lua require "user.keymaps"
    lua require "user.comment"
    lua require "user.whichkey"
endif
