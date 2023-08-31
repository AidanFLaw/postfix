package main

import (
	"fmt"
	"log"
	"net/smtp"
	"os"
)

func main() {
	if len(os.Args) != 4 {
		fmt.Println("Usage: smtp-tester <server> <from> <to>")
		return
	}

	server := os.Args[1]
	from := os.Args[2]
	to := os.Args[3]

	message := []byte("To: " + to + "\r\n" +
		"Subject: SMTP Tester\r\n" +
		"\r\n" +
		"This is a test email from the SMTP tester.\r\n")

	auth := smtp.PlainAuth("", "", "", server)

	err := smtp.SendMail(server+":587", auth, from, []string{to}, message)
	if err != nil {
		log.Fatal("Error sending email:", err)
	} else {
		fmt.Println("Email sent successfully!")
	}
}
