#Universities App
## Stack
 
| Tecnología | Uso |
|---|---|
| Flutter + Dart | Framework principal |
| Provider | Manejo de estado |
| http | Network requests |
| image_picker | Selección de imágenes |

##Arquitectura 
El proyecto sigue el patrón **MVVM** (Model - View - ViewModel):
 
```
lib/
├── main.dart
├── models/
│   └── university.dart
├── services/
│   └── university_service.dart
├── viewmodels/
│   └── university_viewmodel.dart
└── views/
    ├── list/
    │   └── university_list_screen.dart
    └── detail/
        └── university_detail_screen.dart
```
##Correr proyecto

```bash
# Instalar dependencias
flutter pub get
 
# Correr la app
flutter run
```
