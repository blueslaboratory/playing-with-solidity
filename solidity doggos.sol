pragma solidity ^0.4.20;

/*** NOTES ***/
/* Source: bitdegree */

/*
Version
Solidity source files can contain any number of contract definitions. Each Solidity file also includes a thing called “Version Pragma”. 
It is used to prevent the code from being compiled with future compiler versions that might introduce incompatible changes. 
Most of the time, the definition looks like this:
pragma solidity ^0.4.20;
*/


/*
Contracts
Contracts in Solidity are similar to classes in object-oriented languages. They contain data in variables and functions that can modify these variables.
They are defined by using a contract keyword, followed by the contract name and and two brackets { } which will later enclose contract variables and functions. 
For example:
contract SpaceDoggos { }
*/


/*
Solidity is a statically typed programming language, meaning that each variable must have its type specified. Examples of the main data types:

Booleans
Can only have one of the two following values: true or false. The keyword for booleans is bool.

Integers
Integers can be split into main groups: regular integers (can store both positive and negative values) and 
unsigned integers (can only store values that are 0 or higher)
-> Regular integer has keywords from int8 to int256. The number signifies the maximum number of bits it can store 
(thus limiting the maximum value), and it can be any number between 8 and 256 as long as it incremented in steps of 8 
(e.g., int16 is valid but int17 is not). The int keyword alone would be understood as int256.
-> Unsigned integers follow the same logic. The only difference is the keyword which ranges from uint8 to uint256. 
Keyword uint can also be used instead of uint256.

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
Function 
Functions are pieces of code that perform a specific task. Functions can take any number of variables as an input, 
and it can return a specific value back. In case of Solidity, you can even return multiple values from one function.
Here is a simple function that does not return any data but simply adds two values together and assigns the result 
to a state variable sum:

uint sum;
function add(uint a, uint b) {
    sum = a + b;
}

Function inputs are optional, but if there are any, they need to be comma-separated.
If we want to return data and avoid changing the contract’s state, we can rewrite the function like this:

function add(uint a, uint b) returns(uint)  {
    return a + b;
}

Note that a new keyword returns() was used to specify the type of the function output. Because we added two uints together, 
the result will also be uint. To return a value back, you need to use the return statement.
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


Using structs
Structs are created by specifying the values for each struct property.

struct Car {
    string make;
    string model;
    uint16 year;
}

function makeCar(uint16 _year) {
    Car myCar = Car({
        make: "Nissan",
        model: "Micra",
        year: _year
    });
}

Please note how you can assign both constant values and values from variables. In this case, you can see how model value is a constant 
and year value comes from function argument _year.

Storage Types
Solidity has two places where it can store variable data: storage (which is the blockchain itself) or memory (a temporary place 
which is erased when it is no longer needed). Storage is expensive to use but memory is not. By default, structs and arrays reference 
to storage and all other variables use memory. 
If you want to make sure that a specific variable (a struct, for example) is stored in memory, you need to use the memory keyword. Like this:

Pizza memory favoritePizza = Pizza({type: "pepperoni"});
*/


/*
Mappings
We’ll learn how to create a variable that will later map your Doggo to blockchain - a special list where all other Doggos are stored.
Mappings allow the programmer to create key-value pairs and store them as a list. Concepts like this also are known as hash tables.

Mappings are defined like this:
mapping(key_type => key_value) mappingName;

key_type should be replaced by a data type. Two commonly used variable types for mapping keys that we already know about are address and uint. 
It is important to note that not every data type can be used as a key. For instance, structs and other mappings cannot be used as keys.
Similarly, key_value should be replaced by the value type. Unlike with keys, Solidity does not limit the data type for values. 
It can be anything, including structs and other mappings.

A real-world example of a mapping:
mapping(address => uint256) balance;

This mapping could hold the bank account balance in uint256 for the given address.


Assigning values to a mapping
Attaching values to a mapping is pretty straight forward. The syntax is very similar to regular value assignment, 
the only difference is that you need to specify the key. It is done like this:

mapping(address => uint) score;

function updatePoints(address _person, uint _points) {
    score[_person] = _points;
}

Sender address
The functions on Smart Contracts (unless they are internal or private - more on that in upcoming lessons) will be called directly 
by accounts on Ethereum blockchain. Each account is a hexadecimal address that looks something like this:
0x1961b3331969ed52770751fc718ef530838b6dee

To retrieve the function caller’s address, you can use special variable msg.sender. For example:
score[msg.sender] = 500;
*/


/*
Hashes and Typecasting
Hashes
To generate the space and planets we will need to turn two numbers that correspond to X and Y coordinates to a seemingly 
random code that we could use to determine the traits of the solar system and the planets that belong to it.

For this purpose, we will use Ethereum’s KECCAK-256 algorithm that produces a 256-bit hexadecimal number. In Solidity, 
you can use the keccak256 function to get the hash. You can pass any number of arguments to this function. For example:
keccak256(123, 321);


Typecasting
Sometimes you may need to do arithmetics with two variables that have different data types. Solidity will only allow 
operations between two variables that have the same type. Therefore you need to convert one of the variables to the type 
of the others. For example:
uint8 x = 8;
uint256 y = 10 ** 18;
uint256 z = y * uint256(x);
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


    /*
    Create a mapping called doggos, with key type address and value type Doggo. We will use this mapping to keep track
    of which Ethereum address owns which Doggo.
    */

    mapping(address => Doggo) doggos;

    /*
    Function with struct:
    Inside function createDoggo, define a new variable called myDoggo that has the type Doggo (it is a struct we created earlier). 
    Pay attention to the case of these two words. It is important! Make sure the variable is stored in memory
    Assign myDoggo variable a new struct Doggo, by using function arguments as inputs for each of its corresponding property. 
    For properties coordX and coordY, use 0 as the value.
    */

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

        /*
        In createDoggo function, save the myDoggo variable you’ve created in the previous lesson to doggos mapping. 
        Use sender’s address as the key.
        */
        doggos[msg.sender] = myDoggo;
    }


    /*
    Create a new function called getSystemMap that will take two uint variables _coordX and _coordY as arguments. 
    The function will return one uint. All of this should be visible in the function definition.
    In function’s getSystemMap body, return a keccak256 value of _coordX and _coordY. 
    Because our function must return an uint, make sure to typecast it to uint.
    */

    function getSystemMap(uint _coordX, uint _coordY) returns (uint) {
    return uint(keccak256(_coordX, _coordY));
    }


}