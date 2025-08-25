#!/bin/sh
set -eu

# Fix common Ruchy syntax issues in demo files

printf "Fixing Ruchy syntax in demo files...\n"

# Fix palindrome check
cat > demos/one-liners/text-processing/palindrome_check.sh << 'EOF'
#!/bin/sh
set -eu
# Check if a string is a palindrome

printf "Checking if 'racecar' is a palindrome: "
ruchy -e '"racecar".reverse() == "racecar"'
EOF

# Fix reverse string
cat > demos/one-liners/text-processing/reverse_string.sh << 'EOF'
#!/bin/sh
set -eu
# Reverse a string

printf "Reversing 'hello world': "
ruchy -e 'print("hello world".reverse())'
EOF

# Fix count words
cat > demos/one-liners/text-processing/count_words.sh << 'EOF'
#!/bin/sh
set -eu
# Count words in a string

printf "Word count in 'the quick brown fox': "
ruchy -e '"the quick brown fox".split(" ").len()'
EOF

# Fix replace text
cat > demos/one-liners/text-processing/replace_text.sh << 'EOF'
#!/bin/sh
set -eu
# Replace text in a string

printf "Replace 'world' with 'Ruchy' in 'hello world': "
ruchy -e 'print("hello world".replace("world", "Ruchy"))'
EOF

# Fix uppercase
cat > demos/one-liners/text-processing/uppercase.sh << 'EOF'
#!/bin/sh
set -eu
# Convert string to uppercase

printf "Uppercase 'hello ruchy': "
ruchy -e 'print("hello ruchy".to_uppercase())'
EOF

printf "Fixed text-processing demos\n"

# Fix math calculations
cat > demos/one-liners/math-calculations/factorial.sh << 'EOF'
#!/bin/sh
set -eu
# Calculate factorial

printf "Factorial of 5: "
ruchy -e '(1..6).fold(1, |a, b| a * b)'
EOF

cat > demos/one-liners/math-calculations/fibonacci.sh << 'EOF'
#!/bin/sh
set -eu
# Calculate Fibonacci number

printf "10th Fibonacci number: "
ruchy -e 'let mut a = 0; let mut b = 1; for _ in 0..10 { let t = a + b; a = b; b = t; } a'
EOF

cat > demos/one-liners/math-calculations/prime_check.sh << 'EOF'
#!/bin/sh
set -eu
# Check if a number is prime

printf "Is 17 prime? "
ruchy -e 'let n = 17; n > 1 && !(2..n).any(|i| n % i == 0)'
EOF

cat > demos/one-liners/math-calculations/sum_squares.sh << 'EOF'
#!/bin/sh
set -eu
# Sum of squares

printf "Sum of squares 1-5: "
ruchy -e '(1..6).map(|x| x * x).sum()'
EOF

cat > demos/one-liners/math-calculations/gcd.sh << 'EOF'
#!/bin/sh
set -eu
# Calculate GCD

printf "GCD of 48 and 18: "
ruchy -e 'let mut a = 48; let mut b = 18; while b != 0 { let t = b; b = a % b; a = t; } a'
EOF

printf "Fixed math-calculations demos\n"

# Make all scripts executable
find demos/one-liners -name "*.sh" -exec chmod +x {} \;

printf "All fixes applied\n"