import json
import os
import boto3
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError

# SNS client
sns = boto3.client('sns')
ssm = boto3.client('ssm')

# Slack webhook URL
SLACK_WEBHOOK_URL = ssm.get_parameter(Name='minoru_slack_webhook_url', WithDecryption=True)['Parameter']['Value']

def lambda_handler(event, context):
    message = event['Records'][0]['Sns']['Message']

    # Slack payload
    payload = {
        'text': message
    }

    # Send message to Slack
    try:
        req = Request(SLACK_WEBHOOK_URL, json.dumps(payload).encode('utf-8'))
        response = urlopen(req)
        response.read()
        print('Message posted to Slack')
    except HTTPError as e:
        print('Request failed: {}'.format(e.code))
    except URLError as e:
        print('Server connection failed: {}'.format(e.reason))
