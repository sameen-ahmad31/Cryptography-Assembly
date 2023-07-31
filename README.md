# Cryptography in LC3 Assembly
I developed an encryption and decryption program following a structured approach. The process began with creating a flowchart to serve as a roadmap. The program was written in LC3 assembly, starting at memory address x3000. The program began by initializing and storing prompt messages as strings, displaying "STARTING PRIVACY MODULE" to the user. The user was then prompted to input "E" for encryption, "D" for decryption, or "X" to erase the encrypted data at x4000 and fill it with zeros. Upon receiving valid input, the program executed the corresponding function. If an invalid input was entered, the user was asked to provide a new input.

For encryption, the program requested the user to enter a key and checked its validity. If any character in the key was 0, the corresponding algorithm was skipped and that part remained unencrypted. The encryption process involved three steps:
<br>
1. Vigenere: Each character in the message was XORed with the corresponding character in the key and stored back at the same memory address.
<br>
2. Caesar: The result from the Vigenere step (if performed) was added to the last three digits of the key. The sum was then MODed with 128, and the result was stored at the same memory location.
<br>
3. Bitshift: The message was left-shifted by the first character of the key, providing an additional layer of encryption. After encryption, the key was cleared for security reasons.
<br>
The program then returned to step 1 (main) and awaited the next user input.

For decryption, the process was the reverse of encryption:
<br>
1. Bitshift (right): The encrypted message was right-shifted by the first character of the key.
<br>
2. Caesar: The result from the Bitshift step (if performed) was subtracted by the last three digits of the key. The result was then MODed with 128.
<br>
3. Vigenere: The message was XORed with the second character of the key, resulting in the decrypted message. The decrypted message was stored at x5000, while the encrypted message at x4000 remained unchanged.
<br>
The program concluded by returning to step 1 (main) and prompting the user for the next input. If the user typed "X," the encrypted message was erased and filled with zeros before halting the program. The program underwent rigorous testing to ensure accurate encryption and decryption functionality.
