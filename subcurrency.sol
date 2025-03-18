// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract Coin {

    address public minter;
    mapping(address => uint) public balances;

    event Sent(address sender, address to, uint amount);

    constructor() {
        minter = msg.sender;  // set the creator of the contract as the minter
    }


    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;

    }

    error InsufficientBalance(uint requested, uint availabe);

    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender]){
            revert InsufficientBalance({
                requested: amount,
                availabe: balances[msg.sender]
            });
        }
        
        balances[msg.sender] -=amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}