# AZ305 复习 topic 3

Solution: You deploy two Azure virtual machines to two Azure regions, and you create an **Azure Traffic Manager profile**. == Yes

Storage account type*



Gateway Load Balancer > front door



## 1-27

### HARD: 1，7，9，12，17，18，21，23，24



1、 RTO RPO

== D. Azure Site Recovery



2、

Virtual Machines that are backed up by using the policy can be recovered for up to a maximum of: **36 months**

The minimum recovery point objective (RPO) for virtual machines that are backed up by using the policy is: **1 day**

![image-20250715155444498](./AZ305 复习 topic 3.assets/image-20250715155444498.png)



3、 Provide access to the full .NET framework

Solution: You deploy two Azure virtual machines to two Azure regions, and you create an **Azure Traffic Manager profile**.

== Yes



4、. Solution: You deploy two Azure virtual machines to two Azure regions, and you deploy an Azure Application Gate

no



5、

Storage tier: **Premium**

Redundancy: **ZRS**

![image-20250715155642208](./AZ305 复习 topic 3.assets/image-20250715155642208.png)



6、000



#### 7、

Application1:  **BlobStorage with Premium Performance and ZRS replication**

Application2:  **General purpose v2 with Standard Performance, Cool access tier, and RA-GRS replication**

![image-20250715155748092](./AZ305 复习 topic 3.assets/image-20250715155748092.png)



8、

Prevent new data from being modified for **one year.**  

Maximize data resiliency.  

Minimize read latency. 



![image-20250715155824381](./AZ305 复习 topic 3.assets/image-20250715155824381.png)



9、有AKS

connection traffic over the internet is encrypted by using SSL

== A. Azure Front Door



10、

**Be available if a single Azure datacenter fails**.  

Support storage tiers.  

Minimize cost. 

![image-20250715155931256](./AZ305 复习 topic 3.assets/image-20250715155931256.png)



11、

![image-20250715160053624](./AZ305 复习 topic 3.assets/image-20250715160053624.png)



12、

Sales: **Azure Site Recovery only**

Finance: **Azure Site Recovery and Azure Backup**

Reporting: **Azure Backup only**

![image-20250715160110195](./AZ305 复习 topic 3.assets/image-20250715160110195.png)



13、000



14、000



15、000



16、如果没有premium，就是Business Critical，有争议

== B. Azure SQL Database Business Critical



#### 17、

Azure servie or service tier: **The hyperscale service tier**

Replication mechanism: **Active geo-replication**

![image-20250715160335916](./AZ305 复习 topic 3.assets/image-20250715160335916.png)



18、

Prepare for the migration by: **Creating an Always On availablility group on VM1**

Perform the migration by using: **Azure migration**

![image-20250715160420683](./AZ305 复习 topic 3.assets/image-20250715160420683.png)



19、

Service tier and computer tier: **General Purpose service tier and Serverless computer tier**

Encryption method: **Always Encrypted**

![image-20250715160444769](./AZ305 复习 topic 3.assets/image-20250715160444769.png)



20、minimize downtime in the event of a failover to a paired region.

== C. Implement Geo-redundant backup



#### 21、 

incoming traffic for VMSS1 across NVA1 and NVA2

== A. Gateway Load Balancer

![image-20250715161233231](./AZ305 复习 topic 3.assets/image-20250715161233231.png)



22、Recovery Services vault = Resource Guard

Sub1: **A Recovery Services vault**

Sub2: **A Resource Guard**

![image-20250715160622685](./AZ305 复习 topic 3.assets/image-20250715160622685.png)



#### 23、MARS = LRS

On the servers: **The Microsoft Azure Recovery Services (MARS) agent**

For the storage: **LRS**

![image-20250715160637260](./AZ305 复习 topic 3.assets/image-20250715160637260.png)



#### 24、

For global load balancing: **Azure Front door**

As the ingress controller: **Azure Application Gateway**

![image-20250715160706822](./AZ305 复习 topic 3.assets/image-20250715160706822.png)



25、

![image-20250715160721882](./AZ305 复习 topic 3.assets/image-20250715160721882.png)



26、

To run the containerized apps:                                                              Azure Container Apps

FOr the lifecycle management and storage of container images:  Azure Container Registery

![image-20250715160736395](./AZ305 复习 topic 3.assets/image-20250715160736395.png)



27、GRS

![image-20250715160748848](./AZ305 复习 topic 3.assets/image-20250715160748848.png)























































