#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

RANDOM_NUMBER=$((RANDOM % 1000 +1))
echo "$RANDOM_NUMBER"
echo -e "\nEnter your username:"
read USERNAME
