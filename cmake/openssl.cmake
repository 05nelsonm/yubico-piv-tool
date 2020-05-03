macro (find_libcrypto)
    if(WIN32)
        if(NOT OpenSSL_FOUND)
            find_package(OpenSSL REQUIRED PATHS ${OPENSSL_ROOT_DIR})
            if(OpenSSL_FOUND)
                #set(LIBCRYPTO_LDFLAGS OpenSSL::Crypto)
                set(LIBCRYPTO_LDFLAGS crypto)
                set(LIBCRYPTO_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIR})
                set(LIBCRYPTO_VERSION ${OPENSSL_VERSION})
                set(LIBCRYPTO_LIBRARIES ${LIBCRYPTO_LIBRARIES} ${OPENSSL_LIBRARIES})

                if(VERBOSE_CMAKE)
                    message("LIBCRYPTO_LDFLAGS: ${LIBCRYPTO_LDFLAGS}")
                    message("LIBCRYPTO_INCLUDE_DIRS: ${LIBCRYPTO_INCLUDE_DIRS}")
                    message("LIBCRYPTO_VERSION: ${LIBCRYPTO_VERSION}")
                    message("LIBCRYPTO_LIBRARIES: ${LIBCRYPTO_LIBRARIES}")
                endif(VERBOSE_CMAKE)
            else(OpenSSL_FOUND)
                message (FATAL_ERROR "static libcrypto not found. Aborting...")
            endif(OpenSSL_FOUND)
        endif(NOT OpenSSL_FOUND)

    else(WIN32)

        if(NOT OpenSSL_FOUND)
            if(OPENSSL_STATIC_LINK)

                set(OPENSSL_USE_STATIC_LIBS TRUE) #Need to be set so that find_package would find the static library
                find_package(OpenSSL REQUIRED)
                if(OpenSSL_FOUND)
                    set(LIBCRYPTO_LDFLAGS OpenSSL::Crypto -ldl)

                    if(VERBOSE_CMAKE)
                        message("LIBCRYPTO_LDFLAGS: ${LIBCRYPTO_LDFLAGS}")
                        message("LIBCRYPTO_INCLUDE_DIRS: ${LIBCRYPTO_INCLUDE_DIRS}")
                        message("LIBCRYPTO_VERSION: ${LIBCRYPTO_VERSION}")
                        message("LIBCRYPTO_LIBRARIES: ${LIBCRYPTO_LIBRARIES}")
                    endif(VERBOSE_CMAKE)
                else(OpenSSL_FOUND)
                    message (FATAL_ERROR "static libcrypto not found. Aborting...")
                endif(OpenSSL_FOUND)

            else(OPENSSL_STATIC_LINK)

                    pkg_check_modules(LIBCRYPTO REQUIRED libcrypto)
                    if(LIBCRYPTO_FOUND)
                        if(VERBOSE_CMAKE)
                            message("LIBCRYPTO_FOUND: ${LIBCRYPTO_FOUND}")
                            message("LIBCRYPTO_LIBRARIES: ${LIBCRYPTO_LIBRARIES}")
                            message("LIBCRYPTO_LIBRARY_DIRS: ${LIBCRYPTO_LIBRARY_DIRS}")
                            message("LIBCRYPTO_LDFLAGS: ${LIBCRYPTO_LDFLAGS}")
                            message("LIBCRYPTO_LDFLAGS_OTHER: ${LIBCRYPTO_LDFLAGS_OTHER}")
                            message("LIBCRYPTO_INCLUDE_DIRS: ${LIBCRYPTO_INCLUDE_DIRS}")
                            message("LIBCRYPTO_CFLAGS: ${LIBCRYPTO_CFLAGS}")
                            message("LIBCRYPTO_CFLAGS_OTHER: ${LIBCRYPTO_CFLAGS_OTHER}")
                            message("LIBCRYPTO_VERSION: ${LIBCRYPTO_VERSION}")
                            message("LIBCRYPTO_INCLUDEDIR: ${LIBCRYPTO_INCLUDEDIR}")
                            message("LIBCRYPTO_LIBDIR: ${LIBCRYPTO_LIBDIR}")
                        endif(VERBOSE_CMAKE)
                    else(LIBCRYPTO_FOUND)
                        message (FATAL_ERROR "libcrypto not found. Aborting...")
                    endif(LIBCRYPTO_FOUND)

            endif(OPENSSL_STATIC_LINK)
        endif(NOT OpenSSL_FOUND)

        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${LIBCRYPTO_CFLAGS}")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${LIBCRYPTO_CFLAGS}")
        link_directories(${LIBCRYPTO_LIBRARY_DIRS})

     endif(WIN32)
