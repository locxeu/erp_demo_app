# erp_demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Application demo:



https://github.com/user-attachments/assets/06658760-1daa-423d-adbe-bce9b7328f19



## Project Structure overview
Separation-of-concerns is the most important principle to follow when designing your Flutter app. Your Flutter application should split into two broad layers, the UI layer and the Data layer.

Each layer is further split into different components, each of which has distinct responsibilities, a well-defined interface, boundaries and dependencies. This guide recommends you split your application into the following components:

- Views
- View models
- Repositories
- Services

```bash
lib
|____ui
| |____core
| | |____ui
| | | |____<shared widgets>
| | |____themes
| |____<FEATURE NAME>
| | |____view_model
| | | |_____<view_model class>.dart
| | |____widgets
| | | |____<feature name>_screen.dart
| | | |____<other widgets>
|____domain
| |____models
| | |____<model name>.dart
|____data
| |____repositories
| | |____<repository class>.dart
| |____services
| | |____<service class>.dart
| |____model
| | |____<api model class>.dart
|____config
|____utils
|____routing
|____main_staging.dart
|____main_development.dart
|____main.dart
```
