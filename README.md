0 setup ftp server
===
	ftp server is in the directory named ftp-server
	build the image, and use the following command to start
```console
docker run -d --network host -v your-software-dir:/mnt ftp-server /ftp-server -p=working-port
```
1 change the ftp info
===
	change the info of ftp server in the Dockerfiles
	can use the change-ftp-server.sh script to implement
