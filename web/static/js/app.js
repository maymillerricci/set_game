// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {}});
socket.connect();

let boardContainer = document.getElementById("board");
let gameId = boardContainer.attributes["data-game-id"].value;
let playerList = document.getElementById("player-list");
let startButton = document.getElementById("start-game");

let channel = socket.channel(`game:${gameId}`);

channel.join()
  .receive("error", resp => {
    alert(`Sorry, you can't join because ${resp.reason}`)
  });

channel.on("player_joined", payload => {
  playerList.innerHTML = "";
  let players = payload.players;
  for (let i = 0; i < players.length; i++) {
    let playerListItem = document.createElement("li");
    let player = payload.players[i];
    let playerText = `Player #${player.number} | Points: ${player.points}`;
    playerListItem.innerText = playerText;
    playerList.appendChild(playerListItem);
  }
});

startButton.addEventListener("click", (event) => {
  channel.push("start_game")
    .receive("error", resp => alert(resp.reason));
});

channel.on("update_board", payload => {
  let board = payload.board;
  let cards = document.getElementsByClassName("card");

  for (let i = 0; i < cards.length; i++) {
    cards[i].className = `card ${board[i].color}`;
  }
});
