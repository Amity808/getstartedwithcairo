#[starknet::interface]
trait IStoringCustomType<TContractState> {
    fn set_person(ref self: TContractState, person: Person);
    fn set_name(ref self: TContractState, name: felt252);
}

//we need to implement starknet::Store trait to store struct in the storage 
// Deriving the trait through starknet::Store
// we need to implement copy trait, drop trait and serde as well
#[derive(Drop, Serde, Copy, starknet::Store)]
struct Person {
    age: u8,
    name: felt252,
}


#[starknet::contract]
mod StoringCustomType {
    // we import the StoragePointerWriteAccess to write the storage struct
    use starknet::storage::StoragePointerWriteAccess;
    // get the visibility of the struct person which is the custom data type we are storing
    use super::Person;
    // importing the trait of fn implements of saving data
    use super::IStoringCustomType;

    // storage struct must be define in starknet contract
    #[storage]
    struct Storage {
        person: Person,
    }
    //.DS_Store

    // define the trait which tells the contract about our abi
    // application binary Interface
    #[abi(embed_v0)]
    // it inherits from the IStoringCustomType trait we import 
    impl StoringCustomType of IStoringCustomType<ContractState> {
        // set_person fn takes in the contract state and the person struct
        fn set_person(ref self: ContractState, person: Person) {
            self.person.write(person);
         }

        // When you derive the Store trait, Cairo automatically generates the necessary storage pointers 
        // for each struct member. This allows you to access and modify individual fields of your stored struct directly:
        // set_person fn takes in the contract state and the name which we want to write to the person struct
        fn set_name(ref self: ContractState, name: felt252) {
            self.person.name.write(name);
        }
    }



}