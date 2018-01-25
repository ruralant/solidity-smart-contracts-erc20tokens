pragma solidity ^0.4.16;

contract SimpleCoin {
  function totalSupply() constant returns (uint256 totalSupply);
  function balanceOf(address _owner) constant returns (uint256 balance);
  function transfer(address _to, uint256 _value) returns (bool success);

  event Transfer(address indexed _from, address indexed _to, uint256 _value);

}

contract RedsCoin is SimpleCoin {
  // Constants of the contract
  string public constant name = "Reds Coin";
  string public constant symbol = "RDC";
  uint256 constant _totalSupply = 1000000;

  // Owner of the contract
  address public owner;

  // Balances for each account
  mapping(address => uint256) balances;

  // Constructor
  function RedsCoin() public {
    owner = msg.sender;
    balances[msg.sender] = _totalSupply;
  }

  // Set the Reds Coin total supply
  function totalSupply() public constant returns (uint256 totalSupply) {
    totalSupply = _totalSupply;
  }

  // Get the balanc of every single account
  function balanceOf(address _owner) public constant returns (uint256 balance) {
    return balances[_owner];
  }

  // Create trensfers
  function transfer(address _to, uint256 _value) public returns (bool success) {
    // Only run if all the condition underneath are valid
    require(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    // Emit the event
    Transfer(msg.sender, _to, _value);
    return true;
  }
}
 