{
	pkgs,
	versao ? "1.0"
}:
{
	nome = "meu-projeto";
	compilador = pkgs.gcc;

  # equivalente a `versao = versao';
	inherit versao;
}
