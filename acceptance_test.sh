#!/bin/bash
test $(curl http://35.174.116.17:8080/sum?a=1\&b=2) -eq 3