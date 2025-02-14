#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

RANDOM_NUMBER=$((RANDOM % 1000 +1))
echo "$RANDOM_NUMBER"

echo -e "\nEnter your username:"
read USERNAME

echo "$($PSQL "SELECT * FROM users;")" | while read USER_ID BAR USER_NAME BAR GAME_PLAYED BAR BEST_GAME
do
  if [[ -z $USER_NAME ]]
  then
    USER_NAME=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
    echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  else
    USERNAME=$USER_NAME
    echo -e "\nWelcome back, $USERNAME! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
  
done