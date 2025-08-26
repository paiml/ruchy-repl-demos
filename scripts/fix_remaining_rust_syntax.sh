#!/bin/sh
set -eu

echo "Fixing remaining Rust syntax in REPL demos..."

# List of files that still have Rust syntax
files="
demos/repl/02-functions/demo_06_partial_application.repl
demos/repl/02-functions/demo_07_variadic.repl
demos/repl/04-algorithms/demo_03_binary_search.repl
demos/repl/04-algorithms/demo_05_dynamic_programming.repl
demos/repl/04-algorithms/demo_08_knapsack.repl
demos/repl/05-functional/demo_07_currying.repl
demos/repl/05-functional/demo_08_higher_order.repl
demos/repl/05-functional/demo_09_monads.repl
demos/repl/05-functional/demo_10_lazy_evaluation.repl
demos/repl/05-functional/demo_12_applicative.repl
demos/repl/06-advanced/demo_01_pattern_matching.repl
demos/repl/06-advanced/demo_02_generics.repl
demos/repl/06-advanced/demo_03_traits.repl
demos/repl/06-advanced/demo_04_error_handling.repl
demos/repl/06-advanced/demo_08_lifetimes.repl
demos/repl/06-advanced/demo_16_try_trait.repl
"

for file in $files; do
    if [ -f "$file" ]; then
        echo "Fixing: $file"
        tmp_file="${file}.tmp"
        
        # More aggressive fixes
        sed \
            -e 's/: &\[[^]]*\]//' \
            -e 's/: &\[&str\]//' \
            -e 's/: &str//' \
            -e 's/: &[a-zA-Z][a-zA-Z0-9_]*//' \
            -e 's/&\[\([^]]*\)\]/[\1]/g' \
            -e 's/&str/str/g' \
            -e 's/\bfn\b/fun/g' \
            -e 's/impl //' \
            -e 's/struct //' \
            -e 's/enum //' \
            -e 's/trait //' \
            -e 's/->.*i32//' \
            -e 's/->.*i64//' \
            -e 's/->.*f32//' \
            -e 's/->.*f64//' \
            -e 's/->.*bool//' \
            -e 's/->.*str//' \
            -e 's/->.*usize//' \
            "$file" > "$tmp_file"
        
        mv "$tmp_file" "$file"
    else
        echo "Warning: File not found: $file"
    fi
done

echo "Fixes complete!"