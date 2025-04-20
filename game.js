const GameBoardModule = (() => {
    let gameBoard = ["", "", "", "", "", "", "", "", ""]


    const getGameBoard = () => gameBoard;
    function render() { 
        let boardHTML = "";
        gameBoard.forEach((square,index) => {
            boardHTML += `<div class="cell" id="cell-${index}">${square}</div>`
        });
        document.querySelector("#gameBoardContainer").innerHTML = boardHTML;

        const $cells = document.querySelectorAll('.cell');
        $cells.forEach(($cell) =>{
            $cell.addEventListener('click', Game.handleClickEvent);
        });
    }

    function update(index,value) {
        gameBoard[index] = value;
        render();
    }

    return {
        render,
        update,
        getGameBoard
    }
})(); 

const Game = (() => {
    let players = [];
    let currentPlayerIndex;
    let gameOver;

    //Cache DOM elements
    const $player1_input = document.querySelector("#player1")
    const $player2_input = document.querySelector("#player2")
    
    function start() {
        players = [
            createPlayer($player1_input.value.trim(), "X"),
            createPlayer($player2_input.value.trim(), "O"),
        ];
        currentPlayerIndex = 0;
        gameOver = false
        GameBoardModule.render();

        const $cells = document.querySelectorAll('.cell');
        $cells.forEach(($cell) =>{
            $cell.addEventListener('click', Game.handleClickEvent);
        });
    }

    function handleClickEvent(event) {
        const index = parseInt(event.target.id.split("-")[1]);

        if(GameBoardModule.getGameBoard()[index] !== "") {
            return;
        }

        GameBoardModule.update(index, players[currentPlayerIndex].symbol);
        currentPlayerIndex = currentPlayerIndex === 0 ? 1 : 0;
    }
    
    return {
        start,
        handleClickEvent
    }
})();


function createPlayer(name, symbol) {
    return {
        name,
        symbol
    }
}

const startButton = document.querySelector('#start-button');
startButton.addEventListener('click', ()=> {
    Game.start();
});


