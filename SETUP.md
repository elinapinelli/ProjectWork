# 🚀 Project Setup Guide

Guida per configurare il progetto in locale. Segui le istruzioni per il tuo sistema operativo.

## 📋 Prerequisiti Globali

### Windows
- **Git**: [Scarica Git per Windows](https://git-scm.com/download/win)
- **.NET SDK 10**: [Scarica .NET SDK 10](https://dotnet.microsoft.com/en-us/download/dotnet/10.0)
- **Node.js** (v18+): [Scarica Node.js](https://nodejs.org/)
- **Visual Studio 2022** (opzionale ma consigliato): [Community Edition](https://visualstudio.microsoft.com/)

Dopo l'installazione, verifica i prerequisiti:
```cmd
git --version
dotnet --version
node --version
npm --version
```

### macOS
```bash
# Installa Homebrew se non lo hai
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installa i prerequisiti
brew install git
brew install dotnet
brew install node

# Verifica
git --version
dotnet --version
node --version
npm --version
```

### Linux (Ubuntu/Debian)
```bash
# Update package manager
sudo apt update

# Installa Git
sudo apt install git

# Installa .NET SDK 10
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --version latest

# Installa Node.js
sudo apt install nodejs npm

# Verifica
git --version
dotnet --version
node --version
npm --version
```

---

## ⚙️ Setup Automatico

Esegui lo script di setup per il tuo sistema operativo qui sotto. Questo configurerà tutto automaticamente.

### Windows
Apri **Command Prompt (cmd.exe)** o **PowerShell** nella cartella del progetto e esegui:
```cmd
setup.bat
```

### macOS / Linux
Apri **Terminal** nella cartella del progetto e esegui:
```bash
chmod +x setup.sh
./setup.sh
```

---

## 📝 Setup Manuale (se gli script non funzionano)

### 1️⃣ Configura Git (IMPORTANTE per collaborazione)

**Tutti i sistemi operativi:**
```bash
# Configurazione line endings (Windows)
git config core.autocrlf true

# Configurazione line endings (macOS/Linux)
git config core.autocrlf input

# Verifica la configurazione
git config core.autocrlf
```

### 2️⃣ Setup Backend (.NET)

```bash
cd Backend/SupportApi

# Ripristina le dipendenze NuGet
dotnet restore

# Compila il progetto
dotnet build

# (Opzionale) Esegui il progetto
dotnet run
```

Il backend sarà disponibile su `https://localhost:5001`

### 3️⃣ Setup Frontend (SharePoint Framework)

```bash
cd Frontend

# Installa le dipendenze npm
npm install

# Avvia il server di sviluppo
npm start
```

Il frontend sarà disponibile su `http://localhost:4321`

---

## 🔄 Comandi Comuni

### Frontend (SPFx)
```bash
cd Frontend

# Installa/aggiorna dipendenze
npm install

# Avvia il development server
npm start

# Build per la produzione
npm run build

# Esegui i linter
npm run lint
```

### Backend (.NET)
```bash
cd Backend/SupportApi

# Ripristina dipendenze
dotnet restore

# Compila il progetto
dotnet build

# Esegui il progetto
dotnet run

# Esegui i test (se disponibili)
dotnet test
```

---

## 🐛 Troubleshooting

### "dotnet is not recognized" (Windows)
- Assicurati di aver installato .NET SDK 10
- Windows richiede il riavvio dopo l'installazione
- Riavvia il terminale dopo l'installazione

### "npm: command not found" (macOS/Linux)
```bash
# Se Homebrew installato:
brew install node

# Oppure scarica da: https://nodejs.org/
```

### "Permission denied" su `setup.sh` (macOS/Linux)
```bash
chmod +x setup.sh
./setup.sh
```

### Errori di line endings dopo il clone
```bash
git config core.autocrlf true    # Windows
git config core.autocrlf input   # macOS/Linux

# Poi resetta i file
git reset --hard HEAD
git clean -fd
```

### Errori "npm install" fallisce
```bash
cd Frontend
rm -rf node_modules package-lock.json
npm cache clean --force
npm install
```

---

## ✅ Verifica Setup Completo

Dopo aver eseguito gli script, verifica che tutto funzioni:

```bash
# Nel progetto root
cd Backend/SupportApi && dotnet build && cd ../..
cd Frontend && npm install && cd ..

echo "✅ Setup completo!"
```

---

## 📞 Supporto

Se hai problemi:
1. Controlla i prerequisiti sopra
2. Esegui gli script di setup
3. Consulta la sezione Troubleshooting
4. Chiedi ai quali altri collaboratori

---

## 🔗 Link Utili

- [Documentazione .NET 10](https://learn.microsoft.com/en-us/dotnet/)
- [Documentazione SharePoint Framework](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/sharepoint-framework-overview)
- [Node.js Docs](https://nodejs.org/docs/)
- [Git Documentation](https://git-scm.com/doc)
