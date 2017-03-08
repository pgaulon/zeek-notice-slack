# bro-notice-slack
Script extending Bro Notice framework, adding Slack notifications.

## Usage
Append to bro_install/share/bro/site/local.bro:
```
@load ./notice_slack.bro

redef Notice::slack_webhook_url = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX";
redef Notice::slack_emoji = ":eyes:";
redef Notice::slack_channel = "#bro-channel";
redef Notice::slack_username = "Big Brother";

hook Notice::policy(n: Notice::Info)
{
    add n$actions[Notice::ACTION_SLACK];
}
```
## TODO
- Allow \n in Slack text by changing the pattern in to_json()
- Add timeout block with Reporter::warning after when block  
- ...
