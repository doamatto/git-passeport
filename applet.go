package main

import (
	"encoding/json"
	"log"
	"os"
)

type UserData struct {
	Users []struct{
		Name string `json:"name"`
		Keys []string `json:"keys"`
		Repos []string `json:"repos"`
	} `json:"users"`
}

func main() {
	// Fetch user
	user := os.Getenv("USER")

	// Read user data from JSON
	var userData UserData
	data, err := os.ReadFile("data.json")
	if err != nil {
		log.Panic(err)
	}
	err = json.Unmarshal(data, &userData)
	if err != nil {
		log.Panic(err)
	}

	// Confirm connecting user has access.
	repo := os.Getenv("REPO")
	repos := getUserRepos(user, userData)
	for _, r0 := range repos {
		if r0 == repo {
			os.Exit(0)
		}
	}
	// Exit with non-zero if no access.
	os.Exit(1)
}

func getUserRepos(user string, u0 UserData) []string {
	for _, u1 := range u0.Users {
		if user == u1.Name {
			return u1.Repos
		}
	}
	os.Exit(2)
	return make([]string, 0)
}

