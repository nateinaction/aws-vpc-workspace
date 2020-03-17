# workspace

A personal workspace in the cloud.

### Setup
- Verify Docker and brew installed locally
- Setup your `~/.terraformrc` - [Terraform Docs](https://www.terraform.io/docs/commands/cli-config.html#credentials-1)
- Variables are declared in [Terraform Cloud](https://app.terraform.io/app)

### How to lint and test infrastructure changes
- `make`

### How to deploy to dev and test
- `make deploy`
- `SSH_USERNAME="" SSH_DOMAIN="" make test_ssh_connection`

### How to deploy to prod
- `INFRASTRUCTURE_ENV="prod" make deploy`
