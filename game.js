const GameBoardModule = (() => {
    let gameBoard = ["0", "", "", "X", "", "", "", "", ""]

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

    return {
        render,
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
    }

    function handleClickEvent(event) {
        alert("Square Clicked!!!");
        console.log(`${event}`);
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


