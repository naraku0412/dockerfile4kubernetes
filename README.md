0 setup file server
===
	file server is in the directory named file-server
	build the image:
```console
docker build -t file-server .
```
1 run the image
===
```console
docker run -d --network host -v your-software-dir:/mnt file-server /file-server -p=working-port
```
2 change the info of the file server
===
	change the info of file server in Dockerfiles
	one can use the change-file-server.sh script to implement:
```console
./change-file-server.sh http://x.x.x.x:y
```
