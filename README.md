# Fluent::Plugin::ParseMessage

The ParseMessageFilter matches incoming messages against a format regex and adds any named matches to the message.

This is the same functionality as using `type tail; format regex`, but we can't use that because we are receiving all messages as `type syslog` from rsyslog, so need a filter to match once we have extracted tags from the syslog tag.
