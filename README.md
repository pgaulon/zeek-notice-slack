# zeek-notice-slack
Script extending Zeek Notice framework, adding Slack notifications.

## Usage
### Manual installation
```shell
[root@manager site]# pwd
/opt/zeek/share/zeek/site
[root@manager site]# git clone https://github.com/pgaulon/zeek-notice-slack.git
Cloning into 'zeek-notice-slack'...
remote: Enumerating objects: 9, done.
remote: Counting objects: 100% (9/9), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 51 (delta 1), reused 4 (delta 0), pack-reused 42
Unpacking objects: 100% (51/51), done.
[root@manager site]# ls
local.zeek  zeek-notice-slack
[root@manager site]# vi local.zeek
[root@manager site]# tail -n9 local.zeek ; echo
@load ./zeek-notice-slack
redef Notice::slack_webhook_url = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX";
redef Notice::slack_emoji = ":eyes:";
redef Notice::slack_channel = "#zeek-channel";
redef Notice::slack_username = "Zeek";
hook Notice::policy(n: Notice::Info)
{
    add n$actions[Notice::ACTION_SLACK];
}


[root@manager site]# /opt/zeek/bin/zeekctl deploy
# truncated output
[root@manager site]# /opt/zeek/bin/zeekctl start
starting logger ...
starting manager ...
starting proxy ...
starting worker ...
[root@manager zeek-notice-slack]# /opt/zeek/bin/zeekctl scripts | grep slack
    /opt/zeek/spool/installed-scripts-do-not-touch/site/zeek-notice-slack/__load__.zeek
      /opt/zeek/spool/installed-scripts-do-not-touch/site/zeek-notice-slack/notice_slack.zeek
    /opt/zeek/spool/installed-scripts-do-not-touch/site/zeek-notice-slack/__load__.zeek
      /opt/zeek/spool/installed-scripts-do-not-touch/site/zeek-notice-slack/notice_slack.zeek
    /opt/zeek/spool/installed-scripts-do-not-touch/site/zeek-notice-slack/__load__.zeek
      /opt/zeek/spool/installed-scripts-do-not-touch/site/zeek-notice-slack/notice_slack.zeek
    /opt/zeek/spool/installed-scripts-do-not-touch/site/zeek-notice-slack/__load__.zeek
      /opt/zeek/spool/installed-scripts-do-not-touch/site/zeek-notice-slack/notice_slack.zeek
```

## TODO
- Allow \n in Slack text by changing the pattern in to_json()
- Add timeout block with Reporter::warning after when block
- ...
