Import-Module FailoverClusters
Get-ClusterNode | Select Name, State, QuorumVotes
Get-ClusterQuorum | Select QuorumResource, QuorumType