{ config, lib, ...}:
let cfg = config.services.ola; in
{
  # interface do módulo
  options.services.ola = {
    enable = lib.mkEnableOption "serviço olá";
    saudacao = lib.mkOption {
      type = lib.types.str;
      default = "mundo";
      description = "uma opção";
      example = "povo";
    };
  };
  # só aplicado se a opção for habilitada
  config = lib.mkIf cfg.enable {
    systemd.services.ola.script = ''
      echo "ola, ${cfg.saudacao}"
    '';
  };
}
