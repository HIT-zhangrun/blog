#!/bin/bash
rm -rf build/
clear
sphinx-autobuild doc build/html --host 192.168.31.4 --port 8080
