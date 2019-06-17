#!/bin/bash
test $(curl 34.201.45.141:8080/sum?a=1\&b=2) -eq 3