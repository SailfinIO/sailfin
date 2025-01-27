Sail Language Specification

Version: 0.0.1
Date: January 2025

Sail is a modern, developer-friendly programming language designed to combine the type-safe, expressive syntax of TypeScript with the powerful concurrency features of Go. Sail aims to empower developers to write performant, scalable, and readable code for modern applications.

Table of Contents

Core Principles
Basic Syntax
Types
Concurrency Model
Memory Model
Standard Library Overview
Compile Targets
Future Roadmap
Core Principles

Readable and Expressive Syntax: Inspired by TypeScript for developer familiarity.
First-Class Concurrency: Lightweight threads (routines), channels for communication, and parallel execution.
Type Safety: Statically typed with support for generics, union types, and interfaces.
Performance: Compiles to efficient machine code or WebAssembly for fast execution.
Interoperability: Easy integration with existing JavaScript and TypeScript ecosystems.
Memory Safety: Prevent data races and unsafe memory access with immutable-by-default variables and ownership models.
Basic Syntax

Hello, Sail!
function main() {
console.log("Hello, Sail!");
}
Variables
Sail supports immutable variables by default. Use mut to make variables mutable.

let name: string = "Sail"; // Immutable
mut age: number = 25; // Mutable
Functions
Sail functions are strongly typed and support default parameters and generics.

function greet(name: string = "World"): string {
return `Hello, ${name}!`;
}

console.log(greet()); // "Hello, World!"
Conditionals and Loops
if (x > 0) {
console.log("Positive");
} else {
console.log("Negative or zero");
}

for (let i = 0; i < 10; i++) {
console.log(i);
}
Types

Primitive Types
number: Represents integers and floats.
string: UTF-8 encoded strings.
boolean: True or false values.
void: Represents no value (used in function returns).
null and undefined: Used for nullable types.
Composite Types
Arrays: Fixed or dynamic arrays.
let numbers: number[] = [1, 2, 3];
Tuples: Fixed-size collections of mixed types.
let pair: [string, number] = ["age", 25];
Enums:
enum Color {
Red,
Green,
Blue,
}
let color: Color = Color.Red;
Structs: Custom data structures.
struct Point {
x: number;
y: number;
}
let p: Point = { x: 0, y: 0 };
Generics
function identity<T>(value: T): T {
return value;
}
Union and Intersection Types
type StringOrNumber = string | number;
type AdminUser = User & { isAdmin: boolean };
Concurrency Model

Routines
Routines are lightweight threads that can be spawned using the spawn keyword.

spawn {
console.log("Running in a separate thread");
}
Channels
Channels enable thread-safe communication between routines.

const channel = new Channel<number>();

spawn {
channel.send(42);
}

console.log(await channel.receive()); // Outputs: 42
Parallel Execution
For tasks that can run independently, use parallel.

const results = parallel([
() => task1(),
() => task2(),
]);

console.log(results); // Outputs results of task1 and task2
Memory Model

Immutability by Default
Variables are immutable unless explicitly declared mutable.

Ownership and Borrowing
Sail ensures memory safety by controlling ownership:

Ownership can be transferred between threads.
Shared resources are managed through Mutex or Channel.
Standard Library Overview

Sail's standard library focuses on modern application development, with modules for:

Concurrency: Routines, channels, and parallel execution.
Networking: HTTP clients and servers.
File I/O: Read and write files efficiently.
Collections: Arrays, maps, and sets.
Math: Utilities for numerical computation.
Compile Targets

Sail compiles to:

LLVM IR for generating efficient machine code.
WebAssembly for browser and server environments.
JavaScript for seamless interoperability.
Future Roadmap

Self-Hosting Compiler: Rewrite the compiler in Sail itself.
Advanced Tooling: Include a package manager, formatter, and linter.
WebAssembly Ecosystem: Strengthen WASM support for browser-based applications.
Distributed Computing: Add built-in support for distributed routines and data.
This specification provides a solid foundation for developing the Sail language. Let me know if you'd like to dive into any specific section or start implementing the compiler!
