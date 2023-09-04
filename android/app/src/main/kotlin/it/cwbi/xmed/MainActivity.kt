package it.cwbi.xmed

import android.content.Intent
import it.cwbi.xmed.models.SignatureField
import com.namirial.android.license.LicenseTaskEndStatus
import com.namirial.android.license.RequireLicenseData
import com.namirial.android.namirialfea.license.FeaLicense
import com.namirial.android.namirialfeagui.pdf.PDFUtils
import com.namirial.android.namirialfeagui.pdf.PDFViewerActivity
import com.namirial.android.namirialfeagui.pdf.Wizard
import com.namirial.android.namirialfeagui.pdf.Wizard.WizardPDF
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

const val SETUP_CHANNEL = "cwbi/setup"
const val VIEWER_CHANNEL = "cwbi/viewer"
const val LICENSE_CHANNEL = "cwbi/license"

// CALL BACK CODE PER IL RITONRO DEGLI INTENT
const val SIGN_PDF_REQUEST: Int = 102
const val PREVIEW_REQUEST_CODE: Int = 103
const val STATUS_INTERMEDIATE: Int = 200

class MainActivity: FlutterActivity() {
    private lateinit var setupChannel: MethodChannel
    private lateinit var viewerChannel: MethodChannel
    private lateinit var licenseChannel: MethodChannel

    private lateinit var callBackOption: String
    private lateinit var idDocumento: String

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        PDFUtils.activateSDK("", "", ""); // TODO: inserire dati licenza SDK

        setupChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SETUP_CHANNEL);
        viewerChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, VIEWER_CHANNEL);
        licenseChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LICENSE_CHANNEL);

        setupChannel.setMethodCallHandler { call, result ->
            if (call.method == "activateSDK") {
                val arguments = call.arguments() as HashMap<String, String>?

                val company = arguments?.get("company") as String
                val mail = arguments?.get("mail") as String
                val serial = arguments?.get("serial") as String
                val activation = PDFUtils.activateSDK(company, mail, serial);

                result.success(activation)
            }
        }

        viewerChannel.setMethodCallHandler { call, result ->
            if (call.method == "startWizard") {
                val arguments = call.arguments() as HashMap<String, Object>?

                val filePath = arguments?.get("pdfFile") as String
                val signatureFields = arguments?.get("signatureFields") as List<String>
                val partialSigning = arguments?.get("partialSigning") as Boolean
                callBackOption = arguments?.get("callBackOption") as String
                idDocumento = arguments?.get("idDocumento") as String

                // startWizard(filePath, signatureFields);
                startPreview(filePath, signatureFields.toTypedArray(), partialSigning);
            }
        }

        licenseChannel.setMethodCallHandler { call, result ->
            if (call.method == "requireLicense") {
                val arguments = call.arguments() as HashMap<String, String>?

                val username = arguments?.get("username") as String
                val mailAddress = arguments?.get("mailAddress") as String
                val licenseFile = arguments?.get("licenseFile") as String

                requireLicense(username, mailAddress, licenseFile, result);
            }

            if (call.method == "getLicenseData") {
                getLicenseData()
            }
        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        println("request code : " + requestCode + " (SIGN_PDF_REQUEST = )" + SIGN_PDF_REQUEST + ", PERVIEW_REQUEST_CODE = " + PREVIEW_REQUEST_CODE + ")")
        if (requestCode == SIGN_PDF_REQUEST || requestCode == PREVIEW_REQUEST_CODE) {
            val _data = LinkedHashMap<String, String?>()

            val pdfPath: String? = data?.getStringExtra("pdfPath")
            _data["pdfPath"] = pdfPath
            
            println("resultCode" + resultCode)

            when (resultCode) {
                RESULT_OK -> {
                    println("RESULT_OK")
                    _data["status"] = "SIGNED"
                    _data["idDocumento"] = idDocumento
                    _data["callBackOption"] = callBackOption
                }
                STATUS_INTERMEDIATE -> {
                    val emptySignatures: String? = data?.getStringExtra("emptySignatures")
                    val missingSignatures: String? = data?.getStringExtra("missingSignatures")

                    _data["status"] = "INTERMEDIATE"
                    _data["emptySignatures"] = emptySignatures
                    _data["missingSignatures"] = missingSignatures
                    _data["callBackOption"] = callBackOption
                    _data["idDocumento"] = idDocumento

                }
                else -> {
                    val emptySignatures: String? = data?.getStringExtra("emptySignatures")
                    val missingSignatures: String? = data?.getStringExtra("missingSignatures")

                    _data["status"] = "CANCELLED"
                    _data["emptySignatures"] = emptySignatures
                    _data["missingSignatures"] = missingSignatures
                }
            }
            viewerChannel.invokeMethod("completeWizard", _data)
        }
    }

    private fun getLicenseData() {
        val license = FeaLicense.getInstance()

        license.getLicenseData { ld ->
            licenseChannel.invokeMethod("retrieveLicense", ld.toJsonString());
        }
    }

    /**
     * Start preview with selected signature fields
     */
    private fun startPreview(
        filename: String,
        signatureFields: Array<String>,
        partialSigning: Boolean,
    ) {
        val intent = Intent(this@MainActivity, XmedCustomViewer::class.java)
        intent.putExtra(PDFViewerActivity.KEY_PDF, filename)

        if (signatureFields.isNotEmpty()) {
            val _signatureFields = ArrayList<SignatureField>()
            for (signatureField in signatureFields) {
                var _signatureField = SignatureField()
                _signatureField.id = signatureField
                _signatureField.required = true
                _signatureFields.add(_signatureField)
            }
            intent.putExtra(XmedCustomViewer.KEY_SIGNATURE_FIELDS, _signatureFields)
            intent.putExtra(XmedCustomViewer.PARTIAL_SIGNING, partialSigning)
        }
        startActivityForResult(intent, PREVIEW_REQUEST_CODE)
    }

    /**
     * Start wizard with selected signature fields
     */
    private fun startWizard(fileName: String, signatureFields: List<String>, callBackOption: String) {
        val wizard = Wizard()
        wizard.wizardConfiguration = Wizard.WizardConfiguration()
        val wizardPdf: Wizard.WizardPDF = Wizard.WizardPDF(fileName, "")

        if (signatureFields == null) {
            wizardPdf.isHandleSignatureFields = true
            wizardPdf.isIncludeBiometricData = true
        } else {
            signatureFields!!.forEach { signatureField ->
                wizardPdf.addSignatureField(
                    Wizard.WizardSignatureField(
                        signatureField,
                        true,
                        true
                    )
                )
            }
        }
        wizard.addWizardPDF(wizardPdf)
        wizard.startWizard(this@MainActivity, SIGN_PDF_REQUEST)
    }

    /**
     * Require license for user and license file
     */
    private fun requireLicense(
        username: String,
        mailAddress: String,
        licenseFile: String,
        result: MethodChannel.Result
    ) {
        val license = FeaLicense.getInstance()
        val licenseData = RequireLicenseData()
        licenseData.userName = username
        licenseData.userMailAddress = mailAddress

        licenseData.setPromoCodeFromLicenseFile(path = licenseFile)
        var jsonLicense: String;

        if (licenseData.isDataValid) { //check if all the license data are correct
            license.requireLicense(licenseData) { licenseTaskEndStatus ->
                //LISTENT TO END LICENSE REQUIREMENT EVENT
                when (licenseTaskEndStatus) {
                    LicenseTaskEndStatus.OK,
                    LicenseTaskEndStatus.LICENSE_RECOVERED -> {
                        val data = HashMap<String, String>()
                        license.getLicenseData { ld ->
                            print(ld.isDemo)
                            result.success(ld.toJsonString());
                            //licenseChannel.invokeMethod("requiredLicense", ld.toJsonString());
                        }
                    }
                    LicenseTaskEndStatus.LICENSE_FROZEN,
                    LicenseTaskEndStatus.LICENSE_EXPIRED -> {
                        // show a message to the user
                        var errMesssage: String? = licenseTaskEndStatus.message
                        result.success("expired");
                        //licenseChannel.invokeMethod("requiredLicense", "expired");
                    }
                    LicenseTaskEndStatus.ERROR_CERTIFICATE_INVALID -> {
                        // show a message to the user
                        var errMesssage: String? = licenseTaskEndStatus.message
                        //YOUR AFGCLIC IS CORRUPTED OR SIGNING CERTIFICATE IS EXPIRED
                        //please contact our sales to get an updated AFGCLIC license file to
                        //use with your app
                        result.success("invalid");
                        //licenseChannel.invokeMethod("requiredLicense", "invalid");
                    }
                    else -> {
                        //THERE IS SOMETHING WRONG WITH YOUR LICENSE
                        var errMesssage: String? = licenseTaskEndStatus.message
                        result.success("error");
                        //licenseChannel.invokeMethod("requiredLicense", "error");
                    }
                }

            }
        } else if (!licenseData.hasValidCertificate()) {
            result.success("wrong params");
            //licenseChannel.invokeMethod("requiredLicense", "wrong params");
        } else {
            result.success("invalid certificate");
            //licenseChannel.invokeMethod("requiredLicense", "invalid certificate");
        }
    }
}
