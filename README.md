# Pingtunnel

[<img src="https://img.shields.io/github/license/esrrhs/pingtunnel">](https://github.com/esrrhs/pingtunnel)
[<img src="https://img.shields.io/github/languages/top/esrrhs/pingtunnel">](https://github.com/esrrhs/pingtunnel)
[![Go Report Card](https://goreportcard.com/badge/github.com/esrrhs/pingtunnel)](https://goreportcard.com/report/github.com/esrrhs/pingtunnel)
[<img src="https://img.shields.io/github/v/release/esrrhs/pingtunnel">](https://github.com/esrrhs/pingtunnel/releases)
[<img src="https://img.shields.io/github/downloads/esrrhs/pingtunnel/total">](https://github.com/esrrhs/pingtunnel/releases)
[<img src="https://img.shields.io/docker/pulls/esrrhs/pingtunnel">](https://hub.docker.com/repository/docker/esrrhs/pingtunnel)
[<img src="https://img.shields.io/github/workflow/status/esrrhs/pingtunnel/Go">](https://github.com/esrrhs/pingtunnel/actions)

Pingtunnel is a tool that send TCP/UDP traffic over ICMP.

## Note: This tool is only to be used for study and research, do not use it for illegal purposes

![image](network.jpg)

## Build source code

### build on Linux(Ubuntu)

- clone code
```shell
git clone https://github.com/xsgam/pingtunnel
go get -u github.com/xsgam/pingtunnel/...

or 
go install github.com/xsgam/pingtunnel@latest
```

```shell
# make
# make -f ./Makefile.cross-build
# sh release_pkg.sh
```

### build on Windows
- download  code
```
download code from https://github.com/xsgam/pingtunnel

c:\Go\pingtunnel-fast_build> go get

  go: downloading github.com/xsgam/go-engine v0.0.1
  go: downloading github.com/OneOfOne/xxhash v1.2.8
  go: downloading github.com/google/uuid v1.3.0
  go: downloading google.golang.org/protobuf v1.27.1
  go: downloading github.com/oschwald/geoip2-golang v1.6.1
  go: downloading github.com/golang/protobuf v1.5.2
  go: downloading golang.org/x/net v0.0.0-20220127200216-cd36cc0744dd
  go: downloading github.com/oschwald/maxminddb-golang v1.8.0
  go: downloading golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e
```

- build
```
c:\Go\pingtunnel-fast_build>go build

or 

c:\Go\pingtunnel-fast_build>win_build.bat
```
```

## Usage

### Install server

-   First prepare a server with a public IP, such as EC2 on AWS, assuming the domain name or public IP is www.yourserver.com
-   Download the corresponding installation package from [releases](https://github.com/esrrhs/pingtunnel/releases), such as pingtunnel_linux64.zip, then decompress and execute with **root** privileges

```
sudo wget (link of latest release)
sudo unzip pingtunnel_linux64.zip
sudo ./pingtunnel -type server
```

-   (Optional) Disable system default ping

```
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
```

### Install the client

-   Download the corresponding installation package from [releases](https://github.com/esrrhs/pingtunnel/releases), such as pingtunnel_windows64.zip, and decompress it
-   Then run with **administrator** privileges. The commands corresponding to different forwarding functions are as follows.
-   If you see a log of ping pong, the connection is normal

#### Forward sock5

```
pingtunnel.exe -type client -l: 4455 -s www.yourserver.com -sock5 1
```

#### Forward tcp

```
pingtunnel.exe -type client -l: 4455 -s www.yourserver.com -t www.yourserver.com:4455 -tcp 1
```

#### Forward udp

```
pingtunnel.exe -type client -l: 4455 -s www.yourserver.com -t www.yourserver.com:4455
```

### Use Docker
It can also be started directly with docker, which is more convenient. Same parameters as above
-   server:
```
docker run --name pingtunnel-server -d --privileged --network host --restart=always esrrhs/pingtunnel ./pingtunnel -type server -key 123456
```
-   client:
```
docker run --name pingtunnel-client -d --restart=always -p 1080: 1080 esrrhs/pingtunnel ./pingtunnel -type client -l: 1080 -s www.yourserver.com -sock5 1 -key 123456
```

## Test

download the centos image [centos mirror](http://centos.s.uw.edu/centos/8.4.2105/isos/x86_64/CentOS-8.4.2105-x86_64-dvd1.iso)

|              | wget     | ss       | kcp     | pingtunnel |
| ------------ | -------- | -------- | ------- | ---------- |
| AlibabaCloud | 26.6KB/s | 31.8KB/s | 606KB/s | 5.64MB/s   |

