# 📸 Galeria Geolocalizada – Aplicativo Flutter

> Registra fotos com data, hora e localização. Toque na foto para ver os metadados.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Geolocator](https://img.shields.io/badge/Geolocator-000000?style=for-the-badge)
![Platform](https://img.shields.io/badge/Android%20%7C%20iOS-4CAF50?style=for-the-badge)

---

## 🎯 Objetivo

Aplicativo móvel em Flutter que permite ao usuário:

- Tirar fotos usando a câmera do dispositivo.
- Registrar automaticamente:
  - **Data e hora** da captura
  - **Localização geográfica** (latitude e longitude)
- Visualizar as fotos em uma galeria
- Ao tocar em uma foto, exibir seus metadados completos

---

## ⚙️ Tecnologias e Pacotes

| Pacote | Função |
|--------|--------|
| `camera` | Captura de imagens via câmera |
| `geolocator` | Obtenção da localização GPS em tempo real |
| `image_picker` | Seleção e exibição de imagens |
| `path_provider` | Acesso a diretórios locais para salvar fotos e dados |
| `permission_handler` | Gerenciamento de permissões (câmera, localização, armazenamento) |

---

## 📱 Funcionalidades Principais

✅ Captura de fotos com câmera  
✅ Registro automático de data/hora e coordenadas geográficas  
✅ Galeria visual com lista de fotos salvas  
✅ Tela de detalhes ao clicar em uma foto: mostra data, hora e local  
✅ Persistência local dos dados (imagens + metadados)  

---

## 📦 Estrutura de Arquivos (Simplificada)

```
lib/
├── controller/
│   └── photo_controller.dart      # Lógica de captura, salvamento e leitura de fotos
├── models/
│   └── photo_model.dart           # Modelo de dados: imagem, data, hora, latitude, longitude
├── view/
│   ├── gallery_screen.dart        # Tela principal com lista de fotos
│   ├── photo_detail_screen.dart   # Tela de detalhes ao clicar em uma foto
│   └── main.dart                  # Ponto de entrada do app
```
---

## 🔐 Permissões Necessárias

### Android (`android/app/src/debug/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

## 💬 Contato

Desenvolvido por: **[Pietro Amorim Fernandes]**  
📧 Email: pietro.amorim.fernandes.2007@gmail.com  
🔗 GitHub: [github.com/Pietro-Amorim](https://github.com/Pietro-Amorim)
