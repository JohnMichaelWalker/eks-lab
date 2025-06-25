import logging
import boto3

# A script to run when starting from a fresh aws account
region ='eu-west-2'
s3BucketName ='boss-eks-lab-terraform-state'
dynamoDbTableName = 'boss-eks-lab-terraform-locks'

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s %(levelname)s: %(message)s'
)

# create an s3 bucket for the terraform state
logging.info(f"Creating S3 bucket '{s3BucketName}' in region '{region}'...")
s3 = boto3.client('s3', region_name=region)
s3.create_bucket(
    Bucket=s3BucketName, 
    CreateBucketConfiguration={'LocationConstraint': 'eu-west-2'}
    )
logging.info(f"S3 bucket '{s3BucketName}' created.")



# create a dynamo db for the terraform locks

logging.info(f"Creating DynamoDB table '{dynamoDbTableName}' in region '{region}'...")
dynamodb = boto3.client('dynamodb', region_name=region)
dynamodb.create_table(
    TableName=dynamoDbTableName,
    AttributeDefinitions=[{
        'AttributeName': 'LockID',
        'AttributeType': 'S'
    }],
    KeySchema=[{
        'AttributeName': 'LockID',
        'KeyType': 'HASH'
    }],
    BillingMode='PAY_PER_REQUEST'
)
logging.info(f"DynamoDB table '{dynamoDbTableName}' created.")
