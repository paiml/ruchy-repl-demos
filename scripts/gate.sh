#!/bin/sh
# gate.sh — the measurement behind the `gate` status check (.github/workflows/gate.yml).
#
# The paiml org ruleset "Green Main" requires exactly one status context, `gate`.
# This repo emitted no such check, so every pull request sat at
# mergeStateStatus=BLOCKED with nothing failing and nothing a contributor could
# fix. This script is what makes `gate` mean something rather than being an
# `exit 0` that satisfies the ruleset and measures nothing.
#
# It is hermetic: it needs only the checkout, git, /bin/sh and /bin/bash. No
# network, no toolchain install, no Python.
#
# Every check prints its DENOMINATOR, and a denominator of zero is a FAILURE — a
# check that silently inspected nothing must never read as a pass.
#
# Run it locally with:  sh scripts/gate.sh

set -u

RC=0
CHECKS_RUN=0
CHECKS_FAILED=0

section() {
    CHECKS_RUN=$((CHECKS_RUN + 1))
    printf '\n=== [%s] %s ===\n' "$CHECKS_RUN" "$1"
}

pass() { printf 'PASS: %s\n' "$1"; }

fail() {
    printf 'FAIL: %s\n' "$1"
    CHECKS_FAILED=$((CHECKS_FAILED + 1))
    RC=1
}

# Tracked files only, so the gate measures the repository and not a dirty
# worktree. The loops below read this newline-delimited, which would silently
# lose a path containing a newline; count_tracked() counts the same pathspec
# NUL-delimited so the two can be compared and a mismatch failed loudly.
tracked() { git ls-files "$@"; }
count_tracked() { git ls-files -z "$@" | tr -dc '\0' | wc -c | tr -d ' '; }

# ---------------------------------------------------------------------------
# 1. Repository skeleton — the paths the Makefile, the book and the workflows
#    all assume exist.
# ---------------------------------------------------------------------------
section 'repository skeleton'
REQUIRED='README.md CONTRIBUTING.md CHANGELOG.md ROADMAP.md LICENSE CLAUDE.md
Makefile book.toml book/src/SUMMARY.md demos/repl demos/one-liners scripts tests'
n=0
bad=0
for p in $REQUIRED; do
    n=$((n + 1))
    if [ ! -e "$p" ]; then
        printf '  missing: %s\n' "$p"
        bad=$((bad + 1))
    fi
done
printf '  checked %s required path(s), %s missing\n' "$n" "$bad"
if [ "$n" -eq 0 ]; then
    fail 'repository skeleton: denominator is zero — the required-path list is empty'
elif [ "$bad" -gt 0 ]; then
    fail "repository skeleton: $bad of $n required path(s) missing"
else
    pass "repository skeleton: $n of $n required path(s) present"
fi

# ---------------------------------------------------------------------------
# 2. Shell sources parse. Every *.sh must carry a shebang and must parse under
#    the interpreter that shebang names — this repo is 138 POSIX sh scripts plus
#    a handful of bash, so checking them all with a single parser is wrong in
#    both directions (bash arrays fail under dash; dash-isms pass under bash).
# ---------------------------------------------------------------------------
section 'shell scripts parse'
expected=$(count_tracked '*.sh')
n=0
bad=0
noshebang=0
while IFS= read -r f; do
    [ -n "$f" ] || continue
    n=$((n + 1))
    first=$(head -n 1 "$f")
    case "$first" in
        '#!'*) ;;
        *)
            printf '  no shebang: %s\n' "$f"
            noshebang=$((noshebang + 1))
            bad=$((bad + 1))
            continue
            ;;
    esac
    case "$first" in
        *bash*) parser=bash ;;
        *) parser=sh ;;
    esac
    if ! err=$("$parser" -n "$f" 2>&1); then
        printf '  syntax error (%s -n): %s\n' "$parser" "$f"
        printf '%s\n' "$err" | sed 's/^/      /'
        bad=$((bad + 1))
    fi
done <<EOF
$(tracked '*.sh')
EOF
printf '  checked %s of %s tracked shell script(s), %s failed (%s without a shebang)\n' \
    "$n" "$expected" "$bad" "$noshebang"
if [ "$n" -eq 0 ]; then
    fail 'shell scripts parse: denominator is zero — no *.sh tracked, so nothing was parsed'
elif [ "$n" -ne "$expected" ]; then
    fail "shell scripts parse: iterated $n paths but git tracks $expected — a path was lost, refusing to pass"
elif [ "$bad" -gt 0 ]; then
    fail "shell scripts parse: $bad of $n script(s) do not parse"
else
    pass "shell scripts parse: $n of $n script(s) parse"
fi

