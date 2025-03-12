Error handling 

assert is equal require in solidity 
assert(condition, 'error message');           // Basic assertion
assert!(condition, "formatted error: {}", x); // Formatted string error

Using Panic similar to revert in solidity
panic_with_felt252('error message');        // Basic panic
panic!("formatted error: value={}", value);    // Formatted string error

