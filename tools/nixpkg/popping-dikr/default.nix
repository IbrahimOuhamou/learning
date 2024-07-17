# بسم الله الرحمن الرحيم
# la ilaha illa Allah Mohammed Rassoul Allah
{ lib
, stdenv
, fetchgit
, zig_0_13
, SDL2
, SDL2_ttf
, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "popping-dikr";
  version = "1.1.1";

  src = fetchgit {
    url = "https://github.com/muslimDevCommunity/PoppingDikr.git";
    #url = "https://github.com/IbrahimOuhamou/popping-dikr.git";
    rev = "3c642eb2ba5bf057db37b5a5b385e1ca79673ee2";
    hash = "sha256-EJAcR04A4SEXE7VaCWW0xvGtxSWtNrrofrRHj5Gi+E0=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    pkg-config
    SDL2.dev
    SDL2_ttf
    zig_0_13.hook
  ];

  postInstallPhase = ''
    mv $out/dikr $out/${pname}
    mv zig-out/bin/settings $out/${pname}-settings
  '';

  meta = with lib; {
    description = "Dikr app that shows itself every now and then";
    homepage = "https://github.com/muslimDevCommunity/PoppingDikr";
    # license = licenses.mit;
    mainProgram = "popping-dikr";
    inherit (zig_0_13.meta) platforms;
  };
}
