#!/bin/sh
set -eu

# Convert all shell scripts to POSIX sh
find demos/one-liners -name "*.sh" | while read -r file; do
    printf "Converting %s to POSIX sh...\n" "$file"
    
    # Replace shebang
    sed -i '1s|^#!/bin/bash|#!/bin/sh|' "$file"
    
    # Add strict mode after shebang if not present
    if ! grep -q "^set -eu" "$file"; then
        sed -i '2i\
set -eu' "$file"
    fi
done

printf "Conversion complete\n"