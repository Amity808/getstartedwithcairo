// Events in samrt contract allows smart contract emit state of recorded data of the smart contract 
//it is very essential for tracking the state of smart contract and provide transparency to user and other contract
// event structs that derive the starknet::Event trait
// to use events is annoatetd with #[event] where each variant is link to event struct

// #[derive] attribute in starknet allows the compile to provide basic implementation for certain trait 
// the Copy trait allow simple types to duplicated by copying value with allocating new memory slot 
// it also provide copy semantixs instead of movie semantic which can transfer ownership
//Drop: this trait allow to move trait out of scoope to reuse in another scope imported
//Debug: this trait allow to debug fromatting in formart string or type by adding the `:?` within {} or {}


#[starknet::interface]
pub trait IEventCounter<TContractState> {
    fn increment(ref self: TContractState, amount: u128);
}

mod Events {
    //  Events must derive fromt the starknet::Event trait
    #[derive(Copy, Drop, Debug, PartialEq, starknet::Event)]
    // define our counterincrease event which will emit amount of u128 type
    pub struct CounterIncreased {
        pub amount: u128,
    }

    //we are defining another event
    #[derive(Copy, Drop, Debug, PartialEq, starknet::Event)]
    // this event will emit when the counter increased
    pub struct UserIncreaseCounter {
        // this event have the attribute of #[key] whcihc represent that
        // the event will be indexed
        // You can also use `#[flat]` for nested structs.
        #[key]
        pub user: starknet::ContractAddress,
        pub new_value: u128,
    }
}

#[starknet::contract]
mod EventCounter {
    //importing the event struct the two struct
    use super::Events::{CounterIncreased, UserIncreaseCounter};
    // the trait of Event interfacecontract
    use super::IEventCounter;
    //the caller of the function at the particular time
    use starknet::get_caller_address;
    //import the Storage pointer which allows to read and write to the storage struct
    use starknet::storage::{StoragePointerReadAccess, StorageMapWriteAccess};

    #[storage]
    struct Storage {
        counter: u128, 
    }

    

    
}
