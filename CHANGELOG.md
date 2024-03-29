## [1.1.1](https://github.com/adhocore/tusc.sh/releases/tag/1.1.1) (2023-10-19)

### Bug Fixes
- Extract locate() helper, namespace location with host (Jitendra A) [_59b80ac_](https://github.com/adhocore/tusc.sh/commit/59b80ac)

### Miscellaneous
- Cleanup debug code (Jitendra A) [_4885cc6_](https://github.com/adhocore/tusc.sh/commit/4885cc6)


## [1.1.0](https://github.com/adhocore/tusc.sh/releases/tag/1.1.0) (2023-10-18)

### Features
- Extract header() for case insensitive header lookup, pass -v to curl if DEBUG (Jitendra A) [_c60c8d4_](https://github.com/adhocore/tusc.sh/commit/c60c8d4)

### Bug Fixes
- **Tusc**: Location header may not present (Jitendra A) [_4e3406d_](https://github.com/adhocore/tusc.sh/commit/4e3406d)

### Documentations
- Add usage instruction with tusd v2 (Jitendra A) [_8d14877_](https://github.com/adhocore/tusc.sh/commit/8d14877)

### Builds
- Add gh action (Jitendra A) [_7d008f5_](https://github.com/adhocore/tusc.sh/commit/7d008f5)


## [1.0.2](https://github.com/adhocore/tusc.sh/releases/tag/1.0.2) (2023-10-17)

### Miscellaneous
- Trigger (Jitendra A) [_18c080e_](https://github.com/adhocore/tusc.sh/commit/18c080e)


## [v1.0.1](https://github.com/adhocore/tusc.sh/releases/tag/v1.0.1) (2023-10-17)

### Documentations
- Extra curl args quote escaping (Jitendra Adhikari) [_fe9a3b8_](https://github.com/adhocore/tusc.sh/commit/fe9a3b8)


## [0.8.1](https://github.com/adhocore/tusc.sh/releases/tag/0.8.1) (2020-11-05)

### Bug Fixes
- **Tusc**: Use HOME env instead of tilde (Jitendra Adhikari) [_768cbc4_](https://github.com/adhocore/tusc.sh/commit/768cbc4)

### Builds
- **Travis**: Setup debug (Jitendra Adhikari) [_e34673d_](https://github.com/adhocore/tusc.sh/commit/e34673d)


## [0.8.0](https://github.com/adhocore/tusc.sh/releases/tag/0.8.0) (2020-10-09)

### Features
- **Tusc**: Add rest args as curl args (Jitendra Adhikari) [_be5a88a_](https://github.com/adhocore/tusc.sh/commit/be5a88a)

### Documentations
- Fix a README error (everconnectcn) [_42be48d_](https://github.com/adhocore/tusc.sh/commit/42be48d)
- About -- curl args (Jitendra Adhikari) [_1e33f1d_](https://github.com/adhocore/tusc.sh/commit/1e33f1d)
- Fix a README error (everconnectcn) [_3ee0a02_](https://github.com/adhocore/tusc.sh/commit/3ee0a02)

### Builds
- **Travis**: Test curl args (Jitendra Adhikari) [_9b7160f_](https://github.com/adhocore/tusc.sh/commit/9b7160f)


## [0.7.0](https://github.com/adhocore/tusc.sh/releases/tag/0.7.0) (2019-10-02)

### Features
- Improve performance by caching sha keys (Jitendra Adhikari) [_5340593_](https://github.com/adhocore/tusc.sh/commit/5340593)

### Bug Fixes
- Respect NOCOLOR (-C) (Jitendra Adhikari) [_4ae4f0a_](https://github.com/adhocore/tusc.sh/commit/4ae4f0a)

### Internal Refactors
- Improve msg helpers, dont show url on failure (Jitendra Adhikari) [_6357fc1_](https://github.com/adhocore/tusc.sh/commit/6357fc1)

### Miscellaneous
- Sensor the asset release output (Jitendra Adhikari) [_12e6ad2_](https://github.com/adhocore/tusc.sh/commit/12e6ad2)

### Documentations
- Update installation instruction (Jitendra Adhikari) [_62c5d67_](https://github.com/adhocore/tusc.sh/commit/62c5d67)


## [0.6.4](https://github.com/adhocore/tusc.sh/releases/tag/0.6.4) (2019-10-02)

### Miscellaneous
- Add after-release hook (Jitendra Adhikari) [_cf932f8_](https://github.com/adhocore/tusc.sh/commit/cf932f8)


## [0.6.3](https://github.com/adhocore/tusc.sh/releases/tag/0.6.3) (2019-10-02)

### Internal Refactors
- Check TUSURL strictly (Jitendra Adhikari) [_85a3efa_](https://github.com/adhocore/tusc.sh/commit/85a3efa)


## [0.6.2](https://github.com/adhocore/tusc.sh/releases/tag/0.6.2) (2019-10-02)

### Bug Fixes
- Use chunked transfer instead of binary for really big files (Jitendra Adhikari) [_4426ddf_](https://github.com/adhocore/tusc.sh/commit/4426ddf)

### Documentations
- Add contributors (Jitendra Adhikari) [_c89e4ad_](https://github.com/adhocore/tusc.sh/commit/c89e4ad)


## [0.6.1](https://github.com/adhocore/tusc.sh/releases/tag/0.6.1) (2019-09-27)

### Features
- Add credential option (Jitendra Adhikari) [_181a628_](https://github.com/adhocore/tusc.sh/commit/181a628)
- **Tusc**: Add --no-spin, --no-color and rename vars (Jitendra Adhikari) [_2be4503_](https://github.com/adhocore/tusc.sh/commit/2be4503)
- Show spinner on slower subtasks (Jitendra Adhikari) [_18ece00_](https://github.com/adhocore/tusc.sh/commit/18ece00)

### Miscellaneous
- Cleanup creds (will document instead) (Jitendra Adhikari) [_e265c40_](https://github.com/adhocore/tusc.sh/commit/e265c40)
- Create FUNDING.yml (Jitendra Adhikari) [_3122b31_](https://github.com/adhocore/tusc.sh/commit/3122b31)

### Documentations
- Update help and usage, add preview (Jitendra Adhikari) [_d30431e_](https://github.com/adhocore/tusc.sh/commit/d30431e)
- On git lfs (Jitendra Adhikari) [_e978e11_](https://github.com/adhocore/tusc.sh/commit/e978e11)

### 
- **Travis**: Lint on every branch, group scripts (Jitendra Adhikari) [_630baf2_](https://github.com/adhocore/tusc.sh/commit/630baf2)
- **Travis**: Improve lint script (Jitendra Adhikari) [_1df33a4_](https://github.com/adhocore/tusc.sh/commit/1df33a4)
- **Travis**: Fix wc input (Jitendra Adhikari) [_ab99fc0_](https://github.com/adhocore/tusc.sh/commit/ab99fc0)
- **Travis**: Add commit lint (Jitendra Adhikari) [_06e60fa_](https://github.com/adhocore/tusc.sh/commit/06e60fa)
- **Travis**: Update and simplify scripts (Jitendra Adhikari) [_5bb74dd_](https://github.com/adhocore/tusc.sh/commit/5bb74dd)
- Travis test scripts (Jitendra Adhikari) [_14ed7d5_](https://github.com/adhocore/tusc.sh/commit/14ed7d5)


## [0.6.0](https://github.com/adhocore/tusc.sh/releases/tag/0.6.0) (2019-09-27)

### Internal Refactors
- Cleanup creds from tusurl, simplify creds validation and meta (Jitendra Adhikari) [_16a0f6f_](https://github.com/adhocore/tusc.sh/commit/16a0f6f)

### Documentations
- Add creds example, update system requirements (Jitendra Adhikari) [_efa2cda_](https://github.com/adhocore/tusc.sh/commit/efa2cda)

### Miscellaneous
- Cleanup creds (will document instead) (Jitendra Adhikari) [_0809e40_](https://github.com/adhocore/tusc.sh/commit/0809e40)


## [0.5.0](https://github.com/adhocore/tusc.sh/releases/tag/0.5.0) (2019-09-26)

### Features
- **Tusc**: Add --no-spin, --no-color and rename vars (Jitendra Adhikari) [_f01c605_](https://github.com/adhocore/tusc.sh/commit/f01c605)

### Documentations
- Update help and usage, add preview (Jitendra Adhikari) [_e160ad9_](https://github.com/adhocore/tusc.sh/commit/e160ad9)


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
