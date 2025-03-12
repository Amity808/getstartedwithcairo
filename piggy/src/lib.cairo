// define the interface they are like abstract in solidity
#[starknet::interface]
pub trait IPiggy<TContractState> {
    fn deposit(ref self: TContractState, amount: u256);
    fn withdraw(ref self: TContractState, amount: u256);
    fn getBalance(self: @TContractState) -> u256;
}
// my custom error from the error mod file i created in the src importing
mod error;

#[starknet::contract]
mod PiggyContract {
    // import StorageMapReadAccess and StorageMapWriteAccess to access the starknet storage
    // a storage struct must be define for a every contract
    use starknet::storage::{StorageMapReadAccess, StorageMapWriteAccess};
    use super::{error::PiggyErrors, IPiggy};

    // decalaring a struct for hold difference variable types
    #[storage]
    struct Storage {
        balance: u256,
        purpose: felt252
    }

    // implementing smart contract
    // it is inheriting the interface we declared 
    #[abi(embed_v0)]
    impl PiggyContract of IPiggy<ContractState> {
        //this is a function deposit implemented in the interface
        // it take the contract state and amount to add to the balance
        fn deposit(ref self: ContractState, amount: u256) {
            // checking amount should be greater than zero
            assert(amount > 0, PiggyErrors::MUST_BE_GREATER_THAN_ZERO);
            // reading the balance prior so we can mutate the value which we delarea a mutable variable named balance
            let mut balance = self.balance.read();
            // add the balance to previous read value
            balance = balance + amount;
            // writing to the balance 
            self.balance.write(balance);
        }

        // the withdraw from the interface we declared
        fn withdraw(ref self: ContractState, amount: u256) {
            // reading the balance prior so we can mutate the value which we delarea a mutable variable named balance

            let mut balance = self.balance.read();
            // checking amount is below or equal the balance of the user 
            assert(balance >= amount, PiggyErrors::INSUFFICIENT_BALANCE);

            // or we can use if the amoun is out of balance we use panic
            if (balance < amount) {
                core::panic_with_felt252(PiggyErrors::INSUFFICIENT_BALANCE);
            }
        }
        // getting the user balance which return u256
        fn getBalance(self: @ContractState) -> u256 {
            self.balance.read()
        }
    }


}