## Freezed
Automatically:
- Provide the == operator to compare objects by value.
- Provide copy method with modified fields, also known as copyWith.
- Provide toJson and fromJson method (Map<String, dynamic>).

## Funzionamento algoritmo chiave asimmetrica
Le chiavi pubbliche e private di un utente in un sistema di cifratura asimmetrica (come RSA) sono strettamente correlate e formano una coppia matematica. Queste chiavi sono generate insieme in modo tale da creare una relazione univoca tra di loro.

Nel caso di RSA, una coppia di chiavi è generata utilizzando un processo matematico basato sulla teoria dei numeri. Vediamo come sono correlate le chiavi pubbliche e private di un utente:

1. Chiave pubblica:
La chiave pubblica è utilizzata per crittografare i dati e può essere distribuita liberamente a chiunque desideri inviare messaggi all'utente proprietario della coppia di chiavi. La chiave pubblica è tipicamente rappresentata da un numero intero lungo e complesso. Può essere usata solo per cifrare i dati e non per decifrarli.

2. Chiave privata:
La chiave privata è segreta e nota solo all'utente proprietario della coppia di chiavi. È utilizzata per decifrare i dati cifrati con la corrispondente chiave pubblica. Anche se le chiavi pubblica e privata sono correlate, il processo matematico utilizzato per generare la chiave privata dalla chiave pubblica è estremamente difficile da invertire. Questo rende praticamente impossibile dedurre la chiave privata conoscendo solo la chiave pubblica.

3. Generazione delle chiavi:
La coppia di chiavi (pubblica e privata) è generata da un algoritmo di generazione delle chiavi. Durante il processo di generazione, vengono eseguiti calcoli matematici avanzati, inclusi grandi numeri primi, che creano la relazione tra le due chiavi. Questo processo matematico è fondamentale per il funzionamento della cifratura asimmetrica.

4. Utilizzo:
Quando qualcuno vuole inviare un messaggio all'utente, utilizza la chiave pubblica dell'utente per cifrare il messaggio. Solo l'utente, in possesso della corrispondente chiave privata, può decifrare il messaggio e leggerne il contenuto.

In sintesi, la chiave pubblica viene utilizzata per cifrare i dati, mentre la chiave privata è utilizzata per decifrarli. La sicurezza del sistema di cifratura asimmetrica si basa sulla difficoltà di invertire il processo matematico e dedurre la chiave privata conoscendo solo la chiave pubblica. Questo rende le comunicazioni sicure e protegge i dati dagli occhi indiscreti.