{ stdenv, fetchsvn, gmt, autoconf, gfortran, libtiff, hdf5, liblapack
}:

stdenv.mkDerivation rec {
  version = "5.3";
  name = "gmt-${version}";
  
  src = fetchsvn  {
  url = "svn://gmtserver.soest.hawaii.edu/GMT5SAR/tags/${version}";
  sha256 = "18mpfdwr6zdxcd54z7vcq3fcfj7hycxnz8s4mwz3zafqkcbs58cf";
    };

  buildInputs = [ autoconf gmt gfortran libtiff hdf5 liblapack ];
  preConfigure = "autoconf";
  

  configureFlags=[
    "--with-orbits-dir=/home/laure/GRICAD/MyDevel/orbits"
    "--with-hdf5=${hdf5}"
    "--with-tiff-lib=${libtiff}"
    "--with-gmt-config=${gmt}"
    "--with-lapack=${liblapack}"];

  meta = {
    description     =  "An InSAR processing system based on GMT";
    longDescription = ''
      GMTSAR is an open source (GNU General Public License) InSAR 
      processing system designed for users familiar with Generic 
      Mapping Tools (GMT).
    '';
    homepage        = http://topex.ucsd.edu/gmtsar/;
    license         = stdenv.lib.licenses.glp3Plus;
    maintainers     = [ stdenv.lib.maintainers.ltavard ];
    platforms       = stdenv.lib.platforms.linux;
  };
}

