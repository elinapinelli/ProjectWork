@echo off
REM ###############################################################################
REM Setup Script per Windows
REM Configura automaticamente il progetto (Backend + Frontend)
REM ###############################################################################

setlocal enabledelayedexpansion

cls
echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║          🚀 Setup Automatico - Progetto SupportApi             ║
echo ║                 (Windows)                                      ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM ###############################################################################
REM 1. Verifica Prerequisiti
REM ###############################################################################
echo ▶ Fase 1: Verifica dei prerequisiti...
echo.

set all_ok=1

REM Controlla Git
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git non trovato. Scaricalo da: https://git-scm.com/download/win
    set all_ok=0
) else (
    echo ✓ Git trovato
)

REM Controlla .NET SDK
dotnet --version >nul 2>&1
if errorlevel 1 (
    echo ❌ .NET SDK non trovato. Scaricalo da: https://dotnet.microsoft.com/en-us/download/dotnet/10.0
    set all_ok=0
) else (
    echo ✓ .NET SDK trovato
)

REM Controlla Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js non trovato. Scaricalo da: https://nodejs.org/
    set all_ok=0
) else (
    echo ✓ Node.js trovato
)

REM Controlla npm
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ npm non trovato. Scaricalo da: https://nodejs.org/
    set all_ok=0
) else (
    echo ✓ npm trovato
)

if !all_ok! equ 0 (
    echo.
    echo ❌ Alcuni prerequisiti mancano. Installali prima di continuare.
    echo.
    pause
    exit /b 1
)

echo.
echo ✓ Tutti i prerequisiti sono installati!
echo.

REM ###############################################################################
REM 2. Configurazione Git
REM ###############################################################################
echo ▶ Fase 2: Configurazione Git per line endings...
echo.

git config core.autocrlf true
echo ✓ Git configurato: core.autocrlf = true
echo.

REM ###############################################################################
REM 3. Setup Backend (.NET)
REM ###############################################################################
echo ▶ Fase 3: Setup Backend (.NET)...
echo.

if not exist "Backend\SupportApi" (
    echo ❌ Cartella Backend\SupportApi non trovata!
    pause
    exit /b 1
)

cd Backend\SupportApi

echo 📦 Ripristino dipendenze NuGet...
dotnet restore
if errorlevel 1 (
    echo ❌ Errore nel ripristino delle dipendenze!
    cd ..\..
    pause
    exit /b 1
)
echo ✓ Dipendenze NuGet ripristinate
echo.

echo 🔨 Compilazione del progetto...
dotnet build
if errorlevel 1 (
    echo ❌ Errore nella compilazione!
    cd ..\..
    pause
    exit /b 1
)
echo ✓ Backend compilato con successo!
echo.

cd ..\..

REM ###############################################################################
REM 4. Setup Frontend (SPFx)
REM ###############################################################################
echo ▶ Fase 4: Setup Frontend (SharePoint Framework)...
echo.

if not exist "Frontend" (
    echo ❌ Cartella Frontend non trovata!
    pause
    exit /b 1
)

cd Frontend

echo 📦 Installazione dipendenze npm...
call npm install
if errorlevel 1 (
    echo ❌ Errore nell'installazione delle dipendenze npm!
    cd ..
    pause
    exit /b 1
)
echo ✓ Dipendenze npm installate
echo.

cd ..

REM ###############################################################################
REM 5. Verifica Finale
REM ###############################################################################
echo ▶ Fase 5: Verifica finale...
echo.

cd Backend\SupportApi
dotnet build --no-restore -q >nul 2>&1
if errorlevel 1 (
    echo ⚠ Backend - Errore nella compilazione
) else (
    echo ✓ Backend - OK
)
cd ..\..

cd Frontend
npm --version >nul 2>&1
if errorlevel 1 (
    echo ⚠ Frontend - Errore
) else (
    echo ✓ Frontend - OK
)
cd ..

REM ###############################################################################
REM 6. Istruzioni Finali
REM ###############################################################################
echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                   ✅ SETUP COMPLETATO!                        ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo 📝 Prossimi passi:
echo.
echo   Backend (.NET):
echo     cd Backend\SupportApi
echo     dotnet run
echo     ^→ Server disponibile su https://localhost:5001
echo.
echo   Frontend (SPFx):
echo     cd Frontend
echo     npm start
echo     ^→ Server disponibile su http://localhost:4321
echo.
echo 📚 Per ulteriore aiuto:
echo     Leggi SETUP.md
echo.
pause
