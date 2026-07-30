import 'package:Senaeya/View/Widgegts/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// A [MobileScannerController] that always reports [DeviceOrientation.portraitUp]
/// so the internal [CameraPreview] never rotates or resizes on micro-tilts.
class _PortraitLockedScannerController extends MobileScannerController {
  _PortraitLockedScannerController({
    super.detectionSpeed,
    super.autoStart,
    super.facing,
    super.torchEnabled,
  });

  @override
  MobileScannerState get value {
    final state = super.value;
    // Always clamp orientation to portraitUp — this prevents CameraPreview's
    // RotatedBox from firing and the SizedBox from flipping on every tilt.
    if (state.deviceOrientation == DeviceOrientation.portraitUp) return state;
    return state.copyWith(deviceOrientation: DeviceOrientation.portraitUp);
  }
}

class VinScannerScreen extends StatefulWidget {
  const VinScannerScreen({super.key});

  @override
  State<VinScannerScreen> createState() => _VinScannerScreenState();
}

class _VinScannerScreenState extends State<VinScannerScreen>
    with WidgetsBindingObserver {
  late MobileScannerController cameraController;
  bool _isProcessing = false;
  bool _isTorchOn = false;

  @override
  void initState() {
    super.initState();
    // autoStart:false + manual start after frame prevents the camera from
    // re-initialising on every minor orientation sensor event (the jitter)
    cameraController = _PortraitLockedScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoStart: false,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    WidgetsBinding.instance.addObserver(this);
    // Strict portrait lock so the OS never sends a rotation event to the camera
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Start the camera after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        cameraController.start();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        cameraController.start();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        cameraController.stop();
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController.dispose();
    // Restore portrait lock when leaving scanner
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  bool _isValidVIN(String vin) {
    if (vin.length != 17) return false;
    final vinPattern = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');
    return vinPattern.hasMatch(vin.toUpperCase());
  }

  void _processBarcode(BarcodeCapture capture) {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final scannedValue = barcodes.first.rawValue ?? '';
    if (scannedValue.isEmpty) return;

    if (_isValidVIN(scannedValue)) {
      setState(() => _isProcessing = true);
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) Navigator.of(context).pop(scannedValue.toUpperCase());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid VIN code. VIN must be 17 characters.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Toggle torch with loading state to prevent white screen
  void _toggleTorch() {
    setState(() => _isTorchOn = !_isTorchOn);
    cameraController.toggleTorch();
  }

  void _switchCamera() {
    cameraController.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title:  CustomText(text: 'Scan VIN Code'.tr),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(
                _isTorchOn ? Icons.flash_on : Icons.flash_off,
                color: _isTorchOn ? Colors.yellow : Colors.grey,
              ),
              onPressed: _toggleTorch,
            ),
            IconButton(
              icon: const Icon(Icons.cameraswitch),
              onPressed: _switchCamera,
            ),
          ],
        ),
        body: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                // Fixed scanWindow anchors the preview to a stable rect,
                // preventing the camera from recomposing on slight tilts.
                final scanWindow = Rect.fromCenter(
                  center: Offset(
                    constraints.maxWidth / 2,
                    constraints.maxHeight / 2,
                  ),
                  width: 300,
                  height: 150,
                );
                return MobileScanner(
                  controller: cameraController,
                  fit: BoxFit.cover,
                  scanWindow: scanWindow,
                  onDetect: _processBarcode,
                );
              },
            ),

            // Overlay frame
            Center(
              child: Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            // Instructions
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Position VIN barcode inside the frame',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Processing indicator
            if (_isProcessing)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Processing VIN...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
