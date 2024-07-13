{ lib
, stdenv
, fetchgit
, zig_0_13
, SDL2
, SDL2_ttf
, pkg-config
}:

stdenv.mkDerivation {
  pname = "popping-dikr";
  version = "1.1";

  src = fetchgit {
    #url = "https://github.com/muslimDevCommunity/PoppingDikr.git";
    url = "https://github.com/IbrahimOuhamou/popping-dikr.git";
    rev = "4104624a12e10da04e1f880fd0377416e3d2f6da";
    hash = "sha256-WyJJV2HKQnZvIVvlfhZvAt8UyZ4+54rZ+gQJGiLYG+Q=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    pkg-config
    SDL2.dev
    SDL2_ttf
    zig_0_13.hook
  ];

  meta = with lib; {
    description = "Dikr app that shows itself every now and then";
    homepage = "https://github.com/muslimDevCommunity/PoppingDikr";
    # license = licenses.mit;
    mainProgram = "popping-dikr";
    inherit (zig_0_13.meta) platforms;
  };
}
