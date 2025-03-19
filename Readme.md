Error handling 

assert is equal require in solidity 
assert(condition, 'error message');           // Basic assertion
assert!(condition, "formatted error: {}", x); // Formatted string error

Using Panic similar to revert in solidity
panic_with_felt252('error message');        // Basic panic
panic!("formatted error: value={}", value);    // Formatted string error

#[starknet::interface]
trait IContract<TContractState> {
    /// High-level description of the function
    ///
    /// # Arguments
    ///
    /// * `arg_1` - Description of the argument
    /// * `arg_n` - ...
    ///
    /// # Returns
    ///
    /// High-level description of the return value
    fn do_something(ref self: TContractState, arg_1: T_arg_1) -> T_return;
}

public_key 0x04a28066ec5b04e035091d7ff1f457f1d83a84532c9b405ff7159d0bdf0fde8c


0x02e9a1590931865ead75b76baefd2167e6749af5333d911597d46ef63441c525

todeploy 
Firstly, you need to declare your contract which will create a class on Starknet Sepolia. Note that we will use the Sierra program in ./target/ProjectName_ContractName.contract_class.json in your Scarb folder.

starkli declare \
  --keystore /path/to/starkli-wallet/keystore.json \
  --account /path/to/starkli-wallet/account.json \
  --watch ./target/dev/simple_storage_SimpleStorage.contract_class.json


starkli declare \
  --keystore /path/to/starkli-wallet/keystore.json \
  --account /path/to/starkli-wallet/account.json \
  --watch ./target/dev/mapping_MapContractImpl.contract_class.json