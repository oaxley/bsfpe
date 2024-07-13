#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    System patch

#----- public functions

#.--
#.1 Create a Unix patch
#.2 (old_file){The source file before the modifications.}
#.2 (new_file){The source file after the modifications.}
#.3 (output){The output file that will contain the patch.}
#.3H Create a Unix patch by comparing the \fBold_file\fR and \fBnew_file\fR.
#.3F At the end, the \fBoutput\fR file can be distributed to patch replicates of \fBold_file\fR.
#.4 Create a patch from main.c with main.c.new
#.4 $ system::patch_create main.c main.c.new main.c.patch
#.--
system::patch_create() {
  diff -u "$1" "$2" > "$3"
}

#.--
#.1 Apply a patch to a file
#.2 (source){The source file to be patched.}
#.2 (patch){The patch to apply.}
#.3H Apply the patch to \fBsource\fR, effectively modifying it.
#.3F The original file is overwritten.
#.4 Apply the patch to 'main.c'
#.4 $ system::patch_apply main.c main.c.patch
#.--
system::patch_apply() {
  patch -p1 "$1" < "$2"
}

#.--
#.1 Revert a patch from a file
#.2 (source){The source file to be reverted.}
#.2 (patch){The patch to apply.}
#.3H Apply the patch to \fBsource\fR, effectively modifying it.
#.3F The original file is overwritten.
#.4 Revert the patch to 'main.c'
#.4 $ system::patch_revert main.c main.c.patch
#.--
system::patch_revert() {
  patch -R -p1 "$1" < "$2"
}

