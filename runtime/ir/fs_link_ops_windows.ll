; Win32 BOOLEAN ABI bridge for runtime/sfn/platform/fs_link_ops_windows.sfn.
; CreateSymbolicLinkA returns an unsigned 8-bit BOOLEAN, while Sailfin's
; scalar extern surface cannot spell an i8 return. Keep the real declaration
; here and expose an i32 zero-extension to the Sailfin-authored provider.

target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

declare i8 @CreateSymbolicLinkA(i8*, i8*, i32)

define i32 @sfn_CreateSymbolicLinkA(i8* %link, i8* %target, i32 %flags) #0 {
entry:
  %raw = call i8 @CreateSymbolicLinkA(i8* %link, i8* %target, i32 %flags)
  %wide = zext i8 %raw to i32
  ret i32 %wide
}

attributes #0 = { uwtable(sync) "approx-func-fp-math"="false" "frame-pointer"="none" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "target-cpu"="x86-64" "target-features"="" "unsafe-fp-math"="false" }
