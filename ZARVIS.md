# ZARVIS — Assistant personnel autonome 100 % hors-ligne

> **Z.A.R.V.I.S.** — *Zone Autonome de Réponse Vocale et d'Interface Système*
> Interface futuriste inspirée des tableaux de bord de science-fiction (style JARVIS).
> Application **totalement indépendante** : un seul fichier `zarvis.html`, à côté du reste du dépôt, sans toucher à aucune autre application.

---

## 🚀 Lancement

ZARVIS ne nécessite **aucun serveur, aucune installation, aucune clé API, aucune connexion**.

### Option 1 — Ouverture directe (le plus simple)
Double-cliquez sur **`zarvis.html`** : il s'ouvre dans votre navigateur et tout fonctionne, même en `file://`.

### Option 2 — Petit serveur local (optionnel)
```bash
# Depuis la racine du dépôt :
python3 -m http.server 8000
# puis ouvrez : http://localhost:8000/zarvis.html
```
ou
```bash
npx serve .
```

### Compatibilité
Tout navigateur moderne (Chrome, Edge, Firefox, Safari), ordinateur **et** téléphone. L'interface est responsive.

---

## 🔒 Garantie hors-ligne

| Garantie | Détail |
|---|---|
| Aucun backend | Aucun serveur d'application |
| Aucune clé API | Rien à configurer, jamais |
| Aucun appel réseau | Pas de `fetch`, pas de `XMLHttpRequest`, pas de WebSocket |
| Aucune dépendance | Zéro CDN, zéro fonte/JS/CSS externe, zéro npm |
| Calculatrice sûre | Analyseur maison, **sans `eval()`** |
| Anti-injection | Tout affichage passe par `textContent` (jamais `innerHTML`) |
| Données locales | `localStorage` uniquement, préfixe `zrv_`, sur votre appareil |
| Historique | En `sessionStorage` : mémoire de la session, effacée à la fermeture de l'onglet |

> La **reconnaissance vocale** (bouton 🎙) dépend du navigateur (`SpeechRecognition`) et peut, selon celui-ci, utiliser un service réseau du navigateur. Tout le reste — commandes texte, tâches, notes, minuteur, calculatrice — fonctionne **même avion mode activé**. Si la voix est indisponible, le champ texte reste pleinement fonctionnel.

---

## 🗣️ Commandes disponibles

Tapez `Aide` dans la console, ou touchez un protocole dans le panneau **Protocoles** pour le charger.

### Essentiel
| Commande | Effet |
|---|---|
| `Aide` | Liste des protocoles |
| `Qui es-tu ?` | Présentation de ZARVIS |
| `Je m'appelle [nom]` | Enregistre votre nom d'opérateur (profil local) |
| `Quel est mon nom ?` | Rappelle votre nom |

### Temps
| Commande | Effet |
|---|---|
| `Quelle heure est-il ?` | Heure locale |
| `Quelle est la date ?` | Date complète en français |

### Tâches (persistées dans `localStorage`)
| Commande | Effet |
|---|---|
| `Ajoute une tâche préparer le dossier` | Ajoute la tâche « préparer le dossier » |
| `Mes tâches` | Affiche toutes les tâches (en cours / terminées) |
| `Termine la tâche 1` | Valide la tâche n° 1 |

### Notes (persistées dans `localStorage`)
| Commande | Effet |
|---|---|
| `Note : appeler maman` | Enregistre la note |
| `Mes notes` | Affiche toutes les notes |

### Outils
| Commande | Effet |
|---|---|
| `Calcule 12 × 4` | Calculatrice sécurisée : `+ - × ÷ * / ^ % ( )`, décimaux `,` ou `.` |
| `Minuteur 5 minutes` | Lance un compte à rebours visible (annonce + bip à la fin) |
| `Annule le minuteur` | Stoppe le minuteur (ou cliquez sur la puce ⏱ du bandeau) |
| `Donne-moi une idée` | Tire une idée du réservoir local |