# ---------------------------------------------------------------------------
# 3. Every `make <target>` a workflow invokes exists in the Makefile. A renamed
#    or deleted target is a workflow that dies at run time. The extraction is
#    anchored to command position, so prose such as "Run 'make fix-links'" in an
#    echo is not mistaken for an invocation.
# ---------------------------------------------------------------------------
section 'make targets invoked by workflows exist'
TARGETS=$(grep -ohE '(^[[:space:]]*|run:[[:space:]]*|&&[[:space:]]*|\|\|[[:space:]]*|[;|(][[:space:]]*)make[[:space:]]+[a-zA-Z][a-zA-Z0-9_.-]*' \
    .github/workflows/*.yml 2>/dev/null | sed -E 's/.*make[[:space:]]+//' | sort -u)
n=0
bad=0
for t in $TARGETS; do
    n=$((n + 1))
    if ! grep -qE "^$t:" Makefile; then
        printf '  workflow invokes "make %s", absent from Makefile\n' "$t"
        bad=$((bad + 1))
    fi
done
printf '  checked %s make target(s) invoked by workflows, %s absent\n' "$n" "$bad"
if [ "$n" -eq 0 ]; then
    fail 'make targets: denominator is zero — no "make <target>" found in any workflow'
elif [ "$bad" -gt 0 ]; then
    fail "make targets: $bad of $n invoked target(s) do not exist"
else
    pass "make targets: $n of $n invoked target(s) exist"
fi

# ---------------------------------------------------------------------------
# 4. Every script path the Makefiles and the workflows reference actually
#    exists.
# ---------------------------------------------------------------------------
section 'referenced script paths exist'
PATHS=$(grep -ohE '(\./)?[A-Za-z0-9_./-]*scripts/[A-Za-z0-9_.-]+\.(sh|ts)' \
    Makefile Makefile.book .github/workflows/*.yml 2>/dev/null | sed 's|^\./||' | sort -u)
n=0
bad=0
for p in $PATHS; do
    n=$((n + 1))
    if [ ! -f "$p" ]; then
        printf '  referenced but missing: %s\n' "$p"
        bad=$((bad + 1))
    fi
done
printf '  checked %s referenced script path(s), %s missing\n' "$n" "$bad"
if [ "$n" -eq 0 ]; then
    fail 'referenced scripts: denominator is zero — no scripts/*.sh reference found'
elif [ "$bad" -gt 0 ]; then
    fail "referenced scripts: $bad of $n referenced path(s) missing"
else
    pass "referenced scripts: $n of $n referenced path(s) exist"
fi

# ---------------------------------------------------------------------------
# 5. The book's table of contents resolves. book.toml sets
#    `create-missing = false`, so a SUMMARY.md entry with no file behind it is a
#    hard mdbook build failure — which today is only discovered on a push to
#    main, by the Pages deploy, after the merge.
# ---------------------------------------------------------------------------
section 'book chapter links resolve'
n=0
bad=0
for t in $(sed -n 's/.*](\([^)]*\.md\)).*/\1/p' book/src/SUMMARY.md 2>/dev/null); do
    case "$t" in
        http://* | https://*) continue ;;
    esac
    n=$((n + 1))
    if [ ! -f "book/src/$t" ]; then
        printf '  SUMMARY.md entry with no file behind it: %s\n' "$t"
        bad=$((bad + 1))
    fi
done
printf '  checked %s book chapter link(s), %s unresolved\n' "$n" "$bad"
if [ "$n" -eq 0 ]; then
    fail 'book chapter links: denominator is zero — no link parsed out of book/src/SUMMARY.md'
elif [ "$bad" -gt 0 ]; then
    fail "book chapter links: $bad of $n link(s) do not resolve"
else
    pass "book chapter links: $n of $n link(s) resolve"
fi

# ---------------------------------------------------------------------------
# 6. The demo corpus is present and no demo file is empty. This repo IS its
#    demos; an empty one is a demo that silently teaches nothing.
# ---------------------------------------------------------------------------
section 'demo corpus is present and non-empty'
repl=$(count_tracked 'demos/repl/*.repl')
one=$(count_tracked 'demos/one-liners/*.sh')
expected=$((repl + one))
n=0
bad=0
while IFS= read -r f; do
    [ -n "$f" ] || continue
    n=$((n + 1))
    if [ ! -s "$f" ]; then
        printf '  empty demo file: %s\n' "$f"
        bad=$((bad + 1))
    fi
done <<EOF
$(tracked 'demos/repl/*.repl' 'demos/one-liners/*.sh')
EOF
printf '  checked %s of %s tracked demo file(s) (%s .repl, %s one-liner .sh), %s empty\n' \
    "$n" "$expected" "$repl" "$one" "$bad"
if [ "$repl" -eq 0 ] || [ "$one" -eq 0 ]; then
    fail "demo corpus: denominator is zero for a demo kind (.repl=$repl, one-liner .sh=$one)"
elif [ "$n" -ne "$expected" ]; then
    fail "demo corpus: iterated $n paths but git tracks $expected — a path was lost, refusing to pass"
elif [ "$bad" -gt 0 ]; then
    fail "demo corpus: $bad of $n demo file(s) are empty"
else
    pass "demo corpus: $n of $n demo file(s) present and non-empty"
fi

# ---------------------------------------------------------------------------
printf '\n=== gate summary ===\n'
printf '%s check(s) RAN, %s FAILED\n' "$CHECKS_RUN" "$CHECKS_FAILED"
if [ "$CHECKS_RUN" -eq 0 ]; then
    printf 'FAIL: no check ran at all\n'
    exit 1
fi
exit "$RC"
