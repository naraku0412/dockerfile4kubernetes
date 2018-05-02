0 setup file server
===
	file server is in the directory named file-server
	build the image:
```console
docker build -t file-server .
```
1 run the image
===
	Notes:
1. using host network
2. maping the directory holding files to the /mnt directory of docker 
```console
docker run -d --network host -v your-software-dir:/mnt --name file-server file-server /file-server -p=working-port
```
2 change the info of the file server
===
	change the info of file server in Dockerfiles
	one can use the change-file-server.sh script to implement:
```console
./change-file-server.sh http://x.x.x.x:y
```
