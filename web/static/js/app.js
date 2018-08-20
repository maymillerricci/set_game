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

let boardContainer = $("#board");
let gameId = boardContainer.data("game-id");
let playerList = $("#player-list");
let startButton = $("#start-game");

let channel = socket.channel(`game:${gameId}`);

channel.join()
  .receive("error", resp => {
    alert(`Sorry, you can't join because ${resp.reason}`)
  });

channel.on("player_joined", payload => {
  playerList.text("");
  $.each(payload.players, function(index, player) {
    let playerText = `Player #${player.number} | Points: ${player.points}`;
    playerList.append(`<li>${playerText}</li>`);
  });
});

startButton.on("click", () => {
  channel.push("start_game")
    .receive("error", resp => alert(resp.reason));
});

channel.on("update_board", payload => {
  $.each($(".card"), function(index, card) {
    $(card).addClass(payload.board[index].color);
  });
});
