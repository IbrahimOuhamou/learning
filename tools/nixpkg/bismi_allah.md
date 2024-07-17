بسم الله الرحمن الرحيم
la ilaha illa Allah Mohammed Rassoul Allah

how to build
$ `nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'`

build without sandboxing

$ `sudo nix-build --option sandbox false -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'`

