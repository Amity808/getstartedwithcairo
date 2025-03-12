// you can define error messages in a dedicated module:

mod Errors {
    pub const NOT_POSITIVE: felt252 = 'must be greater than 0';
    // pub const GREATER_TEN: ByteArray = "i must be greater than {}";
    pub const NOT_NULL: felt252 = 'must not be null';
}



#[starknet::interface]
pub trait IErrors<TContractState> {
    // fn test_assert(ref self: TContractState, amount: felt252);
    fn test_assert(self: @TContractState, i: u256);
    fn test_panic(self: @TContractState, i: u256);
}

// assert is equal require in solidity 
// assert(condition, 'error message');           // Basic assertion
// assert!(condition, "formatted error: {}", x); // Formatted string error

// Using Panic similar to revert in solidity
// panic_with_felt252('error message');        // Basic panic
// panic!("formatted error: value={}", value);    // Formatted string error
#[starknet::contract]
mod ErrorContract {
    use super::{IErrors, Errors};

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl ErrorsContract of IErrors<ContractState> {
        fn test_assert(self: @ContractState, i: u256) {
            assert(i > 0, Errors::NOT_POSITIVE);
            // let x = 10;
            // assert!(i > x, "i must be greater than {}", x);
        }

        //using panic used to abort execution directly 
        fn test_panic(self: @ContractState, i: u256) {
            if (i == 0) {
                core::panic_with_felt252(Errors::NOT_NULL);
            }
            
        }
    }
}
