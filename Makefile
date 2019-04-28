SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = sanic-jwt
SOURCEDIR     = docs/source
BUILDDIR      = docs/build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@echo "test - run tests with coverage"
	@echo "release - package and upload a release"

.PHONY: black help  release Makefile

%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

clean:
	find . ! -path "./.eggs/*" -name "*.pyc" -exec rm {} \;
	find . ! -path "./.eggs/*" -name "*.pyo" -exec rm {} \;
	find . ! -path "./.eggs/*" -name ".coverage" -exec rm {} \;
	rm -rf build/* > /dev/null 2>&1
	rm -rf dist/* > /dev/null 2>&1

test:
	python setup.py test

black:
	black ./ -l 79 --safe
	isort -rc sanic_jwt tests

release: clean
	python setup.py sdist bdist_wheel
	twine upload dist/*