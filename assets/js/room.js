let Room = {
  init(socket, currentUserName) {
    let channel = socket.channel('room:lobby', {})
    channel.join()
    this.listenForChats(channel, currentUserName)
  },

  listenForChats(channel, currentUserName) {
    document.getElementById('chat-form').addEventListener('submit', function(e){
      e.preventDefault()

      let userMsg = document.getElementById('user-msg').value

      channel.push('shout', {name: currentUserName, body: userMsg})

      document.getElementById('user-msg').value = ''
    })

    channel.on('shout', payload => {
        let chatBox = document.querySelector('#chat-box')
        let msgBlock = document.createElement('p')

      msgBlock.insertAdjacentHTML('beforeend', `<b>${payload.name}:</b> ${payload.body}`)
      chatBox.appendChild(msgBlock)
    })
  }
}
  
export default Room
