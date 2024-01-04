import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_deck_client/util/constants.dart';
import 'package:macro_deck_client/util/custom_logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DeviceRegister extends StatefulWidget {
  const DeviceRegister({super.key});

  @override
  State<DeviceRegister> createState() => _DeviceRegisterState();
}

class _DeviceRegisterState extends State<DeviceRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeDeviceName = FocusNode();
  final FocusNode _focusNodeHost = FocusNode();
  final FocusNode _focusNodePort = FocusNode();

  final TextEditingController _ctrlDeviceName = TextEditingController();
  final TextEditingController _ctrlHost = TextEditingController();
  final TextEditingController _ctrlPort = TextEditingController();
  //final TextEditingController _ctrlBtnReg = TextEditingController();

  final Box _boxDevices = Hive.box("accounts");
  bool _obscurePort = false;
  bool _obscureHost = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Text(
                "Register your device",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Create your device",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ctrlDeviceName,
                focusNode: _focusNodeDeviceName,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Device name",
                  prefixIcon: const Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name device.";
                  } else if (value.length < 8) {
                    return "Name device  must be at least 8 character.";
                  } else if (_boxDevices.containsKey(value)) {
                    return "Device is already registered.";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodeHost.requestFocus(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _ctrlHost,
                obscureText: _obscureHost,
                focusNode: _focusNodeHost,
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  MaskTextInputFormatter(
                      mask: '###.###.###.###', filter: {"#": RegExp(r'[0-9]')}),
                ],
                decoration: InputDecoration(
                  labelText: "Host/IP",
                  prefixIcon: const Icon(Icons.computer),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureHost = !_obscureHost;
                        });
                      },
                      icon: _obscureHost
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onEditingComplete: () => _focusNodePort.requestFocus(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Host/IP.";
                  } else if (!RegExp(validateIP).hasMatch(value)) {
                    return "Host/IP not is valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ctrlPort,
                focusNode: _focusNodePort,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Port",
                  prefixIcon: const Icon(Icons.network_check_rounded),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePort = !_obscurePort;
                        });
                      },
                      icon: _obscurePort
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter port.";
                  } else if (!RegExp(validatePort).hasMatch(value)) {
                    return "Port not is valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _boxDevices.put(
                          _ctrlDeviceName.text,
                          '$_ctrlHost:$_ctrlPort',
                        );
                        // ignore: unused_local_variable

                        _boxDevices.toMap().forEach((key, value) {});

                        for (var element in _boxDevices.keys) {
                          logger.w(element);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            width: 200,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            behavior: SnackBarBehavior.floating,
                            content: const Text("Registered Successfully"),
                          ),
                        );

                        _formKey.currentState?.reset();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Register"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Direct connection"),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Macro Device"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Existing Devices",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeHost.dispose();
    _focusNodePort.dispose();
    _ctrlHost.dispose();
    _ctrlPort.dispose();
    _ctrlDeviceName.dispose();
    super.dispose();

    //_ctrlBtnReg.dispose();
    //_focusNodeConfirmPassword.dispose();
  }
}
