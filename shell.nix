{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    (texliveSmall.withPackages (ps: [ ps.latexmk ]))
    texlab
    ltex-ls-plus
    zathura
    tombi
  ];
}