### Système & modules
| Commande | Effet |
|---|---|
| `Scanne le système` | Diagnostic visuel complet (stockage, voix, batterie…) |
| `Mode sombre` / `Mode clair` | Change le thème (persisté) |
| `Ouvre les tâches` / `Ouvre les notes` / `Ouvre les protocoles` | Affiche le module dans le panneau de données |

### Voix
| Commande | Effet |
|---|---|
| `Active la voix` | Réactive la synthèse vocale (si le navigateur la propose) |
| `Silence` | Coupe immédiatement la voix — le texte reste disponible |

Bonus : `Salut`, `Merci`, `Désactive la voix`, `Bascule le thème`, `Efface la console`.

---

## 🖥️ Interface

- **Noyau central animé** (canvas 2D) : anneaux contra-rotatifs, balayage radar, particules orbitales, pulsation synchronisée avec la parole.
- **Console de conversation** : messages de l'opérateur et de ZARVIS, historique de session, effet « machine à écrire ».
- **Sidebar modules** (desktop) / barre du bas (mobile) : Tâches, Notes, Protocoles, Système, Profil.
- **Panneau de données** : onglets des modules + télémétrie (uptime, tâches, notes, minuteur) et diagnostic système.
- **Bandeau supérieur** : horloge, état hors-ligne, puce minuteur cliquable, boutons voix / micro / thème.
- Profil : export JSON complet de vos données (Blob local) et réinitialisation d'un clic.

## ♿ Accessibilité

- **Clavier** : tout est un vrai `<button>`/`<input>` ; `Entrée` envoie, `↑`/`↓` rappellent les commandes, `Ctrl+K` ou `/` focalise la saisie, `Échap` ferme le panneau, lien d'évitement présent, focus visible marqué.
- **Lecteurs d'écran** : console en `role="log" aria-live="polite"`, texte intégral dupliqué en accessible, canvas décoratif masqué avec description textuelle.
- **`prefers-reduced-motion`** : noyau figé en image fixe, animations et effet machine à écrire désactivés, scan instantané.
- **Thèmes** : sombre par défaut (ou selon `prefers-color-scheme` à la première visite), mode clair complet, contrastes vérifiés.

## 📁 Données & vie privée

Tout est stocké **localement**, rien ne quitte l'appareil :

| Clé `localStorage` | Contenu |
|---|---|
| `zrv_tasks` | Tâches (texte, état, date) |
| `zrv_notes` | Notes |
| `zrv_profile` | Nom d'opérateur |
| `zrv_theme` | Préférence de thème |
| `zrv_voice` | Préférence voix |
| `zrv_timer` | Minuteur en cours |
| `zrv_history` *(sessionStorage)* | Historique de la session |

Réinitialisation : module **Profil → ⟲ Réinitialiser ZARVIS**, ou videz le stockage du site dans le navigateur.

## 🧱 Architecture

- `zarvis.html` — application complète monofichier (HTML + CSS + JS embarqués, commentés).
- `ZARVIS.md` — cette documentation.
- Le noyau JS isole un **bloc de fonctions pures** (calculatrice, analyse des durées, normalisation) entre `/*__PURE_START__*/` et `/*__PURE_END__*/`, testable sans navigateur.
- Isolation totale : aucune modification des autres fichiers du dépôt.

## ⚠️ Limites connues

- La reconnaissance vocale nécessite Chrome/Edge (technologie navigateur) et éventuellement une connexion selon le navigateur ; la synthèse vocale dépend des voix installées sur l'appareil.
- L'historique est volontairement **de session** ; les tâches/notes/profil, eux, sont persistants.
- Les barres de « télémétrie » du module Système sont décoratives (étiquetées *simulé*) ; les statistiques réelles (batterie, mémoire JS, stockage) sont affichées quand le navigateur les expose.
