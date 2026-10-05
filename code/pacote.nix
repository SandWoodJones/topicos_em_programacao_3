{ lib, fetchFromGitHub, rustPlatform, pkg-config, pcre2 }:
rustPlatform.buildRustPackage {
  pname = "ripgrep";
  version = "14.1.1";

  src = fetchFromGitHub {
    owner = "BurntSushi";
    repo = "ripgrep";
    hash = "sha256-...";
    rev = "14.1.1";
  };

  # ferramentas usadas durante a build
  nativeBuildInputs = [ pkg-config ];
  # bibliotecas ligadas ao binário
  buildInputs = [ pcre2 ];

  meta.license = lib.licenses.mit;
}
