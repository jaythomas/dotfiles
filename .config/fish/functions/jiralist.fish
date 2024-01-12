function jiralist
    jira issue list --assignee $argv --plain --columns SUMMARY,STATUS,REPORTER,UPDATED --order-by UPDATED -s Inbox -s Design -s Analysis -s 'In Progress' -s 'Dev QA' -s 'Stage QA'
end
