# terraform-azure-network-virtualwan

Org-standard Terraform wrapper for **Virtual WAN** and **Virtual Hub**.

⚠️ **No AVM module exists for this resource** as of this writing. This wraps the native `azurerm_virtual_wan` / `azurerm_virtual_hub` resources directly, following the same conventions as the rest of this org's module set. Swap it for an AVM module if/when Microsoft publishes one.

Deploys into an existing resource group -- this module does not create the resource group itself. Compose with [terraform-azure-naming](https://github.com/<org>/terraform-azure-naming) and [terraform-azure-tags](https://github.com/<org>/terraform-azure-tags).

## Usage

```hcl
module "virtualwan" {
  source = "git::https://github.com/<org>/terraform-azure-network-virtualwan.git?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  tags                 = module.tags.tags

  virtual_wans = {
    main = { name = "vwan-prod-eus" }
  }

  virtual_hubs = {
    hub1 = {
      name            = "vhub-prod-eus"
      virtual_wan_key = "main"
      address_prefix  = "10.0.0.0/24"
    }
  }
}
```

See [`examples/basic`](examples/basic) for a minimal (zero-instance) example.

## Inputs

### `virtual_wans`

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `name` | `string` | yes | |
| `type` | `string` | no | Default `"Standard"`. |
| `disable_vpn_encryption` | `bool` | no | Default `false`. |
| `allow_branch_to_branch_traffic` | `bool` | no | Default `true`. |
| `office365_local_breakout_category` | `string` | no | |
| `tags` | `map(string)` | no | |

### `virtual_hubs`

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `name` | `string` | yes | |
| `virtual_wan_key` | `string` | yes | Must reference a key in `var.virtual_wans`. |
| `address_prefix` | `string` | no | |
| `sku` | `string` | no | Default `"Standard"`. |
| `hub_routing_preference` | `string` | no | |
| `tags` | `map(string)` | no | |

## Outputs

- `virtual_wans` -- map of created `azurerm_virtual_wan` resources.
- `virtual_hubs` -- map of created `azurerm_virtual_hub` resources.
