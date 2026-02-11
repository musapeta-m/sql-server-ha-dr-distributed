Planned Manual Failover to DR (Subnet B)
Change Mode: Alter the DR replica to SYNCHRONOUS_COMMIT.

Check Sync: Wait for synchronization_state_desc to show SYNCHRONIZED.

Failover: Execute ALTER AVAILABILITY GROUP [AG_PROD] FAILOVER;.

Update DNS: Ensure the Multi-Subnet Listener redirects traffic to the new Subnet B IP.