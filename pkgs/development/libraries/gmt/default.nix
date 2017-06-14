{ stdenv, fetchurl, cmake, ghostscript, netcdf, gdal, pcre, zlib, curl, fftwFloat, bash}:

stdenv.mkDerivation rec {
  version = "5.4.1";
  name = "gmt-${version}";

  src = fetchurl {
    url = "ftp://ftp.soest.hawaii.edu/gmt/${name}-src.tar.gz";
    sha256 = "1c1szykyxa98cdyzfkb8vnb5p6b9pf4b9vajjn0g19b31gal2mf8";
  };
  
  buildInputs = [ cmake netcdf gdal pcre zlib curl fftwFloat bash ];

  #patches = [ ./wrapper.patch ];

  #configureFlags=''
  #  export DCW_PATH=""
  #  export GSHHG_PATH=""
  #'';

  #preInstallPhase=''
  #  
  #'';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=RelWithDebInfo"
    "-DCMAKE_C_FLAGS=-fstrict-aliasing"
    #"-DDCW_ROOT=DCW_DIR"
    #"-DGSHHG_ROOT=$GSHHG_DIR"
    "-DNETCDF_ROOT=${netcdf}"
    "-DGDAL_ROOT=${gdal}"
    "-DPCRE_ROOT=${pcre}"
    "-DGMT_INSTALL_MODULE_LINKS=off"
    "-DGMT_INSTALL_TRADITIONAL_FOLDERNAMES=off"
    "-DLICENSE_RESTRICTED=LGPL" # or -DLICENSE_RESTRICTED=no to include non-free code
    "-DFFTW3_ROOT=${fftwFloat}"];
  
  enableParallelBuilding = true;
    
  meta = {
    description     =  "The Generic Mapping Tools";
    longDescription = '' 
      and Cartesian data sets and producing PostScript illustrations ranging from 
      simple x-y plots via contour maps to artificially illuminated surfaces and 
      3D perspective views.
      '';
    homepage        = http://gmt.soest.hawaii.edu/;
    # License: GPL-3+, LGPL-3+, or Restrictive depending on LICENSE_RESTRICTED setting
    license         = with stdenv.lib.licenses; [ lgpl3Plus gpl3Plus ];
    maintainers     = [ stdenv.lib.maintainers.ltavard ];
    platforms       = stdenv.lib.platforms.linux;
  };
}

