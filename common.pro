
# Common project definitions for LibreCAD. This file gets
# included from the various *.pro files.


win32 {

    # Use Boost on Windows.

    # Where boost is installed (should have headers in ./boost/ and
    # libraries in ./lib/
    BOOST_DIR = C:/Programme/boost/boost_1_47

    # BOOST_LIBS may specifiy boost import libraries (this are the libraries
    # without the `lib` prefix, which have a corresponding `.dll` file!).
    # They are only needed when dynamically linking against boost, otherwise 
    # leave it empty and the autolink process will take care of linking to
    # the correct (static) boost library. (Most of the boost components are 
    # header-only anyway.)
    # 
    # For example: `BOOST_LIBS = -lboost_regex-vc71-mt-1_47.lib`
    BOOST_LIBS = 

    # Make boost known to compiler and linker.
    # This should also work on other platforms (but BOOST_LIBS may need
    # to be set to the required boost *.sl/*.so/*.dylib/*.a).
    boost {
        DEFINES += HAS_BOOST
        INCLUDEPATH += $${BOOST_DIR}
        LIBS += -L$${BOOST_DIR}/lib $${BOOST_LIBS}
    }

    # On windows, check for MSVC compilers - they need help on C99 
    # features and a hint to povide M_PI et al.
    win32-msvc.net|win32-msvc2003|win32-msvc2005|win32-msvc2008|win32-msvc2010 {
       !build_pass:verbose:message(Setting up support for MSVC.)
       DEFINES += EMU_C99 _USE_MATH_DEFINES
    }

    win32-msvc2003 {
       # Silence "unused formal parameter" warnings about unused `_Iosbase` 
       # in the header file `xloctime` (a Vc7 header!).
       QMAKE_CXXFLAGS += /wd4100
    }
}
