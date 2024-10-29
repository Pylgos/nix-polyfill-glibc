{
  stdenv,
  ninja,
  src,
}:

stdenv.mkDerivation (finalAttrs: {
  name = "polyfill-glibc";
  inherit src;
  nativeBuildInputs = [ ninja ];
  installPhase = ''
    mkdir -p $out/bin
    install -m755 polyfill-glibc $out/bin/polyfill-glibc
  '';
  checkPhase = ''
    ninja test
  '';
  doCheck = true;
})
