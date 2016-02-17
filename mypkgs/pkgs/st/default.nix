{ stdenv, fetchurl, pkgconfig, writeText, libX11, ncurses, libXext, libXft, fontconfig}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "st-0.6";

  src = fetchurl {
    url = "http://dl.suckless.org/st/${name}.tar.gz";
    sha256 = "0avsfc1qp8zvshsfjwwrkvk411jlqy58z225bsdhjkl1qc40qcc5";
  };

  configFile = ./config.def.h;
  preBuild = "cp ${configFile} config.def.h";

  buildInputs = [ pkgconfig libX11 ncurses libXext libXft fontconfig ];

  NIX_LDFLAGS = "-lfontconfig";

  installPhase = ''
    TERMINFO=$out/share/terminfo make install PREFIX=$out
  '';

  meta = {
    homepage = http://st.suckless.org/;
    license = stdenv.lib.licenses.mit;
    maintainers = with maintainers; [viric];
    platforms = platforms.linux;
  };
}
