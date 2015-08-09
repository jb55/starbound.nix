{ stdenv
, xlibs
, mesa_glu
, fetchurl
, SDL
, qt5
, unzip
}:

let bins = [ "launcher"
             "asset_packer"
             "asset_unpacker"
             "dump_versioned_json"
             #"launcher"
             "make_versioned_json"
             "planet_mapgen"
             "starbound"
             "starbound_server"
           ];
    files = [ "launch_launcher.sh"
              "make_versioned_json"
              "platforms"
              "sbboot.config"
            ];

    concat = xs: stdenv.lib.strings.concatStringsSep " " xs;
in stdenv.mkDerivation rec {
  version = "1.0";
  name = "starbound-${version}";

  src = ./.;

  libPath = stdenv.lib.makeLibraryPath (with xlibs; [
    libX11
    libXext
    SDL
    mesa_glu
  ]);

  # buildInputs = [ unzip ];
  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin

    for bin in ${concat bins}; do
      cp $bin $out/bin/$bin.bin
    done

    for file in ${concat files}; do
      cp -r $file $out/bin
    done

    for bin in ${concat bins}; do
      patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
               --set-rpath $libPath $out/bin/$bin.bin
    done
  '';

  meta = with stdenv.lib; {
    description = "extraterrestrial sandbox adventure game";
    homepage = http://playstarbound.com/;
    license = licenses.unfree;
    maintainers = with maintainers; [ jb55 ];
  };
}
