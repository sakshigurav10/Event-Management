// let popup = document.getElementById("popup");

// function closePopup() {
//     popup.classList.remove("open-popup");
// }

// function openPopup() {
//     popup.classList.add("open-popup");
// }

// document.getElementById("btn").addEventListener("click", function() {
//     var own = document.getElementById("owner").getElementsByTagName("input")[0].value;
//     var cv = document.getElementById("cvv").getElementsByTagName("input")[0].value;
//     var card = document.getElementById("card_num").getElementsByTagName("input")[0].value;
//     var val = document.getElementById("months").value + "/" + document.getElementById("years").value;

//     if (own == "" || cv == "" || card == "" || val == "") {
//         alert("All fields are mandatory!");
//     } else if (card.length !== 16) {
//         alert("Enter a valid 16-digit card number");
//     } else if (cv.length !== 3) {
//         alert("Please check CVV!");
//     } else {
//         openPopup(); // Show the popup
//     }
// });

$(document).ready(function() {
    var popup = $("#popup");

    function closePopup() {
        popup.removeClass("open-popup");
    }

    function openPopup() {
        popup.addClass("open-popup");
    }

    $("#btn").click(function() {
        var own = $("#owner input").val();
        var cv = $("#cvv input").val();
        var card = $("#card_num input").val();
        var val = $("#months").val() + "/" + $("#years").val();

        if (own == "" || cv == "" || card == "" || val == "") {
            alert("All fields are mandatory!");
        } else if (card.length !== 16) {
            alert("Enter a valid 16-digit card number");
        } else if (cv.length !== 3) {
            alert("Please check CVV!");
        } else {
            openPopup(); // Show the popup
        }
    });

    // Close the popup when the "OK" button is clicked
    $("#popup button").click(function() {
        closePopup();
    });
});
