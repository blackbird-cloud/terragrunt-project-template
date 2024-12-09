# Terragrunt Project Template

This is an example template for a Terragrunt project. It is a simple template project that gets you started with terragrunt.
It includes a folder layout for easy management and expanding of your infrastructure and some explanations on how to use it.

## Prerequisites

Install the following tools to use this project.

- [Terraform](https://www.terraform.io/)
- [Terragrunt](https://terragrunt.gruntwork.io/)
- [tfenv](https://github.com/tfutils/tfenv)
- [tgenv](https://github.com/tgenv/tgenv)
- [sops](https://github.com/getsops/sops)
- [pre-commit](https://pre-commit.com/)

Check the terraform and terragrunt versions in the `.terraform-version` and `.terragrunt-version` files respectively.

Install the correct verions of terraform and terragrunt using 
```sh
tgenv install
tfenv install
```

## Folder structure

An important part of the modular design is the folder structure. There are a few folders that are important to understand. 

- **Cloud** Contains the infrastructure specific resources
- **Modules** Contains your terraform modules that can be used in the cloud configuration
- **Templates** Contains the templates files or any other files that are used in the terragrunt configuration

### Cloud

This folder contains the resources to create your infrastructure. The first folder layer in here is to divide the resources per environment. This can be different aws accounts, resource groups or regions. For this example we only have a production environment.

In each environment folder, resources are created by folder and each is numbered. This makes it easy to see dependencies and the order in which resources are created. You enforce the order by using the `depends_on` attribute in the terragrunt configuration.

```md
- cloud
  - development
    - 01-vpc
    - 02-instance
  - production
    - 01-vpc
    - 02-instance
    - 03-database
```

In the root of the cloud folder there is also a remote state configuration `remote_state.hcl`. This is used to store the state of the infrastructure in a remote location. This can be an S3 bucket or a terraform cloud workspace. This file is referenced in each resource folder to store the state in the same backend.

### Modules

This folder contains your own modules that can be used in the cloud configuration. Sometimes the public modules are not enough and you need to create your own. This is a good place to store them. Create a folder for each module and add the terraform files in there. 

If you want to use public terraform modules you can find them on the [terraform registry](https://registry.terraform.io/) our blackbird cloud modules are also available [there](https://registry.terraform.io/namespaces/blackbird-cloud) 

### Templates

This folder contains templates, data or other files for the terragrunt configuration. Some examples are cloudformation templates, policy json files or user scripts.

## Secret management

SOPS is a tool to encrypt and decrypt secrets. It is used to encrypt the secrets in the `secrets.sops.hcl` file.

Link your encryption key in the config `.sops.yaml`
```
creation_rules:
  - path_regex: \.sops\.hcl$
    kms: arn:aws:kms:eu-west-1:123456789012:key/12345678-1234-1234-1234-123456789012
```

Commands to decrypt and encrypt the secrets file.

Decrypt
```sh
sops -d secrets.sops.hcl.enc > secrets.sops.hcl
```

Encrypt
```sh
sops -e secrets.sops.hcl > secrets.sops.hcl.enc
```

Make sure to add the `secrets.sops.hcl` file to the `.gitignore` file and only commit the encrypted file `secrets.sops.hcl.enc`.

For more documentation check the [SOPS documentation](https://github.com/getsops/sops)