# eks-lab

## Bootstrapping
Only needs to be ran initially with fresh AWS account
To set up the Terraform backend:

```bash
cd bootstrap-scripts
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python bootstrap.py
```

TODO: Also, create an IAM user in AWS and add the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as repository secrets to this repository. (TODO add this to bootstrap script)

TODO: Also, register a domain with Route53

TODO: Also, created a DNS record Type A that points at my Load Balancer (This isn't going to work long term, temporary)


## Making changes
Terraform apply will automatically be ran on any changes that are merged to main.

## Saving Money with terraform destroy
There is a terraform destroy action which can be used to destroy everything except the bootstrapped bit, this is useful if you're trying to keep costs down.