# Funcs

This directory holds only Bash functions (typically only few lines)

## Functions definition

### Random package (`random::`)

| function | description |
| --- | --- |
| `rand8` | return a random value between 0 and 255 |
| `rand16` | return a random value between 0 and 65,535 |
| `rand24` | return a random value between 0 and 16,777,215 |
| `rand32` | return a random value between 0 and 4,294,967,295 |

### UUID package (`uuid::`)

| function | description |
| --- | --- |
| `uuid4` | return a UUID v4 string |

### Network package (`network::`)

| function | description |
| --- | --- |
| `fake_server` | create a TCP listener to check FW ports |
| `zero_connect` | test if a port is opened |
| `mac_address` | retrieve the MAC address of an interface |
| `ip_address` | retrieve the IP address of an interface |