#[[
        if(OPENSSL_STATIC_LINK)


        if(NOT OpenSSL_FOUND)
            set(OPENSSL_USE_STATIC_LIBS TRUE) #Need to be set so that find_package would find the static library
            find_package(OpenSSL REQUIRED)
            if(OpenSSL_FOUND)
                if(WIN32)
                    set(LIBCRYPTO_LDFLAGS OpenSSL::Crypto)
                else(WIN32)
                    set(LIBCRYPTO_LDFLAGS OpenSSL::Crypto -ldl)
                endif(WIN32)
                set(LIBCRYPTO_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIR})
                set(LIBCRYPTO_VERSION ${OPENSSL_VERSION})
                #set(LIBCRYPTO_LIBRARIES ${LIBCRYPTO_LIBRARIES} ${OPENSSL_LIBRARIES})

                if(VERBOSE_CMAKE)
                    message("LIBCRYPTO_LDFLAGS: ${LIBCRYPTO_LDFLAGS}")
                    message("LIBCRYPTO_INCLUDE_DIRS: ${LIBCRYPTO_INCLUDE_DIRS}")
                    message("LIBCRYPTO_VERSION: ${LIBCRYPTO_VERSION}")
                    message("LIBCRYPTO_LIBRARIES: ${LIBCRYPTO_LIBRARIES}")
                endif(VERBOSE_CMAKE)
            else(OpenSSL_FOUND)
                message (FATAL_ERROR "static libcrypto not found. Aborting...")
            endif(OpenSSL_FOUND)
        endif(NOT OpenSSL_FOUND)

    else(OPENSSL_STATIC_LINK OR WIN32)

        if(NOT LIBCRYPTO_FOUND)
            pkg_check_modules(LIBCRYPTO REQUIRED libcrypto)
            if(LIBCRYPTO_FOUND)
                if(VERBOSE_CMAKE)
                    message("LIBCRYPTO_FOUND: ${LIBCRYPTO_FOUND}")
                    message("LIBCRYPTO_LIBRARIES: ${LIBCRYPTO_LIBRARIES}")
                    message("LIBCRYPTO_LIBRARY_DIRS: ${LIBCRYPTO_LIBRARY_DIRS}")
                    message("LIBCRYPTO_LDFLAGS: ${LIBCRYPTO_LDFLAGS}")
                    message("LIBCRYPTO_LDFLAGS_OTHER: ${LIBCRYPTO_LDFLAGS_OTHER}")
                    message("LIBCRYPTO_INCLUDE_DIRS: ${LIBCRYPTO_INCLUDE_DIRS}")
                    message("LIBCRYPTO_CFLAGS: ${LIBCRYPTO_CFLAGS}")
                    message("LIBCRYPTO_CFLAGS_OTHER: ${LIBCRYPTO_CFLAGS_OTHER}")
                    message("LIBCRYPTO_VERSION: ${LIBCRYPTO_VERSION}")
                    message("LIBCRYPTO_INCLUDEDIR: ${LIBCRYPTO_INCLUDEDIR}")
                    message("LIBCRYPTO_LIBDIR: ${LIBCRYPTO_LIBDIR}")
                endif(VERBOSE_CMAKE)
            else(LIBCRYPTO_FOUND)
                message (FATAL_ERROR "libcrypto not found. Aborting...")
            endif(LIBCRYPTO_FOUND)
        endif(NOT LIBCRYPTO_FOUND)
        set(OPENSSL_VERSION ${LIBCRYPTO_VERSION})

    endif(OPENSSL_STATIC_LINK OR WIN32)

    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${LIBCRYPTO_CFLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${LIBCRYPTO_CFLAGS}")
    link_directories(${LIBCRYPTO_LIBRARY_DIRS})
]]
endmacro()