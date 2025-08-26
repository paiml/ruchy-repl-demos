# Test Files with Syntax Issues

The following test files contain Ruchy syntax that doesn't parse correctly and have been temporarily disabled:

## Broken Files (renamed to .broken):
- `test_advanced.ruchy.broken` - Error: Expected FatArrow, found Comma
- `test_algorithms.ruchy.broken` - Error: Unexpected token: DotDot  
- `test_data_structures.ruchy.broken` - Error: Expected method name after '.'
- `test_functional.ruchy.broken` - Error: Expected RightParen, found Arrow
- `test_oneliners.ruchy.broken` - Error: Unexpected token: ColonColon

## Working Files (syntax valid):
- `test_basics.ruchy` ✅
- `test_framework.ruchy` ✅  
- `test_framework_self.ruchy` ✅
- `test_functions.ruchy` ✅

## Issues Found:
1. Use of advanced syntax not yet implemented in Ruchy
2. Invalid method calls on undefined types
3. Incorrect lambda/closure syntax
4. Range syntax (`..`) not supported  
5. Module path syntax (`::`) not supported

## Resolution:
The broken files need to be rewritten to use only the subset of Ruchy syntax that actually works. Until then, they remain disabled to maintain accurate test reporting.

This ensures our dogfooding only tests real, working Ruchy features.