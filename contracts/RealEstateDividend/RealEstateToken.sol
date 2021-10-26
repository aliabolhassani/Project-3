pragma solidity ^0.5.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract RealEstateCoin is ERC20, ERC20Detailed, ERC20Mintable {
    using SafeMath for uint;
    
    uint public shares;
    address payable public walletAddress;
    uint public maxSupply;
    uint public sharePercent;
    uint public amount;

    constructor(
        string memory name,
        string memory symbol,
        uint _maxSupply
    )
        ERC20Detailed(name, symbol, 18)
        public
    {
        maxSupply = _maxSupply;
    } 


    /**
        Allows renter to deposit their monthly rent.
        Loops through an array of Investors for the property and distributes dividends.
    **/
    function depositRent() payable public {
        // uint totalRent = msg.value;
        uint points = msg.value/100;

        uint arrayLength = ERC20.investorsList.length;
        for (uint i = 0; i < arrayLength; i++) {
            
            shares = ERC20._balances[ERC20.investorsList[i]];
            
            sharePercent = shares * 100 / maxSupply; 
        
            amount = points * sharePercent;
            
            walletAddress = ERC20.investorsList[i];
            
            walletAddress.transfer(amount);
        }
    }


}
    
