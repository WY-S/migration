from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.rdbms.postgresql_flexibleservers import PostgreSQLManagementClient
from azure.mgmt.rdbms.postgresql_flexibleservers.models import Server, Sku, Storage


def create_postgres_flexible_server(subscription_id, resource_group, server_name, location):
    # Authenticate with your Azure account
    credential = DefaultAzureCredential()

    # Create resource management client and PostgreSQL management client
    resource_client = ResourceManagementClient(credential, subscription_id)
    postgres_client = PostgreSQLManagementClient(credential, subscription_id)

    # Create resource group
    resource_client.resource_groups.create_or_update(
        resource_group,
        {
            'location': location
        }
    )

    # Create PostgreSQL Flexible Server
    server_params = Server(
        location='eastus',
        sku=Sku(name='Standard_D4s_v3', tier='GeneralPurpose'),
        administrator_login='azureuser',
        administrator_login_password='SUNwenyi1234',
        storage=Storage(storage_size_gb=32, auto_grow='Enabled'),
        version="16",
        create_mode="Create"
    )

    postgres_client.servers.begin_create(
        resource_group,
        server_name,
        server_params
    ).result()

    print(f"PostgreSQL Flexible Server '{server_name}' created in resource group '{resource_group}'")


if __name__ == '__main__':
    subscription_id = '25dfc6b1-fc64-4b88-ba09-4c6864d0cadc'
    resource_group = 'postgredb'
    server_name = 'wenyitestcreate3'
    location='eastus'

    create_postgres_flexible_server(subscription_id, resource_group, server_name, location)