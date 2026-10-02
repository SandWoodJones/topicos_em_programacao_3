{
  pkgs,
  versao ? "1.0",
}:
let
  mkNome = nome: "projeto-${nome}-${versao}";
in
{
  # equivalente a `nome = "projeto-raul-${versao}"`;
  nome = mkNome "raul";
  compilador = pkgs.gcc;

  # equivalente a `versao = versao`;
  inherit versao;
}
