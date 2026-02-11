Architecture Blueprint: Multi-Subnet Distributed AG
1. Network Topology & Traffic Routing
In a multi-subnet environment, the SQL Server Listener must handle "IP-Roaming." When the database fails over from Subnet A (10.0.1.x) to Subnet B (192.168.1.x), the application connection string must be resilient.

Multi-Subnet Listener Configuration
Dual-Registration: The Listener is assigned one IP per subnet. Both IPs are registered in DNS under the same Virtual Network Name (VNN).

Client Connectivity: We recommend the use of MultiSubnetFailover=True in the application connection string. This enables parallel connection attempts to all registered IPs, reducing failover time from minutes (waiting for DNS propagation) to seconds.

RegisterAllProvidersIP: We have configured the cluster resource with RegisterAllProvidersIP = 1 to ensure both IPs are active in DNS simultaneously.

2. Quorum and Voting Logic
To prevent a "split-brain" scenario (where both sites think they are the primary), we implement a Node Majority + Cloud Witness model.

Quorum Configuration:
Primary Site (Subnet A): 2 Nodes (2 Votes).

DR Site (Subnet B): 1 Node (1 Vote).

Azure Cloud Witness: 1 Vote (Neutral tie-breaker).

Total Votes: 4.

Failure Logic: If the connection to the Primary Site is lost, the DR Node and the Cloud Witness maintain 2 out of 4 votes. While this doesn't reach a majority, it provides the "Architect's Hook" to manually force quorum and resume service at the DR site without risk of data corruption from the old Primary.

3. Data Consistency & Replication Modes
A Data Architect must balance Data Safety against Application Performance.
 
Replica	Subnet		Commit Mode		Business Logic
SQL-01	Subnet A	Synchronous	    Local High Availability (HA)
SQL-02	Subnet A	Synchronous	    Local High Availability (HA)
SQL-03	Subnet B	Asynchronous	Geographic Disaster Recovery (DR)

Asynchronous commit is used for the DR node to prevent "Network Hops" (latency) between regions from slowing down production transactions.

4. Performance & Bottleneck Mitigation
As a Performance Expert, the architecture includes specific tuning for cross-subnet throughput:

Compression: Enabled Hadr_endpoint compression to reduce network bandwidth consumption over the WAN link.

Redo Thread Optimization: To prevent the DR site from lagging, we have optimized the redo thread limits to handle high-volume transaction bursts.

Log Send Queue Monitoring: We utilize custom alerts for any Log Send Queue exceeding 500MB, indicating that the DR site is no longer meeting its RPO (Recovery Point Objective).