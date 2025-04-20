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
        if(gameOver) {
            return;
        }

        const index = parseInt(event.target.id.split("-")[1]);

        if(GameBoardModule.getGameBoard()[index] !== "") {
            return;
        }

        GameBoardModule.update(index, players[currentPlayerIndex].symbol);

        if(checkForWinner(GameBoardModule.getGameBoard(), players[currentPlayerIndex].symbol)){
            gameOver = true;
            alert(`${players[currentPlayerIndex].name} won!`);
        } 
        else if (checkForTie(GameBoardModule.getGameBoard())) {
            gameOver = true;
            alert("Its a Tie!!!");
        }
        currentPlayerIndex = currentPlayerIndex === 0 ? 1 : 0;
    }

    function restart() {
        for(let i = 0; i < 9; i++) {
            GameBoardModule.update(i,"");
        }
        GameBoardModule.render();
    }
    
    return {
        start,
        restart,
        handleClickEvent,
    }
})();  


function createPlayer(name, symbol) {
    return {
        name,
        symbol
    }
}

function checkForWinner(board, playerSymbol) {
    const winningCombinations = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ];

    for (let i = 0; i < winningCombinations.length; i++) {
        const [a, b, c] = winningCombinations[i];
        if (board[a] &&
            board[a] === playerSymbol &&
            board[b] === playerSymbol &&
            board[c] === playerSymbol
        ) {
            return true;
        }
    }

    return false;
}

const restartButton = document.querySelector('#restart-button');
restartButton.addEventListener('click', () => {
    Game.restart();
});

const startButton = document.querySelector('#start-button');
startButton.addEventListener('click', ()=> {
    Game.start();
});


