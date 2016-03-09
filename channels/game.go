package main

import "fmt"

func main() {
	messages := make(chan string, 1)
	barrier := make(chan bool, 1)
	go ping(messages, barrier)
	<-barrier
	go pong(messages, barrier)
	<-barrier
	fmt.Println("Message after ping-pong: " + <-messages)
	go peng(messages, barrier)
	<-barrier
	go pong(messages, barrier)
	<-barrier
	fmt.Println("Message after peng-pong: " + <-messages)
}

func ping(channel chan string, barrier chan bool) {
	channel <- "ping"
	barrier <- true
}

func pong(channel chan string, barrier chan bool) {
	recv := <-channel
	if recv == "ping" {
		channel <- "pong"
	} else {
		channel <- "There's no pong without a ping..."
	}
	barrier <- true
}

func peng(channel chan string, barrier chan bool) {
	channel <- "peng"
	barrier <- true
}
