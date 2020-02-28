# Ansible-variable-evaluation-bug-demonstration

This is a barebones Operator-sdk operator made in Ansible to demonstrate the current issue with sourcing variables in tasks, and how the variables can unknowingly be sourced from either jinja templating, or ansible templating. Depending on the templating engine, certain definitions may fail to validate.

For more information read the following slack thread:
https://kubernetes.slack.com/archives/CAW0GV7A5/p1582893529107700
or this git issue:
https://github.com/operator-framework/operator-sdk/issues/2609

# Using the operator
To use this operator, create a new namespace/project and run ./build.sh <docker-registry/image-name:v1>. For example: ./build.sh/ quay.io/username/test-operator:v1 It needs a temporary registry to store the dockerfile so that pods can access it.

Inspect the ansible logs with ./logs.sh to see the errors caused by different methods of using THE SAME RESOURCE_DEFINITION

When done run ./cleanup.sh to clean up all created resources

# The problem area
The problem is highlighted in /roles/test/tasks/main.yaml, comment and uncomment different tasks to see how they fail.
One of the tasks sources from /roles/test/templates/bugged-service-definition.yaml


I lost way too many hours on this so I hope it gets fixed or becomes more well-known and thus avoided.
