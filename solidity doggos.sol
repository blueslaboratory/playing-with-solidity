pragma solidity ^0.4.20;

/*** NOTES ***/
/* Source: bitdegree */

/*
Version
Solidity source files can contain any number of contract definitions. Each Solidity file also includes a thing called “Version Pragma”. It is used to prevent the code from being compiled with future compiler versions that might introduce incompatible changes. Most of the time, the definition looks like this:
*/


/*
Contracts
Contracts in Solidity are similar to classes in object-oriented languages. They contain data in variables and functions that can modify these variables.
They are defined by using a contract keyword, followed by the contract name and and two brackets { } which will later enclose contract variables and functions. For example:
*/


/*
Solidity is a statically typed programming language, meaning that each variable must have its type specified. Examples of the main data types:

Booleans
Can only have one of the two following values: true or false. The keyword for booleans is bool.

Integers
Integers can be split into main groups: regular integers (can store both positive and negative values) and unsigned integers (can only store values that are 0 or higher)
-> Regular integer has keywords from int8 to int256. The number signifies the maximum number of bits it can store (thus limiting the maximum value), and it can be any number between 8 and 256 as long as it incremented in steps of  (e.g., int16 is valid but int17 is not). The int keyword alone would be understood as int256.
-> Unsigned integers follow the same logic. The only difference is the keyword which ranges from uint8 to uint256. Keyword uint can also be used instead of uint256.

Addresses
The address keyword is used to hold Ethereum addresses. If you're planning to store an Ethereum address, you will need to use the address keyword.

Strings
The string variable is used to store text information. If you need to store a variable that should contain text information use the string keyword.
*/


/*
Arithmetic operations
Integers can be used for arithmetic operations:
    Addition x + y
    Subtraction x - y
    Multiplication x * y
    Division x / y
    Remainder x % y
    Exponentiation x ** y (x to the power of y)
*/


/*
Structs
A struct is a special data type that allows the programmer to group a list of variables.
Structures are defined like this:
struct Car {
    string make;
    string model;
    uint16 year;
    uint16 horsepower;
}
*/


/*
Mappings
We’ll learn how to create a variable that will later map your Doggo to blockchain - a special list where all other Doggos are stored.
Mappings allow the programmer to create key-value pairs and store them as a list. Concepts like this also are known as hash tables.

Mappings are defined like this:
mapping(key_type => key_value) mappingName;

key_type should be replaced by a data type. Two commonly used variable types for mapping keys that we already know about are address and uint. It is important to note that not every data type can be used as a key. For instance, structs and other mappings cannot be used as keys.
Similarly, key_value should be replaced by the value type. Unlike with keys, Solidity does not limit the data type for values. It can be anything, including structs and other mappings.

A real-world example of a mapping:
mapping(address => uint256) balance;

This mapping could hold the bank account balance in uint256 for the given address.
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