# idris-libsel4-ffi
An Idris FFI to the libsel4 library

# How to use this library?

See the instructions in the project repository, [sel4-idris-manifest](https://github.com/mokshasoft/sel4-idris-manifest).

# Configuration with [m4](https://www.gnu.org/software/m4/m4.html)

I have selected the m4 macro processor to preprocess the Idris files. The seL4 build system generates an autoconf.h that tells which parts of the kernel that are enabled. The Idris FFI needs to only include the FFI functions that are available in the current kernel build.

# Contribution

Contributions are very welcome! Before creating a pull request, please make sure that at least the following works without errors:

- git diff --check
- The example apps compile and run in the sel4-idris-manifest project.

# Developed by [mokshasoft.com](http://www.mokshasoft.com/)
