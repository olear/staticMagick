#!/bin/sh
CWD=`pwd`
INSTALL_PATH=$CWD/build
TMP_PATH=$CWD/tmp
MKJOBS=4
BF="-fPIC"

rm -rf $INSTALL_PATH $TMP_PATH || true
mkdir -p $TMP_PATH $INSTALL_PATH || exit 1
export PKG_CONFIG_PATH=$INSTALL_PATH/lib/pkgconfig

cd $CWD/zlib || exit 1
make distclean
env CFLAGS="$BF" CXXFLAGS="$BF" CPPFLAGS="-I${INSTALL_PATH}/include" LDFLAGS="-L${INSTALL_PATH}/lib" ./configure --prefix=$INSTALL_PATH --libdir=$INSTALL_PATH/lib || exit 1
make -j${MKJOBS} || exit 1
make install || exit 1
rm -f $INSTALL_PATH/lib/libz*.so* $INSTALL_PATH/lib/libz*.dy*

cd $CWD/libpng || exit 1
autoreconf -fi
make distclean
env CFLAGS="$BF" CXXFLAGS="$BF" CPPFLAGS="-I${INSTALL_PATH}/include" LDFLAGS="-L${INSTALL_PATH}/lib" ./configure --prefix=$INSTALL_PATH --libdir=$INSTALL_PATH/lib --disable-shared --enable-static || exit 1
make -j${MKJOBS} || exit 1
make install || exit 1

cd $CWD/libjpeg || exit 1
autoreconf -fi
make distclean
env CFLAGS="$BF" CXXFLAGS="$BF" ./configure --prefix=$INSTALL_PATH --libdir=$INSTALL_PATH/lib --with-jpeg8 --disable-shared --enable-static || exit 1
make -j${MKJOBS} || exit 1
make install || exit 1

cd $CWD/libtiff || exit 1
env CFLAGS="$BF" CXXFLAGS="$BF" CPPFLAGS="-I${INSTALL_PATH}/include" LDFLAGS="-L${INSTALL_PATH}/lib" ./configure --prefix=$INSTALL_PATH --libdir=$INSTALL_PATH/lib --disable-shared --enable-static --disable-lzma || exit 1
make -j${MKJOBS} || exit 1
make install || exit 1

cd $CWD/lcms || exit 1
env CFLAGS="$BF" CXXFLAGS="$BF" CPPFLAGS="-I${INSTALL_PATH}/include" LDFLAGS="-L${INSTALL_PATH}/lib" ./configure --prefix=$INSTALL_PATH --libdir=$INSTALL_PATH/lib --disable-shared --enable-static || exit 1
make -j${MKJOBS} || exit 1
make install || exit 1

cd $CWD/magick || exit 1
make distclean
env CFLAGS="$BF" CXXFLAGS="$BF" CPPFLAGS="-I${INSTALL_PATH}/include" LDFLAGS="-L${INSTALL_PATH}/lib -ljpeg -lz -lm" ./configure --prefix=$INSTALL_PATH --with-magick-plus-plus=yes --with-quantum-depth=32 --without-dps --without-djvu --without-fftw --without-fpx --without-gslib --without-gvc --without-jbig --with-jpeg --with-lcms --without-openjp2 --without-lqr --without-lzma --without-openexr --without-pango --with-png --without-rsvg --with-tiff --without-webp --without-xml --with-zlib --without-bzlib --enable-static --disable-shared --enable-hdri --without-freetype --without-fontconfig --without-modules --disable-docs --without-x || exit 1 
make -j${MKJOBS} || exit 1
make install || exit 1

