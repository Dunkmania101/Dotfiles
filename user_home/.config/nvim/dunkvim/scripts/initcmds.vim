function! BufAbsPath()
  return expand('%:p:h')
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

command! Reload source $dunkvimdir/init.vim

function! InstallLspServers()
    :LspInstall java
    :LspInstall python
    :LspInstall json
    :LspInstall html
    :LspInstall css
    :LspInstall typescript
    :LspInstall dockerfile
    :LspInstall vim
    :LspInstall yaml
    :LspInstall lua
    :LspInstall haskell
    :LspInstall bash
    :LspInstall cpp
    :LspInstall csharp
    :LspInstall cmake
    :LspInstall latex
    :LspInstall rust
endfunction

command! InstallLspServers call InstallLspServers()
command! SetupLspServers lua setup_servers()

