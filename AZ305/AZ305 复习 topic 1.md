# AZ305 复习 topic 1

AAD IG > AAD IP



**run IP flow == yes**



## 1-30

### HARD: 3,6,17



1、All users are licensed for the **Microsoft 365 E5 plan**. 

== A. In Azure Active Directory (Azure AD), create an **access review of Application**





2、access to the blobs during the month of **April** only.

== A. shared access signatures (SAS)



3、

provide the remote users with single sign-on (SSO) access to WebApp1.

== A. Azure AD Application Proxy

E. Azure AD enterprise applications



4、removed

== C. Create an access review. 



5、

Databrick SKU: <font color = red>Premium</font>

Cluster configuration:  <font color = red>Credential passthrough</font>



![image-20250716000702187](./AZ305 复习 topic 1.assets/image-20250716000702187.png)



#### 6、

The users can connect to App1 **without being prompted** for authentication: <font color = red>An Azure AD app registration</font>

The users can access to app1 only from **company-owned computers**: <font color = red>A conditional Access policy</font>



![image-20250716000727525](./AZ305 复习 topic 1.assets/image-20250716000727525.png)







7，8，9，14、being **allowed or denied** to the virtual machines

== run IP flow



10、

Events from Windows event logs: <font color = red>Event</font>

Events from Linus system logging: <font color = red>Syslog</font>



11、e



12、

<font color = red>Azure AD Application Proxy</font>

<font color = red>an Azure AD enterprise application</font>

<font color = red>a conditional Access policy</font>



![image-20250716000834218](./AZ305 复习 topic 1.assets/image-20250716000834218.png)





13、ARM

<font color = red>Azure Activity Log</font>



15、

AAD audit log  ---> Azure Event Hubs ---> Azure Functions ---> Cosmos DB

![image-20250716000908796](./AZ305 复习 topic 1.assets/image-20250716000908796.png)





16、 

OAuth 2.0 provider\The solution must NOT use **Azure AD guest accounts** 

== D. Azure API Management



17、

Resouce to create in Azure: <font color = red>A Log Analytics workspace</font>

Configuration to perform on the virtual machines: <font color = red>Install the Azue Monitor Agent</font>



![image-20250716000951385](./AZ305 复习 topic 1.assets/image-20250716000951385.png)







18、PIM - MI - PIM

Security: <font color = red>Azure AD Privileged Identity Management (PIM)</font>

Deployment: <font color = red>Azure Managed Identity (MI)</font>

Quality Assurance: <font color = red>Azure AD Privileged Identity Management (PIM)</font>



![image-20250716001023078](./AZ305 复习 topic 1.assets/image-20250716001023078.png)







19、blueprint 

2-2-2

![image-20250716001052346](./AZ305 复习 topic 1.assets/image-20250716001052346.png)





20、

Azure policy effect to use: <font color = red>Modify</font>

Azure AD object and RBAC role to use for the remediation tasks: <font color = red>A managed identity with Contributor role</font>



21、new diagnostic settings

yes yes yes



![image-20250716001127190](./AZ305 复习 topic 1.assets/image-20250716001127190.png)



22、only privileged users can view the **PII**

== A. dynamic data masking



23、 

Encrypt all the data in the storage account by using customer-managed key

== B. **blobs in a general purpose v2 storage account**



![image-20250716092704872](./AZ305 复习 topic 1.assets/image-20250716092704872.png)





24、KV

== 

Key Vault integration method: <font color = red>Key Vault reference in Application settings</font>

Key Vault permissions for the managed identity: <font color = red>Secrets: Get</font>



25、Avoid storing secrets and certificates on the virtual machi

== D. a user-assigned managed iden



26、AS1 CDB1

== C. Azure Synapse Link for Azure Cosmos DB



27、90/730 days

The amount of time that SQLInsights data will be stored in blob storage is: <font color = red>90 days

The maximum amount of time that SQLinsight data can be stored in Azure Log Analytics is: <font color = red>730 days



28、

== C. password-based



29、bastion/ Azure Windows VM

