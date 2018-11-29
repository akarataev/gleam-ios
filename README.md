<h1 align="center">
  <img src="Docs/Icon.png" width="150" alt="icon">
  <br>Gleam for iOS<br>
  <p align="center">
    <img src="https://img.shields.io/badge/Language-Swift-blue.svg">
    <a href="LICENSE.md"><img src="https://img.shields.io/badge/License-MIT-brightgreen.svg"></a>
    <img src="https://img.shields.io/badge/Event-VK Hackathon 2018-orange.svg">
  </p>
</h1>
<p align="center">Skin cancer screening app.</p>
<br><br>
<p align="center"><img src="Docs/Mockup.png" width="1000"></p>

## About Gleam

Skin cancer is in third place in terms of the incidence of oncology detection in Russian men and second in women. The five-year threshold is experienced by only half of the patients. Even with the second stage of melanoma and with proper treatment. Therefore, an early production diagnosis is practically the only way to get a favorable prognosis for treatment. The solution could be a mobile application, with which you can make an early diagnosis and promptly seek treatment. A detailed description of the problem and its solution can be found in my article.: [CoreML vs Skin cancer](http://cocoa-beans.ru/technology/coreml-protiv-raka-kozhi/).


## Dataset

To train this model the data to use is a set of images from the International Skin Imaging Collaboration: [Mellanoma Project ISIC](https://isic-archive.com).

### Preprocessing

The following preprocessing tasks are developed for each image:

1. Visual inspection to detect images with low quality
1. Image resizing: Transform images to 255x256x3
1. Crop images


### Download model

You can get acquainted with the results of the training model in this [repository](https://github.com/akarataev/gleam-model).


## Contributing

### Bug Reports & Feature Requests
Please use GitHub issues to report any bugs or file feature requests. If you want fix it yourself or suggest a new feature, feel free to send in a pull request.
For any bugs please include the following information:
- The iOS version of the device
- The model of the device (iPhone 7 plus, iPhone X etc)
- If you are running the App Store version of the app or a version that you've compiled yourself
- The fork or branch used if you've compiled the app yourself

### Pull requests

Pull requests should include information about what has been changed. Also, try to include screenshots or links to issues in order to better review the pull request.


## Requirements

In order to compile Gleam you will need to meet the following requirements:
```
- A Mac with Xcode 8.1 or later
- Git command line tools or a git source control client like GitKraken.
- Cocoapods as dependency manager for Swift and Objective-C Cocoa projects.
```


## License

Gleam is available under the MIT license. See the [LICENSE.md](LICENSE.md) file for more info.
