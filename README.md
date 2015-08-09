# starbound.nix

Get Starbound working in NixOS

This is a giant hack, but I can't think of a better way.

If you can please submit an issue and let me know.

## Instructions

1. install steam

2. install Starbound with steam

3. copy `default.nix` into `$HOME/.local/share/Steam/steamapps/common/Starbound/linux64`

4. cd into `$HOME/.local/share/Steam/steamapps/common/Starbound/linux64`

5. run `nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'`

6. install the resulting build like so: 

```bash
nix-env -i /nix/store/<hash>-starbound-1.0
```

replacing the path with the one from the result of `nix-build`

7. copy and paste this into a `starbound` script in your `$PATH`:

```bash
#!/usr/bin/env bash
cd $HOME/.local/share/Steam/steamapps/common/Starbound/linux64
starbound.bin
```       

8. launch starbound by typing `starbound` from a launcher or your shell
