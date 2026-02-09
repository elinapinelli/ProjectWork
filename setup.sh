#!/bin/bash

###############################################################################
# Setup Script per macOS/Linux
# Configura automaticamente il progetto (Backend + Frontend)
###############################################################################

set -e  # Esci se c'è un errore

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║          🚀 Setup Automatico - Progetto SupportApi             ║"
echo "║                 (macOS/Linux)                                  ║"
echo "╚════════════════════════════════════════════════════════════════╝"

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

###############################################################################
# 1. Verifica Prerequisiti
###############################################################################
echo ""
echo -e "${BLUE}▶ Fase 1: Verifica dei prerequisiti...${NC}"
echo ""

check_command() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}❌ $2 non trovato. Installalo prima di continuare.${NC}"
        echo "   Scarica da: $3"
        exit 1
    else
        echo -e "${GREEN}✓ $1 trovato${NC}"
    fi
}

check_command "git" "Git" "https://git-scm.com/download/mac"
check_command "dotnet" ".NET SDK" "https://dotnet.microsoft.com/en-us/download/dotnet/10.0"
check_command "node" "Node.js" "https://nodejs.org/"
check_command "npm" "npm" "https://nodejs.org/"

echo ""
echo -e "${GREEN}✓ Tutti i prerequisiti sono installati!${NC}"

###############################################################################
# 2. Configurazione Git
###############################################################################
echo ""
echo -e "${BLUE}▶ Fase 2: Configurazione Git per line endings...${NC}"
echo ""

# Per macOS/Linux usiamo input
git config core.autocrlf input
echo -e "${GREEN}✓ Git configurato: core.autocrlf = input${NC}"

###############################################################################
# 3. Setup Backend (.NET)
###############################################################################
echo ""
echo -e "${BLUE}▶ Fase 3: Setup Backend (.NET)...${NC}"
echo ""

if [ ! -d "Backend/SupportApi" ]; then
    echo -e "${RED}❌ Cartella Backend/SupportApi non trovata!${NC}"
    exit 1
fi

cd Backend/SupportApi

echo "📦 Ripristino dipendenze NuGet..."
dotnet restore
echo -e "${GREEN}✓ Dipendenze NuGet ripristinate${NC}"

echo "🔨 Compilazione del progetto..."
dotnet build
echo -e "${GREEN}✓ Backend compilato con successo!${NC}"

cd ../..

###############################################################################
# 4. Setup Frontend (SPFx)
###############################################################################
echo ""
echo -e "${BLUE}▶ Fase 4: Setup Frontend (SharePoint Framework)...${NC}"
echo ""

if [ ! -d "Frontend" ]; then
    echo -e "${RED}❌ Cartella Frontend non trovata!${NC}"
    exit 1
fi

cd Frontend

echo "📦 Installazione dipendenze npm..."
npm install
echo -e "${GREEN}✓ Dipendenze npm installate${NC}"

cd ..

###############################################################################
# 5. Verifica Finale
###############################################################################
echo ""
echo -e "${BLUE}▶ Fase 5: Verifica finale...${NC}"
echo ""

# Test Backend
cd Backend/SupportApi
if dotnet build --no-restore -q 2>/dev/null; then
    echo -e "${GREEN}✓ Backend - OK${NC}"
else
    echo -e "${RED}⚠ Backend - Errore nella compilazione${NC}"
fi
cd ../..

# Test Frontend
cd Frontend
if npm --version > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Frontend - OK${NC}"
else
    echo -e "${RED}⚠ Frontend - Errore${NC}"
fi
cd ..

###############################################################################
# 6. Istruzioni Finali
###############################################################################
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo -e "${GREEN}║                   ✅ SETUP COMPLETATO!                   ║${NC}"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo -e "${YELLOW}📝 Prossimi passi:${NC}"
echo ""
echo "  Backend (.NET):"
echo "    cd Backend/SupportApi"
echo "    dotnet run"
echo "    → Server disponibile su https://localhost:5001"
echo ""
echo "  Frontend (SPFx):"
echo "    cd Frontend"
echo "    npm start"
echo "    → Server disponibile su http://localhost:4321"
echo ""
echo -e "${YELLOW}📚 Per ulteriore aiuto:${NC}"
echo "    Leggi SETUP.md"
echo ""
