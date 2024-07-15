{ lib
, stdenv
, fetchgit
, zig_0_13
, csfml
}:

stdenv.mkDerivation {
  pname = "quran-warsh";
  version = "alpha-2";

  src = fetchgit {
    url = "https://github.com/muslimDevCommunity/quran-warsh.git";
    rev = "f7a60ad6e339196b9a9ac9803f16bd685f0c9c9f";
    hash = "sha256-QXqcFZVMIRPAISA3ezEsleK8oTmhVgb6TWGW6C6nPBc=";
  };

  nativeBuildInputs = [
    csfml
    zig_0_13.hook
  ];

  meta = with lib; {
    description = "warsh tajweed quran for desktop";
    homepage = "https://github.com/muslimDevCommunity/quran-warsh";
    # license = licenses.mit;
    mainProgram = "quran-warsh";
    inherit (zig_0_13.meta) platforms;
  };
}
