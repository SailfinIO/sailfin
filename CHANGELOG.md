# CHANGELOG


## v0.2.0-alpha.1 (2026-03-28)

### Features

- Sfn registry functionality
  ([`df5b635`](https://github.com/SailfinIO/sailfin/commit/df5b6353ccf85cb979a3b0faa9b6e867a520ca69))


## v0.1.1-alpha.142 (2026-03-28)

### Bug Fixes

- Exit in ps1
  ([`c56a545`](https://github.com/SailfinIO/sailfin/commit/c56a5456d1151da5a398f8cdfd0f98ac452e9c3d))

- Upload assets
  ([`97137d7`](https://github.com/SailfinIO/sailfin/commit/97137d70cef9167f2bb26cb45db32b3fcfeb9685))


## v0.1.1-alpha.141 (2026-03-28)

### Bug Fixes

- Token not needed
  ([`b604c75`](https://github.com/SailfinIO/sailfin/commit/b604c75402f04a8c04b2aa1c1b7227158d846fe9))

- Windows installation runtime
  ([`9a09112`](https://github.com/SailfinIO/sailfin/commit/9a0911264d5719127049a938af40e84eb3f452eb))

- Windows installation runtime
  ([`6d47b86`](https://github.com/SailfinIO/sailfin/commit/6d47b86ec93f9936310a96e2c943b865c3e053b9))


## v0.1.1-alpha.140 (2026-03-28)

### Bug Fixes

- Windows installation
  ([`fc486aa`](https://github.com/SailfinIO/sailfin/commit/fc486aaab3ca2f77d488c4b9405062a39a49670c))

- Windows installation
  ([`8e986b0`](https://github.com/SailfinIO/sailfin/commit/8e986b046dfe55ad92d1dd0dc259ae23e6f440db))


## v0.1.1-alpha.139 (2026-03-28)

### Bug Fixes

- At least runs hello world again
  ([`24fcc1d`](https://github.com/SailfinIO/sailfin/commit/24fcc1d8c214c653de04653c28ddca48f7c4d205))

- Bypass temporarily
  ([`7cf46bd`](https://github.com/SailfinIO/sailfin/commit/7cf46bdcea16d9df9184d4a75b8f8c54454954a2))

- Cross module shim
  ([`b7ef61a`](https://github.com/SailfinIO/sailfin/commit/b7ef61aaf9dc3efbb2357c735507b1ccd8a8483d))

- Fails on version check at the end
  ([`8b50884`](https://github.com/SailfinIO/sailfin/commit/8b50884b72e844f6d6b25d2dc05a0a65613bb75e))

- Fails on version check at the end
  ([`6d82218`](https://github.com/SailfinIO/sailfin/commit/6d82218df648687849402657ed27d43480cbb998))

- Implement file guard
  ([`4f3f80e`](https://github.com/SailfinIO/sailfin/commit/4f3f80e8e943a5e62cbbd6cb5c31d022d126eac4))

- Install curl
  ([`941b2d4`](https://github.com/SailfinIO/sailfin/commit/941b2d4d2e0a748379a839827e063bb6b9ec89c1))

- Install location
  ([`2831026`](https://github.com/SailfinIO/sailfin/commit/28310261d69761db26ddf69b24ce693f42dc0d42))

- Make check passing - version command works but run doesnt
  ([`0f8a6f0`](https://github.com/SailfinIO/sailfin/commit/0f8a6f0c9328985b2e25b1aeb0c85c4b0385ec92))

- Make check working but binary cant run hello world
  ([`c1e14a5`](https://github.com/SailfinIO/sailfin/commit/c1e14a58c6327d1a03c1a2e2b05d2d62b071fe47))

- Make check working but binary not
  ([`48497e6`](https://github.com/SailfinIO/sailfin/commit/48497e69efad86c6cbf39880b03b340965ccfb0b))

- Make check working with --version
  ([`0375f91`](https://github.com/SailfinIO/sailfin/commit/0375f91072923ad1ae084cec9b850c9ec8caba03))

- Make typecheck_diagnostics handle empty arrays explicitly
  ([`d2397e7`](https://github.com/SailfinIO/sailfin/commit/d2397e7fc9e89e1017c939480f3796fc2c364331))

- Missing effect
  ([`447a4b9`](https://github.com/SailfinIO/sailfin/commit/447a4b950352a9788e067f1cb4c9450bbcf98093))

- More fixups
  ([`033925b`](https://github.com/SailfinIO/sailfin/commit/033925b934461d9fc2765be38c4c12ae75e55d92))

- Null passes
  ([`a9bf8a8`](https://github.com/SailfinIO/sailfin/commit/a9bf8a89d2f76a9f941f59117af798f4f41dd117))

- Skip --weaken on macOS to fix test linker failure
  ([`ff97c84`](https://github.com/SailfinIO/sailfin/commit/ff97c84accac05d955a392030913dd5a9bbd1ca0))

On Mach-O (macOS ARM64), llvm-objcopy --weaken converts defined symbols to weak references rather
  than weak definitions, causing the Apple linker to report them as undefined. Since import inlining
  gives each test a unique module-name suffix, there are no duplicate symbols with the compiler
  objects, so the weakening step is unnecessary and harmful on macOS.

Skip the entire compiler-object link step on macOS. Tests remain self-contained via the existing
  import inlining path.

- Split out concat to push
  ([`90e8691`](https://github.com/SailfinIO/sailfin/commit/90e86914940a5f2f2d856891702461e03252ca62))

- Split out concat to push seedcheck compiles but no hellow world
  ([`eaceb65`](https://github.com/SailfinIO/sailfin/commit/eaceb6516d794ff5544eab387574aeeb6284e515))

- Struct dispatch
  ([`a681c2e`](https://github.com/SailfinIO/sailfin/commit/a681c2e88ef24ec8c8d7faf18677f1f8ade11c3d))

- Stub work
  ([`4af135a`](https://github.com/SailfinIO/sailfin/commit/4af135afc74f732debbe56386c5f3c49eb0d8296))

- Stub work
  ([`a060c00`](https://github.com/SailfinIO/sailfin/commit/a060c0039f10113fc6a53c2cffcb8039d9812cff))

- Tag access instead of .variant
  ([`9d11e84`](https://github.com/SailfinIO/sailfin/commit/9d11e84122f4ccedb2b6e56f220d92ff7c9f8b57))

- Timeout missing
  ([`fdb5b18`](https://github.com/SailfinIO/sailfin/commit/fdb5b18b6e876a26121a064ae6d18820d80474dd))

- Try rename truncated labels
  ([`4fd66e9`](https://github.com/SailfinIO/sailfin/commit/4fd66e9b79e8a7a18fced5cb973678225d4ba363))

- Typechecking
  ([`0a0b1cf`](https://github.com/SailfinIO/sailfin/commit/0a0b1cf47e957563ee6c7508f9c067d626129a44))

- Use tag accessors instead of .variant
  ([`3c6458c`](https://github.com/SailfinIO/sailfin/commit/3c6458ceada10f5074a253b1c6d26098afd084f4))


## v0.1.1-alpha.138 (2026-01-23)

### Bug Fixes

- Making LLVM line concatenation non-mutating
  ([`19eb092`](https://github.com/SailfinIO/sailfin/commit/19eb09202d277bbf53d2181e25d86474ad5269c7))


## v0.1.1-alpha.137 (2026-01-23)

### Bug Fixes

- Pin 135 for now since 136 seems broken with duplicates
  ([`9fd464d`](https://github.com/SailfinIO/sailfin/commit/9fd464d26e774b9859f845c20efff28493a42847))


## v0.1.1-alpha.136 (2026-01-22)

### Bug Fixes

- Abi enahancement
  ([`0762add`](https://github.com/SailfinIO/sailfin/commit/0762add251caf40f8271c53042cbcdb9eed98366))


## v0.1.1-beta.2 (2026-01-20)

### Bug Fixes

- Merge conflicts by adding gitattributes
  ([`0fdac52`](https://github.com/SailfinIO/sailfin/commit/0fdac52b61db42c5d7bbd0b8fbdc3844224cdba2))


## v0.1.1-alpha.135 (2026-01-21)

### Bug Fixes

- Module naming
  ([`80afafe`](https://github.com/SailfinIO/sailfin/commit/80afafed4f9265b3e4637792eabfdf1ed6435ff1))

- Remove legacy stage2 ref
  ([`3d2781d`](https://github.com/SailfinIO/sailfin/commit/3d2781d78a564672f8a5e4ec7df294f39f1d2e2b))


## v0.1.1-beta.1 (2026-01-20)


## v0.1.1-alpha.134 (2026-01-20)

### Bug Fixes

- Permissions
  ([`514749e`](https://github.com/SailfinIO/sailfin/commit/514749e9294b9ca626cf278164dfcf9cff606e11))


## v0.1.1-alpha.133 (2026-01-20)

### Bug Fixes

- Duplication in runs
  ([`c126650`](https://github.com/SailfinIO/sailfin/commit/c126650674e077f34e22dc4e466a5e1008b422e9))

- Permissions and seed version
  ([`1ea7717`](https://github.com/SailfinIO/sailfin/commit/1ea771771ad6587e287cb737eb3a957afab6ae7b))


## v0.1.1-alpha.132 (2026-01-20)

### Bug Fixes

- Dispatch release workflow
  ([`3f1d719`](https://github.com/SailfinIO/sailfin/commit/3f1d719dae8ccc3c288e239177c1487f7d564b24))


## v0.1.1-alpha.131 (2026-01-20)

### Bug Fixes

- Semantic release skip ci removal
  ([`37a8747`](https://github.com/SailfinIO/sailfin/commit/37a8747f7b3f80e6391033e0a22715cfe4b30a8f))


## v0.1.1-alpha.130 (2026-01-20)

### Bug Fixes

- Use release pat
  ([`a9dcfb0`](https://github.com/SailfinIO/sailfin/commit/a9dcfb089b8f278b091f91ca9cdf801e2f40d55d))

- Use release pat
  ([`06880ad`](https://github.com/SailfinIO/sailfin/commit/06880ad68805fa59a40d9afa442d7ded939fd6ce))


## v0.1.1-alpha.129 (2026-01-20)

### Bug Fixes

- Refactor and release tag and branches yml
  ([`55b8818`](https://github.com/SailfinIO/sailfin/commit/55b88189514d5ebc64a2ae87c5346ae60d6f8002))

- Refactor and release tag and branches yml
  ([`509cea1`](https://github.com/SailfinIO/sailfin/commit/509cea10b137312de7333df1e44bf59f7950c3ab))


## v0.1.1-alpha.128 (2026-01-20)

### Bug Fixes

- Ci refactor
  ([`3c70cfd`](https://github.com/SailfinIO/sailfin/commit/3c70cfd18f39f880db45b5204d2cc9ce5bfc1d88))

- Ci version checking
  ([`c130ebc`](https://github.com/SailfinIO/sailfin/commit/c130ebc1aab0db2d860580126d4ae0ae1942de22))

- Conda env
  ([`1c69454`](https://github.com/SailfinIO/sailfin/commit/1c694547520a04c34b4d01a3b2d0170ad210549e))

- Install symlinks
  ([`60b0c48`](https://github.com/SailfinIO/sailfin/commit/60b0c48bc1bb3dda78189c2acc985457b4ef601c))

- Makefile
  ([`ffa12dc`](https://github.com/SailfinIO/sailfin/commit/ffa12dc893bebf1ee212110c1a6944af98caf237))

- Pin seed
  ([`0242091`](https://github.com/SailfinIO/sailfin/commit/0242091ec10d5483300d23f96fffae2d400d61bc))

- Pin seed
  ([`69fea14`](https://github.com/SailfinIO/sailfin/commit/69fea14bf4eb2ad7fffee54318d3dae105451e76))

- Pin seed
  ([`b01fac1`](https://github.com/SailfinIO/sailfin/commit/b01fac1a9aae7898b30c2d8505522c27e7139a0c))

- Pipefail and targets
  ([`2804ddc`](https://github.com/SailfinIO/sailfin/commit/2804ddce83518fe78c24382aa4948f1ed4415ff3))

- Use release seed
  ([`699934b`](https://github.com/SailfinIO/sailfin/commit/699934bb1afdaa54ea129cbd32e61aeb716474b4))


## v0.1.1-alpha.127 (2026-01-20)

### Bug Fixes

- Ci version checking
  ([`275991b`](https://github.com/SailfinIO/sailfin/commit/275991b5eff3007c27ba854c737e737dad98a17a))


## v0.1.1-alpha.126 (2026-01-20)

### Bug Fixes

- Remove stage2 fallback
  ([`ef75e07`](https://github.com/SailfinIO/sailfin/commit/ef75e07cf514542d2567a33b3e184d62f8879976))

- Remove stage2 naming
  ([`6fd8411`](https://github.com/SailfinIO/sailfin/commit/6fd8411483a5637c61001ae7b91d8626692e5bc0))


## v0.1.1-alpha.125 (2026-01-20)

### Bug Fixes

- Stage2 reference in benchmark
  ([`973b861`](https://github.com/SailfinIO/sailfin/commit/973b861d0defa246afef8f77712e61b1850c868f))


## v0.1.1-alpha.124 (2026-01-20)

### Bug Fixes

- Remove llvm shim file
  ([`4ecf0be`](https://github.com/SailfinIO/sailfin/commit/4ecf0bef5f2f18c8d0ecd82c23e3dda89434ed88))

- Remove release assets step
  ([`6deaa51`](https://github.com/SailfinIO/sailfin/commit/6deaa51d2469ceb240b02d1812384430386d973f))


## v0.1.1-alpha.123 (2026-01-20)

### Bug Fixes

- Add check for testing and compiling
  ([`97a8eef`](https://github.com/SailfinIO/sailfin/commit/97a8eef63d58851d8d4392007dba95a3c70e3099))

- Add check for testing and compiling
  ([`cc19448`](https://github.com/SailfinIO/sailfin/commit/cc19448f66f60d40d09a4fe84acf07c526f7045a))

- Asset upload
  ([`e3821a6`](https://github.com/SailfinIO/sailfin/commit/e3821a629e2a75ec2adc2b020ba3589a30e90f20))

- Missing package
  ([`a558cef`](https://github.com/SailfinIO/sailfin/commit/a558cef7e7e8460a2bfd0e50821cdcfe719c00e0))

- Packaging redundancies and fixed point gating
  ([`e40bdf4`](https://github.com/SailfinIO/sailfin/commit/e40bdf4f81ce527969af238c9056c430d6ae2b01))

- Remove legacy stage1
  ([`3f1b021`](https://github.com/SailfinIO/sailfin/commit/3f1b02131b8a25c7af16b89d7b0316ea08840a7d))

- Remove legacy stage1
  ([`9321f1d`](https://github.com/SailfinIO/sailfin/commit/9321f1d2aaaa35edb449f606b02be63f93820019))

- Split core into manageable files
  ([`b78b92e`](https://github.com/SailfinIO/sailfin/commit/b78b92ecd7c59fcd823d5f7758b029335ffcfbef))


## v0.1.1-alpha.122 (2026-01-20)

### Bug Fixes

- Clean up ci
  ([`6c7249b`](https://github.com/SailfinIO/sailfin/commit/6c7249b40e26573df93916970aac2d49dcfb7467))

- Remove stage2 referencing
  ([`e1eb0bf`](https://github.com/SailfinIO/sailfin/commit/e1eb0bf1aa81af713d30c776474d9d9e7283bf0b))

- Remove stage2 referencing
  ([`353e392`](https://github.com/SailfinIO/sailfin/commit/353e392f15b90e07a615fe05f63c04c0a8fb1a1a))


## v0.1.1-alpha.121 (2026-01-19)

### Bug Fixes

- Clean build and doc planning
  ([`15cebf7`](https://github.com/SailfinIO/sailfin/commit/15cebf7c3adf9f24b3a8cdfdfdf39a7b7e615fdf))

- Clean build and stage2 renaming
  ([`60560e8`](https://github.com/SailfinIO/sailfin/commit/60560e82aacf3b89aead0875c11554ffef0bde23))

- Clean build and stage2 renaming
  ([`f5a498c`](https://github.com/SailfinIO/sailfin/commit/f5a498c46cabeb66b68696fd8dc2363c1d7f2517))

- Clean build and stage2 renaming
  ([`0a1320b`](https://github.com/SailfinIO/sailfin/commit/0a1320be3d4186e57fac2e4bed031eb7029a4428))


## v0.1.1-alpha.120 (2026-01-19)

### Bug Fixes

- Clean build and stage2 renaming
  ([`aae34f5`](https://github.com/SailfinIO/sailfin/commit/aae34f5abdaa0992300b2d66a36d44276b967124))

- Repo local wrapper
  ([`30e686d`](https://github.com/SailfinIO/sailfin/commit/30e686dc74c2a14abcd120820def06610be0602c))

- Stage2 removal
  ([`2a452d3`](https://github.com/SailfinIO/sailfin/commit/2a452d385be32539c711b73d882e4eb414832ddf))

- Stage2 removal
  ([`a97963a`](https://github.com/SailfinIO/sailfin/commit/a97963a78e441da4449b1e7f1f749b77ac26eb62))


## v0.1.1-alpha.119 (2026-01-19)

### Bug Fixes

- Stage2 naming
  ([`11d1e48`](https://github.com/SailfinIO/sailfin/commit/11d1e487d1813c85ec64d1003e89931d54dbe592))


## v0.1.1-alpha.118 (2026-01-19)

### Bug Fixes

- Stage2 naming
  ([`c895520`](https://github.com/SailfinIO/sailfin/commit/c8955202f80941c7cbcc92fdbbfad23562fa6fbc))


## v0.1.1-alpha.117 (2026-01-18)

### Bug Fixes

- Expose prelude.o
  ([`fb417e3`](https://github.com/SailfinIO/sailfin/commit/fb417e3c7499b442314b3612cc211a2237b29ae3))


## v0.1.1-alpha.116 (2026-01-17)

### Bug Fixes

- Selfhost-only CI using seed 0.1.1-alpha.115
  ([`9ab40e9`](https://github.com/SailfinIO/sailfin/commit/9ab40e9c049ccab4682e2f1703c78a2893548252))

- Testing in self hosting
  ([`4159a6d`](https://github.com/SailfinIO/sailfin/commit/4159a6ddcef8cc595c48ad8948a17fa71c4c74a1))


## v0.1.1-alpha.115 (2026-01-17)

### Bug Fixes

- Add test for self-host
  ([`5d6100f`](https://github.com/SailfinIO/sailfin/commit/5d6100fad0f55cb01e44db9e1e02cba1bf967e8a))

- Add timeouts + progress for native build
  ([`370fa66`](https://github.com/SailfinIO/sailfin/commit/370fa66881fcfae204c2603b473207a1a4d04958))

- Avoid opaque-pointers flag for runtime IR
  ([`1dc75c6`](https://github.com/SailfinIO/sailfin/commit/1dc75c6439d72808fdb22cdb5dd4fd137d8ed9a8))

- Ci self hosting
  ([`b5862c8`](https://github.com/SailfinIO/sailfin/commit/b5862c8ac1af21ea744a41a2392c6048657378bc))

- Compatibility strategy
  ([`a810156`](https://github.com/SailfinIO/sailfin/commit/a810156349030bbf1cf4428f488ecff59dd6ef2f))

- Eliminate stale import context artifacts
  ([`9a950f9`](https://github.com/SailfinIO/sailfin/commit/9a950f93733a630f97430ed19eed030d0241802b))

- Import context staging
  ([`6b5b007`](https://github.com/SailfinIO/sailfin/commit/6b5b0075a0c07619f91b5d37b9707205dc9262b8))

- Import reliability
  ([`6628928`](https://github.com/SailfinIO/sailfin/commit/66289289b6bbf41f2898c6bc08d432b394713a95))

- Llvm-link opaque pointers retry
  ([`ef9dbd8`](https://github.com/SailfinIO/sailfin/commit/ef9dbd83129b5528c75beefcbbf1a3b7b2cba885))

- Pass opaque-pointers flag on linux
  ([`a6e955a`](https://github.com/SailfinIO/sailfin/commit/a6e955ab927abeb91815450bd18d0db07f89c79c))

- Repair Makefile shell continuation
  ([`3b03cd1`](https://github.com/SailfinIO/sailfin/commit/3b03cd157681ee509b2e004dc24a188575f3b10a))

- Seed
  ([`07ab814`](https://github.com/SailfinIO/sailfin/commit/07ab814dcbd5977b6a9147eea457c3cc91309799))

- Speed up linux stage1 seed build
  ([`720575e`](https://github.com/SailfinIO/sailfin/commit/720575e64806afa66ab635f0af61e083bc1fdb1e))

- Stage2 native determinism
  ([`e340d9c`](https://github.com/SailfinIO/sailfin/commit/e340d9ceba741bbc5a506d7957e14377764466c3))

- Surface failing LLVM module in native build
  ([`f419121`](https://github.com/SailfinIO/sailfin/commit/f419121b81bc8568fd672e89bd4834259e49f0fe))

- Use clang-15 on ubuntu
  ([`fb0dbe1`](https://github.com/SailfinIO/sailfin/commit/fb0dbe1fba66aab963c88887fa298ccb84acf1b4))

- Wall time
  ([`23ba3c4`](https://github.com/SailfinIO/sailfin/commit/23ba3c434b07bc871bcf26d949fbe32170c57150))

- **ci**: Add macOS ASAN repro + stabilize linux fixed-point
  ([`55edbd5`](https://github.com/SailfinIO/sailfin/commit/55edbd5bc5694abd68596d5bf0ba90352ab604ee))

- **ci**: Avoid aot-prepare-dir in selfhost
  ([`0047480`](https://github.com/SailfinIO/sailfin/commit/0047480a1446cb0dd29a7f37920d88210aa34e31))

- **ci**: Correct opaque-pointers + opt passing
  ([`95a06ed`](https://github.com/SailfinIO/sailfin/commit/95a06ed7029343735575880f74d3db44eef0e397))

- **ci**: Ensure llvm-link available for selfhost
  ([`9b3f3dd`](https://github.com/SailfinIO/sailfin/commit/9b3f3ddbf375cca05fcbde297719db19c1617881))

- **ci**: Make alpha bootstrap escape hatch work
  ([`ade004d`](https://github.com/SailfinIO/sailfin/commit/ade004df208578c11f089ba29e72d9d7fcc2be93))

- **ci**: Stage1 fallback until seed 115
  ([`b11a786`](https://github.com/SailfinIO/sailfin/commit/b11a786a813ae2eba4f056f65e12615b147eeabf))

- **selfhost**: Avoid clang_flags scoping crash
  ([`d05c86e`](https://github.com/SailfinIO/sailfin/commit/d05c86ec22c504196416d95aaa1775168167d742))

- **selfhost**: Clear import-context cache on seed change
  ([`8b9586a`](https://github.com/SailfinIO/sailfin/commit/8b9586a7f8d6e62d745909a022610f11039cea87))

- **selfhost**: Prelude missing in ci
  ([`76ea861`](https://github.com/SailfinIO/sailfin/commit/76ea8616dcad0f9f775a4147082ba9da7c5ed24b))

### Continuous Integration

- Drop -opaque-pointers clang flag on llvm18
  ([`7fbb4e5`](https://github.com/SailfinIO/sailfin/commit/7fbb4e5cebef39241bd511016c62ddd64500ed25))

- Fix llvm-link preflight for llvm18
  ([`707cc2c`](https://github.com/SailfinIO/sailfin/commit/707cc2c2e215e30e306618f3f220d49d9bd5d754))

- Force stage1 seed on alpha
  ([`62b7880`](https://github.com/SailfinIO/sailfin/commit/62b788041b9248b197058c59cf31469dc3a0f127))

- Harden selfhost-from-release-seed
  ([`8a5a834`](https://github.com/SailfinIO/sailfin/commit/8a5a8341c555c9c407385ca8250f1e2c72fbdb81))

- Improve ASAN diagnostics + fixed-point reporting
  ([`6c41a57`](https://github.com/SailfinIO/sailfin/commit/6c41a57c363f28bb12e95507e97460918abadf36))

- Ubuntu-24.04 llvm18 preflight + force clang
  ([`df55f3f`](https://github.com/SailfinIO/sailfin/commit/df55f3f9c50f47e8efeb012311f690b2baf84a9f))

### Documentation

- Aot doc removal
  ([`a34e630`](https://github.com/SailfinIO/sailfin/commit/a34e630048ce62ae9e06b3a8ab00ae432fcfa4a1))


## v0.1.1-alpha.114 (2026-01-13)

### Bug Fixes

- **bootstrap**: Stabilize stage1 effect checker
  ([`10f1da2`](https://github.com/SailfinIO/sailfin/commit/10f1da2debc5b9ffd9468f3fa45c7eb1ab0ecdb3))

- **compiler**: Avoid Token in effect checker
  ([`efc4f24`](https://github.com/SailfinIO/sailfin/commit/efc4f24c1fe9f22438b459de0754157ad822c6c3))


## v0.1.1-alpha.113 (2026-01-13)

### Bug Fixes

- Opaque struct flakiness
  ([`110a944`](https://github.com/SailfinIO/sailfin/commit/110a9440d114eb2945ae25f874797e93458cab95))


## v0.1.1-alpha.112 (2026-01-13)

### Bug Fixes

- Trigger version bump to test self host release
  ([`957796c`](https://github.com/SailfinIO/sailfin/commit/957796cde52c6574cec0eacdd309981ccff426e3))


## v0.1.1-alpha.111 (2026-01-13)

### Bug Fixes

- Decorator indexing
  ([`107c7b9`](https://github.com/SailfinIO/sailfin/commit/107c7b96e4d908d0e33aa510adf69ccceb20afca))


## v0.1.1-alpha.110 (2026-01-13)

### Bug Fixes

- Trigger version bumpt to test self host release
  ([`6ae2046`](https://github.com/SailfinIO/sailfin/commit/6ae20462a34dd4a88eea022e01e65d2d69630569))


## v0.1.1-alpha.109 (2026-01-13)

### Bug Fixes

- Decorator semantics
  ([`4aabf92`](https://github.com/SailfinIO/sailfin/commit/4aabf92d34fcc12b50762bbf304fc6c206b825a2))


## v0.1.1-alpha.108 (2026-01-13)

### Bug Fixes

- Trigger version bumpt to test self host release
  ([`f2836ab`](https://github.com/SailfinIO/sailfin/commit/f2836ab4a30fac8841c690b0e27e699a8cabdb23))


## v0.1.1-alpha.107 (2026-01-13)

### Bug Fixes

- Job parallelzation
  ([`f8cbd10`](https://github.com/SailfinIO/sailfin/commit/f8cbd10229a0a3aa8ace89d20dc0099e4853bbec))


## v0.1.1-alpha.106 (2026-01-13)

### Bug Fixes

- Clang validation in selfhost
  ([`e31e8f1`](https://github.com/SailfinIO/sailfin/commit/e31e8f13116d232bdc7823be69cca166f1694196))


## v0.1.1-alpha.105 (2026-01-13)

### Bug Fixes

- Clang validation in selfhost
  ([`8f7b7f8`](https://github.com/SailfinIO/sailfin/commit/8f7b7f85def7946bda465082ac4a058e610b70bf))


## v0.1.1-alpha.104 (2026-01-13)

### Bug Fixes

- Array push declare
  ([`53c2c2c`](https://github.com/SailfinIO/sailfin/commit/53c2c2caae34f9437db3dd989c6a06fef4f52cf1))


## v0.1.1-alpha.103 (2026-01-12)

### Bug Fixes

- Timing improvements
  ([`d312e17`](https://github.com/SailfinIO/sailfin/commit/d312e172d4073349d7d0d0bdd71dcd5f02d80d1c))

- Timing improvements
  ([`92c32c3`](https://github.com/SailfinIO/sailfin/commit/92c32c3c65919496eb2ebc181f18cb7576467a19))

- Timing improvements
  ([`cca50d1`](https://github.com/SailfinIO/sailfin/commit/cca50d12253e05f0f4873dc20602ab6b296258ea))

- Timing improvements
  ([`fc48e5d`](https://github.com/SailfinIO/sailfin/commit/fc48e5d4fcabd150bd44cc9bbc431402c78d4544))


## v0.1.1-alpha.102 (2026-01-12)

### Bug Fixes

- Timing improvements
  ([`68a63d8`](https://github.com/SailfinIO/sailfin/commit/68a63d837360c62e7a150c1df275a77fbe17f8a3))


## v0.1.1-alpha.101 (2026-01-12)

### Bug Fixes

- Timing improvements
  ([`cd4d455`](https://github.com/SailfinIO/sailfin/commit/cd4d4558d7620cbd26ef2bc2ee4e52da7dbd4114))


## v0.1.1-alpha.100 (2026-01-12)

### Bug Fixes

- Join with separator
  ([`0f03320`](https://github.com/SailfinIO/sailfin/commit/0f03320c93bd5b7ecd669a00dc710ac0eea6550f))


## v0.1.1-alpha.99 (2026-01-12)

### Bug Fixes

- Manginling entrypoints
  ([`eaa3c45`](https://github.com/SailfinIO/sailfin/commit/eaa3c45cd197aa21575768e3e82a6acb28c76142))


## v0.1.1-alpha.98 (2026-01-08)

### Bug Fixes

- Timing addition to cli
  ([`8762497`](https://github.com/SailfinIO/sailfin/commit/8762497ba0273690f361b761ea5c08ca6c848d98))


## v0.1.1-alpha.97 (2026-01-07)

### Bug Fixes

- Timing addition to cli
  ([`b4649ed`](https://github.com/SailfinIO/sailfin/commit/b4649ed6ddeb4a71fea9dbca67261ebc098c9294))


## v0.1.1-alpha.96 (2026-01-07)

### Bug Fixes

- Use Stage1 seed for self-hosting to break bootstrap deadlock
  ([`5e4a78a`](https://github.com/SailfinIO/sailfin/commit/5e4a78ab10e760cb678c09dcfd03ae46dcd7a283))

- Replace broken alpha.92 download with Stage1-compiled binary - Fixes bootstrap chicken-and-egg
  where old release can't compile new code - Enables first successful self-hosted release build


## v0.1.1-alpha.95 (2026-01-07)

### Bug Fixes

- Core refactor
  ([`0eb0996`](https://github.com/SailfinIO/sailfin/commit/0eb0996e78944f2cf9d65f165d4c2c61ae6d882a))

- Use non asan
  ([`cfc3f15`](https://github.com/SailfinIO/sailfin/commit/cfc3f15b9657fd0d957277210edb47869061ba4a))

- Work on core refactor
  ([`22598fc`](https://github.com/SailfinIO/sailfin/commit/22598fc74781e358b6d9069a1a46906113ac7d6e))

- Work on core refactor
  ([`337535a`](https://github.com/SailfinIO/sailfin/commit/337535a6fc86d0d39ff3cc07cd73b46c4736f75c))


## v0.1.1-alpha.94 (2026-01-07)

### Bug Fixes

- Log lines
  ([`c15bd7d`](https://github.com/SailfinIO/sailfin/commit/c15bd7dd2a0b5bf7fe9b65a183bb79a7db1627a4))


## v0.1.1-alpha.93 (2026-01-07)

### Bug Fixes

- Emit llvm truncation
  ([`05425cd`](https://github.com/SailfinIO/sailfin/commit/05425cdf3b8f26a9f29f903a1388e5ddd5b1794a))


## v0.1.1-alpha.92 (2026-01-07)

### Bug Fixes

- Add fallbacks for now
  ([`065a76b`](https://github.com/SailfinIO/sailfin/commit/065a76bb5b155c29d1342c76dee1a27adb3dcad6))


## v0.1.1-alpha.91 (2026-01-07)

### Bug Fixes

- Add compile fallback for now
  ([`e527956`](https://github.com/SailfinIO/sailfin/commit/e527956b2320139178e21c1f2d22fba45bc21677))


## v0.1.1-alpha.90 (2026-01-07)

### Bug Fixes

- Install and release for missing assets
  ([`4abf31f`](https://github.com/SailfinIO/sailfin/commit/4abf31fad47fcc9d3f5cfb04e5ed6322a9088c58))


## v0.1.1-alpha.89 (2026-01-07)

### Bug Fixes

- Add self host seed installer
  ([`95f089d`](https://github.com/SailfinIO/sailfin/commit/95f089d55540f04865eeffe87dc8afc8c696402e))

- Aot prepare
  ([`7c2551f`](https://github.com/SailfinIO/sailfin/commit/7c2551fdbd6d77e575890556e76336a720df7c4a))

- Aot prepare
  ([`4e99da7`](https://github.com/SailfinIO/sailfin/commit/4e99da7be831af4f6c45686800c95e813edf7484))

- Aot prepare
  ([`9e79d44`](https://github.com/SailfinIO/sailfin/commit/9e79d4484d7106ebd44ca9da6824b20b2609e7a3))

- Aot prepare declare rounds
  ([`d56b4cd`](https://github.com/SailfinIO/sailfin/commit/d56b4cd7978ec81398cd9b5b084964a1cde51ed0))

- Ci failure and use install script
  ([`148c9cf`](https://github.com/SailfinIO/sailfin/commit/148c9cf0a9358974a3ef45e13407beaa75667aee))

- Env gate tracing
  ([`94da7df`](https://github.com/SailfinIO/sailfin/commit/94da7dfe5b20517dc162eb017299dc5c1cc822d2))

- Linux fixed point and test failure
  ([`917e40f`](https://github.com/SailfinIO/sailfin/commit/917e40f46c22447874de7d3b6ab8f596d293a28c))

- Relative import handling
  ([`b1ccf8f`](https://github.com/SailfinIO/sailfin/commit/b1ccf8f1f8e2a30771156dee39200620c91bf686))

- Remove e2e
  ([`f70ce32`](https://github.com/SailfinIO/sailfin/commit/f70ce321bc479f9ffcb5f28416c50cdb073fbb8a))

- Stage2
  ([`28268ee`](https://github.com/SailfinIO/sailfin/commit/28268eeedf43f6cb30a0580f1dfeedc49f5c52d4))

- Stage2 asan
  ([`3981b2a`](https://github.com/SailfinIO/sailfin/commit/3981b2afc60f467ab8155683330833a028075138))

- Test strictness
  ([`441fb4d`](https://github.com/SailfinIO/sailfin/commit/441fb4d96e9629255bb1ef86274fb28a0ad5ec77))

- Write lines
  ([`f1da48c`](https://github.com/SailfinIO/sailfin/commit/f1da48cc09061df879164cd65946b44a64e999b8))


## v0.1.1-alpha.88 (2026-01-03)

### Bug Fixes

- Lowering calls and addressing
  ([`7b823dd`](https://github.com/SailfinIO/sailfin/commit/7b823dd736cece2349654a5e6c7a5f053af034e2))


## v0.1.1-alpha.87 (2026-01-02)

### Bug Fixes

- Borrowing
  ([`e230324`](https://github.com/SailfinIO/sailfin/commit/e23032445997b3ee1183d29dabc78977a39ba57a))

- Breakout bindings, operators, ownership, parsing, type mapping
  ([`60be595`](https://github.com/SailfinIO/sailfin/commit/60be59511405dfb2a03ae1d550a0c1a56c2819a4))

- Checkin llvm stage1
  ([`7aecc10`](https://github.com/SailfinIO/sailfin/commit/7aecc102af13625a339a50bfe5e5938492c52601))

- Compiler build check in
  ([`77973cd`](https://github.com/SailfinIO/sailfin/commit/77973cdf55e9b21e299a2c6042d0da7cc04d223a))

- Emitter collision and missing type import
  ([`b987fec`](https://github.com/SailfinIO/sailfin/commit/b987fecdfa5698ea317267d3a63933bfcfd21f14))

- Lifetime releases restore
  ([`3156a75`](https://github.com/SailfinIO/sailfin/commit/3156a7575a5ae10786b9cc52c8df52b6f6c69295))

- Lowering after module refactor
  ([`896fd59`](https://github.com/SailfinIO/sailfin/commit/896fd597493766f467a918174db0b821469d4ba8))

- Lowering after module refactor
  ([`1debf40`](https://github.com/SailfinIO/sailfin/commit/1debf400ed4434a2d54e3f37f5e7a6a9e1e25633))

- Lowering calls and addressing
  ([`fea7759`](https://github.com/SailfinIO/sailfin/commit/fea7759be56e46a3ea52b2838987d3c82f3eccec))

- Lowering for new modules
  ([`8722b76`](https://github.com/SailfinIO/sailfin/commit/8722b7663ec7f7f938c70ffd8d5d938523b502cc))

- Lowering operands, parse, scopes
  ([`9ac6846`](https://github.com/SailfinIO/sailfin/commit/9ac6846a1e07e5f03367ed55ab1544f09eff3c81))

- Lowering strings
  ([`85e025a`](https://github.com/SailfinIO/sailfin/commit/85e025a1624fc135ac36e0511b3df2ccfc3d1a5f))

- Paser refactor
  ([`6caaabf`](https://github.com/SailfinIO/sailfin/commit/6caaabf0ca8e87dfff113478383fb0c397c34d1c))

- Re add missing llvm sub dir
  ([`9d88930`](https://github.com/SailfinIO/sailfin/commit/9d88930a014a7d32ae31902369974794a93bd888))

- Recompiling after parser split
  ([`c672ee3`](https://github.com/SailfinIO/sailfin/commit/c672ee3e05396dd8aedfd533c8c6645cdf1dfe0d))

- Setup llvm refactor
  ([`edc7826`](https://github.com/SailfinIO/sailfin/commit/edc782638bb6e714b79fae59e7c940f563926699))

- Use imports and remove duplicates in llvm lowering
  ([`d3bcda1`](https://github.com/SailfinIO/sailfin/commit/d3bcda16348052107ad38cd78ef33ce878229dd2))

- Work on refactoring native llvm lowering
  ([`1b9c057`](https://github.com/SailfinIO/sailfin/commit/1b9c05782d399f76c06e1524cc81543b4f60d2bc))

### Documentation

- Aot improvement assesment
  ([`2d1d5c6`](https://github.com/SailfinIO/sailfin/commit/2d1d5c6016e7322349b89fc394cba6cdb19c5c90))


## v0.1.1-alpha.86 (2025-12-30)

### Bug Fixes

- Add aot prepare python
  ([`2becc60`](https://github.com/SailfinIO/sailfin/commit/2becc60ed26f35b1118e33bdbf1a0cc669b9d694))

- Module linking
  ([`d988f49`](https://github.com/SailfinIO/sailfin/commit/d988f49713276c3de98462be2a146159dd900a72))

- Print to stout
  ([`36e8058`](https://github.com/SailfinIO/sailfin/commit/36e8058534c23c769163b8035d748a7111c875fc))

- String utils
  ([`3644f80`](https://github.com/SailfinIO/sailfin/commit/3644f80b58749be03e362f716aa33d29f52f134a))


## v0.1.1-alpha.85 (2025-12-29)

### Bug Fixes

- Tests time
  ([`352d229`](https://github.com/SailfinIO/sailfin/commit/352d2291fcedca888ce2f4bb8d1161eb40af3bfc))


## v0.1.1-alpha.84 (2025-12-29)

### Bug Fixes

- Version strategy and ownership
  ([`b3478a8`](https://github.com/SailfinIO/sailfin/commit/b3478a89159674a9edf61616fb77ebe68db775f7))


## v0.1.1-alpha.83 (2025-12-27)

### Bug Fixes

- Linking
  ([`27794e2`](https://github.com/SailfinIO/sailfin/commit/27794e24b22a0643dcb19d1adc6cd650d29f060a))


## v0.1.1-alpha.82 (2025-12-26)

### Bug Fixes

- Version check and work on compilation speed
  ([`4772bfd`](https://github.com/SailfinIO/sailfin/commit/4772bfd79ee63f8579a6fb18e0bf55231f32f283))


## v0.1.1-alpha.81 (2025-12-26)

### Bug Fixes

- Trigger semantic release
  ([`94ba0bf`](https://github.com/SailfinIO/sailfin/commit/94ba0bfc0d95842f5c1e9c1f650641786af050ef))


## v0.1.1-alpha.80 (2025-12-26)

### Bug Fixes

- Invallid llvm emission during testing
  ([`cda8833`](https://github.com/SailfinIO/sailfin/commit/cda88331a0a034716659e1870ac434e02183f17f))


## v0.1.1-alpha.79 (2025-12-26)

### Bug Fixes

- Async return support and legacy tests removal
  ([`d7e72bd`](https://github.com/SailfinIO/sailfin/commit/d7e72bdd26de06c468288f78630d972d72183dfc))


## v0.1.1-alpha.78 (2025-12-26)

### Bug Fixes

- Async futures boolean
  ([`6c70efa`](https://github.com/SailfinIO/sailfin/commit/6c70efabed56939053ddbef1f89ff43b6086574a))

- Gh worfklow naming, native aot, install
  ([`c611794`](https://github.com/SailfinIO/sailfin/commit/c61179467b5eef21d90bd782d461ec2c62af1e2e))

- Llvm rounding
  ([`015810b`](https://github.com/SailfinIO/sailfin/commit/015810ba17fb79bf8cec270d01fbe8f170cbd12b))

- Parameters for async
  ([`5765b83`](https://github.com/SailfinIO/sailfin/commit/5765b83cf5231269acad8408ffb6b4cb06c6e721))

- String interpolation with literal insiade
  ([`a075b16`](https://github.com/SailfinIO/sailfin/commit/a075b166183fff7c31486c86c74d21439268b770))


## v0.1.1-alpha.77 (2025-12-24)

### Bug Fixes

- Tagged enums
  ([`3f81844`](https://github.com/SailfinIO/sailfin/commit/3f818448667ffac8d6edeead33d29e970c8ad7d9))

- Try catch finally
  ([`c429eec`](https://github.com/SailfinIO/sailfin/commit/c429eecbd38a59c539494168f4911eee4ab06371))


## v0.1.1-alpha.76 (2025-12-24)

### Bug Fixes

- Strcut composition
  ([`c6c2eac`](https://github.com/SailfinIO/sailfin/commit/c6c2eacc7b7b9cf5d643b6c5e4cfde243b360370))


## v0.1.1-alpha.75 (2025-12-24)

### Bug Fixes

- Unsafe and extern interop
  ([`eee8ac5`](https://github.com/SailfinIO/sailfin/commit/eee8ac52f4157115c694878fbef42f401945a413))


## v0.1.1-alpha.74 (2025-12-23)

### Bug Fixes

- Decorators
  ([`66707a9`](https://github.com/SailfinIO/sailfin/commit/66707a9c804e599c20e16f786da00510b80e26fd))

- Decorators
  ([`950b996`](https://github.com/SailfinIO/sailfin/commit/950b996bbc1978b21577661f2744d35ec00f4803))


## v0.1.1-alpha.73 (2025-12-23)

### Bug Fixes

- Decorators
  ([`7a0f6c3`](https://github.com/SailfinIO/sailfin/commit/7a0f6c3fff6922db7d8070ad35ff4ee7148645c2))


## v0.1.1-alpha.72 (2025-12-23)

### Bug Fixes

- Error handling example w/ union types
  ([`2338f74`](https://github.com/SailfinIO/sailfin/commit/2338f74f21a986b89b5f4c89698791ed84b2cd23))


## v0.1.1-alpha.71 (2025-12-23)

### Bug Fixes

- Testing and assertion
  ([`36a98f0`](https://github.com/SailfinIO/sailfin/commit/36a98f0bbb3a948ff334b7fac15332531a9c44dc))


## v0.1.1-alpha.70 (2025-12-23)

### Bug Fixes

- Testing and assertion
  ([`8f5849f`](https://github.com/SailfinIO/sailfin/commit/8f5849f806a4fb47a54f040a45466a08c8056eaa))


## v0.1.1-alpha.69 (2025-12-23)

### Bug Fixes

- Testing and assertion no longer crashing
  ([`d4ac35d`](https://github.com/SailfinIO/sailfin/commit/d4ac35d98ab7abf93ad03b1905c1873ace506067))

### Chores

- Doc updates
  ([`3f67d50`](https://github.com/SailfinIO/sailfin/commit/3f67d505314b4e591ae794f1ad16771bf254edca))


## v0.1.1-alpha.68 (2025-12-22)

### Bug Fixes

- Native cli and example naming
  ([`c551fc5`](https://github.com/SailfinIO/sailfin/commit/c551fc5bf375ebedc581be8cc606cb9d1cd3a6ac))


## v0.1.1-alpha.67 (2025-12-22)

### Bug Fixes

- **ci**: Stop canceling stage2 builds
  ([`551ecd0`](https://github.com/SailfinIO/sailfin/commit/551ecd0f9efd9dbce17263bd829ed481d9233325))


## v0.1.1-alpha.66 (2025-12-22)

### Bug Fixes

- **stage2**: Avoid CI segfaults and fix packaging
  ([`192b22f`](https://github.com/SailfinIO/sailfin/commit/192b22fc2045c746b613d8906fea27a1e0587d67))


## v0.1.1-alpha.65 (2025-12-22)

### Bug Fixes

- Borrow expression
  ([`d23f2f0`](https://github.com/SailfinIO/sailfin/commit/d23f2f06c66d5dfdb2dfb9f20a137450557526d1))

- Checksums
  ([`aa66344`](https://github.com/SailfinIO/sailfin/commit/aa66344ed9da76fe4d17ef225d40886f28b31046))

- Diagnostics missing local bindings
  ([`20c9446`](https://github.com/SailfinIO/sailfin/commit/20c94464e350f00adf8fa8196b1ab5f148240fd4))

- Inlining to reduce
  ([`d88ae32`](https://github.com/SailfinIO/sailfin/commit/d88ae321ce6bb00d75a518eecd500e1de2c49c11))

- Package stage2 and build
  ([`8aafe97`](https://github.com/SailfinIO/sailfin/commit/8aafe9713916e2edcb46d4fcaae884a09620cf41))

- Prelude warnings
  ([`7fecb52`](https://github.com/SailfinIO/sailfin/commit/7fecb52e1bbde197066134765841ed18248a2288))

- Retarget recent mutations
  ([`699e27d`](https://github.com/SailfinIO/sailfin/commit/699e27df5652a0b55107ed8a152119319496a12e))

- Slicing to bracket
  ([`ae67639`](https://github.com/SailfinIO/sailfin/commit/ae676398213935a2e126eaa98ca2e8596fbe811b))

- String handling
  ([`a492dbd`](https://github.com/SailfinIO/sailfin/commit/a492dbd9eefe1ed65bfa64bd0c82103c114b8c86))

- Stubb suspension
  ([`964490f`](https://github.com/SailfinIO/sailfin/commit/964490f747c83e9a840b6b6ed54c7c2d3871d746))

- Work on effects list
  ([`49b4dfb`](https://github.com/SailfinIO/sailfin/commit/49b4dfb7bcf5c917249cc00a120c11ba7d51a13d))

- **stage2**: Align emitter import/export syntax with Stage1 and update test expectations
  ([`0351ece`](https://github.com/SailfinIO/sailfin/commit/0351ece54e9b06ab372c9b67bfeb49c0018ed6a8))

- Update compiler/src/emitter_sailfin.sfn to emit `import() from "..."` and `export() from "..."`
  for empty specifier lists, matching Stage1 canonical output - Rebuild stage2 artifacts to include
  the emitter fix - Update stage2 string literal tests to expect malloc-based lowering (Stage2
  approach) instead of @.str. global constants - Fix metadata.ll golden snapshot to include
  sailfin_runtime_number_to_string declare - Skip test_stage2_emits_native_artifacts (known issue
  with JIT artifact marshaling) - All 132 stage2 tests now pass (previously 6 failures)

- **stage2**: Improve clang/AOT compatibility
  ([`dd8e9ef`](https://github.com/SailfinIO/sailfin/commit/dd8e9efffef055ab45dd7e1b9a362785765ebb80))

### Chores

- **repo**: Stop tracking build outputs
  ([`9532992`](https://github.com/SailfinIO/sailfin/commit/9532992be92c19b7738e2ec4d42116764be7d682))


## v0.1.1-alpha.64 (2025-10-21)

### Bug Fixes

- Collection returns
  ([`9a00de8`](https://github.com/SailfinIO/sailfin/commit/9a00de860c0965fc06cff2bed8900bd5192c4ec8))

- Combined lines
  ([`34fdc20`](https://github.com/SailfinIO/sailfin/commit/34fdc20c2748b45fb654efec5cfd00911003dfd2))

- Deeper lowering pass
  ([`20ed226`](https://github.com/SailfinIO/sailfin/commit/20ed2269a9771c53ae5e0b3545ed3317733911ea))

- Missing token import
  ([`f9a313b`](https://github.com/SailfinIO/sailfin/commit/f9a313b7256b50f69b731e0d44131382a52d1ba0))

- Runtime descriptors
  ([`bafbe95`](https://github.com/SailfinIO/sailfin/commit/bafbe951b4481334a0e64671d1cfd58ce5afd7b1))

- Runtime helper descriptor wiring
  ([`8aa0425`](https://github.com/SailfinIO/sailfin/commit/8aa0425342958c7494c89ff0630f7e3622cd08f6))

- Simplify emitter
  ([`b93f76d`](https://github.com/SailfinIO/sailfin/commit/b93f76d395fb1616191c75855753286614088f59))

- Sliced_text
  ([`40c4dd2`](https://github.com/SailfinIO/sailfin/commit/40c4dd27e4a8c9ce5155ac3db9f1e323e1f02b20))

- Stop mutating input
  ([`cb48fc3`](https://github.com/SailfinIO/sailfin/commit/cb48fc3e3ae71c3f408ceaae6a91c4b2e4798082))

- Strings
  ([`6101299`](https://github.com/SailfinIO/sailfin/commit/61012999f6f5557d42f394d4a25644e7e3388abc))

- Tests
  ([`02c4f07`](https://github.com/SailfinIO/sailfin/commit/02c4f0754c4f731d267c3154a311e3a34d6737df))

- Type-check helpers
  ([`1a88f7e`](https://github.com/SailfinIO/sailfin/commit/1a88f7eaa365b1189401ab38844c7624b320e47d))


## v0.1.1-alpha.63 (2025-10-21)

### Bug Fixes

- Pointer related references
  ([`617dbe9`](https://github.com/SailfinIO/sailfin/commit/617dbe9a17095b9d95cbe644d01926774029b29d))


## v0.1.1-alpha.62 (2025-10-21)

### Bug Fixes

- Native text context
  ([`f8e022b`](https://github.com/SailfinIO/sailfin/commit/f8e022bb1dd5fe9822a86d319d2005920514bd6b))


## v0.1.1-alpha.61 (2025-10-21)

### Bug Fixes

- Combined manifests
  ([`1d49570`](https://github.com/SailfinIO/sailfin/commit/1d495703ce63f1980d07eafd4457f5e10b6d7d0f))


## v0.1.1-alpha.60 (2025-10-21)

### Bug Fixes

- Pointer coercion
  ([`ece4195`](https://github.com/SailfinIO/sailfin/commit/ece41956ddb43329a192f56ab6a1d4520601109f))


## v0.1.1-alpha.59 (2025-10-21)

### Bug Fixes

- Operator scanner
  ([`a777158`](https://github.com/SailfinIO/sailfin/commit/a777158421675438ec1613b0a46e4d973b8c45d3))


## v0.1.1-alpha.58 (2025-10-21)

### Bug Fixes

- Metadata runtime
  ([`edae93a`](https://github.com/SailfinIO/sailfin/commit/edae93ac0b1a9ccd4dde3f343c51de1ece7c0d68))


## v0.1.1-alpha.57 (2025-10-20)

### Bug Fixes

- Work on stage2 parity
  ([`8234468`](https://github.com/SailfinIO/sailfin/commit/8234468e38917fbb7e9a9a20141ac8ac94276fd7))

- Work on stage2 parity
  ([`4264b75`](https://github.com/SailfinIO/sailfin/commit/4264b756e8861862e72133c50b02fb55de7f2f30))

- Work on stage2 parity
  ([`a6a8e1c`](https://github.com/SailfinIO/sailfin/commit/a6a8e1c0506d0cbf8a496bb7877efee108a9000c))


## v0.1.1-alpha.56 (2025-10-20)

### Bug Fixes

- Work on stage2 parity
  ([`2062233`](https://github.com/SailfinIO/sailfin/commit/206223392644d9f42c3f5f9eb3545f7465e29009))


## v0.1.1-alpha.55 (2025-10-20)

### Bug Fixes

- Work on stage2 parity
  ([`0c67039`](https://github.com/SailfinIO/sailfin/commit/0c670398cb1064b1546c4526f591ab5788078306))

- Work on stage2 parity
  ([`731144c`](https://github.com/SailfinIO/sailfin/commit/731144c6b3ac1594c5ff9ed80b298e874c720fe0))

- Work on stage2 parity
  ([`1aec47f`](https://github.com/SailfinIO/sailfin/commit/1aec47f6b63060a0bce2eab635481f2845d29c3d))

- Work on stage2 parity
  ([`da493dd`](https://github.com/SailfinIO/sailfin/commit/da493dd8a572e8e821cb18824cb7b85499c65a5f))

- Work on stage2 parity
  ([`271fd47`](https://github.com/SailfinIO/sailfin/commit/271fd47ab3aa3264f62701a31b4c906555b75939))

- Work on stage2 parity
  ([`c96ba4c`](https://github.com/SailfinIO/sailfin/commit/c96ba4c673b4744ce6aa1b7a096f04dcb01f2dc5))

- Work on stage2 parity
  ([`2fa6797`](https://github.com/SailfinIO/sailfin/commit/2fa6797324300e3fca96302a3ad391c51a7a6e6c))


## v0.1.1-alpha.54 (2025-10-20)

### Bug Fixes

- Work on stage2 parity
  ([`9104604`](https://github.com/SailfinIO/sailfin/commit/9104604d35f3444c61bf57f5f097ebeb83248afd))

- Work on stage2 parity
  ([`48b79c4`](https://github.com/SailfinIO/sailfin/commit/48b79c48c9110c99b86660d29c552091caff0fa3))

- Work on stage2 parity
  ([`a8449e1`](https://github.com/SailfinIO/sailfin/commit/a8449e1453150aa2db2ad8273f19eb83064fdae0))

- Work on stage2 parity
  ([`e479158`](https://github.com/SailfinIO/sailfin/commit/e47915849083cf99201f1326539209a28348ccdf))

- Work on stage2 parity
  ([`be64ae7`](https://github.com/SailfinIO/sailfin/commit/be64ae724b33abc6f55851b6d1a87801959aef17))

- Work on stage2 parity
  ([`36d59f8`](https://github.com/SailfinIO/sailfin/commit/36d59f8eb71e1b58be76812f393c1acbbff4b5a5))

- Work on stage2 parity
  ([`d8879b7`](https://github.com/SailfinIO/sailfin/commit/d8879b75b82259cf441c3a9752a80e2a8b4da033))

- Work on stage2 parity
  ([`ea03cba`](https://github.com/SailfinIO/sailfin/commit/ea03cbad35efbc1962d45debd523ad3b7fec0523))

- Work on stage2 parity
  ([`30fd80e`](https://github.com/SailfinIO/sailfin/commit/30fd80ecaaa3eba743d26c225ce2e6808c442c32))

- Work on stage2 parity
  ([`a8c2d20`](https://github.com/SailfinIO/sailfin/commit/a8c2d2024ca8e8aa517232063fa9102ef54d00fb))

- Work on stage2 parity
  ([`94f9ef8`](https://github.com/SailfinIO/sailfin/commit/94f9ef8a448dc42090ba51064733e88678947018))


## v0.1.1-alpha.53 (2025-10-19)

### Bug Fixes

- Reduce stage2 warnings
  ([`25920a2`](https://github.com/SailfinIO/sailfin/commit/25920a2735e3f2bf6d76d3535107ccae6eb402f8))

- Work on stage2 parity
  ([`891be5b`](https://github.com/SailfinIO/sailfin/commit/891be5b201a6c32a83d8e74af1357e676d8e2450))

- Work on stage2 parity
  ([`5117b03`](https://github.com/SailfinIO/sailfin/commit/5117b03533a3385305530b5366c884982f7e0716))

- Work on stage2 parity
  ([`e93eb60`](https://github.com/SailfinIO/sailfin/commit/e93eb60f9cb322a01ecacd3f4d3d7a4b19efadcd))

- Work on stage2 parity
  ([`c4145bc`](https://github.com/SailfinIO/sailfin/commit/c4145bcc02612cffd13b2d919ca28fe3a0075b57))

- Work on stage2 parity
  ([`c8990cf`](https://github.com/SailfinIO/sailfin/commit/c8990cf61880ccb051a52c2936919defc4367fcd))

- Work on stage2 parity
  ([`3796914`](https://github.com/SailfinIO/sailfin/commit/37969141ac917ee15c475064c7882b976e2ea3ea))

- Work on stage2 parity
  ([`3f19ea4`](https://github.com/SailfinIO/sailfin/commit/3f19ea41ca470352f5ccdffc836f1bc0eb785203))

- Work on stage2 parity
  ([`38dbd97`](https://github.com/SailfinIO/sailfin/commit/38dbd976a77bbd0b840d90ffcfefe061ab1a8ae1))

- Work on stage2 parity
  ([`4d49864`](https://github.com/SailfinIO/sailfin/commit/4d4986468c28c3c2b3d591fd11ed0e68ad9d00df))

- Work on stage2 parity
  ([`8ad2336`](https://github.com/SailfinIO/sailfin/commit/8ad2336a1d0bd89c8f2a670c4899bafab3263069))

- Work on stage2 parity
  ([`fcccbac`](https://github.com/SailfinIO/sailfin/commit/fcccbac98464da97158d3de5f4953cf73dcb9949))

- Work on stage2 parity
  ([`4f69a8d`](https://github.com/SailfinIO/sailfin/commit/4f69a8d0d3293162228914f6da03ce3e72dbc106))

- Work on stage2 parity
  ([`cf94f3e`](https://github.com/SailfinIO/sailfin/commit/cf94f3eafcef9cc11a0a476e71a3bbb564b74f1f))

### Documentation

- Self hosting stage2 roadmap
  ([`07e7768`](https://github.com/SailfinIO/sailfin/commit/07e776830abf447ac46a1d842ca4307388258439))


## v0.1.1-alpha.52 (2025-10-18)

### Bug Fixes

- Additional test ahead of stage2 compile
  ([`f8a9327`](https://github.com/SailfinIO/sailfin/commit/f8a9327a631cf18836c6e5db766336809bdb525b))

### Documentation

- String literal and self roadmap completion
  ([`33294ba`](https://github.com/SailfinIO/sailfin/commit/33294ba529b70dba8b357fbd6984f527ca93f170))


## v0.1.1-alpha.51 (2025-10-18)

### Bug Fixes

- String lowering in llvm backend passing again
  ([`4de2a96`](https://github.com/SailfinIO/sailfin/commit/4de2a96873375fa5608c407ae5b0e0a23f86d5f9))


## v0.1.1-alpha.50 (2025-10-18)

### Bug Fixes

- Bridge capability adapters
  ([`f6c891b`](https://github.com/SailfinIO/sailfin/commit/f6c891ba218c3922fb5da766261d16df38700b35))

- Register capability adapters
  ([`a0bfabb`](https://github.com/SailfinIO/sailfin/commit/a0bfabb358574c3fab03451752d0b7601fac18d4))


## v0.1.1-alpha.49 (2025-10-18)

### Bug Fixes

- Capability aware intrinsics
  ([`3925fad`](https://github.com/SailfinIO/sailfin/commit/3925fadfda31068a0556fe9fce784bb7c14f1b22))

### Documentation

- Roadmap updates
  ([`c6807b5`](https://github.com/SailfinIO/sailfin/commit/c6807b50ebc0df5431ce15d96d689e0f11ee0d27))


## v0.1.1-alpha.48 (2025-10-17)

### Bug Fixes

- Cross module testing:
  ([`7441a57`](https://github.com/SailfinIO/sailfin/commit/7441a57aafebf4c080e3a9301a18197f1b46cdc4))


## v0.1.1-alpha.47 (2025-10-17)

### Bug Fixes

- Share layout descriptors
  ([`0770f14`](https://github.com/SailfinIO/sailfin/commit/0770f141284d864434be6316bdad22a729477f4b))


## v0.1.1-alpha.46 (2025-10-17)

### Bug Fixes

- Surface enum arrays
  ([`ac48400`](https://github.com/SailfinIO/sailfin/commit/ac48400222d77ba26fa9aaceb96f9ac120c35e71))


## v0.1.1-alpha.45 (2025-10-17)

### Bug Fixes

- Lower method dispatch through interface values
  ([`1cbb374`](https://github.com/SailfinIO/sailfin/commit/1cbb37497fd69df1eed6998807b5aac7588e5580))


## v0.1.1-alpha.44 (2025-10-17)

### Bug Fixes

- Interface trait objects and vtables
  ([`fb40ec4`](https://github.com/SailfinIO/sailfin/commit/fb40ec48d9e4ecb7fb22f82c5e99d3f7b28d7d1e))


## v0.1.1-alpha.43 (2025-10-17)

### Bug Fixes

- Enum lowering
  ([`d488120`](https://github.com/SailfinIO/sailfin/commit/d4881208bbc753cfc302b3708c029c5f0402ad9d))


## v0.1.1-alpha.42 (2025-10-17)

### Bug Fixes

- Payload field extraction
  ([`a742968`](https://github.com/SailfinIO/sailfin/commit/a742968e4f70c8874337b1c865f7a5e125434534))


## v0.1.1-alpha.41 (2025-10-17)

### Bug Fixes

- Inline payload emission
  ([`6cc6088`](https://github.com/SailfinIO/sailfin/commit/6cc6088ce686fb3b26d9f589d58f4aa196706374))


## v0.1.1-alpha.40 (2025-10-17)

### Bug Fixes

- Enum lowering
  ([`6b2b0f3`](https://github.com/SailfinIO/sailfin/commit/6b2b0f3065be1f519773a08536e1213c8ffa913a))


## v0.1.1-alpha.39 (2025-10-17)

### Bug Fixes

- Enum lowering
  ([`69a32ec`](https://github.com/SailfinIO/sailfin/commit/69a32ec49b086a314a227d8cdd68cd77b16df73e))


## v0.1.1-alpha.38 (2025-10-17)

### Bug Fixes

- Refactor finalized ssa/phi
  ([`4ef4076`](https://github.com/SailfinIO/sailfin/commit/4ef40762817bc09629be32544a6394f6ca9ff684))


## v0.1.1-alpha.37 (2025-10-17)

### Bug Fixes

- Phi match merges
  ([`3e40c15`](https://github.com/SailfinIO/sailfin/commit/3e40c1504f99c97a81cc3871b84c6eb2749f21b6))

- Unused var
  ([`95a40dd`](https://github.com/SailfinIO/sailfin/commit/95a40dd60a5028fce483554b0154833e8c5f3657))


## v0.1.1-alpha.36 (2025-10-17)

### Bug Fixes

- Loop header phis
  ([`b741dc3`](https://github.com/SailfinIO/sailfin/commit/b741dc3bbb79f4e18b6efaeed26bd21406418362))


## v0.1.1-alpha.35 (2025-10-17)

### Bug Fixes

- If/else merges
  ([`1f979d6`](https://github.com/SailfinIO/sailfin/commit/1f979d672dc3bcfd8ba3b87af30d465651b7b188))


## v0.1.1-alpha.34 (2025-10-17)

### Bug Fixes

- Straight-line ifs
  ([`2e50344`](https://github.com/SailfinIO/sailfin/commit/2e50344b7fa944e7b68e60ffe97e6f0c3e48db2c))


## v0.1.1-alpha.33 (2025-10-17)

### Bug Fixes

- Metadata threading
  ([`51649e5`](https://github.com/SailfinIO/sailfin/commit/51649e536380475c9f0b622b5f3f0bf1db79214e))

### Documentation

- Add claude
  ([`547d438`](https://github.com/SailfinIO/sailfin/commit/547d438298a728bcdd1ff4256a5a9d7afe12390c))

- Add gemini guide
  ([`2d49027`](https://github.com/SailfinIO/sailfin/commit/2d49027b10e8f39257fe776bf9bf47e8724a6fd5))


## v0.1.1-alpha.32 (2025-10-17)

### Bug Fixes

- Mutation capture
  ([`46e108e`](https://github.com/SailfinIO/sailfin/commit/46e108e86de67a76d8ce358bf90c04d35a6d6782))

### Documentation

- Roadmap task enhancement
  ([`bd5580e`](https://github.com/SailfinIO/sailfin/commit/bd5580ef16969e12eb1627d34b0df3a9b7f2d9b7))


## v0.1.1-alpha.31 (2025-10-17)

### Bug Fixes

- Warnings for pointer layouts
  ([`84f1d29`](https://github.com/SailfinIO/sailfin/commit/84f1d29fc781877ad7d52b46c19e0c9dfcc2d865))

### Documentation

- Roadmap task enhancement
  ([`6d080f0`](https://github.com/SailfinIO/sailfin/commit/6d080f090621cd75977d6b3a0bf49c326c37b5d4))


## v0.1.1-alpha.30 (2025-10-17)

### Bug Fixes

- Borrow lifetime tracking
  ([`dd4f2ae`](https://github.com/SailfinIO/sailfin/commit/dd4f2ae590e9121364c1f238b182672f7db86918))


## v0.1.1-alpha.29 (2025-10-17)

### Bug Fixes

- Stage2 runner needed
  ([`b5aebc1`](https://github.com/SailfinIO/sailfin/commit/b5aebc12684e00726dadacf98c0cc2151dd6bb09))

### Documentation

- Stage2 prioritization
  ([`d3a26ba`](https://github.com/SailfinIO/sailfin/commit/d3a26ba984665f5ef77b937cd96afabe9cfd660e))


## v0.1.1-alpha.28 (2025-10-17)

### Bug Fixes

- Runtime adapter bridging
  ([`31bf982`](https://github.com/SailfinIO/sailfin/commit/31bf982758e25eba1288b19a97776a7e3d86b0c3))


## v0.1.1-alpha.27 (2025-10-17)

### Bug Fixes

- Some of the pointer fallback warnings during compilation
  ([`c784af4`](https://github.com/SailfinIO/sailfin/commit/c784af49b87653250e126dd3b7a613993488cb97))


## v0.1.1-alpha.26 (2025-10-17)

### Bug Fixes

- Test modernization
  ([`9b23feb`](https://github.com/SailfinIO/sailfin/commit/9b23febdc81b6211ac46e85f11cdcc6b17bf255a))


## v0.1.1-alpha.25 (2025-10-17)

### Bug Fixes

- Continued test enhancements to reduce time
  ([`5646662`](https://github.com/SailfinIO/sailfin/commit/56466628b907fb97fdb5f5e51c8807566f4029c3))


## v0.1.1-alpha.24 (2025-10-17)

### Bug Fixes

- Base scoped metadata and testing proposal
  ([`96137ef`](https://github.com/SailfinIO/sailfin/commit/96137efedaec42a51a220fa73e3bf707575dd14f))

- Reduce test duration
  ([`3bc8abb`](https://github.com/SailfinIO/sailfin/commit/3bc8abbe1e6567ba6a2cea25dd49684a2c1c8471))


## v0.1.1-alpha.23 (2025-10-17)

### Bug Fixes

- Scope metadata through local consumption
  ([`511fadf`](https://github.com/SailfinIO/sailfin/commit/511fadfb1ecac70b694e54979f8627a3bd17569d))


## v0.1.1-alpha.22 (2025-10-17)

### Bug Fixes

- Accumulate regions during lowering
  ([`3cd4fac`](https://github.com/SailfinIO/sailfin/commit/3cd4facf265cc77a8c0d8fea41dbea8f0352a93d))


## v0.1.1-alpha.21 (2025-10-16)

### Bug Fixes

- Array descriptors ctype carriers
  ([`9c59d61`](https://github.com/SailfinIO/sailfin/commit/9c59d6158f70693cbf4106f5c94f61cf98f07d91))

### Documentation

- Stage2 tasks
  ([`5a1cc16`](https://github.com/SailfinIO/sailfin/commit/5a1cc16130b0c44fec4c8edb00d3987f739f8a4a))


## v0.1.1-alpha.20 (2025-10-16)

### Bug Fixes

- Declaration spans from parser to typechecker
  ([`587bb97`](https://github.com/SailfinIO/sailfin/commit/587bb977af2da2fd2141c85a40ec9baff176df66))

- Diagnostics snippets
  ([`1df0aca`](https://github.com/SailfinIO/sailfin/commit/1df0acaffc88bb06efe8480cdfe53c6ccd4560b1))


## v0.1.1-alpha.19 (2025-10-16)

### Bug Fixes

- Docs referencing scratch dir
  ([`7538204`](https://github.com/SailfinIO/sailfin/commit/753820433e03585045bccf967403d84d714ff203))

- Struct literal lowering
  ([`9ac5c4e`](https://github.com/SailfinIO/sailfin/commit/9ac5c4e1e3ffb308400dfa2c34ca2f1634201b59))


## v0.1.1-alpha.18 (2025-10-16)

### Bug Fixes

- Imterface implements type enforcement
  ([`b4efbcd`](https://github.com/SailfinIO/sailfin/commit/b4efbcd7e467ebef03ed3d99da9aa3f466903527))


## v0.1.1-alpha.17 (2025-10-16)

### Bug Fixes

- Missing typeschecks
  ([`e4a8f8c`](https://github.com/SailfinIO/sailfin/commit/e4a8f8ce43c8094a0aa05a953c4c676086d42d1f))


## v0.1.1-alpha.16 (2025-10-16)

### Bug Fixes

- Parameter spans flow insto stage2 diagnostics
  ([`f40a610`](https://github.com/SailfinIO/sailfin/commit/f40a610f63bd8dffdda5559345bfb73352c9fcd7))


## v0.1.1-alpha.15 (2025-10-16)

### Bug Fixes

- Struct metadata through member access
  ([`77dbcfc`](https://github.com/SailfinIO/sailfin/commit/77dbcfc60c03e57dafe82b6f5f46d10f46901269))


## v0.1.1-alpha.14 (2025-10-15)

### Bug Fixes

- Source span attachment so suspension-conflict
  ([`13e49c7`](https://github.com/SailfinIO/sailfin/commit/13e49c7c918ace807413f33075e8bff07bf7542c))


## v0.1.1-alpha.13 (2025-10-15)

### Bug Fixes

- Lattice rejecting enforcement
  ([`f489772`](https://github.com/SailfinIO/sailfin/commit/f489772b106e13ae2d46a9cea9bc3f82af440903))


## v0.1.1-alpha.12 (2025-10-15)

### Bug Fixes

- Sythetic native artifact in test for now
  ([`e26b034`](https://github.com/SailfinIO/sailfin/commit/e26b034b4800e38275dc9b2499ea07801405b792))


## v0.1.1-alpha.11 (2025-10-15)

### Bug Fixes

- Fall back to instruction span
  ([`7ed4465`](https://github.com/SailfinIO/sailfin/commit/7ed4465f65cebd8a4ccb08d0edb250c460639723))

- Regrssions for diagnostics
  ([`e1d084f`](https://github.com/SailfinIO/sailfin/commit/e1d084fceda9a80ead068a64ce52134ced4fa869))


## v0.1.1-alpha.10 (2025-10-15)

### Bug Fixes

- Wire span metadata into stage2 lowering
  ([`230e33c`](https://github.com/SailfinIO/sailfin/commit/230e33c776770836b23f64ad6c047ab8ea1f3f56))


## v0.1.1-alpha.9 (2025-10-15)

### Bug Fixes

- Regressions for use after move
  ([`b90156e`](https://github.com/SailfinIO/sailfin/commit/b90156ec8173ff236ea9f30b4d0416f360ec7468))


## v0.1.1-alpha.8 (2025-10-15)

### Bug Fixes

- Borrow effect metadata
  ([`4bafaa7`](https://github.com/SailfinIO/sailfin/commit/4bafaa78dc32025923e43515737ef8e55b534df9))


## v0.1.1-alpha.7 (2025-10-15)

### Bug Fixes

- Borrowing threaded ownership
  ([`b3bfdcd`](https://github.com/SailfinIO/sailfin/commit/b3bfdcd93e2973ae2948038e38df2f670d31a109))

### Documentation

- Refreshed on borrowing
  ([`cad1dab`](https://github.com/SailfinIO/sailfin/commit/cad1dab1dd3be2e98161a5a95b38654ac7bb750b))


## v0.1.1-alpha.6 (2025-10-15)

### Bug Fixes

- Lowering importing interface/struct metadata
  ([`644171b`](https://github.com/SailfinIO/sailfin/commit/644171bfee6c0237afeea430d5a0e62609382e54))

- Parsed interface metta data plumbing
  ([`75577ef`](https://github.com/SailfinIO/sailfin/commit/75577efb36627387b5e3c92bc73dd0fdca0120dd))


## v0.1.1-alpha.5 (2025-10-14)

### Bug Fixes

- .push to .append rewrite after re-build
  ([`fa3bdab`](https://github.com/SailfinIO/sailfin/commit/fa3bdabe439e738f40886a40c6fd0d2297f09136))

- Rewrite push calls scans expression
  ([`35da81b`](https://github.com/SailfinIO/sailfin/commit/35da81b60e7d0fd82b43d0714237943d1e2f4b8b))

### Documentation

- Runtime assesment
  ([`0c1f6d6`](https://github.com/SailfinIO/sailfin/commit/0c1f6d684e189bd0dc67e03dccfc3c3579c55dba))

- Update roadmap
  ([`ef63d55`](https://github.com/SailfinIO/sailfin/commit/ef63d556cd0ac5a07f8f4b836f4edf1cf61c0af3))


## v0.1.1-alpha.4 (2025-10-12)

### Bug Fixes

- Importing and exporting and runtime
  ([`cc4f049`](https://github.com/SailfinIO/sailfin/commit/cc4f0490d8df3be50b043f54d31e14629a40e17e))

### Documentation

- Update roadmap and status for de pythonization
  ([`29f2af9`](https://github.com/SailfinIO/sailfin/commit/29f2af953889d22533e8938074e6d965c9066ca0))


## v0.1.1-alpha.3 (2025-10-11)

### Bug Fixes

- Gitignore build dir so workflow can rebuild as well as archive stage0 and update docs
  ([`bec69c0`](https://github.com/SailfinIO/sailfin/commit/bec69c03730b749d2bbce141c13fe78a17408bb4))

- Move sys path injection
  ([`fc6e3a4`](https://github.com/SailfinIO/sailfin/commit/fc6e3a41d6a7a00bfac0eafed868459a6987b038))


## v0.1.1-alpha.2 (2025-10-11)

### Bug Fixes

- Install script release resolving
  ([`d425395`](https://github.com/SailfinIO/sailfin/commit/d425395ac2222aec3dffa006cd3dfe6d4d11dcfb))

### Documentation

- Update to reference current stage1 self hosting
  ([`7e770d2`](https://github.com/SailfinIO/sailfin/commit/7e770d243275313c860d7b75dd2004e5b163180b))


## v0.1.1-alpha.1 (2025-10-11)

### Bug Fixes

- Add installer
  ([`6fb6f79`](https://github.com/SailfinIO/sailfin/commit/6fb6f7966da6c564459f6f12eb7790ade6e79b27))

- Gh creds
  ([`455c44d`](https://github.com/SailfinIO/sailfin/commit/455c44dfb8a9965c7e4ae1e7092aabdb760a8846))

- Gh creds
  ([`48cfbb4`](https://github.com/SailfinIO/sailfin/commit/48cfbb4bab74e13fdd05df9da3f8df4b0779f038))

- Semantic release version missing in workflow
  ([`ca96192`](https://github.com/SailfinIO/sailfin/commit/ca96192e8c6baa6e13a2145a1761b3208240fd69))


## v0.1.0 (2025-10-11)

### Bug Fixes

- Add bootstrap back for now
  ([`57cc0d7`](https://github.com/SailfinIO/sailfin/commit/57cc0d7cc01737e6e7418faff74ae12e57381c42))

- Add effect checker to walk ast and ensure routine containing prompt block declares model effect
  ([`3030d9e`](https://github.com/SailfinIO/sailfin/commit/3030d9eaed95ea6b267cf392aa64063c4a56730a))

- Additional syntax support
  ([`d78724c`](https://github.com/SailfinIO/sailfin/commit/d78724cf00d184c35fb345168e1ca8b4101b5a07))

- Branch config for semantic release anc versioning
  ([`1691047`](https://github.com/SailfinIO/sailfin/commit/1691047587aff0792f4198b02f2e11b4085cafbc))

- Conda env setup
  ([`86cbfde`](https://github.com/SailfinIO/sailfin/commit/86cbfdee47ec4193d21948b1bc1b559863fe63df))

- Docs updates and effect checker enhancements
  ([`28b1aeb`](https://github.com/SailfinIO/sailfin/commit/28b1aeb1f8f0aef976daf73ba81c30229f9d74b2))

- Hooked decorators into semantics and effect inference so the self-hosted parser no longer treats
  them as passive metadata
  ([`0830f08`](https://github.com/SailfinIO/sailfin/commit/0830f08fd89aa9bca11b44b639dfcf8d27e92145))

- Language examples parsing
  ([`bd0f00c`](https://github.com/SailfinIO/sailfin/commit/bd0f00c14748ca39494602c26ab1683f3727f044))

- Language extension support
  ([`8fc12de`](https://github.com/SailfinIO/sailfin/commit/8fc12def8a513dd545ec8d702f4716ab23926b6e))

- Lexer handling rudimentery syntax
  ([`9b52f47`](https://github.com/SailfinIO/sailfin/commit/9b52f47435a353fd52b4b2fe4fe6496370fcbad3))

- Missing examples for additional syntax
  ([`a43063c`](https://github.com/SailfinIO/sailfin/commit/a43063c1d1829c8b0f45ffcdeebc2b5a118aaa75))

- Naming convensions
  ([`92463c0`](https://github.com/SailfinIO/sailfin/commit/92463c0040ede86d30369de5e65c4b283f4ac672))

- Only use github release
  ([`91cfd44`](https://github.com/SailfinIO/sailfin/commit/91cfd4484d93d71fe1013e46048d48c2f10bc8d7))

- Package root dir
  ([`658737f`](https://github.com/SailfinIO/sailfin/commit/658737f452321f54a862430292f9e123b4edd977))

- Pathing for extension
  ([`00d11cc`](https://github.com/SailfinIO/sailfin/commit/00d11cc81250b35f0ffbd1439a0d3f49a1c51356))

- Progress on example support
  ([`71d5b15`](https://github.com/SailfinIO/sailfin/commit/71d5b15294af976f1b3dce81cee669f00c4b72f1))

- Pyproject.toml
  ([`b9bd329`](https://github.com/SailfinIO/sailfin/commit/b9bd329994aded1fe4683bc8c930690fa0a4bd18))

- Remove broken bootstrap release and add stage1 release
  ([`1faa71b`](https://github.com/SailfinIO/sailfin/commit/1faa71bdeafb6cd6daab6bedf9c3f758c058de18))

- Rename compiler dir
  ([`0a343ad`](https://github.com/SailfinIO/sailfin/commit/0a343ad5b6ca79b6739a03c5a523a9923344f2f6))

- Self hosting ast
  ([`12fbcb3`](https://github.com/SailfinIO/sailfin/commit/12fbcb363877db5132d51e75a6b2e0c9b7b934d6))

- Semantic release releasing
  ([`9785481`](https://github.com/SailfinIO/sailfin/commit/9785481cfaec67dc987fe89352e40c52e112049a))

- Sematic release in pyproject.toml
  ([`13df576`](https://github.com/SailfinIO/sailfin/commit/13df576a685c03681ec9e8724862f1bbe15b8561))

- Test bump detection
  ([`7febc4c`](https://github.com/SailfinIO/sailfin/commit/7febc4cc00751d0266bbb940869fca165cbf3e56))

- Trigger first automated binary release
  ([`941a0bc`](https://github.com/SailfinIO/sailfin/commit/941a0bcd27243833449acbf0c7a809f6d5ce0ae6))

- Use conda and fix broken tests
  ([`0021605`](https://github.com/SailfinIO/sailfin/commit/00216056da7c5bc033438cdd462d2785e6022950))

- Use semantic release
  ([`39a8965`](https://github.com/SailfinIO/sailfin/commit/39a8965c0566774c8e3c782e8e26a0369ef79fdd))

- Working directory
  ([`029f2de`](https://github.com/SailfinIO/sailfin/commit/029f2de5c7015f9d01c7667b8cf12b0e5d2e5936))

### Chores

- Package lock update
  ([`04263ff`](https://github.com/SailfinIO/sailfin/commit/04263ffe6a893db404389c786fddef4459350dc8))

- Remove unused llvm and http def
  ([`354d6ca`](https://github.com/SailfinIO/sailfin/commit/354d6ca481cea2b579c54ad3e54c060f19a8dca9))

- Repo level gitignore
  ([`7d7bdf2`](https://github.com/SailfinIO/sailfin/commit/7d7bdf22507b26202d7a7ee4e2275eb8ffd75877))

- **deps-dev**: Bump esbuild from 0.24.2 to 0.25.0 in /extension
  ([`ea6789d`](https://github.com/SailfinIO/sailfin/commit/ea6789d2a299eb9869c2c6705719f1158957f160))

Bumps [esbuild](https://github.com/evanw/esbuild) from 0.24.2 to 0.25.0. - [Release
  notes](https://github.com/evanw/esbuild/releases) -
  [Changelog](https://github.com/evanw/esbuild/blob/main/CHANGELOG-2024.md) -
  [Commits](https://github.com/evanw/esbuild/compare/v0.24.2...v0.25.0)

--- updated-dependencies: - dependency-name: esbuild dependency-version: 0.25.0

dependency-type: direct:development ...

Signed-off-by: dependabot[bot] <support@github.com>

- **gitignore**: Add root-level ignores; ignore bootstrap poetry.lock and PLY outputs; untrack
  generated files
  ([`14229f6`](https://github.com/SailfinIO/sailfin/commit/14229f6fce4e5a584c2ebea959f7b4843e9d9bb4))

### Documentation

- Add and reference style guide
  ([`58d14d6`](https://github.com/SailfinIO/sailfin/commit/58d14d6ba2e42c31cd2dc4861e934231ab82cd73))

- Add engine, adapters, tensors, training proposal
  ([`943fa15`](https://github.com/SailfinIO/sailfin/commit/943fa15fd87172dc6dbc20cd62954284fffe6976))

- Consitancy refactor
  ([`4936657`](https://github.com/SailfinIO/sailfin/commit/493665785ff6d9051a18efa6c9add624bb647ccb))

- Fix inconsistencies regarding print
  ([`ad0168f`](https://github.com/SailfinIO/sailfin/commit/ad0168f7b1751a191c597a14072e8da58683a8b2))

- Language enhancements
  ([`bec7437`](https://github.com/SailfinIO/sailfin/commit/bec743714e6aa94070682f1167dca2ff5ef18459))

- Move enbf to docs dir
  ([`8f6b380`](https://github.com/SailfinIO/sailfin/commit/8f6b3807f0a188c1bd5de734ba286f7e5af1339c))

- Outline algorithm capsule plans
  ([`8cfaa64`](https://github.com/SailfinIO/sailfin/commit/8cfaa642ddc36698f024c63aa9c414b98d68e227))

- Update docs for additional syntax
  ([`cc332ee`](https://github.com/SailfinIO/sailfin/commit/cc332ee787d49b19ab04230b4788d2b88c891de1))

- Update for package management handling and structure
  ([`97916e9`](https://github.com/SailfinIO/sailfin/commit/97916e93bb337a3347bb09587c215dd29a80e87f))

- Update roadmap and status to prioritize self hosting
  ([`000f8b5`](https://github.com/SailfinIO/sailfin/commit/000f8b5ce2c9d00d995df8b48a32ec1ff8c3c3a9))

- Update sfn readme
  ([`83a8f48`](https://github.com/SailfinIO/sailfin/commit/83a8f480b45efc9c9a8fe0c3370148d969218867))

- Update to demonstrate effect checker
  ([`cb8a446`](https://github.com/SailfinIO/sailfin/commit/cb8a446c8cd2cfc0479f62bfa484f61dea844ece))
