# Nova AI - Installation sur Windows (sans Mac)

Ce guide explique comment construire et installer le fichier `.ipa` sur iPhone depuis un PC Windows.

## Méthode 1 : Build automatique via GitHub Actions (Recommandée)

GitHub fournit gratuitement des runners macOS pour compiler des projets iOS. Vous n'avez besoin d'aucun Mac.

### Étapes

1. **Forkez ce dépôt** sur GitHub (bouton Fork en haut à droite)

2. **Déclenchez le build :**
   - Allez dans l'onglet **Actions** de votre fork
   - Sélectionnez **Build iOS .ipa (Auto-sign)** dans la liste des workflows
   - Cliquez sur **Run workflow**
   - Attendez ~5-10 minutes que le build se termine

3. **Téléchargez le .ipa :**
   - Une fois le build terminé, cliquez dessus
   - Téléchargez l'artifact `NovaAI-unsigned.ipa`

4. **Installez le .ipa sur votre iPhone** (voir section ci-dessous)

## Méthode 2 : Build avec signature (App Store / TestFlight)

Pour une app signée avec votre identifiant Apple Developer :

### Préparer les secrets GitHub

1. Obtenez votre certificat de développement Apple (.p12) depuis [Apple Developer](https://developer.apple.com)
2. Obtenez votre provisioning profile (.mobileprovision)
3. Ajoutez ces secrets dans votre dépôt GitHub :
   - Settings > Secrets and variables > Actions
   - `BUILD_CERTIFICATE_BASE64` : contenu du .p12 encodé en base64
   - `P12_PASSWORD` : mot de passe du .p12
   - `PROVISIONING_PROFILE_BASE64` : provisioning profile encodé en base64

4. Déclenchez le workflow **Build iOS .ipa** (le premier)

### Sur Windows, pour encoder en base64 :
```powershell
# Certificat
[Convert]::ToBase64String([IO.File]::ReadAllBytes("certificate.p12"))

# Provisioning profile
[Convert]::ToBase64String([IO.File]::ReadAllBytes("profile.mobileprovision"))
```

## Installation du .ipa sur iPhone depuis Windows

### Option A : Sideloadly (Gratuit, recommandé)

1. Téléchargez [Sideloadly](https://sideloadly.io/) pour Windows
2. Installez et lancez Sideloadly
3. Branchez votre iPhone en USB
4. Glissez le fichier `.ipa` dans Sideloadly
5. Entrez votre identifiant Apple (compte gratuit OK)
6. Cliquez sur **Start**
7. Sur votre iPhone : Paramètres > Général > VPN et gestion de l'appareil > faites confiance au développeur

### Option B : 3uTools (Gratuit)

1. Téléchargez [3uTools](https://www.3u.com/) pour Windows
2. Branchez votre iPhone en USB
3. Allez dans **Applications** > **Importer et installer .ipa**
4. Sélectionnez le fichier `.ipa` téléchargé

### Option C : AltStore (Gratuit)

1. Téléchargez [AltServer](https://altstore.io/) pour Windows
2. Installez AltServer et AltStore sur votre iPhone
3. Utilisez AltStore pour installer le `.ipa`

## Notes importantes

- Avec un compte Apple **gratuit** : l'app expire après 7 jours, il faut la réinstaller
- Avec un compte Apple **Developer** (99$/an) : l'app reste installée 1 an
- L'app charge l'application web Nova AI via une WebView — elle nécessite une connexion internet
- Pour modifier l'URL de l'app, éditez `nova-ios/NovaAI/Source/ViewController.swift`

## Structure du dépôt

```
├── .github/workflows/
│   ├── build-ipa.yml              # Build avec signature (nécessite secrets)
│   └── build-unsigned-ipa.yml     # Build sans signature (auto, prêt à sideloader)
├── nova-ios/
│   ├── NovaAI.xcodeproj/          # Projet Xcode
│   ├── NovaAI/
│   │   ├── Source/
│   │   │   ├── AppDelegate.swift
│   │   │   └── ViewController.swift
│   │   └── Info.plist
│   └── ExportOptions.plist
└── README.md
```
