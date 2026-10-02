$pdf_mode = 1;
$pdf_previewer = 'start zathura';
$max_repeat = 8;

add_cus_dep('nix', 'nixtex', 0, 'pygmentize_nix');
sub pygmentize_nix {
	return system("pygmentize -f latex -l nix -o \"$_[0].nixtex\" \"$_[0].nix\"");
}
