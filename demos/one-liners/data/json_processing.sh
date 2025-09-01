#!/bin/bash
# One-liner: JSON-like data processing with objects
# Usage: ./json_processing.sh
# Features: v1.27.7+ object literals

echo "JSON-like data processing with Ruchy objects..."
echo

echo "Create user object:"
ruchy -e 'let user = { name: "Alice", id: 123, active: true }; println(f"User: {user}")'

echo "Extract user fields:"
ruchy -e 'let user = { name: "Bob", age: 25, city: "NYC" }; println(f"Name: {user.name}, Age: {user.age}, City: {user.city}")'

echo "Nested configuration:"
ruchy -e 'let config = { api: { host: "localhost", port: 3000 }, debug: true }; println(f"API endpoint: {config.api.host}:{config.api.port}")'

echo "Array of objects:"
ruchy -e 'let users = [{ name: "Alice", score: 95 }, { name: "Bob", score: 87 }]; println(f"User 1: {users[0].name} scored {users[0].score}")'

echo "Object transformation:"
ruchy -e 'let product = { name: "Widget", price: 29.99, category: "tools" }; println(f"Product: {product.name} in {product.category} costs ${product.price}")'