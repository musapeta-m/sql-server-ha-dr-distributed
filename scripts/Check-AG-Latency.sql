SELECT 
    replica_server_name, 
    last_redone_time, 
    log_send_queue_size, -- Data waiting to be sent to DR
    redo_queue_size      -- Data waiting to be applied at DR
FROM sys.dm_hadr_database_replica_states;