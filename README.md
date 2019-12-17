# bastion with instance connect

公開されているterraform moduleに2019/12現在ec2 instance connectをサポートしているものが見つからなかったため作った。

## 接続方法

[EC2 Instance Connect を使用して接続する \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ec2-instance-connect-methods.html)に従う。
ただし、[EC2のSSHアクセスをIAMで制御できるEC2 Instance Connectが発表されました ｜ Developers\.IO](https://dev.classmethod.jp/cloud/aws/ec2-instance-connect/)
に書かれている通りEC2InstanceConnectマネージドポリシーがあるため
それで事足りるなら手動でポリシーを作る必要はない。

## Terraform Configuration記述の参考元

* [EC2 Instance Connect を使用して接続する \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ec2-instance-connect-methods.html)
* [EC2 Instance Connect のセットアップ \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ec2-instance-connect-set-up.html)

## トリビア

bastionのより正しい発音はバスチャンらしい(イタリア語由来のため)
https://en.hatsuon.info/word/bastion
