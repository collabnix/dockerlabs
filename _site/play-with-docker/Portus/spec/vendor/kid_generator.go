package main

import (
	"fmt"
	"github.com/docker/libtrust"
	"os"
)

func main() {
	if len(os.Args) != 2 {
		fmt.Fprintf(os.Stderr, "Usage: kid_generator <public_key>\n")
		os.Exit(1)
	}
	fmt.Println(os.Args)

	public_key, err := libtrust.LoadPublicKeyFile(os.Args[1])

	if err != nil {
		fmt.Fprintf(os.Stderr, "Something went wrong while reading %s: %v\n", os.Args[1], err)
		os.Exit(1)
	}

	fmt.Println("The KeyID of Public Key is:", public_key.KeyID())
}
