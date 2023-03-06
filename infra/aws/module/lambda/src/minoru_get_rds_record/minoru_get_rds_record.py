import json
import boto3
import pymysql

sns = boto3.client('sns')
ssm = boto3.client('ssm')
topic_arn = 'arn:aws:sns:ap-northeast-1:379378515717:minoru_notice_slack'
password = ssm.get_parameter(Name='/example/prod/foobar/DB_PASSWORD', WithDecryption=True)['Parameter']['Value']

def lambda_handler(event, context):

    # MySQLに接続してSELECT文を実行
    conn = pymysql.connect(
        host="example-prod-foobar.cxp1rwmc91cd.ap-northeast-1.rds.amazonaws.com",
        user="admin",
        password=str(password),
        database="example-prod-foobar"
    )
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM tasks")
    rows = cursor.fetchall()

    # 行を処理してメッセージを作成
    message = "未消化タスクは以下になります。\n"
    for row in rows:
        print(row)
        message += "・" + row[0] + "\n"

    print(message)

    # SNSにメッセージを送信
    sns.publish(
        TopicArn=topic_arn,
        Message=message
    )

    # Lambdaログに結果を出力
    return {
        'statusCode': 200,
        'body': json.dumps("Success")
    }
