PACKAGE_S3_BUCKET := cross-ts.serverless-source
APPLICATION_NAME := discord-notifier

.PHONY: deploy
deploy:
	@aws cloudformation package \
		--s3-bucket $(PACKAGE_S3_BUCKET) \
		--s3-prefix $(APPLICATION_NAME) \
		--template-file template.yml \
		--output-template-file .template.yml
	@aws cloudformation deploy \
		--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
		--template-file .template.yml \
		--stack-name $(APPLICATION_NAME)
	@rm .template.yml

.PHONY: delete
delete:
	@aws cloudformation delete-stack \
		--stack-name $(APPLICATION_NAME)
