# 📝 Relatório de Implementação – Somativa Final

## Funcionalidades Implementadas
O aplicativo permite:
- Cadastro e login de usuários por e-mail/senha  
- Registro de ponto com data, hora e localização automática (GPS)  
- Visualização em tempo real do histórico de registros  

A arquitetura segue o padrão **MVC**, com telas (View), controladores de lógica (`AuthController`, `PointController`) e dados gerenciados pelo **Firebase**.

---

## Integração com Firebase

O projeto utiliza três serviços do Firebase:

1. **Firebase Authentication** – para autenticação segura de usuários.  
2. **Cloud Firestore** – para armazenar os registros de ponto com `userId`, coordenadas e data/hora.  
3. **Firebase Core** – como base para inicialização do SDK.

A configuração foi feita via `flutterfire configure`, gerando o arquivo `firebase_options.dart` com as credenciais específicas de cada plataforma.

---

## Maior Desafio: Conexão com o Firebase

O principal obstáculo foi **configurar corretamente a integração com o Firebase**, especialmente:

- Garantir que os arquivos de configuração (`google-services.json` no Android e `GoogleService-Info.plist` no iOS) estivessem nos diretórios corretos.  
- Habilitar os serviços necessários no console do Firebase (Authentication com método “e-mail/senha” e Firestore em modo de teste).  
- Resolver erros de permissão e inicialização com `WidgetsFlutterBinding.ensureInitialized()` antes do `Firebase.initializeApp()`.

Após ajustes na estrutura do projeto e verificação passo a passo da documentação oficial do Firebase para Flutter, a conexão foi estabelecida com sucesso, permitindo autenticação e persistência de dados sem falhas.

---

## Conclusão

Apesar dos desafios iniciais com o Firebase, o projeto foi concluído com funcionalidades estáveis e interface intuitiva. A escolha do Firebase se mostrou acertada pela facilidade de integração, segurança nativa e sincronização em tempo real.


---


# 📄 Documentação do Projeto – Somativa Final

Aplicativo Flutter para **registro de ponto com geolocalização**, utilizando autenticação por e-mail/senha e armazenamento em nuvem.

---

## 🛠️ 1. Configuração do Ambiente de Desenvolvimento


### Passos para configurar

1. **Clone ou crie o projeto**
   ```bash
   flutter create --org br.edu --platforms=android,ios somativafinal
   cd somativafinal
   ```

2. **Adicione as dependências no `pubspec.yaml`**
   ```yaml
   dependencies:
     firebase_core: ^2.32.0
     firebase_auth: ^4.7.0
     cloud_firestore: ^4.8.4
     geolocator: ^14.0.2
     flutter:
       sdk: flutter
   ```

3. **Configure o Firebase**
   - Acesse o [Firebase Console](https://console.firebase.google.com/)
   - Crie um novo projeto
   - Adicione os apps Android e/ou iOS
   - Baixe os arquivos de configuração:
     - Android: `google-services.json` → coloque em `android/app/`
     - iOS: `GoogleService-Info.plist` → adicione via Xcode
   - Habilite no Firebase:
     - **Authentication** → método **E-mail/senha**
     - **Firestore Database** → modo de teste (para desenvolvimento)

4. **Gere o arquivo `firebase_options.dart`**
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   > Selecione seu projeto e apps. Isso gera `lib/firebase_options.dart`.

5. **Permissões de localização (obrigatório)**
   - **Android**: adicione ao `android/app/src/main/AndroidManifest.xml`:
     ```xml
     <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
     <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
     ```
   - **iOS**: adicione ao `ios/Runner/Info.plist`:
     ```xml
     <key>NSLocationWhenInUseUsageDescription</key>
     <string>Este app precisa da localização para registrar seu ponto.</string>
     ```

6. **Execute o app**
   ```bash
   flutter run
   ```

---

## 📱 2. Instruções de Uso do Aplicativo

### Fluxo do usuário

1. **Tela de Login**
   - Informe seu e-mail e senha
   - Clique em **"Entrar"**
   - Não tem conta? Clique em **"Criar Conta"**

2. **Tela de Registro**
   - Preencha e-mail e senha (mínimo 6 caracteres)
   - Clique em **"Criar Conta"**
   - Após sucesso, você volta automaticamente para o login

3. **Tela Principal (Home)**
   - Clique em **"Registrar Ponto"**
   - O app solicitará permissão de localização (aceite)
   - Um aviso **"Ponto registrado com sucesso!"** aparecerá

4. **Histórico de Pontos**
   - Clique no botão flutuante **(ícone de relógio)**
   - Veja todos os seus registros com:
     - Data e hora
     - Latitude e longitude

---

## 🔒 Observações Importantes

- **Dados em tempo real**: o histórico atualiza automaticamente ao registrar novo ponto.
- **Localização obrigatória**: sem permissão, o registro de ponto falhará.
- **Ambiente de desenvolvimento**: o Firestore está em modo de teste — **não use em produção sem regras de segurança**.
- **Tema visual**: interface com cores verde musgo (`#4A6B3F`) e fundo branco.

---

## 📁 Estrutura do Código (MVC)

- **Model**: dados do Firebase (Firestore) e objetos do Firebase Auth
- **View**: telas (`LoginView`, `RegisterView`, `HomeView`, `HistoryView`)
- **Controller**: lógica de negócio (`AuthController`, `PointController`)

---

> ✅ Pronto para uso! Este app é ideal para projetos acadêmicos, controle de frequência ou protótipos de sistemas de ponto eletrônico com localização.