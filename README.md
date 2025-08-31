# RadioBuilder

A customizable and flexible **Radio Button builder for Flutter**. 🚀

This package allows you to easily build and manage radio button groups with full customization, adaptive design, and integration with Material widgets. Perfect for building settings screens, forms, surveys, or any place where radio selection is required.

---

## ✨ Features

* 📦 **Generic RadioBuilder<T>** – works with any data type.
* 🎨 **Customizable UI** – use your own builder or default styling.
* 📱 **Adaptive Widgets** – Material & Cupertino style support.
* 🖱️ **Hover & Focus Support** – works with mouse and keyboard.
* 🧩 **Scrollable Lists** – vertical and horizontal directions supported.
* ⚡ **Lightweight & Fast** – built purely with Flutter widgets.
* 🌐 **Web, Android, iOS, Desktop** supported.

---

## 📥 Installation

Add dependency in your `pubspec.yaml`:

```yaml
dependencies:
  # flutter_radio_builder
  flutter_radio_builder:
    git:
      url: https://github.com/uur-dev/flutter_radio_builder
      ref: main
      path: flutter_radio_builder
```

Then run:

```bash
flutter pub get
```

Import in your Dart code:

```dart
import 'package:flutter_radio_builder/flutter_radio_builder.dart';
```

---

## 🚀 Usage

### Basic Example

```dart
RadioBuilder<String>(
      list: options, // list of items <T> type
      scrollEnabled: false, // disable scrolling,
      defaultTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.deepPurple,
      ), // label text style
      optionTextBuilder: (item, index) => options[index], // text for label
      onSelectionChanged: (selectedItem, index) {
        /// option selection changed
        print("Radio Option : $selectedItem Selected");
      },
    );
```

### With Custom UI

```dart
RadioBuilder<String>(
      list: options, // list of items <T> type
      scrollEnabled: false, // disable scrolling
      radioStyle: RadioStyle(
        isAdaptive: _adativeNotfier.value,
        hoverEffect: _hoverEffect.value,
        hoverEffectFactor: 0.96,
      ),
      builder: (context, item, index, radio, checked) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: index < 2 ? radio : null,
              trailing: index >= 2 ? radio : null,
              title: Text(
                item,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      },
      onSelectionChanged: (selectedItem, index) {
        /// option selection changed
        print("Radio Option : $selectedItem Selected");
      },
    );
```

---

## 📱 CheckBox Builder

```dart
CheckBoxBuilder<String>(
  list: options,
  errorForItem: (index, value) {
    return (index % 2) == 0; // error only on even index
  },
  checkBoxStyle: CheckBoxStyle(isError: true),
  builder: (context, item, index, checkbox, checked) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: checkbox,
          title: Text(
            item,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.purple,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  },
)
```

---

## 🛠️ Build APK / Web

### Build Debug APK

```bash
flutter build apk --debug
```

### Build Web

```bash
flutter build web
```

Then open in browser:

```bash
flutter run -d chrome
```

---

## 🌍 Platform Support

* ✅ Android
* ✅ iOS
* ✅ Web
* ✅ macOS / Windows / Linux

---

## 📜 License

MIT License. Free to use and modify.

---

## 👨‍💻 Author

Built with ❤️ by [Ubaid ur Rahman](https://github.com/uur-dev/)

---

## 🙌 Contributing

Contributions are welcome! Please fork the repo and create a PR.

---

## ⭐ Support

If you like this package, give it a star ⭐ on [GitHub](https://github.com/uur-dev/radiobuilder)! 🚀
