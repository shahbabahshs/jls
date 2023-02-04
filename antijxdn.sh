sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -N SAMP-DDOS
iptables -N SAMP-DDOS2
iptables -N SAMP-DDOS3
iptables -t mangle -A PREROUTING -p icmp -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -t mangle -A PREROUTING -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 1:7776 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7778:30000 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j RETURN
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A INPUT -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j REJECT
iptables -A INPUT -p udp --dport 1:7776 -j REJECT
iptables -A INPUT -p udp --dport 7778:30000 -j REJECT
iptables -A INPUT -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j REJECT
iptables -I INPUT  -s 66.55.155.101 -j ACCEPT
iptables -I INPUT  -s 66.55.155.0/24 -j ACCEPT
iptables -I INPUT  -s  82.192.84.116 -j ACCEPT
iptables -I INPUT  -s  82.192.84.0/24 -j ACCEPT		
iptables -t filter -A OUTPUT -p icmp -m icmp --icmp-type echo-reply -j DROP
iptables -t filter -A OUTPUT -p icmp -m icmp --icmp-type port-unreachable -j DROP
iptables -I INPUT  -s 104.28.17.92 -j ACCEPT
iptables -I INPUT  -s 104.28.17.0/24 -j ACCEPT
iptables -I INPUT  -s 162.144.7.215 -j ACCEPT
iptables -I INPUT  -s 162.144.7.0/24 -j ACCEPT
iptables -I INPUT  -s 149.202.241.189 -j ACCEPT
iptables -I INPUT  -s 149.202.241.0/24 -j ACCEPT
iptables -I INPUT -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|081e77da|' -m recent --name test ! --rcheck  -m recent --name test --set   -j  DROP
iptables -I INPUT -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|081e77da|'  -m recent --name test --rcheck --seconds 2  --hitcount 1     -j DROP 
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e63|'  -m recent --name limitC7777 ! --rcheck  -m recent --name limitC7777 --set -j DROP
iptables -I INPUT  -p udp --dport 7777   -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e63|' -m recent --name limitC7777 --rcheck  --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e69|'  -m recent --name limitI7777 ! --rcheck  -m recent --name limitI7777 --set 
iptables -I INPUT  -p udp --dport 7777   -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e69|' -m recent --name limitI7777 --rcheck  --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e72|'  -m recent --name limitR7777 ! --rcheck  -m recent --name limitR7777 --set -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e72|' -m recent --name limitR7777 --rcheck --seconds 2 --hitcount 1 -j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS 
iptables -A SAMP-DDOS -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS2 
iptables -A SAMP-DDOS2 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS3
iptables -A SAMP-DDOS3 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS3
iptables -A SAMP-DDOS3 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp -d 50.0.0.0 -s 177.0.0.0/8 --destination-port 7777 -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -m limit --limit 100/s -j ACCEPT
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 -s 177.0.0.0/8 --destination-port 7777 -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -m limit --limit 1/s -j ACCEPT
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -j DROP
iptables -A SAMP-DDOS -j LOG --log-prefix "IPTABLES TOTAL LOG: "
iptables -A SAMP-DDOS -j ACCEPT
netfilter-persistent save
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -N SAMP-DDOS
iptables -N SAMP-DDOS2
iptables -N SAMP-DDOS3
iptables -t mangle -A PREROUTING -p icmp -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -t mangle -A PREROUTING -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 1:7776 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7778:30000 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j RETURN
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A INPUT -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j REJECT
iptables -A INPUT -p udp --dport 1:7776 -j REJECT
iptables -A INPUT -p udp --dport 7778:30000 -j REJECT
iptables -A INPUT -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j REJECT
iptables -I INPUT  -s 66.55.155.101 -j ACCEPT
iptables -I INPUT  -s 66.55.155.0/24 -j ACCEPT
iptables -I INPUT  -s  82.192.84.116 -j ACCEPT
iptables -I INPUT  -s  82.192.84.0/24 -j ACCEPT		
iptables -t filter -A OUTPUT -p icmp -m icmp --icmp-type echo-reply -j DROP
iptables -t filter -A OUTPUT -p icmp -m icmp --icmp-type port-unreachable -j DROP
iptables -I INPUT  -s 104.28.17.92 -j ACCEPT
iptables -I INPUT  -s 104.28.17.0/24 -j ACCEPT
iptables -I INPUT  -s 162.144.7.215 -j ACCEPT
iptables -I INPUT  -s 162.144.7.0/24 -j ACCEPT
iptables -I INPUT  -s 149.202.241.189 -j ACCEPT
iptables -I INPUT  -s 149.202.241.0/24 -j ACCEPT
iptables -I INPUT -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|081e77da|' -m recent --name test ! --rcheck  -m recent --name test --set   -j  DROP
iptables -I INPUT -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|081e77da|'  -m recent --name test --rcheck --seconds 2  --hitcount 1     -j DROP 
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e63|'  -m recent --name limitC7777 ! --rcheck  -m recent --name limitC7777 --set -j DROP
iptables -I INPUT  -p udp --dport 7777   -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e63|' -m recent --name limitC7777 --rcheck  --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e69|'  -m recent --name limitI7777 ! --rcheck  -m recent --name limitI7777 --set 
iptables -I INPUT  -p udp --dport 7777   -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e69|' -m recent --name limitI7777 --rcheck  --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e72|'  -m recent --name limitR7777 ! --rcheck  -m recent --name limitR7777 --set -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e72|' -m recent --name limitR7777 --rcheck --seconds 2 --hitcount 1 -j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS 
iptables -A SAMP-DDOS -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS2 
iptables -A SAMP-DDOS2 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS3
iptables -A SAMP-DDOS3 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS3
iptables -A SAMP-DDOS3 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp -d 50.0.0.0 -s 177.0.0.0/8 --destination-port 7777 -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -m limit --limit 100/s -j ACCEPT
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 -s 177.0.0.0/8 --destination-port 7777 -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -m limit --limit 1/s -j ACCEPT
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -j DROP
iptables -A SAMP-DDOS -j LOG --log-prefix "IPTABLES TOTAL LOG: "
iptables -A SAMP-DDOS -j ACCEPT
netfilter-persistent save
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
iptables -N SAMP-DDOS
iptables -N SAMP-DDOS2
iptables -N SAMP-DDOS3
iptables -t mangle -A PREROUTING -p icmp -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -t mangle -A PREROUTING -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 1:7776 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7778:30000 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j RETURN
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A INPUT -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j REJECT
iptables -A INPUT -p udp --dport 1:7776 -j REJECT
iptables -A INPUT -p udp --dport 7778:30000 -j REJECT
iptables -A INPUT -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j REJECT
iptables -I INPUT  -s 66.55.155.101 -j ACCEPT
iptables -I INPUT  -s 66.55.155.0/24 -j ACCEPT
iptables -I INPUT  -s  82.192.84.116 -j ACCEPT
iptables -I INPUT  -s  82.192.84.0/24 -j ACCEPT		
iptables -t filter -A OUTPUT -p icmp -m icmp --icmp-type echo-reply -j DROP
iptables -t filter -A OUTPUT -p icmp -m icmp --icmp-type port-unreachable -j DROP
iptables -I INPUT  -s 104.28.17.92 -j ACCEPT
iptables -I INPUT  -s 104.28.17.0/24 -j ACCEPT
iptables -I INPUT  -s 162.144.7.215 -j ACCEPT
iptables -I INPUT  -s 162.144.7.0/24 -j ACCEPT
iptables -I INPUT  -s 149.202.241.189 -j ACCEPT
iptables -I INPUT  -s 149.202.241.0/24 -j ACCEPT
iptables -I INPUT -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|081e77da|' -m recent --name test ! --rcheck  -m recent --name test --set   -j  DROP
iptables -I INPUT -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|081e77da|'  -m recent --name test --rcheck --seconds 2  --hitcount 1     -j DROP 
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e63|'  -m recent --name limitC7777 ! --rcheck  -m recent --name limitC7777 --set -j DROP
iptables -I INPUT  -p udp --dport 7777   -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e63|' -m recent --name limitC7777 --rcheck  --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e69|'  -m recent --name limitI7777 ! --rcheck  -m recent --name limitI7777 --set 
iptables -I INPUT  -p udp --dport 7777   -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e69|' -m recent --name limitI7777 --rcheck  --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT  -p udp --dport 7777  -m  string --algo kmp   --hex-string   '|53414d50|' -m  string --algo kmp   --hex-string   '|611e72|'  -m recent --name limitR7777 ! --rcheck  -m recent --name limitR7777 --set -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e72|' -m recent --name limitR7777 --rcheck --seconds 2 --hitcount 1 -j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS 
iptables -A SAMP-DDOS -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS2 
iptables -A SAMP-DDOS2 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS3
iptables -A SAMP-DDOS3 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp --dport 7777-m ttl --ttl-eq=128-j SAMP-DDOS3
iptables -A SAMP-DDOS3 -p udp --dport 7777-m length --length 17:604-j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128-j DROP
iptables -A INPUT -p udp --dport 7777-m limit --limit 1/s --limit-burst 2-j DROP
iptables -A INPUT -p udp -d 50.0.0.0 -s 177.0.0.0/8 --destination-port 7777 -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -m limit --limit 100/s -j ACCEPT
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 -s 177.0.0.0/8 --destination-port 7777 -j DROP
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -m limit --limit 1/s -j ACCEPT
iptables -A INPUT -p udp -d 50.0.0.0 --destination-port 7777 -m string --string 'SAMP3' --algo bm -j DROP
iptables -A SAMP-DDOS -j LOG --log-prefix "IPTABLES TOTAL LOG: "
iptables -A SAMP-DDOS -j ACCEPT
netfilter-persistent save
systemctl enable netfilter-persistent
systemctl restart netfilter-persistent
iptables -L
echo "Anti Ddos Setup Done"