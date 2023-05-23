# WhichOneIsFaster

## Switch vs. Dictionary to map `enum` cases to other values
Discover the best approach for mapping enum cases to other values in your Swift projects. This example compares the performance of using switch statements versus dictionary lookups, helping you make an informed decision for your specific use case.

### Overview

When you need to map each enum case to a particular value, such as a SwiftUI.Color, you may wonder whether it's more efficient to use a dictionary of [MyEnum: Color] or to rely on a switch statement in a function. This repository provides an example to showcase the performance differences between these two approaches.

### Example

The example project is available at the following link:

https://github.com/atacan/WhichIsFaster/tree/main/Sources/SwitchVsDictionary

## Encoding Decoding

<div style="font-family: monospace;">

|name                                                                   |time         std        |iterations|
|:-----------------------------------------------------------------------|------------------------:|----------:|
|JSON Encoding to Data                                                  | 2709.000 ns ±   6.19 % |    501617|
|Ikiga Encoding to Data                                                 | 1042.000 ns ±  11.02 % |   1000000|
|Plist Encoding to Data                                                 | 6500.000 ns ±   4.00 % |    216577|
|XMLCoder Encoding to Data                                              |15375.000 ns ±   2.67 % |     90621|
|BSON Encoding to Data                                                  | 2375.000 ns ±   7.73 % |    585132|
|Avro Encoding to Data                                                  | 4500.000 ns ±   5.71 % |    305185|
|CBOR Encoding to Data                                                  | 1792.000 ns ±   8.67 % |    785476|
|Protobuf Encoding to Data                                              |  166.000 ns ±  34.02 % |   1000000|
|Protobuf Encoding to Data - First Convert Internal Type to Proto Model |  167.000 ns ±  28.56 % |   1000000|
|Manual Encoding                                                        | 2083.000 ns ± 447.26 % |    568766|
|JSON Decoding from Data                                                | 4333.000 ns ±   5.16 % |    321362|
|Ikiga Decoding from Data                                               | 2125.000 ns ±   9.10 % |    654229|
|BSON Decoding from Data                                                | 3083.000 ns ±   6.45 % |    454194|
|Avro Decoding from Data                                                |  917.000 ns ±  12.09 % |   1000000|
|Plist Decoding from Data                                               | 3250.000 ns ±  23.10 % |    431053|
|XMLCoder Decoding from Data                                            |22416.000 ns ±   6.24 % |     61379|
|CBOR Decoding from Data                                                | 1542.000 ns ±  11.47 % |    928932|
|Protobuf Decoding from Data                                            |  167.000 ns ±  61.93 % |   1000000|
|Protobuf Decoding from Data - Convert to Internal                      |  167.000 ns ±  31.00 % |   1000000|
|Manual Decoding                                                        | 2417.000 ns ±  16.96 % |    562552|

</div>

## Markdown Parsers

```haskell
name      time        std        iterations
-------------------------------------------
cmark gfm 6459.000 ns ±  10.63 %     211010

name time         std        iterations
---------------------------------------
Ink  25208.000 ns ±   3.98 %      53692
Down  5000.000 ns ±   6.15 %     278264

Parsley      17357 ns
MarkdownKit  54346 ns
```

## Usage

To test the performance follow these steps:

1. Clone the repository or download the example project from the link above.
1. Open the project in Xcode.
1. Select the scheme for the topic.
1. Google/Benchmark package will output the time it took to run each option.
