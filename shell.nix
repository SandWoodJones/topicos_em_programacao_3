{
  pkgs ? import <nixpkgs> { },
}:
let
  ltexSettings = pkgs.writeText "ltex.json" (
    builtins.toJSON {
      ltex = {
        language = "pt-BR";
        dictionary."pt-BR" = [
          "Nix"
          "NixOS"
          "Nixpkgs"
          "nixpkgs"
          "DSL"
          "declarativo"
          "reprodutibilidade"
          "script"
          "shell"
        ];
        disabledRules."pt-BR" = [ "PT_BARBARISMS_REPLACE_SCRIPT" ];
        latex.commands = {
          "\\en{}" = "dummy";
          "\\termo{}" = "default";
          "\\code{}" = "ignore";
          "\\usetheme{}" = "ignore";
          "\\usecolortheme{}" = "ignore";
          "\\setbeamertemplate{}{}" = "ignore";
        };
      };
    }
  );

  ltex-ls-wrapped = pkgs.writeShellScriptBin "ltex-ls-wrapped" ''
    export LTEX_SETTINGS=${ltexSettings}
    export LTEX_SERVER=${pkgs.ltex-ls-plus}/bin/ltex-ls-plus
    exec ${pkgs.lib.getExe pkgs.python3} ${./ltex-wrapper.py} "$@"
  '';
in
pkgs.mkShell {
  packages = with pkgs; [
    (texliveSmall.withPackages (ps: [ ps.latexmk ]))
    texlab
    ltex-ls-wrapped
    zathura
    tombi
  ];
}
