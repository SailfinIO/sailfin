; Win32 BOOLEAN ABI bridge for runtime/sfn/platform/fs_link_ops_windows.sfn.
; CreateSymbolicLinkA returns an unsigned 8-bit BOOLEAN, while Sailfin's
; scalar extern surface cannot spell an i8 return. Keep the real declaration
; here and expose an i32 zero-extension to the Sailfin-authored provider.

declare i8 @CreateSymbolicLinkA(i8*, i8*, i32)

define i32 @sfn_CreateSymbolicLinkA(i8* %link, i8* %target, i32 %flags) {
entry:
  %raw = call i8 @CreateSymbolicLinkA(i8* %link, i8* %target, i32 %flags)
  %wide = zext i8 %raw to i32
  ret i32 %wide
}
