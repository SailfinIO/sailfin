# E2E per-file elapsed — 2026-08-14

Source: local sweep sidecars build/agent-test.shard-e2e-{a,b}.jsonl.
Coverage: e2e-a complete + e2e-b partial = 157 of 326 e2e files. Total 1578s.
The sweep died before e2e-c/e2e-d ran; this is NOT a complete ranking.

NOTE: this document was derived from the sidecar's duration_ms field, which
was believed at the time to be PER-FILE. That belief was wrong (SFN-1222):
duration_ms is the row's even-distribution per-test slice (the file's
elapsed time divided by its test count), not the file's whole elapsed time.
A separate file_elapsed_ms field now carries the true per-file value.

WARNING: the rankings below understate every multi-test file by roughly its
test count, because they were computed from the divided value. Do not use
this document for target selection; regenerate against file_elapsed_ms
instead. Retained for its historical elapsed-time data with this caveat.

SUPERSEDED by docs/measurements/e2e-shard-weights-2026-08-31.md, which
re-ranks the e2e heavy tail from corrected file_elapsed_ms across both arm64
targets and rules on which of the targets below survive. The full 880-file
ranking lives in compiler/tests/shard_weights.tsv. Use those for target
selection (SFN-1223).

rank file                                                   elapsed    share
1    dep_closure_prewarm_test.sfn                            205.4s    13.0%
2    work_dir_parity_test.sfn                                169.1s    10.7%
3    build_clean_runtime_objects_test.sfn                    112.9s     7.2%
4    cli_bare_file_cached_capsule_import_test.sfn             87.3s     5.5%
5    array_filter_closure_test.sfn                            72.1s     4.6%
6    array_interpolation_test.sfn                             71.9s     4.6%
7    build_json_schema_test.sfn                               67.7s     4.3%
8    harness_crash_durability_test.sfn                        62.4s     4.0%
9    dep_object_cache_test.sfn                                59.4s     3.8%
10   harness_stream_records_test.sfn                          59.0s     3.7%
11   subframe_aggregation_stream_test.sfn                     56.1s     3.6%
12   bench_consumer_test.sfn                                  53.9s     3.4%
13   async_coerce_refusal_test.sfn                            31.2s     2.0%
14   test_bin_cache_test.sfn                                  26.0s     1.6%
15   recoverable_harness_test.sfn                             22.3s     1.4%
16   update_snapshots_flag_test.sfn                           20.9s     1.3%
17   runner_jobs_parallel_test.sfn                            20.2s     1.3%
18   channel_nursery_reclaim_test.sfn                         16.9s     1.1%
19   sailfin_trace_link_test.sfn                              15.8s     1.0%
20   serve_reuseaddr_restart_test.sfn                         14.9s     0.9%
21   capsule_transitive_dep_link_test.sfn                     11.5s     0.7%
22   serve_loopback_test.sfn                                  10.8s     0.7%
23   check_compiler_src_test.sfn                               9.8s     0.6%
24   push_in_struct_method_test.sfn                            9.2s     0.6%
25   short_write_truncated_ir_test.sfn                         9.1s     0.6%
26   union_named_variant_match_test.sfn                        9.0s     0.6%
27   module_global_runtime_init_test.sfn                       8.9s     0.6%
28   monotonic_millis_advances_test.sfn                        8.9s     0.6%
29   runtime_tls_ca_bundle_realistic_size_test.sfn             8.8s     0.6%
30   serve_tls_loopback_test.sfn                               8.4s     0.5%
31   substring_method_call_test.sfn                            8.3s     0.5%
32   cache_command_test.sfn                                    8.3s     0.5%
33   runtime_io_print_test.sfn                                 8.1s     0.5%
34   interface_dispatch_test.sfn                               7.9s     0.5%
35   dx_transfer_ergonomics_gate_test.sfn                      7.6s     0.5%
36   runtime_tls_anchor_cache_test.sfn                         6.0s     0.4%
37   cross_module_signature_resolution_test.sfn                5.8s     0.4%
38   agent_report_abort_test.sfn                               5.6s     0.4%
39   runtime_sfn_sources_struct_import_test.sfn                5.1s     0.3%
40   runtime_dir_capsule_link_test.sfn                         4.8s     0.3%
41   direct_link_test.sfn                                      4.6s     0.3%
42   self_param_lowering_test.sfn                              4.5s     0.3%
43   generic_sort_run_test.sfn                                 4.5s     0.3%
44   union_interpolation_test.sfn                              4.5s     0.3%
45   work_dir_flag_test.sfn                                    4.4s     0.3%
46   reexport_transitive_order_test.sfn                        4.4s     0.3%
47   concurrent_runtime_objkey_race_test.sfn                   4.1s     0.3%
48   dev_arena_equivalence_test.sfn                            3.9s     0.2%
49   runtime_tls_verify_failure_test.sfn                       3.6s     0.2%
50   is_type_guard_test.sfn                                    3.6s     0.2%
51   linker_selection_test.sfn                                 3.4s     0.2%
52   for_range_zero_stride_test.sfn                            3.3s     0.2%
53   runtime_implicit_capsule_link_test.sfn                    3.2s     0.2%
54   dev_shard_test.sfn                                        3.1s     0.2%
55   process_exec_test.sfn                                     3.0s     0.2%
56   import_shadows_local_fn_test.sfn                          3.0s     0.2%
57   capsule_byname_import_link_test.sfn                       3.0s     0.2%
58   float_int_saturating_cast_test.sfn                        2.8s     0.2%
59   run_scratch_isolation_test.sfn                            2.8s     0.2%
60   nested_lambda_capture_test.sfn                            2.8s     0.2%
61   channel_producer_consumer_exec_test.sfn                   2.8s     0.2%
62   parallel_concurrent_execution_test.sfn                    2.7s     0.2%
63   lowering_fatal_gate_prints_cause_test.sfn                 2.7s     0.2%
64   socket_recv_timeout_test.sfn                              2.7s     0.2%
65   capsule_dead_strip_guard_test.sfn                         2.6s     0.2%
66   short_lambda_closure_pair_test.sfn                        2.5s     0.2%
67   tls_record_throughput_test.sfn                            2.5s     0.2%
68   owned_buf_grow_determinism_test.sfn                       2.4s     0.2%
69   interp_unsupported_fatal_test.sfn                         2.1s     0.1%
70   bench_runtime_runner_test.sfn                             2.0s     0.1%
71   capsule_build_test.sfn                                    2.0s     0.1%
72   match_arm_fallthrough_dominance_test.sfn                  1.9s     0.1%
73   effectful_lambda_no_return_type_test.sfn                  1.9s     0.1%
74   routine_spawn_channel_exec_test.sfn                       1.9s     0.1%
75   string_index_no_rescan_test.sfn                           1.9s     0.1%
76   sleep_routes_to_sfn_clock_test.sfn                        1.9s     0.1%
77   string_length_aware_lv_test.sfn                           1.9s     0.1%
78   rename_running_image_windows_test.sfn                     1.9s     0.1%
79   range_map_test.sfn                                        1.7s     0.1%
80   cli_help_json_test.sfn                                    1.7s     0.1%
81   runtime_array_test.sfn                                    1.7s     0.1%
82   call_emission_no_polling_test.sfn                         1.7s     0.1%
83   routine_await_receive_test.sfn                            1.5s     0.1%
84   nested_function_declaration_test.sfn                      1.5s     0.1%
85   abi_value_return_test.sfn                                 1.3s     0.1%
86   result_prelude_discriminant_test.sfn                      1.2s     0.1%
87   try_catch_frames_test.sfn                                 1.1s     0.1%
88   capability_cross_check_test.sfn                           1.1s     0.1%
89   windows_socket_ops_test.sfn                               1.0s     0.1%
90   cross_windows_runtime_modules_test.sfn                    1.0s     0.1%
91   lowering_no_bare_runtime_emissions_test.sfn               1.0s     0.1%
92   runtime_adapter_websocket_test.sfn                        1.0s     0.1%
93   spawn_capture_env_free_test.sfn                           1.0s     0.1%
94   process_run_stdio_passthrough_test.sfn                    1.0s     0.1%
95   array_arithmetic_diagnostic_test.sfn                      0.9s     0.1%
96   directory_import_test.sfn                                 0.9s     0.1%
97   capsule_artifact_sidecar_test.sfn                         0.9s     0.1%
98   runtime_process_test.sfn                                  0.9s     0.1%
99   runtime_serve_test.sfn                                    0.9s     0.1%
100  process_run_capture_windows_test.sfn                      0.9s     0.1%
101  cross_module_import_test.sfn                              0.8s     0.1%
102  emit_llvm_unresolved_callee_exit_test.sfn                 0.8s     0.1%
103  compiler_capsule_release_lockstep_test.sfn                0.8s     0.1%
104  check_unresolved_import_test.sfn                          0.8s     0.1%
105  spawn_empty_array_push_test.sfn                           0.8s     0.1%
106  guillermo_test.sfn                                        0.8s     0.1%
107  check_effect_call_site_caret_test.sfn                     0.8s     0.1%
108  errno_reader_test.sfn                                     0.8s     0.1%
109  task_join_all_test.sfn                                    0.8s     0.0%
110  ice_banner_test.sfn                                       0.8s     0.0%
111  runtime_scheduler_skeleton_test.sfn                       0.8s     0.0%
112  build_diagnostics_format_test.sfn                         0.8s     0.0%
113  numeric_bitwise_test.sfn                                  0.8s     0.0%
114  fs_read_link_intrinsic_test.sfn                           0.7s     0.0%
115  runtime_adapter_filesystem_test.sfn                       0.7s     0.0%
116  capsule_ir_layout_test.sfn                                0.7s     0.0%
117  fs_list_dir_intrinsic_test.sfn                            0.7s     0.0%
118  build_hash_matches_sha256sum_test.sfn                     0.7s     0.0%
119  runtime_string_basic_test.sfn                             0.7s     0.0%
120  secure_zero_optimized_ir_test.sfn                         0.7s     0.0%
121  numeric_int_default_test.sfn                              0.7s     0.0%
122  serve_resolvable_callsite_test.sfn                        0.7s     0.0%
123  bootstrap_install_gate_test.sfn                           0.7s     0.0%
124  clock_monotonic_id_sentinel_test.sfn                      0.7s     0.0%
125  channel_producer_consumer_ir_test.sfn                     0.7s     0.0%
126  add_registry_index_test.sfn                               0.7s     0.0%
127  drop_emission_try_catch_test.sfn                          0.7s     0.0%
128  runtime_string_utf8_numeric_test.sfn                      0.7s     0.0%
129  st_mode_arch_layout_test.sfn                              0.6s     0.0%
130  pointer_read_intrinsic_test.sfn                           0.6s     0.0%
131  array_aggregate_shape_test.sfn                            0.6s     0.0%
132  numeric_literal_position_test.sfn                         0.5s     0.0%
133  errno_locator_test.sfn                                    0.5s     0.0%
134  numeric_int_float_test.sfn                                0.5s     0.0%
135  parse_truncated_body_test.sfn                             0.5s     0.0%
136  toolchain_install_test.sfn                                0.5s     0.0%
137  aarch64_binfmt_probe_test.sfn                             0.5s     0.0%
138  runtime_sfn_sources_active_test.sfn                       0.5s     0.0%
139  runtime_memory_arena_test.sfn                             0.5s     0.0%
140  parse_malformed_declaration_test.sfn                      0.5s     0.0%
141  cli_completion_test.sfn                                   0.4s     0.0%
142  process_run_capture_metered_test.sfn                      0.4s     0.0%
143  channel_nursery_escape_test.sfn                           0.4s     0.0%
144  lowering_fabricated_value_gate_test.sfn                   0.4s     0.0%
145  module_layout_fingerprint_test.sfn                        0.4s     0.0%
146  cross_module_int_signature_test.sfn                       0.4s     0.0%
147  tls_record_pointer_differential_test.sfn                  0.4s     0.0%
148  cli_color_output_test.sfn                                 0.4s     0.0%
149  compiler_debug_toggle_env_vars_test.sfn                   0.3s     0.0%
150  struct_abi_test.sfn                                       0.3s     0.0%
151  compiler_source_fingerprint_test.sfn                      0.3s     0.0%
152  dev_verify_test.sfn                                       0.3s     0.0%
153  fmt_missing_path_test.sfn                                 0.3s     0.0%
154  dev_clean_test.sfn                                        0.2s     0.0%
155  login_test.sfn                                            0.2s     0.0%
156  process_handle_windows_test.sfn                           0.2s     0.0%
157  perf_history_compare_test.sfn                             0.2s     0.0%
