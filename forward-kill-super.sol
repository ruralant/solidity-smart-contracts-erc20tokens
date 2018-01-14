pragma solidity ^0.4.19;

contract owned {
    function owned() { owner = msg.sender; }
    address owner;
}

contract mortal is owned {
    function kill() public {
        // check if is called by the owner and send him the funds and self distruct
        if (msg.sender == owner) {
          selfdestruct(owner);
        }
    }
}

contract Base1 is mortal {
    function kill() public {
        super.kill();
    }
}

contract Base2 is mortal {
    function kill() public{ 
        super.kill();
    }
}

contract Final is Base1, Base2 {
    // using the keyword "super", a new contract that call Final, will call Base1 and Base2
}