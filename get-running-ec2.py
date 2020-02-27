"""
    Write python script to get all running ec2
    And send email with those details

"""
import boto3
client = boto3.client('ec2')
sns_client = boto3.client('sns')

resp = client.describe_instances()
ec2_running = []
for reservation in resp['Reservations']:
    for instance in reservation['Instances']:
        id = instance['InstanceId']
        state = instance['State']['Name']
        name = None
        tags = instance['Tags']
        for tag in tags:
            if tag['Key'] == 'Name':
                name = tag['Value']
                break
        if(state=='running'):
            ec2_running.append(f"Name={name} and InstanceId={id} and State={state}")
       
print(ec2_running)

sns_client.publish(
    TopicArn = 'arn:aws:sns:ap-south-1:652173775377:ec2-alerst',
    Message = str(ec2_running),
    Subject = 'Running EC2 Report'
)
