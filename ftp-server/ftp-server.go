package main

import (
    "fmt"
    "net/http"
    "flag"
)

var portFlag = flag.Int("p",2121,"working port")
var dirFlag = flag.String("d","/mnt","working directory")

func main() {
    flag.Parse()
    dir := *dirFlag + "/"
    port := fmt.Sprintf(":%d",*portFlag)
    http.Handle("/", http.FileServer(http.Dir(dir)))
    http.ListenAndServe(port, nil)
}
