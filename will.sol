// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract Will { 
    address owner;
    uint fortune;
    bool deceased;


    constructor() payable {
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;

    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;

    }

     modifier onlyDeceased {
        require(deceased == true);
        _;

    }

    address payable[] familyWallets;

    mapping(address  => uint) inheritence;

    function setInheritence(address payable  wallet, uint amount) public{
        familyWallets.push(wallet);
        inheritence[wallet] = amount;
    }

    function payout() private onlyDeceased{
        for(uint i=0; i<familyWallets.length; i++){
            familyWallets[i].transfer(inheritence[familyWallets[i]]);

        }

    }


    function runOnlyDeceased() public onlyOwner{
        deceased = true;
        payout();
    }
}

