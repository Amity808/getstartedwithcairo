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

mod event;

#[starknet::contract]
mod EventCounter {
    //importing the event struct the two struct
    use super::event::Events::{CounterIncreased, UserIncreaseCounter};
    // the trait of Event interfacecontract
    use super::IEventCounter;
    //the caller of the function at the particular time
    use starknet::get_caller_address;
    //import the Storage pointer which allows to read and write to the storage struct
    use starknet::storage::{StoragePointerReadAccess, StorageMapWriteAccess};

    // a struct storage to write to blockchain
    // with u128 type
    #[storage]
    struct Storage {
        counter: u128, 
    }

    #[event]
    #[derive(Debug, Drop, Copy, PartialEq, starknet::Event)]
    //the event must be annoated with #[event] attribute
    // It must also derive at least the `Drop` and `starknet::Event` traits.
    pub enum Event {
        CounterIncreased: CounterIncreased,
        UserIncreaseCounter: UserIncreaseCounter,
    }

    #[abi(embed_v0)]
    impl EventCounter of IEventCounter<ContractState> {
        fn increment(ref self: ContractState, amount: u128) {
            self.counter.write(self.counter.read() + amount);
            // to emit event
            self.emit(Event::CounterIncreased(CounterIncreased {amount}));
            // this also emit the caller which serves as the msg.sender in solidity
            // and new counter value we can use it to update the value
            self.emit(Event::UserIncreaseCounter(
                UserIncreaseCounter {
                    user: get_caller_address(), 
                    new_value: self.counter.read() 
                }
            ))

        }
    }




    
}
