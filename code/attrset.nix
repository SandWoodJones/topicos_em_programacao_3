let
  projeto = {
    nome = "meu-projeto";
    versao = 1.0;
    estavel = true;
    deps = [
      "gcc"
      "make"
    ];
    meta = {
      licenca = "MIT";
    };
  };
in
projeto.meta.licenca
