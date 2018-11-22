# Makefile for msgiver
#
# useful targets:
#		make test
#		make install
#		make update
#		make clean
#		make develop
#		make watch

PWD = $(shell pwd)
OS = $(shell uname -s)
NAME = lambda_deploy
PYTHON_VERSION = $(python --version)

test:
	# python -m unittest tests
	pipenv run pytest

build-pkg: clean
	@echo "Build to setup.py"
	python setup.py sdist
	twine register dist/*

upload-pkg:
	@echo "Upload package to PyPI"
	twine upload dist/*

install: clean
	@echo "Install $(NAME)"
	pipenv install
	pipenv lock -r > requirements.txt
	python setup.py install
	@echo "Complete installed $(NAME)"

update:
	@echo "Update $(NAME)"
	python setup.py install
	unlink /usr/local/bin/$(NAME)
	ln -svf ./bin/$(NAME) /usr/local/bin
	/usr/local/bin/$(NAME) setting
	@echo "Complete updated $(NAME)"

clean:
	@echo "Clean this project"
	rm -rf $(NAME).egg-info/
	rm -rf dist/*
	rm -rf build/*
	find . -type f -regex ".*\.py[co]$$" -delete
	find . -type d -name "__pycache__"  -delete
	find . -type f \( -name "*.swp" \) -delete

develop:
	@echo "Development $(NAME) project"
	pip install pipenv
	pipenv install
	@echo "This project document is <https://github.com/kitaro-tn/$(NAME)/blob/master/README.md>"

watch:
	python bin/watcher.py
