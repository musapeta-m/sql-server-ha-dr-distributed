Enterprise Hybrid DR: SQL Server Always On Multi-Subnet Cluster
📌 Project Overview
This repository contains the end-to-end architecture, configuration scripts, and disaster recovery playbooks for a SQL Server Always On Availability Group (AG) spanning multiple geographic subnets. 
This design is engineered to survive a complete regional data center failure while maintaining zero data loss for local outages.

🏗️ Architecture Design
The cluster utilizes a Hybrid Commit Model to balance local performance with global data resilience.
Primary Site (Subnet A): 2 Nodes configured with Synchronous Commit and Automatic Failover for High Availability (HA).
DR Site (Subnet B): 1 Node configured with Asynchronous Commit for Geographic Disaster Recovery (DR).
Quorum: Azure Cloud Witness serving as the tie-breaker to ensure cluster stability during network partitions.

Technical Specifications
Feature	                Implementation
SQL Server Version	      2019 / 2022 Enterprise Edition
Cluster Type	            Windows Server Failover Cluster (WSFC)
Replication Strategy	    Hybrid (Sync + Async)
Witness Type	            Cloud Witness (Azure Storage Account)
Listener Logic	          Multi-Subnet (RegisterAllProvidersIP=1)

📁 Repository Structure
/configs: T-SQL templates for Endpoints, AG Creation, and Multi-Subnet Listeners.

/docs:
Architecture Deep-Dive: Detailed logic on Quorum and IP Roaming.
DR Playbook: Step-by-step manual for site-to-site failover.
Troubleshooting Guide: Solving common Multi-Subnet latency and DNS issues.

/scripts:
Network Simulation: Tooling to test cluster resilience during WAN failure.
Latency Monitoring: Tracking RPO via Log Send Queue analysis.

🚀 Key Performance Indicators (SLAs)
This architecture is designed to meet the following enterprise recovery targets:

RPO (Recovery Point Objective):
Local Failure: 0 seconds (No data loss).
Regional Failure: < 5 seconds (Minimal data loss via Asynchronous commit).
RTO (Recovery Time Objective):
Local Failure: < 30 seconds (Automatic failover via Listener).

Regional Failure: < 15 minutes (Manual failover with DNS TTL considerations).

🛠️ Performance & Security
AES Encryption: All data in transit between subnets is encrypted via the HADR endpoint.
Read-Only Routing: Optimized for scalability by offloading reporting workloads to the secondary replicas.
Multi-Subnet Failover: Application connection strings utilize MultiSubnetFailover=True for parallel IP polling.

👨‍💻 About the Author
[MEGNA] Data Architect | SQL Server & PostgreSQL Specialist

LinkedIn: [Your Profile Link]

Portfolio: [https://github.com/musapeta-m/musapeta-m]

