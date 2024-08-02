# بسم الله الرحمن الرحيم
# la ilaha illa Allah Mohammed Rassoul Allah
{ lib
, stdenv
, fetchgit
, zig
, csfml
}:

stdenv.mkDerivation {
  pname = "quran-warsh";
  version = "alpha-2";

  src = fetchgit {
    url = "https://github.com/muslimDevCommunity/quran-warsh.git";
    rev = "f7a60ad6e339196b9a9ac9803f16bd685f0c9c9f";
    hash = "sha256-QXqcFZVMIRPAISA3ezEsleK8oTmhVgb6TWGW6C6nPBc=";
    postFetch = ''
      zig build --fetch
    '';
  };

  nativeBuildInputs = [
    csfml
    zig.hook
  ];

  meta = with lib; {
    description = "warsh tajweed quran for desktop";
    homepage = "https://github.com/muslimDevCommunity/quran-warsh";
    # license = licenses.mit;
    mainProgram = "quran-warsh";
    inherit (zig.meta) platforms;
  };
}
