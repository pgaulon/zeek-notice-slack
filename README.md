# zeek-notice-slack
Script extending Zeek Notice framework, adding Slack notifications.

## Usage
Append to zeek_install/share/zeek/site/local.zeek:
```
@load ./notice_slack.zeek

redef Notice::slack_webhook_url = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX";
redef Notice::slack_emoji = ":eyes:";
redef Notice::slack_channel = "#zeek-channel";
redef Notice::slack_username = "Zeek";

hook Notice::policy(n: Notice::Info)
{
    add n$actions[Notice::ACTION_SLACK];
}
```
## TODO
- Allow \n in Slack text by changing the pattern in to_json()
- Add timeout block with Reporter::warning after when block
- ...
