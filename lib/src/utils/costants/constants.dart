//App
const String appTitle = 'XMed';

// Network and APIs
const int connectionLimitTimeout = 6000;
const int receiveLimitTimeout = 6000;

const String passwordToDecryptEncryptedPrivateKey = "Cambiami2013!";

// const String baseUrl =
//     "https://wwwtest.codiceweb.com/xmed-api/rest/v202201/tablet";
// const String clinicDetailsEndPoint = "/clinicaDetails";
// const String documentoClinicaDownloadEndPoint = "/documentoClinicaDownload";
// const String documentoClinicaSearchEndPoint = "/documentoClinicaSearch";
// const String documentoClinicaUploadEndPoint = "/documentoClinicaUpload";
const String baseUrl = "http://localhost:3000";
const String clinicDetailsEndPoint = "/clinicaDetails";
const String documentoClinicaDownloadEndPoint = "/documentoClinicaDownload";
const String documentoClinicaSearchEndPoint = "/documentoClinicaSearch";
const String documentoClinicaUploadEndPoint = "/documentoClinicaUpload";

// Regular expressions
const emailRegExp =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

// Validators messages
const requiredField = "Il campo non può essere vuoto.";
const wrongCredential = "Credenziali inserite non corrette.";
const badFormat = "Il formato inserito non è corretto";
