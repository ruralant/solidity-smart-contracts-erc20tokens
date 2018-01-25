pragma solidity ^0.4.16;

contract Owned {
  address public owner;

  modifier onlyOwner() {
    if (msg.sender == owner) {
      _;
    }
  }

  // Event function
  event OwnerChanged(address previousOwner, address newOwner);

  // Get the current owner
  function Owned() public {
    owner = msg.sender;
  }

  // Change the owner
  function changeOwner(address _newOwner) external onlyOwner {
    address previousOwner = owner;
    owner = _newOwner;
    // Emit event
    OwnerChanged(previousOwner,_newOwner);
  }
}

// Base contract
contract RedsCoin {
  // Constants of the contract
  function totalSupply() public constant returns (uint256 totalSupply);
  function balanceOf(address _owner) public constant returns (uint256 balance);
  function transfer(address _to, uint256 _value) public returns (bool success);

  // Transfer Event
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
}

// Coin contract
contract Coin is RedsCoin, Owned {
  // Constants of the contract
  string public constant name = "Reds Coin";
  string public constant symbol = "RDC";
  uint256 constant totSupply = 1000000;
  uint256 limit = 0;

  // Get the balance for each account
  mapping(address => uint256) balances;

  address[] public whitelist;

  // Check the accounts' balance limits
  modifier withinLimit(uint256 _value) {
    if ((limit==0) || (_value < limit)) {
      _;
    }
  }
  // broadcast the account details (Web3)
  event TransferDetails(address indexed _from, address indexed _to, uint256 _value,bool _success,uint256 _gas);

  // Constructor
  function Coin() public {
    owner = msg.sender;
    balances[msg.sender] = totSupply;
  }

  // Set the total supply of the contract
  function totalSupply() public constant returns (uint256) {
    return totSupply;
  }

  // Set a limit for the transfers (limit gas use)
  function setLimit(uint256 _limit) public {
    limit = _limit;
  }

  // Whitelist accounts
  function addToWhiteList(address _newAddress) public onlyOwner {
    if (checkWhiteList(_newAddress)==false) {
      whitelist.push(_newAddress);
    }
  }

  // Check if the account is whitelisted
  function checkWhiteList(address _newAddress) public view returns (bool) {
    bool found = false;
    for (uint256 ii = 0; ii < whitelist.length;ii++) {
      if (_newAddress==whitelist[ii]) {
        found = true;
        break;
      }
    }
    return found;
  }

  // Get the balance of a particular account
  function balanceOf(address _owner) public constant returns (uint256 balance) {
    return balances[_owner];
  }

  // Transfer's final result
  function transfer(address _to, uint256 _value) public onlyOwner withinLimit(_value) returns (bool success) {
    // Check if the account is whiteliested
    if (checkWhiteList(_to) == true) {
      // Check that all the balances are valid
      require(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]);
      balances[msg.sender] -= _value;
      balances[_to] += _value;
      // Emit the transfer event's details
      TransferDetails(msg.sender, _to, _value,true,msg.gas);
      return true;
    } else {
      // Basic error handling
      TransferDetails(msg.sender, _to, _value,false,msg.gas);
      return false;
    }
  }
}

// To create an ERC20 compliant token base your token on ERC20 Coin
// Add the extra functions to your simple token contract
contract ERC20Coin {
  function totalSupply() public constant returns (uint256 totalSupply);
  function balanceOf(address _owner) public constant returns (uint256 balance);
  function transfer(address _to, uint256 _value) public returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
  function approve(address _spender, uint256 _value) public returns (bool success);
  function allowance(address _owner, address _spender) public constant returns (uint256 remaining);

  // Events
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

contract Coin is ERC20Coin {
  // Constants of the contract
  string public constant name = "RedsCoin";
  string public constant symbol = "RDC";
  uint256 constant _totalSupply = 1000000;

  // Get the current owner
  address public owner;

  // Get the balance for each account
  mapping (address => uint256) balances;
  // Owner approves the transfer to another account
  mapping (address => mapping (address => uint256)) allowed;

  // Constructor
  function Coin() public {
    owner = msg.sender;
    balances[msg.sender] = _totalSupply;
  }

  // Set the total supply of the contract
  function totalSupply() public constant returns (uint256 totalSupply) {
    totalSupply = _totalSupply;
  }

  // Get the account's balance
  function balanceOf(address _owner) public constant returns (uint256 balance) {
    return balances[_owner];
  }

  // Transfer's final result 
  function transfer(address _to, uint256 _value) public returns (bool success) {
    // Check that all the balances are valid
    require(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    // Emit the transfer event's details
    Transfer(msg.sender, _to, _value);
    return true;
  }

  // Send _value amount of tokens from address _from to address _to
  function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success) {
    if (balances[_from] >= _amount
    && allowed[_from][msg.sender] >= _amount
    && _amount > 0
    && balances[_to] + _amount > balances[_to]) {
      balances[_from] -= _amount;
      allowed[_from][msg.sender] -= _amount;
      balances[_to] += _amount;
      Transfer(_from, _to, _amount);
      return true;
    } else {
      return false;
    }
  }

  // Allow _spender to withdraw from your account, multiple times, up to the _value amount.
  // If this function is called again it overwrites the current allowance with _value.
  function approve(address _spender, uint256 _amount) public returns (bool success) {
    allowed[msg.sender][_spender] = _amount;
    Approval(msg.sender, _spender, _amount);
    return true;
  }

  function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }
}

