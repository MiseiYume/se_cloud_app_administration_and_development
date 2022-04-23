###    Variables
VENV = venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip


###    Targets with recipes
run: $(VENV)/bin/activate
	touch requirements.txt
	$(PYTHON) ./PiAAC/run.py

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt

rerun:  $(wildcard PiAAC/**/*)
	pkill -f ./PiAAC/run.py
	$(PYTHON) ./PiAAC/run.py

clean:
	rm -rf __pycache__
	rm -rf $(VENV)

