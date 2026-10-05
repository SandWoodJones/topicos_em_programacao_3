let
  inherit (import <nixpkgs> { }) lib;
in
{
  n = builtins.length [ 1 2 3 ];

  # retorna uma lista ou uma lista vazia dependendo do booleano
  args = lib.optionals true [ "-v" ]; 
  # retorna uma string a partir de uma lista de strings
  txt = lib.concatStrings [ "a" "b" ];
  # retorna apenas os atributos que satisfazem o predicado
  attrs = lib.filterAttrs (n: v: v > 1) {
    a = 1;
    b = 2;
  }; 
}
