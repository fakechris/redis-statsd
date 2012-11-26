module.exports = {
    "interval" : 3000
  , "statsd" : {
      "host" : "localhost"
    , "port" : 8125
  }
  , "redis_servers" : [
    {
        "host" : "localhost"
      , "port" : 6379
    }
  ]
  , "gauge" : [
      "connected_clients"
    , "client_longest_output_list"
    , "client_biggest_input_buf"
    , "blocked_clients"
    , "used_memory"
    , "used_memory_human"
    , "used_memory_rss"
    , "used_memory_peak"
    , "used_memory_peak_human"
    , "used_memory_lua"
    , "mem_fragmentation_ratio"
    , "loading"
    , "rdb_changes_since_last_save"
    , "rdb_bgsave_in_progress"
    , "rdb_last_save_time"
    , "rdb_last_bgsave_time_sec"
    , "rdb_current_bgsave_time_sec"
    , "aof_enabled"
    , "aof_rewrite_in_progress"
    , "aof_rewrite_scheduled"
    , "aof_last_rewrite_time_sec"
    , "aof_current_rewrite_time_sec"
    , "total_connections_received"
    , "total_commands_processed"
    , "instantaneous_ops_per_sec"
    , "rejected_connections"
    , "expired_keys"
    , "evicted_keys"
    , "keyspace_hits"
    , "keyspace_misses"
    , "pubsub_channels"
    , "pubsub_patterns"
    , "latest_fork_usec"
    , "connected_slaves"
    , "used_cpu_sys"
    , "used_cpu_user"
    , "used_cpu_sys_children"
    , "used_cpu_user_children"
  ]
}