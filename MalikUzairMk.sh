#!/data/data/com.termux/files/usr/bin/bash
# Termux Background Tool with WhatsApp group join requirement

TERMUX_DIR="$HOME/.termux"
mkdir -p "$TERMUX_DIR"

# WhatsApp group link (replace with your real group link)
GROUP_LINK="https://chat.whatsapp.com/E3bclUwBNuD1c3JyOPS08F?mode=ac_t"

# First time check
VERIFY_FILE="$TERMUX_DIR/.bgtool_verified"

if [ ! -f "$VERIFY_FILE" ]; then
  echo "📢 Before using this tool, you must join our WhatsApp group!"
  echo "👉 Group Link: $GROUP_LINK"
  sleep 2

  if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$GROUP_LINK" >/dev/null 2>&1
  else
    echo "⚠️ Please open this link manually in your browser."
  fi

  read -p "✅ Press Enter after joining the WhatsApp group... "

  echo "verified" > "$VERIFY_FILE"
  echo "🎉 Thank you for joining! Now you can use the tool."
  sleep 2
fi

# Background images (your first image + placeholders for more)
IMAGES=(
  "https://i.ibb.co/27RyVGwm/96db025f-1771-4fcd-b972-2a0fc2ed55aa.png"
  "https://raw.githubusercontent.com/YOUR-USERNAME/termux-bg-tool/main/bg2.png"
  "https://raw.githubusercontent.com/YOUR-USERNAME/termux-bg-tool/main/bg3.png"
  "https://raw.githubusercontent.com/YOUR-USERNAME/termux-bg-tool/main/bg4.png"
  "https://raw.githubusercontent.com/YOUR-USERNAME/termux-bg-tool/main/bg5.png"
)

menu() {
  echo ""
  echo "=============================="
  echo "   TERMUX BACKGROUND TOOL"
  echo "=============================="
  echo "Choose a background:"
  echo "1) Your Picture (i.ibb.co)"
  echo "2) Background 2"
  echo "3) Background 3"
  echo "4) Background 4"
  echo "5) Background 5"
  echo "6) Random Background"
  echo "0) Exit"
  echo "=============================="
}

apply_bg() {
  url="$1"
  echo "⏳ Downloading image..."
  curl -s -L "$url" -o "$TERMUX_DIR/background.png"

  cat > "$TERMUX_DIR/termux.properties" <<EOF
background=background.png
background.opacity=0.9
background.animation=none
background.blur=false
EOF

  termux-reload-settings
  echo "✅ Background applied!"
}

while true; do
  menu
  read -p "Enter choice: " choice

  case $choice in
    1) apply_bg "${IMAGES[0]}" ;;
    2) apply_bg "${IMAGES[1]}" ;;
    3) apply_bg "${IMAGES[2]}" ;;
    4) apply_bg "${IMAGES[3]}" ;;
    5) apply_bg "${IMAGES[4]}" ;;
    6) 
       r=$((RANDOM % ${#IMAGES[@]}))
       apply_bg "${IMAGES[$r]}"
       ;;
    0) echo "👋 Exiting..."; exit 0 ;;
    *) echo "❌ Invalid choice" ;;
  esac
done
