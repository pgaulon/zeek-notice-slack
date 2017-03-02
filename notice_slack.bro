##! This script is providing slack notifications for notices

@load base/frameworks/notice
@load base/utils/active-http
@load base/utils/json

module Notice;

export {
    redef enum Action += {
        ACTION_SLACK,
    };

    # a Slack_message an enum which will be converted to JSON format
    # to be sent to the Slack Incoming Webhook
    type Slack_message: record {
        text: string;
        channel: string &optional;
        username: string &optional;
        icon_emoji: string &optional;
    };

    # Needs to be redefined to match your Slack Incoming Webhook URL
    const slack_webhook_url = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX" &redef;

    # Can be redefined to add a different public channel, username and emoji
    const slack_channel = "" &redef;
    const slack_username = "Big Brother" &redef;
    const slack_emoji = ":eyes:" &redef;

    # creates the Slack_message
    global slack_payload: function(n: Notice::Info, channel: string, username: string, emoji: string): Notice::Slack_message;
    # converts the Slack_message to JSON and sends it to the Slack Incoming Webhook
    global slack_send_notice: function(webhook: string, payload: Notice::Slack_message);

}

function slack_send_notice(webhook: string, payload: Notice::Slack_message)
    {
    local request: ActiveHTTP::Request = ActiveHTTP::Request(
        $url=webhook,
        $method="POST",
        $client_data=to_json(payload)
    );

    when ( local result = ActiveHTTP::request(request) )
        {
        if ( result$code != 200 )
            Reporter::warning(fmt("Slack notice received an error status code: %d", result$code));
        }
    }

function slack_payload(n: Notice::Info, channel: string, username: string, emoji: string): Notice::Slack_message
    {
    local text = fmt("%s: %s", n$note, n$msg);
    local message: Slack_message = Slack_message($text=text, $channel=channel, $username=username, $icon_emoji=emoji);
    return message;
    }

hook notice(n: Notice::Info)
    {
        if ( ACTION_SLACK in n$actions )
            slack_send_notice(slack_webhook_url, slack_payload(n, slack_channel, slack_username, slack_emoji));
    }
