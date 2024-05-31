USER_NAME = $(shell python3 Scripts/author_name.py)
CURRENT_DATE = $(shell pipenv run python Scripts/current_date.py)

Bootstrap:
	@arch -arm64 brew install pipenv
	@tuist install
	@tuist generate

# e.g. make Core name=모듈이름
Core:
	@echo "User Name: $(USER_NAME)"
	@echo "Current Date: $(CURRENT_DATE)"
	@tuist scaffold Core \
	 --name-core ${name} \
	 --author-core "$(USER_NAME)" \
	 --current-date-core "$(CURRENT_DATE)"
	 
	@tuist edit

# e.g. make Feature name=모듈이름
Feature:
	@echo "User Name: $(USER_NAME)"
	@echo "Current Date: $(CURRENT_DATE)"
	@tuist scaffold Feature \
	 --name ${name} \
	 --author "$(USER_NAME)" \
	 --current-date "$(CURRENT_DATE)"
	 
	@tuist edit