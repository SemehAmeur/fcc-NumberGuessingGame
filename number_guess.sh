#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

RANDOM_NUMBER=$((RANDOM % 1000 +1))

echo -e "\nEnter your username:"
read USERNAME

echo "$($PSQL "SELECT * FROM users WHERE username='$USERNAME';")" | while read USER_ID BAR USER_NAME BAR GAME_PLAYED BAR BEST_GAME
do
  echo "1    $USER_NAME"
  if [[ -z $USER_NAME ]]
  then
    USER_NAME=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  else
    echo "$USER_NAME"
    USERNAME=$USER_NAME
    echo "Welcome back, $USERNAME! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
done

echo "Guess the secret number between 1 and 1000:"

NUMBER_OF_GUESS=0

while true
do
  read INPUT_NUMBER

  if [[ "$INPUT_NUMBER" =~ ^[0-9]+$ ]]
  then
    (( NUMBER_OF_GUESS++ ))
    if [[ $INPUT_NUMBER -eq $RANDOM_NUMBER ]]
    then
      echo -e "You guessed it in $NUMBER_OF_GUESS tries. The secret number was $RANDOM_NUMBER. Nice job!"
      break
    else
      if [[ $INPUT_NUMBER -lt $RANDOM_NUMBER ]]
      then
        echo "It's higher than that, guess again:"
      else
        echo "It's lower than that, guess again:"
      fi
    fi
  else
    echo "That is not an integer, guess again:"
  fi
done

if [[ -z $BEST_GAME ]]
then
  BEST_GAME=$NUMBER_OF_GUESS
else
  if [[ $NUMBER_OF_GUESS -lt $BEST_GAME ]]
  then
    BEST_GAME=$NUMBER_OF_GUESS
  fi
fi

(( GAME_PLAYED++ ))
INSERT_QUERY=$($PSQL "UPDATE users SET game_played=$GAME_PLAYED, best_game=$BEST_GAME WHERE username='$USERNAME';")
