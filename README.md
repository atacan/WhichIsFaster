# WhichOneIsFaster

## Switch vs. Dictionary to map `enum` cases to other values
Discover the best approach for mapping enum cases to other values in your Swift projects. This example compares the performance of using switch statements versus dictionary lookups, helping you make an informed decision for your specific use case.

### Overview

When you need to map each enum case to a particular value, such as a SwiftUI.Color, you may wonder whether it's more efficient to use a dictionary of [MyEnum: Color] or to rely on a switch statement in a function. This repository provides an example to showcase the performance differences between these two approaches.

### Example

The example project is available at the following link:

https://github.com/atacan/WhichIsFaster/tree/main/Sources/SwitchVsDictionary

## Encoding Decoding

```haskell
name                                                                   time         std        iterations
---------------------------------------------------------------------------------------------------------
Codable JSON Encoding to Data                                           2375.000 ns ±  21.83 %     552365
Ikiga Encoding to Data                                                   875.000 ns ±  21.00 %    1000000
Plist Encoding to Data                                                  5833.000 ns ±   8.51 %     239088
XMLCoder Encoding to Data                                              12375.000 ns ±   4.29 %     111631
BSON Encoding to Data                                                   2083.000 ns ±  10.92 %     670134
Avro Encoding to Data                                                   3833.000 ns ±  16.69 %     364732
CBOR Encoding to Data                                                   1458.000 ns ±  23.48 %     933959
Protobuf Encoding to Data                                                125.000 ns ±  89.69 %    1000000
Protobuf Encoding to Data - 
First Convert Internal Type to Proto Model                               125.000 ns ±  96.08 %    1000000
Manual Encoding                                                         1792.000 ns ± 678.13 %     631953
Codable JSON Decoding from Data                                         3833.000 ns ±   9.17 %     360046
Ikiga Decoding from Data                                                1833.000 ns ±  11.88 %     760585
BSON Decoding from Data                                                 2625.000 ns ±  13.81 %     523171
Avro Decoding from Data                                                  875.000 ns ±  16.30 %    1000000
Plist Decoding from Data                                                2875.000 ns ±   8.39 %     481137
XMLCoder Decoding from Data                                            19208.000 ns ±   8.63 %      70437
CBOR Decoding from Data                                                 1416.000 ns ±  14.13 %     985492
Protobuf Decoding from Data                                              167.000 ns ±  62.11 %    1000000
Protobuf Decoding from Data - Convert to Internal                        167.000 ns ±  66.94 %    1000000
Manual Decoding                                                         2167.000 ns ±  26.61 %     628820
```

## Markdown Parsers

```haskell
name      time        std        iterations
-------------------------------------------
cmark gfm    6459.000 ns ±  10.63 %     211010
Ink         25208.000 ns ±   3.98 %      53692
Down         5000.000 ns ±   6.15 %     278264
Parsley     17357.000 ns
MarkdownKit 54346.000 ns
```

## String Concatenation

```haskell
name                                  time        std        iterations
-----------------------------------------------------------------------
Plus operator in a function             41.000 ns ± 129.94 %    1000000
Plus operator called inside benchmark    0.000 ns ±    inf %    1000000
Append in a function                     0.000 ns ±    inf %    1000000
Append called inside benchmark        2875.000 ns ±  18.46 %     457165
Interpolation                         5250.000 ns ±  13.83 %     264250
```

## Usage

To test the performance follow these steps:

1. Clone the repository or download the example project from the link above.
1. Open the project in Xcode.
1. Select the scheme for the topic.
1. Google/Benchmark package will output the time it took to run each option.
