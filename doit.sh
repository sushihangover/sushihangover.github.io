#!/usr/bin/env bash

echo "Generate and deploying website"
rake generate
rake deploy
echo "Commiting and pushing source files"
git add --all; 
git commit -m "New posts"; 
git push 
