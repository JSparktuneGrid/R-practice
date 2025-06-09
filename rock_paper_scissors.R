## load library
library(tidyverse)
library(dplyr)

## function to get bot choices
get_bot_hand <- function() {
  hands <- c("rock", "paper","scissors")
  bot_hand <- sample(hands, 1)
}

## function to determine a winner
determine_winner <- function(user_hand, bot_hand) {
  if  ((user_hand == "Rock" && bot_hand == "Scissors") || 
      (user_hand == "Scissors" && bot_hand == "Paper") ||
      (user_hand == "Paper" && bot_hand == "Rock")) {
  return("You Win!")
  } else if (user_hand == bot_hand) {
    return("It's tie!")
  } else {
    return("Try again")
  }
}

## Main loop 
play_game <- function() {
  user_hand <- readline("Enter your hand: ")
  bot_hand <- get_bot_hand()
  
  print(paste("Your choice: ", user_hand))
  print(paste("Bot choice: ", bot_hand))
  
  winner <- determine_winner(user_hand,bot_hand)
  print(winner)
}



