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

To keep all those hundreds of source files from ending up in the same directory, it's a good idea to set up some folder structure depending on your architecture. For instance, you can use the following:

    ├─ Models
    ├─ Views
    ├─ Controllers (or ViewModels, if your architecture is MVVM)
    ├─ Stores
    ├─ Helpers

First, create them as groups (little yellow "folders") within the group with your project's name in Xcode's Project Navigator. Then, for each of the groups, link them to an actual directory in your project path by opening their File Inspector on the right, hitting the little gray folder icon, and creating a new subfolder with the name of the group in your project directory.
  
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

Your Name - [@linkedIn](https://www.linkedin.com/in/kevin-siundu-506b2a162/) - siundu344@gmail.com

Project Link: [https://github.com/rahmakevo/WeatherApp](https://github.com/rahmakevo/WeatherApp)
