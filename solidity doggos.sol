/*
Version
Solidity source files can contain any number of contract definitions. Each Solidity file also includes a thing called “Version Pragma”. It is used to prevent the code from being compiled with future compiler versions that might introduce incompatible changes. Most of the time, the definition looks like this:
*/

pragma solidity ^0.4.20;


/*
Contracts
Contracts in Solidity are similar to classes in object-oriented languages. They contain data in variables and functions that can modify these variables.
They are defined by using a contract keyword, followed by the contract name and and two brackets { } which will later enclose contract variables and functions. For example:
*/

contract SpaceDoggos {

    uint maxPlanetsPerSystem = 10;
    uint minPlanetsPerSystem = 3;

    uint planetCodeDigits = 7;
    uint systemCodeDigits = 7;

    uint planetCodeModulus = 10 ** planetCodeDigits;
    uint systemCodeModulus = 10 ** systemCodeDigits;

    struct Doggo {
        string name;
        uint8 breed;
        uint8 color;
        uint8 face;
        uint8 costume;
        uint coordX;
        uint coordY;
    }

    mapping(address => Doggo) doggos;

    function createDoggo(string _name, uint8 _breed, uint8 _color, uint8 _face, uint8 _costume) {
        Doggo memory myDoggo = Doggo({
            name: _name,
            breed: _breed,
            color: _color,
            face: _face,
            costume: _costume,
            coordX: 0,
            coordY: 0
        });

        doggos[msg.sender] = myDoggo;
    }

    // Write your function below
    function getSystemMap(uint _coordX, uint _coordY) returns (uint) {
    return uint(keccak256(_coordX, _coordY));
    }


}