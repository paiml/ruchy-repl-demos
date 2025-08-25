# Ruchy Version Migration Guide

## Overview

This guide helps you migrate demos between different Ruchy versions and handle compatibility issues.

## Version Compatibility Table

| From Version | To Version | Breaking Changes | Migration Effort |
|--------------|------------|------------------|------------------|
| 1.9.1 | 1.10.0 | Generic syntax | Low |
| 1.10.0 | 1.11.0 | Async/await | Low |
| 1.9.1 | 1.11.0 | Multiple features | Medium |

## Migration Steps

### From 1.9.1 to 1.10.0

#### New Features Available
- **Generics**: Type parameters in functions
- **Enhanced Pattern Matching**: Guards and ranges
- **Improved Collections**: New methods on iterators

#### Code Changes Required

**Before (1.9.1):**
```rust
fn identity(x: i32) -> i32 { x }
```

**After (1.10.0):**
```rust
fn identity<T>(x: T) -> T { x }
```

#### Demo Compatibility
- All basic demos remain compatible
- Advanced demos can use new features
- No breaking changes to existing syntax

### From 1.10.0 to 1.11.0

#### New Features Available
- **Async/Await**: Asynchronous programming
- **Improved Error Handling**: Result type enhancements
- **Macro System**: Custom macros

#### Code Changes Required

**Before (1.10.0):**
```rust
fn fetch_data() -> String {
    // Synchronous operation
    "data"
}
```

**After (1.11.0):**
```rust
async fn fetch_data() -> String {
    // Asynchronous operation
    "data"
}
```

#### Demo Compatibility
- All 1.10.0 demos work in 1.11.0
- New async demos require 1.11.0+
- Macro demos require 1.11.0+

## Version Detection Script

```sh
#!/bin/sh
# detect_version.sh

get_ruchy_version() {
    if ! command -v ruchy >/dev/null 2>&1; then
        echo "0.0.0"
        return 1
    fi
    
    ruchy --version | sed 's/ruchy //'
}

check_version_gte() {
    current="$1"
    required="$2"
    
    current_major=$(echo "$current" | cut -d. -f1)
    current_minor=$(echo "$current" | cut -d. -f2)
    required_major=$(echo "$required" | cut -d. -f1)
    required_minor=$(echo "$required" | cut -d. -f2)
    
    if [ "$current_major" -gt "$required_major" ]; then
        return 0
    elif [ "$current_major" -eq "$required_major" ] && [ "$current_minor" -ge "$required_minor" ]; then
        return 0
    else
        return 1
    fi
}

VERSION=$(get_ruchy_version)
echo "Detected Ruchy version: $VERSION"

if check_version_gte "$VERSION" "1.11.0"; then
    echo "Full feature set available"
elif check_version_gte "$VERSION" "1.10.0"; then
    echo "Most features available (no async)"
elif check_version_gte "$VERSION" "1.9.1"; then
    echo "Basic features available"
else
    echo "Version too old or not installed"
fi
```

## Feature Flags by Version

### Version 1.9.1
```yaml
features:
  - basic_arithmetic
  - variables
  - functions
  - arrays
  - strings
  - closures
  - basic_pattern_matching
```

### Version 1.10.0
```yaml
features:
  - all_from_1.9.1
  - generics
  - enhanced_pattern_matching
  - iterator_methods
  - type_inference_improvements
```

### Version 1.11.0
```yaml
features:
  - all_from_1.10.0
  - async_await
  - macros
  - enhanced_error_handling
  - performance_improvements
```

## Demo Categories by Version

### Minimum Version Requirements

| Demo Category | Min Version | Reason |
|---------------|-------------|--------|
| 01-basics | 1.9.1 | Core features |
| 02-functions | 1.9.1 | Basic functions |
| 03-data-structures | 1.9.1 | Collections |
| 04-algorithms | 1.9.1 | Basic algorithms |
| 05-functional | 1.10.0 | Advanced iterators |
| 06-advanced | 1.11.0 | Async, macros |

## Common Migration Issues

### Issue 1: Method Not Found
**Symptom**: `Method fold not supported on this type`
**Solution**: Use alternative methods or upgrade to 1.10.0+

### Issue 2: Syntax Error
**Symptom**: `Failed to parse input`
**Solution**: Check version-specific syntax differences

### Issue 3: Missing Feature
**Symptom**: Feature not available in older version
**Solution**: Use compatibility shim or upgrade

## Compatibility Shims

### For 1.9.1 Compatibility
```rust
// Instead of fold (1.10.0+)
fn sum_array(arr: &[i32]) -> i32 {
    let mut sum = 0;
    for &x in arr {
        sum += x;
    }
    sum
}

// Instead of generics (1.10.0+)
fn identity_i32(x: i32) -> i32 { x }
fn identity_str(x: &str) -> &str { x }
```

### For 1.10.0 Compatibility
```rust
// Instead of async/await (1.11.0+)
fn fetch_sync() -> String {
    // Synchronous version
    "data".to_string()
}

// Instead of macros (1.11.0+)
fn repeat_code() {
    // Manual repetition
    println!("1");
    println!("2");
    println!("3");
}
```

## Testing Across Versions

### Automated Testing
```sh
#!/bin/sh
# test_compatibility.sh

for version in "1.9.1" "1.10.0" "1.11.0"; do
    echo "Testing with Ruchy $version"
    
    # Use Docker or version manager to test
    docker run -v "$(pwd):/demos" ruchy:$version \
        make test
done
```

### Manual Testing Checklist
- [ ] Test basic demos on 1.9.1
- [ ] Test functional demos on 1.10.0
- [ ] Test advanced demos on 1.11.0
- [ ] Verify error messages are helpful
- [ ] Check performance across versions

## Best Practices

1. **Version Detection**: Always detect version at runtime
2. **Graceful Degradation**: Provide fallbacks for older versions
3. **Clear Documentation**: Mark version requirements clearly
4. **Progressive Enhancement**: Use new features when available
5. **Testing**: Test on minimum supported version

## Resources

- [Ruchy Changelog](https://github.com/paiml/ruchy/CHANGELOG.md)
- [Feature Compatibility Matrix](../INTEGRATION_REPORT.md)
- [Demo Requirements](../README.md#requirements)

## Support Matrix

| Ruchy Version | Support Status | EOL Date |
|---------------|----------------|----------|
| 1.9.x | Active | TBD |
| 1.10.x | Active | TBD |
| 1.11.x | Active | TBD |
| < 1.9.0 | Unsupported | Past |

---

**Last Updated**: Sprint S01
**Next Review**: Sprint S03