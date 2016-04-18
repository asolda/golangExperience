/* Commento di prova */

package main

// commento alla funzione
func main() {
	i := 0
	a := 0

	for i < 100 {
		a += i
	}

	if a < 100 {
		a = 0xFF
	} else {
		a *= 20
	}
}
