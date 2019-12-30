
// VARIABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// Variables
var numSquares = 6;			// Sets difficulty level
var colors = generateRandomColors(numSquares);			// Array of color strings in rgb() syntax
var pickedColor = pickColor();			// Color to be guessed (random from array 'colors')


// Selectors
var	squares = document.querySelectorAll(".square");			// Array of squares on the html page
var colorDisplay = document.getElementById("colorDisplay");			// Text referencing RGB() color to be guessed
var messageDisplay = document.querySelector("#message");			// Interactive message to show if guess was correct
var h1 = document.querySelector("h1");				// Selector for styling h1 banner
var resetButton = document.querySelector("#reset"); // Selector for events related to the reset button
var modeButtons = document.querySelectorAll(".mode"); // Selector for events related to the difficulty level buttons



// MAIN ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// Event listeners for mode buttons
for (var i = 0; i < modeButtons.length; i++) {
	modeButtons[i].addEventListener("click", function() {

		// Remove the selected class from both buttons in the array 
		modeButtons[0].classList.remove("selected");
		modeButtons[1].classList.remove("selected");

		// Add back the selected group to the proper button
		this.classList.add("selected");

		// Modify the number of squares that are referenced based on game difficulty level
		this.textContent  === "Easy" ? numSquares = 3: numSquares = 6;

		// Run reset function
		reset();
	});
}


// ~~~~~~~~~~~~~~


// Update text for picked color display
colorDisplay.textContent = pickedColor;


// ~~~~~~~~~~~~~~


// Reset button event lister
resetButton.addEventListener("click", function() {
	
	// Call reset function to reset game
	reset();
});


// ~~~~~~~~~~~~~~


// Initialize squares with display colors + set up event listeners for squares
for (var i = 0; i < squares.length; i++) {
	// Add initial colors to squares
	squares[i].style.backgroundColor = colors[i];

	// Add click listeners to squares
	squares[i].addEventListener("click", function() {

		// Grab color of clicked square
		var clickedColor = this.style.backgroundColor;

		// Compare color to picked 
		if (clickedColor === pickedColor) {
			messageDisplay.textContent = "Correct!!";
			changeColors(clickedColor);
			h1.style.backgroundColor = pickedColor;
			resetButton.textContent = "Play Again?";
		} else {
			this.style.backgroundColor = "#232323";
			messageDisplay.textContent = "Try Again";
		}
	}); 
}




// FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function reset(){

	// Generate new colors
	colors = generateRandomColors(numSquares);

	// Pick new random color from array
	pickedColor = pickColor();

	// Change color display to match picked color
	colorDisplay.textContent = pickedColor

	// Reset 'reset' Button Text
	resetButton.textContent = "Reset Colors"

	// Reset Text Banner
	messageDisplay.textContent = ""

	// Reset h1 color
	h1.style.backgroundColor = "steelblue" 

	// Change colors of squares  
	for (var i = 0; i < squares.length; i++) {
		if (colors[i]) {
			squares[i].style.backgroundColor = colors[i];
			squares[i].style.display = "block";
		} else {
			squares[i].style.display = "none";

		}
		
	}

}


// ~~~~~~~~~~~~~~


function changeColors(color) {
	// Loop through all squares
	for(var i = 0; i < colors.length; i++) {
		squares[i].style.backgroundColor = color;
	}
	//Change each color to match given color
}


// ~~~~~~~~~~~~~~


function pickColor() {
	var random = Math.floor(Math.random() * colors.length);
	return colors[random];
}


// ~~~~~~~~~~~~~~


function generateRandomColors(num) {
	// Make an empty array
	var arr = [];

	// Add num random colors to array
	for (var i = 0; i < num; i++) {

		// get random color and put into arr
		arr[i] = randomColor();
	}

	// return colors array
	return arr;
}     


// ~~~~~~~~~~~~~~


function randomColor() {
	// Pick a red from 0 - 255
	var r = Math.floor(Math.random() * 256);

	// Pick a green from 0 - 255
	var g = Math.floor(Math.random() * 256);

	// Pick a blue from 0 - 255
	var b = Math.floor(Math.random() * 256);

	// Return properly formatted RGB() string
	return "rgb(" + r + ", " + g + ", " + b + ")";

}