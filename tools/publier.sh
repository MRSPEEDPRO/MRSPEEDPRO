#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Publie « 🌿 Méditation Biblique » dans son propre dépôt GitHub.
#
#   Usage :  bash tools/publier.sh [utilisateur/depot]
#   Défaut :  MRSPEEDPRO/meditation-biblique
#
# Le dépôt de destination doit exister et être VIDE (créé sans README,
# sans .gitignore et sans licence).
#
# Ce script ne touche ni au dépôt courant, ni à son historique : il assemble
# une copie propre dans un dossier temporaire, puis la pousse.
# ---------------------------------------------------------------------------
set -euo pipefail

DEPOT="${1:-MRSPEEDPRO/meditation-biblique}"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "🌿 Publication de Méditation Biblique"
echo "   source      : $SRC"
echo "   destination : https://github.com/$DEPOT"
echo

# 1. Reconstruire index.html pour être sûr qu'il est à jour
if command -v python3 >/dev/null 2>&1; then
  echo "→ Reconstruction de index.html…"
  (cd "$SRC" && python3 build.py)
fi

# 2. Copier les fichiers du projet (sans le README de profil GitHub,
#    sans node_modules ni historique git)
echo "→ Préparation des fichiers…"
cd "$SRC"
for f in index.html build.py package.json LICENSE .gitignore \
         src data tools test_smoke.js; do
  [ -e "$f" ] && cp -r "$f" "$TMP/"
done

# 3. MEDITATION.md devient le README du nouveau dépôt
cp "$SRC/MEDITATION.md" "$TMP/README.md"
rm -f "$TMP/tools/publier.sh"

# 4. Historique neuf et propre
cd "$TMP"
git init -q -b main
git add -A
git -c user.name="MRSPEEDPRO" -c user.email="mrspeedpro@users.noreply.github.com" \
    commit -q -m "🌿 Méditation Biblique 1.2.0

Application web de méditation biblique quotidienne, 100 % hors-ligne,
en un seul fichier index.html. Bible Louis Segond 1910 (domaine public).

- verset du jour (247 versets) et méditation personnalisée
- lecteur plein écran : surlignage, sélection, reprise de lecture
- profil local, 11 plans de lecture, 19 thèmes, journal, favoris
- recherche dans les 31 170 versets, écoute audio, partage
- 300 vérifications automatiques (jsdom)"

echo "→ Envoi vers GitHub…"
git remote add origin "https://github.com/$DEPOT.git"
git push -u origin main

echo
echo "✅ Publié : https://github.com/$DEPOT"
echo
echo "Pour mettre l'application en ligne :"
echo "   Settings → Pages → Source : « Deploy from a branch » → main / (root) → Save"
echo "   Puis, après une minute :"
echo "   https://${DEPOT%%/*}.github.io/${DEPOT##*/}/"
