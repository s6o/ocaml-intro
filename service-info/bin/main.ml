open Service_info

let ssh = service_info_item "ssh 22/udp # SSH Remote Login Protocol"

let () =
  Core.printf
    "Service: %s | port %d | proto %s\n"
    ssh.service_name
    ssh.port
    ssh.protocol
