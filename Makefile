VENV=.venv
PYTHON=python3.4
SYSTEM_PYTHON=$(shell which $(PYTHON))
SOURCE=./lib

virtual-env:
	$(SYSTEM_PYTHON) -m venv $(VENV)

pygraphviz:
	@git clone https://github.com/pygraphviz/pygraphviz
	@. $(VENV)/bin/activate && \
	cd pygraphviz && \
	git checkout 6c0876c9bb158452f1193d562531d258e9193f2e && \
	git apply ../patches/graphviz-includes.diff && \
	python setup.py install
	@rm -rf pygraphviz


deps: pygraphviz
	. $(VENV)/bin/activate && \
	pip3.4 install -r requirements.txt

setup: virtual-env deps
	. $(VENV)/bin/activate && \
	$(PYTHON) setup.py install

run:
	. $(VENV)/bin/activate && \
	ipython notebook notebooks/mmpl-arch.ipynb

clean:
	rm -rf $(VENV)

repl:
	. $(VENV)/bin/activate && $(PYTHON)

flakes:
	flake8 $(SOURCE)
