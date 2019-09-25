## [0.4.0](https://github.com/adhocore/tusc.sh/releases/tag/0.4.0) (2019-09-25)

### Features
- Show spinner on slower subtasks (Jitendra Adhikari) [_832acaa_](https://github.com/adhocore/tusc.sh/commit/832acaa)

### Documentations
- On git lfs (Jitendra Adhikari) [_0a389a8_](https://github.com/adhocore/tusc.sh/commit/0a389a8)

### Miscellaneous
- Remove -i suffix for sed (Jitendra Adhikari) [_822cf7b_](https://github.com/adhocore/tusc.sh/commit/822cf7b)


## [0.3.1](https://github.com/adhocore/tusc.sh/releases/tag/0.3.1) (2019-08-24)

### Bug Fixes
- Exit when we are done with location (Jitendra Adhikari) [_fe2edd1_](https://github.com/adhocore/tusc.sh/commit/fe2edd1)

### Internal Refactors
- Use read instead of awk (Jitendra Adhikari) [_525dcfc_](https://github.com/adhocore/tusc.sh/commit/525dcfc)

### Documentations
- Remove awk (Jitendra Adhikari) [_e453044_](https://github.com/adhocore/tusc.sh/commit/e453044)
- Add system requirements (Jitendra Adhikari) [_a0afe5c_](https://github.com/adhocore/tusc.sh/commit/a0afe5c)


## [0.3.0](https://github.com/adhocore/tusc.sh/releases/tag/0.3.0) (2019-08-24)

### Features
- Add locate command, show location when finished (Jitendra Adhikari) [_ee91ad0_](https://github.com/adhocore/tusc.sh/commit/ee91ad0)

### Internal Refactors
- Use --locate and -L instead of locate (Jitendra Adhikari) [_f069d20_](https://github.com/adhocore/tusc.sh/commit/f069d20)

### Documentations
- Add --locate (Jitendra Adhikari) [_a9538ff_](https://github.com/adhocore/tusc.sh/commit/a9538ff)


## [0.2.0](https://github.com/adhocore/tusc.sh/releases/tag/0.2.0) (2019-08-24)

### Features
- Add tusc --update (Jitendra Adhikari) [_a4d74f8_](https://github.com/adhocore/tusc.sh/commit/a4d74f8)

### Documentations
- Add --update closes #2 (Jitendra Adhikari) [_17a5ebf_](https://github.com/adhocore/tusc.sh/commit/17a5ebf)
- Add trying out section (Jitendra Adhikari) [_df774b7_](https://github.com/adhocore/tusc.sh/commit/df774b7)


## [0.1.1](https://github.com/adhocore/tusc.sh/releases/tag/0.1.1) (2019-08-21)

### Bug Fixes
- Algo name, missing option, examples (Jitendra Adhikari) [_6dcd5ae_](https://github.com/adhocore/tusc.sh/commit/6dcd5ae)

### Documentations
- Update usage + examples (Jitendra Adhikari) [_9a8299d_](https://github.com/adhocore/tusc.sh/commit/9a8299d)
- Add more intro (Jitendra Adhikari) [_8ebc663_](https://github.com/adhocore/tusc.sh/commit/8ebc663)

### Miscellaneous
- Add please.json with before-push hook (Jitendra Adhikari) [_b81bdab_](https://github.com/adhocore/tusc.sh/commit/b81bdab)


## [0.1.0](https://github.com/adhocore/tusc.sh/releases/tag/0.1.0) (2019-08-20)

### Features
- Implement exit handler (trap) (Jitendra Adhikari) [_03c408b_](https://github.com/adhocore/tusc.sh/commit/03c408b)
- Set bash flags (Jitendra Adhikari) [_3ba83e7_](https://github.com/adhocore/tusc.sh/commit/3ba83e7)
- Save config, implement patch request (Jitendra Adhikari) [_aef20a0_](https://github.com/adhocore/tusc.sh/commit/aef20a0)
- Implement head/create request (Jitendra Adhikari) [_52e0b30_](https://github.com/adhocore/tusc.sh/commit/52e0b30)
- Add http request handler (Jitendra Adhikari) [_d97ae35_](https://github.com/adhocore/tusc.sh/commit/d97ae35)
- Validate args/inputs (Jitendra Adhikari) [_25116d1_](https://github.com/adhocore/tusc.sh/commit/25116d1)
- Parse argv, define some globals (Jitendra Adhikari) [_2670497_](https://github.com/adhocore/tusc.sh/commit/2670497)
- Add filepart() (Jitendra Adhikari) [_47206ad_](https://github.com/adhocore/tusc.sh/commit/47206ad)
- Add tus-config() (Jitendra Adhikari) [_dcc80a7_](https://github.com/adhocore/tusc.sh/commit/dcc80a7)
- Add version() and usage() (Jitendra Adhikari) [_b79045f_](https://github.com/adhocore/tusc.sh/commit/b79045f)
- Add message helpers (Jitendra Adhikari) [_f5da511_](https://github.com/adhocore/tusc.sh/commit/f5da511)

### Bug Fixes
- Save location config only on create request (Jitendra Adhikari) [_77540e7_](https://github.com/adhocore/tusc.sh/commit/77540e7)
- On-exit dont show msg if no upload in progress (Jitendra Adhikari) [_4e53aa5_](https://github.com/adhocore/tusc.sh/commit/4e53aa5)
- Remove redundant msg, show checksum, delete HFILE on exit (Jitendra Adhikari) [_b4fe946_](https://github.com/adhocore/tusc.sh/commit/b4fe946)

### Documentations
- Add readme (Jitendra Adhikari) [_a4a9251_](https://github.com/adhocore/tusc.sh/commit/a4a9251)

### Miscellaneous
- Update usage examples (Jitendra Adhikari) [_993dafb_](https://github.com/adhocore/tusc.sh/commit/993dafb)
