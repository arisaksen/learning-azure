# Azure Bicep

Deploy to subscription is done with

```shell
az deployment sub
```

Deploy to resource-group is done with

```shell
az deployment group
```

`what-if` can be used to check before create.
Check what resources will be created or updated.

```shell
az deployment sub what-if
az deployment group what-if
```

# Create resource group

```shell
az deployment sub what-if \
--location northeurope
--template-file resource-group.bicep

az deployment sub create\
--location northeurope
--template-file resource-group.bicep
```

Resource-group name is use as input for the other:

```shell
export grp='myrg'
```

# Create resources

First create resource group

```
az deployment group what-if \
--resource-group $grp \
--template-file <filename>.bicep

az deployment group create \
--resource-group $grp \
--template-file <filename>.bicep
```

# Show stacks

```
az deployment sub show --name resource-group
az deployment sub show --name resource-group --query properties.timestamp
az deployment group show --name <filename>
```

To test resource `Output`

```
az deployment group show --name <filename> --query properties.outputs.<outputName>
```

Output example:

```shell
{
  "type": "String",
  "value": "13760ed6-eb70-4343-a5f9-7aaebad07f3a"
}
```

## Delete resource group

az group delete --name <resource-group-name> --yes
