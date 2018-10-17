import {Socket} from "phoenix"
import username from "./currentUser"

let socket = new Socket("/socket", {params: {username: username}})

socket.connect()

export default socket
