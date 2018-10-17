let Room = {
  init(socket) {
    let messages = document.getElementById("messages")
    let room = messages.attributes['data-room'].value
    let channel = socket.channel(room, {})
    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
    this.listenForMessages(channel)
  },

  listenForMessages(channel) {
    let input = document.getElementById("input");
    input.addEventListener("keyup", function(e){
        if (e.keyCode != 13) {
          return
        }
        channel.push("shout", {body: input.value})
        input.value = "";
      })

    channel.on("shout", function(message){
    let messages = document.getElementById("messages")
    messages.innerHTML += `<b><div class=message>@${message.username}:</b> ${message.body}</div>`
  })
  }
}
  
export default Room
