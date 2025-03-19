// Maps are one of the key value data structure in cairo
// smart contracts that allow to retrieve values using unique keys
// The Map type in starknet::storage is specifically designed for contract storage for this purpose.
// Maps are declared using Map<KeyType, ValueType>
// Example: ERC20 allowance mapping
// Map<(ContractAddress, ContractAddress), felt252>  // (owner, spender) -> amount
// getting the Contract Address type
use core::starknet::ContractAddress;

//define interface for setting mapping and get map by the key
#[starknet::interface]
trait IMapContract<TContractState> {
    fn set(ref self: TContractState, key: ContractAddress, value: felt252);

    fn get(self: @TContractState, key: ContractAddress) -> felt252;

}


// implementing the contract state 
#[starknet::contract]
mod MapContractImpl {
    //using the super to access the trait define above
    use super::IMapContract;
    // getting the Contract Address type
    use starknet::ContractAddress;
    //getting Map pointer and storage pointer to declare the map and write to the storage struct
    use starknet::storage::{Map, StorageMapReadAccess, StorageMapWriteAccess};

    // define the storage struct with initialization of mapping
    #[storage]
    struct Storage {
        map: Map<ContractAddress, felt252>,
    }

    //implement contract abi
    #[abi(embed_v0)]
    impl MapContractImpl of IMapContract<ContractState> {
        //seting the map with the key and the value
        /// * `key` - is the key pair of map
        fn set(ref self: ContractState, key: ContractAddress, value: felt252) {
            self.map.write(key, value);
        }
        /// getting the map with the key
        /// # Returns values
        fn get(self: @ContractState, key: ContractAddress) -> felt252 {
            self.map.read(key)
        }
    }
    

}
