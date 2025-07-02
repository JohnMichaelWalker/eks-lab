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

Create an IAM user in AWS and add the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as repository secrets to this repository. (TODO add this to bootstrap script)

