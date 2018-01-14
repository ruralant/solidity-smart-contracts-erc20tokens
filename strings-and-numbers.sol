pragma solidity ^0.4.19;

contract owned {
    bool myBool;
    uint8 myUint8;
    uint myUint256;
    bytes32 myBytes32;
    bytes myBytes;
    string myString;
    
    function owned() public {
        myBool = true;
        myUint8 = 255;
        myUint256 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        myBytes32 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        myString = "Hello";
    }
    
    function setMyString(string mystring) public {
        myString = mystring;
    }
    
    function getMyBytes32() public constant returns (bytes32) {
        return myBytes32;
    }
    
    function getMyBytes256() public constant returns (uint256) {
        return myUint256;
    }
}