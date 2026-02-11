Test Scenario: Total WAN Loss
Observation: When the firewall rule was active, Node 01 and Node 02 remained in a Synchronized state because they share the local subnet.

DR Impact: Node 03 moved to Not Synchronizing.

Quorum Behavior: Because the Primary site had 2 nodes + the Cloud Witness (3/4 votes), the cluster stayed online. If we didn't have the Cloud Witness, the cluster would have "shrunk" or gone offline.

Resolution: Once the firewall rule was removed, the Log Send Queue began to drain, and Node 03 caught up automatically via Asynchronous catch-up.