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
        mortal.kill();
    }
}

contract Base2 is mortal {
    function kill() public {
        mortal.kill();
    }
}

contract Final is Base1, Base2 {
    // if another contract call mortal.kill() it will call Base2 and never see Base1.
    // to avoid this we need to call the keyword "super"
}