Common Issue: "The Listener is offline in the DR Subnet"
Cause: The cluster cannot bring the IP online because the DR subnet is on a different VLAN/Gateway. Fix: Check the OR dependency in the Cluster Resource. The Listener must be set to (IP Subnet A OR IP Subnet B), not AND.

Common Issue: "High Log Send Queue"
Cause: Network throughput between subnets is lower than the transaction volume. Fix: Enable hadr_endpoint compression and verify if the storage on the DR node can handle the same IOPS as the primary.