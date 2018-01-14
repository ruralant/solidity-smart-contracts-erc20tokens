pragma solidity ^0.4.19;

// abstract contract because is a function without function body
contract Feline {
    function utterance() public returns (bytes32);
}

// Cat extend Feline. We can compile Cat but not Feline
contract Cat is Feline {
    function utterance() public returns (bytes32) {
        return "miaow!";
    }
}