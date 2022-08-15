if $colorsname == 'onedark'
    let g:onedark_config = {
        \ 'style': 'darker',
    \}
     colorscheme onedark
    let g:lightline.colorscheme = 'onedark'
endif

" if $colorsname == 'gruvbox'
"     let g:gruvbox_italic=1
"     let g:lightline.colorscheme = 'gruvbox'
"     colorscheme gruvbox
" endif

if $colorsname == 'gruvbox-material'
  let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_enable_bold = 1
  let g:gruvbox_material_enable_italic = 1
  let g:gruvbox_material_better_performance = 1
  let g:gruvbox_material_diagnostic_text_highlight = 1
  colorscheme gruvbox-material
  let g:lightline.colorscheme = 'gruvbox_material'
endif

if $colorsname == 'sonokai'
  let g:sonokai_style = 'espresso'
  let g:sonokai_background = 'medium'
  let g:sonokai_enable_bold = 1
  let g:sonokai_enable_italic = 1
  let g:sonokai_better_performance = 1
  let g:sonokai_diagnostic_text_highlight = 1
  colorscheme sonokai
  let g:lightline.colorscheme = 'sonokai'
endif


" :hi CocCodeLens guifg=Lime
