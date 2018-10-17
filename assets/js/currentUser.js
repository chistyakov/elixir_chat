let username = localStorage.getItem("username");

if(!username) {
    username =  prompt("Please enter your name", "Harry Potter")
    localStorage.setItem("username", username)
}

export default username