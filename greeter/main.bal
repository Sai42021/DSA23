// Hello world, service and consumer
// import ballerina/http;

// listener http:Listener httpListener = new (8080);

// service / on httpListener {
//     resource function get greeting() returns string { 
//         return "Hello, World!"; 
//     }

//     resource function get greeting/[string name]() returns string { 
//         return "Hello " + name; 
//     }
// }

// Variables and types
// import ballerina/io;

// Modules and functions can declare variables. You can see both in this example.
// Here we declare a variable `greeting` of type `string` and initialize it to `"Hello"`.

// string greeting = "Hello";

// public function main() {
//     string name = "Ballerina";

//     io:println(greeting, " ", name);
// }

// Integers
// import ballerina/io;

// public function main() {
//     int m = 1;

//      // Integer literals can be hexadecimal (but not octal).
//     int n = 0xFFFF;

//     // You can use compound assignment operations such as `+=` and `-=`. 
//     n += m;

//     io:println(n);
// }

// Practical class
// import ballerina/io;

// enum Gender {
//     MALE,
//     FEMALE
// }

// Records
// type Isaac record {|
//     string name;
//     int age;
//     Gender gender;
// |};

// public function main() {
//     io:println("Hello, world!");
// Data types
// enum when you have two or three values that you already know the outcome of

// string name = "Isaac";
// int age = 34;
// float height = 1.4;
// decimal skin_color = 0x36527;
// any salary = 200000;
// salary = "2000000009X"; // Can accomodate any data type
// int grade = 100;

// Conditions; If statetments and switch case
// if height >= 1.89 {
//     io:println("Height > 1.89");
// } else {
//     io:println("Height < 1.89");
// }

/// Match statement
// match grade {
//     20 => {
//         io:println("Fail");
//     }
//     40 => {
//         io:println("Pass");
//     }
//     60 => {
//         io:println("Pass with Credit");
//     }
//     _ => {
//         io:println("Invalid Credit");
//     }
// }

// loops
// while loop
// if age is int {// Used to check the data type
//      while age >= 2 {
//     io:println(age);
//     break;
//     //continue;
// } 
// }

// for each loop
// int[] items = [1, 3, 10, 3, 5, 16];
// foreach int item in items {
//     io:println(item);
// }

// foreach int i in 20 ... 40 {
//     if i % 2 == 0 {
//         io:println(i);
//     }
// }

// Data structures

// Arrays
// string[] names = ["Isaac", "Makosa", "Jeff"];

//Tuples
// Similar to arrays but can store different data types
// [string, int, float] firstTuple = ["Dave", 67, 23.98];

// Map
// Stores keys with values
// map<int> marks = {
//     "Isaac": 34,
//     "Mak": 64,
//     "Rijarua": 34
// };

// If you want tp print a sepcific position
// io:println(marks["Mak"]);
// io:println(marks["Isaac"]);

// foreach string student_name in marks.keys() {
//     io:println(student_name, " ", marks[student_name]);
// }

// Records 
// Isaac person = {
//     age: 0,
//     name: "Dave",
//     gender: "MALE"
// };

// io:println(person);

// Unions
//float|int|string height2 = 20; 

// Functions
// function averageMark(map<int> marks) returns int {
//     int totalMarks = 0;

//     foreach int mark in marks {
//         totalMarks += mark;
//     }

//     return totalMarks / marks.length();
// }
// }

