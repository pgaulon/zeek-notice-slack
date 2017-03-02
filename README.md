# bro-notice-slack
Script extending Bro Notice framework, adding Slack notifications.

## Usage
Append to bro_install/share/bro/site/local.bro:
```
@load ./notice_slack.bro

redef Notice::slack_webhook_url = "https://hooks.slack.com/services/T00000000/000000000/XXXXXXXXXXXXXXXX";
redef Notice::slack_emoji = ":bro:";
redef Notice::slack_channel = "#bro-channel";
redef Notice::slack_username = "Big Brother";

hook Notice::policy(n: Notice::Info)
{
    add n$actions[Notice::ACTION_SLACK];
}
```
