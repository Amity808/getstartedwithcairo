
pub mod Events {
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