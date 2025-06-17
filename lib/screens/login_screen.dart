import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'register_screen.dart';
import 'package:geolocator/geolocator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Future<void> _checkAndRequestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceAlertDialog();
      return;
    }

    // Always show the custom rationale dialog first
    await _showLocationPermissionRationaleDialog();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _navigateToHome();
  }

  void _showLocationServiceAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text('Location Services Disabled', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
          content: Text('Please enable location services for Her Rides to work properly.', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLocationPermissionRationaleDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text('Location Access for Her Rides', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Her Rides collects location data to enable your ride booking and tracking features even when the app is closed or not in use.', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                const SizedBox(height: 10),
                Text('Please allow location access to continue.', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Deny', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Allow', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              onPressed: () async {
                Navigator.of(context).pop();
                // After user allows custom dialog, proceed to request native permission
                LocationPermission currentPermission = await Geolocator.checkPermission();
                if (currentPermission == LocationPermission.denied || currentPermission == LocationPermission.deniedForever) {
                  Geolocator.requestPermission().then((permissionStatus) {
                    if (permissionStatus != LocationPermission.denied && permissionStatus != LocationPermission.deniedForever) {
                      _navigateToHome();
                    }
                  });
                } else {
                  _navigateToHome();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.email, color: Color(0xFFE91E63)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFFE91E63)),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Implement login logic
                        _checkAndRequestLocationPermission();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE91E63),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(onRegister: _navigateToHome),
                        ),
                      );
                    },
                    child: const Text(
                      'Don\'t have an account? Register',
                      style: TextStyle(
                        color: Color(0xFFE91E63),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 