# WhichOneIsFaster

## Switch vs. Dictionary to map `enum` cases to other values
Discover the best approach for mapping enum cases to other values in your Swift projects. This example compares the performance of using switch statements versus dictionary lookups, helping you make an informed decision for your specific use case.

### Overview

When you need to map each enum case to a particular value, such as a SwiftUI.Color, you may wonder whether it's more efficient to use a dictionary of [MyEnum: Color] or to rely on a switch statement in a function. This repository provides an example to showcase the performance differences between these two approaches.

### Example

The example project is available at the following link:

https://github.com/atacan/WhichIsFaster/tree/main/Sources/SwitchVsDictionary

## Usage

To test the performance follow these steps:

1. Clone the repository or download the example project from the link above.
1. Open the project in Xcode.
1. Select the scheme for the topic.
1. Google/Benchmark package will output the time it took to run each option.