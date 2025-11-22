import 'dart:io';

// This program demonstrates basic input/output, a 'for' loop, and a 'while' loop in Dart.

void main() {
  // --- 1. Basic Input and Output (I/O) ---
  print('--- 1. Basic I/O Demonstration ---');

  // Output: Printing a simple message to the console.
  stdout.write('Please enter your name: ');

  // Input: Reading a line of text from the console.
  // The 'readLineSync()' function is used for synchronous input.
  // The '?' after String means the result can be null, so we use '?? ""' to handle it safely.
  String? inputName = stdin.readLineSync();
  String userName = inputName ?? "Guest";

  print('Hello, $userName! We will now run some loops.');

  // --- 2. The 'for' Loop (Fixed Iteration) ---
  print('\n--- 2. The \'for\' Loop: Counting Up ---');

  // A standard 'for' loop iterates a fixed number of times (from 1 to 5).
  for (int i = 1; i <= 5; i++) {
    print('For Loop Count: $i');
  }

  // --- 3. The 'while' Loop (Conditional Iteration) ---
  print('\n--- 3. The \'while\' Loop: Doubling a Number ---');

  int multiplier = 2;
  int limit = 32;

  // A 'while' loop continues as long as a specified condition is true.
  while (multiplier <= limit) {
    print('Multiplier value: $multiplier');
    multiplier = multiplier * 2; // Double the value for the next iteration
  }

  print('\nLoop finished. The multiplier exceeded $limit.');

  // --- 4. Loop with Input (Practical Example) ---
  print('\n--- 4. Practical Loop: Calculating Factorial ---');

  stdout.write('Enter a small integer (e.g., 5) to calculate its factorial: ');
  String? numberInput = stdin.readLineSync();
  int number = int.tryParse(numberInput ?? '0') ?? 0;
  
  if (number < 0) {
    print('Factorial is not defined for negative numbers.');
  } else {
    int factorialResult = 1;
    // Use a 'for' loop to calculate the factorial (n!)
    for (int i = 1; i <= number; i++) {
      factorialResult *= i;
    }
    print('The factorial of $number is $factorialResult.');
  }
}
