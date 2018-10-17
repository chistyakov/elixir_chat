let Room = {
  init(socket) {
    let messagesBox = document.getElementById("messages")
    let room = messagesBox.attributes['data-room'].value
    let channel = socket.channel(room, {})
    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
    this.listenForMessages(channel, messagesBox)
  },

  listenForMessages(channel, messagesBox) {
    let input = document.getElementById("input");
    input.addEventListener("keyup", function(e){
        if (e.keyCode != 13) {
          return
        }
        channel.push("shout", {body: input.value})
        input.value = "";
      })

    channel.on("shout", function(message){
        messagesBox.innerHTML += `<b><div class=message>@${message.username}:</b> ${message.body}</div>`
  })
  }
}
  
export default Room
