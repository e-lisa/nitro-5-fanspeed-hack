all:
	git submodule init
	git submodule update
	cp Acer-Nitro-5-AN515-58-EC-Control-Linux/nitrosense /usr/local/bin
	chmod a+x /usr/local/bin/nitrosense
	cp fans.sh /usr/local/bin
	chmod a+x /usr/local/bin/fans.sh
	cp nitro5-fan-speed-hack.service /etc/systemd/system
	systemctl daemon-reload
	systemctl enable nitro5-fan-speed-hack.service
	systemctl start nitro5-fan-speed-hack.service

uninstall:
	rm /etc/system/systemd/nitro5-fan-speed-hack.service
	rm /usr/local/bin/fans.sh
	rm /usr/local/bin/nitrosense
