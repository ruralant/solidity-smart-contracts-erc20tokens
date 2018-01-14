pragma solidity ^0.4.19;

// define a contract
contract SimpleDapp {
    // in Solidity there is no need to initialise variables
    uint someVar;
    
    function setSomeVar(uint myVar) public {
        someVar = myVar;
    }
    
    // constant variables can't change anything on the blockchain and don't cost any gas
    function getSomeVar() public returns(uint) {
        return someVar;
    }
    
    function setSomeVarTimesFour(uint myVar) public {
        setSomeVar(4 * myVar);
    }
}

// possible to have multiple contracts in the same file
contract SecondContractSameFile {
    // interact with other contract: set them as a variable
    SimpleDapp simpleDapp;
    // we can also create a new instance of the other contract
    SimpleDapp newInstanceOfSimpleDapp;
    
    // initialise the contract with the address
    function someOtherSimpleApp(address otherContractAddess) public {
        simpleDapp = SimpleDapp(otherContractAddess);
        // new instance
        newInstanceOfSimpleDapp = new SimpleDapp();
    }
    
    function getSimpleDappSomeVar() public constant returns (uint) {
        return simpleDapp.getSomeVar();
    }
    
    function getNewInstanceOfSimpleDappSomeVar() public constant returns (uint) {
        return newInstanceOfSimpleDapp.getSomeVar();
    }
}