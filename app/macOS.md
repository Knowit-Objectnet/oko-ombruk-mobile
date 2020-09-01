

# Environment setup on macOS


## Flutter SDK


### Download

Flutter v1.20.2: [flutter_macos_1.20.2-stable.zip](https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.20.2-stable.zip).
or find the latest version: [Get started with flutter, macOS](https://flutter.dev/docs/get-started/install/macos) / [GitHub](https://github.com/flutter/flutter).


### Extract and move

Extract the SDK folder and place it under `/usr/local/bin`.

```bash
unzip flutter_macos_1.20.2-stable.zip
mv flutter /usr/local/bin
```


### Persistent `$PATH`

Use the rc file to keep the `$PATH` persistent.

For `zsh` use `~/.zshrc`. For `bash` use `~/.bashrc` or `~/.bash_profile`.
If the file doesn't exists, create it.

```bash
export PATH="$PATH:/usr/local/bin/flutter/bin"
```


<br><br>

## iOS SDK

Required to build and run for iOS.

### Flutter doctor

Change the current directory to the project repo and run the flutter doctor.

```bash
cd OKO/ombruk-mobil		
flutter doctor
```


### Xcode

#### Download

[Download the latest version of Xcode from the App Store](https://apps.apple.com/no/app/xcode/id497799835).

#### First launch

Open Xcode and agree to install the components (Xcode prompts you automatically when you open it for the first time).

Once the component installation is complete you can run the first launch command (reported by flutter doctor)

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```
(note the Xcode directory is the default one if you installed it through the App Store)


### CocoaPods

Flutter depends on CocoaPods for its plugins on iOS or macOS.

```bash
sudo gem install cocoapods
```

### Android Studio / IntelliJ IDEA Community Edition

TBA. Please refer to the [documentation for Android Studio and IntelliJ](https://flutter.dev/docs/development/tools/android-studio).

<br>

## Android SDK

Required to build and run for Android.
TBA.

<br>

## IDE


### Xcode

#### Download

Should already be installed.

#### Build and run

##### iOS simulator

- Open the Xcode workspace project `OKO/ombruk-mobile/app/ios/Runner.xcworkspace`.
- Choose the target scheme and simulator device.
- Run the project (`⌘R`).

### VSCode

#### Download

[VSCodium](https://vscodium.com/) (privacy enhanced) (or download the regular [VSCode](https://code.visualstudio.com/)).

#### Extensions

- [Flutter](https://open-vsx.org/extension/Dart-Code/flutter).
- [Dart](https://open-vsx.org/extension/Dart-Code/dart-code).
    - (Dart should auto-install when installing the Flutter extension)

#### Build and run

##### iOS simulator

- Start the IDE and open `main.dart`.
- Run and debug (`F5`) from VSCode.

##### Android emulator

TBA.


<br>

## Build and run without IDE

### iOS simulator

- Change current directory to `OKO/ombruk-mobile/app`.
- Run the `iOS-simulator.sh` script and choose the desired device.
- Run `flutter run`.

### Android emulator

TBA.