To provide access to virtual machines on VNet1, use: <font color = red>Azure Bastion</font>

To enforce Azure MFA, use: <font color = red>A conditional Access policy that has the Cloud apps assignment set to Azure Windows VM sign-in.</font>



![image-20250716001254212](./AZ305 复习 topic 1.assets/image-20250716001254212.png)



30、

environment, owner, department and cost center.

== C. an Azure policy that enforces tagging rules



![image-20250716001315311](./AZ305 复习 topic 1.assets/image-20250716001315311.png)





## 31-60

### HARD: 40，41，**43**，54，55，59，60





31、

D. In the Azure AD tenant of Contoso, create guest accounts for the Fabnkam developers



32、

C. Use Azure AD entitlement management to govern external users.



33、

Grant permissions to allow the web apps to access the web APIs by using: <font color = red>Azure AD</font>

Configure a JSON Web token validation policy by using: <font color = red>APIM</font>



![image-20250716001402875](./AZ305 复习 topic 1.assets/image-20250716001402875.png)



34、000



35、000



36、

an authentication solution for Azure Functions

== B. system-assigned managed identities



37、000



38、000



39、000



40、

Configure App1 to use OAuth2.0: <font color = red>Client credentials grant flows</font>

Configure App1 to use a REST API call to retrieve an authentication token from the: <font color = red>Azure Instance Metadata Service (MDS) endpoint</font>



![image-20250716001450690](./AZ305 复习 topic 1.assets/image-20250716001450690.png)



41、

Configure **Supported account types in the application registration** and update the **sign-in endpoint**. 



![image-20250716092851513](./AZ305 复习 topic 1.assets/image-20250716092851513.png)



42、removed

== C. Create an access review. 



#### 43、

Authenticaton: <font color = red>APP registration in AAD</font>

Authorization: <font color = red>Delegated permissions</font>



![image-20250715150359298](./AZ305 复习 topic 1.assets/image-20250715150359298.png)



44、000



45、000



#### 46、

![image-20250715144622340](./AZ305 复习 topic 1.assets/image-20250715144622340.png)



47、000



48、000



49、 resources can be grouped by department.

== B. Azure Policy and tags



50、000



51、000



52、

User1: <font color = red>User Administrator for MarketingAU</font>

User2: <font color = red>Helpdesk Administrator for MarketingAU</font>



53、000



54、

Storage: <font color = red>Secret</font>

Access: <font color = red>A managed service identity (MSI)</font>



55、

![image-20250715144917847](./AZ305 复习 topic 1.assets/image-20250715144917847.png)



56、000



57、

minimum number of Azure Monitor workspaces 

== A. 1



58、000



#### 59、

Minimum number of Azure AD tenants: <font color = red>1</font>

Minimum number of conditional access policies to create: <font color = red>2</font>

![image-20250715145033876](./AZ305 复习 topic 1.assets/image-20250715145033876.png)



60、

Once every 30 days, the project managers must be prompted automatically to verify which users are assigned to their projects.

== D. Azure AD Identity Governance





## 61-68

### HARD: 61,62,63，**65**，66



61、

![image-20250715145314921](./AZ305 复习 topic 1.assets/image-20250715145314921.png)



62、monitor traffic between the App1 components

== B. Application Insights



63、

commitment pricing tier

![image-20250715145435325](./AZ305 复习 topic 1.assets/image-20250715145435325.png)



64、budgets, resource tags

use Microsoft Cost Management to monitor costs on a per project basis

== A. budgets

B. resource tags





65、CLI == Azure Activity logs

![image-20250715145547480](./AZ305 复习 topic 1.assets/image-20250715145547480.png)



#### 66、sas only, aad credentials

![image-20250715145610197](./AZ305 复习 topic 1.assets/image-20250715145610197.png)



67、Monitor data collection == KQL

![image-20250715145652430](./AZ305 复习 topic 1.assets/image-20250715145652430.png)



68、DCR = Monitor agent

![image-20250715145716803](./AZ305 复习 topic 1.assets/image-20250715145716803.png)





















