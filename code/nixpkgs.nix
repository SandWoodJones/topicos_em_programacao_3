let
  pkgs = import <nixpkgs> { };
in {
  programa = pkgs.hello;
  versao = pkgs.hello.version;
  derivacao = pkgs.hello.type;
}
