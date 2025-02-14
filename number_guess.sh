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

echo "Guess the secret number between 1 and 1000:"

while true
do
  read INPUT_NUMBER

  if [[ "$INPUT_NUMBER" =~ ^[0-9]+$ ]]
  then
    echo "number"
    break
  else
    echo "That is not an integer, guess again:"
  fi
done