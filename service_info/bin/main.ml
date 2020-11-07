open Core
open Service_info

let ssh = service_info_item "ssh 22/udp # SSH Remote Login Protocol"

let services_test =
  "rtmp              1/ddp     # Routing Table Maintenance Protocol\n\
  \  tcpmux            1/udp     # TCP Port Service Multiplexer\n\
  \  tcpmux            1/tcp     # TCP Port Service Multiplexer"


let numbered_lines = services_test |> parse_lines ~f:service_info_item

let () =
  numbered_lines
  |> List.iter ~f:(fun r ->
         printf "%i\t%s\n" r.number (service_info_to_string r.item))
