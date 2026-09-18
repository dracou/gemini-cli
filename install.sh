#!/usr/bin/env bash
set -e

REPO="dracou/gemini-cli"
DEB_URL=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | jq -r '.assets[] | select(.name | endswith(".deb")) | .browser_download_url')

if [ -z "$DEB_URL" ] || [ "$DEB_URL" = "null" ]; then
echo "Erreur : paquet .deb introuvable sur la derniere release." >&2
exit 1
fi

TMP_DEB=$(mktemp --suffix=.deb)
echo "Téléchargement de la dernière version..."
curl -sL "$DEB_URL" -o "$TMP_DEB"

echo "Installation..."
sudo apt install -y "$TMP_DEB"
rm -f "$TMP_DEB"

echo "Installation terminée ! Tape 'gemini' pour commencer."
