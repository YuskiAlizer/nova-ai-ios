# Nova AI - Agent IA pour iPhone

Application IA intelligente fonctionnant sur iPhone, construisable en fichier `.ipa` **sans Mac**, depuis Windows.

## Démarrage rapide (Windows)

1. Forkez ce dépôt
2. Allez dans l'onglet **Actions** > **Build iOS .ipa (Auto-sign)** > **Run workflow**
3. Attendez ~5 min, téléchargez le `.ipa`
4. Installez-le avec [Sideloadly](https://sideloadly.io/) (gratuit sur Windows)

Voir [INSTALL-WINDOWS.md](INSTALL-WINDOWS.md) pour le guide complet.

## Contenu

- `nova-ios/` — Projet Xcode (app WKWebView chargeant l'IA)
- `.github/workflows/` — Build automatique du `.ipa` via GitHub Actions (runners macOS gratuits)
- `INSTALL-WINDOWS.md` — Guide d'installation depuis Windows

## Fonctionnalités

- Interface chat mobile optimisée
- Streaming des réponses en temps réel
- Mode sombre / clair
- Support markdown (code, listes, titres, liens)
- Installation sur écran d'accueil iPhone (PWA)
- Build `.ipa` sans Mac via GitHub Actions

## URL de l'app

L'app charge l'application web Nova AI. Pour pointer vers votre propre hébergement, modifiez `appURL` dans `nova-ios/NovaAI/Source/ViewController.swift`.

## Licence

MIT — libre d'utilisation et de modification.
