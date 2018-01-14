pragma solidity ^0.4.19;

contract SomeContract {
    
    uint someVar;
    
    function getMyVar() public constant returns (string, uint) {
        if (someVar > 2) {
            return ("greater than two", someVar);
        } else if (someVar == 2) {
            return ("two!", someVar);
        } else {
            return ("smaller than two", someVar);
        }
    }
    
    function setMyVar(uint myVar) public {
        someVar = myVar;
    }
    
    function getWhile() public pure returns (uint) {
        uint i = 0;
        while (i < 5) {
            i++;
        }
        return i;
    }
}