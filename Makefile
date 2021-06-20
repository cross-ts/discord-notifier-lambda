.PHONY: deploy
deploy:
	@aws cloudformation package \
		--s3-bucket cross-ts.serverless-source \
		--s3-prefix discord-notifier \
		--template-file template.yml \
		--output-template-file .template.yml
	@aws cloudformation deploy \
		--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
		--template-file .template.yml \
		--stack-name discord-notifier
	@rm .template.yml

.PHONY: delete
delete:
	@aws cloudformation delete-stack \
		--stack-name discord-notifier
