FORCE:

start: FORCE
	bundle exec middleman server

deploy: FORCE
	./deploy.sh
