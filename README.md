<!-- ABOUT THE PROJECT -->
## About The Project

This project is a sample project that makes network calls to fetch Current Weather Forecast users and Weekly Weather Forecast. The App also allows users to save a location as a favorite. You can also view a saved location on a map. This is an Xcode Project and runs on Swift 5. Feel free to download and run the App.

### Built With

Major frameworks used when building this project :
* [Xcode 12](https://developer.apple.com/xcode/)
* [Swift 5](https://swift.org/blog/swift-5-released/)

### Dependency Management

#### CocoaPods
You have to install Cocoa pods in your machine like so:
```sh
sudo gem install cocoapods
```

To get started, move inside your WeatherApp folder and run
```sh
pod init
```

This creates a Podfile, which will hold all your dependencies in one place. Currently all dependencies are already added to podfile so you can run

```sh
pod install
```

### Project Structure

To keep all those hundreds of source files from ending up in the same directory, we used a folder structure in relation to the architecture used:

    ├─ ViewModels
    ├─ Views
    ├─ Controllers
    ├─ Networking Layer
    ├─ Supporting Files
    ├─ Common Files
    
  
## Architecture
* [Model-View-ViewModel (MVVM)][mvvm]
 * Motivated by "massive view controllers": MVVM considers `UIViewController` subclasses part of the View and keeps them slim by maintaining all state in the ViewModel.
 * To learn more about it, check out Bob Spryn's [fantastic introduction][sprynthesis-mvvm].

## Building

This section contains an overview of this topic — please refer here for more comprehensive information:

- [iOS Developer Library: Xcode Concepts][apple-xcode-concepts]
- [Samantha Marshall: Managing Xcode][pewpew-managing-xcode]

[apple-xcode-concepts]: https://developer.apple.com/library/ios/featuredarticles/XcodeConcepts/
[pewpew-managing-xcode]: http://pewpewthespells.com/blog/managing_xcode.html
  
<!-- CONTACT -->
## Contact

KEVIN SIUNDU - [@linkedIn](https://www.linkedin.com/in/kevin-siundu-506b2a162/) - siundu344@gmail.com

Project Link: [https://github.com/rahmakevo/WeatherApp](https://github.com/rahmakevo/WeatherApp)
