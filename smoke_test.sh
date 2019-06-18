#!/bin/bash
test $(curl http://3.86.190.182:8080/sum?a=1\&b=2) -eq 3