
Um Eine TypeScript Datei in eine JavaScript Datei umzuwandeln, muss diese mit dem TypeScript Compiler (`tsc`) kompiliert werden.

1. Erstelle eine `hello.ts` Datei mit folgendem Inhalt:
   ```typescript
   let message: string = "Hallo TypeScript!"; 
   console.log(message);
   ```

2. Kompiliere die Datei mit folgendem CLI Befehl:
   ```powershell
   tsc hello.ts
   ```

3. Eine `hello.js` wird automatisch generiert mit folgendem Inhalt"
   ```javascript
   var message = "Hallo TypeScript!"; 
   console.log(message);
   ```

4. Führe die JavaScript Datei `hello.js` aus:
   ```powershell
   node hello.js
   ```

