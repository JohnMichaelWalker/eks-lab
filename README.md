# eks-lab

## Bootstrapping - only need to be ran initially with fresh AWS account
To set up the Terraform backend:

```bash
cd bootstrap-scripts
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python bootstrap.py