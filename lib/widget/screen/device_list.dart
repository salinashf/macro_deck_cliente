import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_deck_client/model/saved_devices.dart';
import 'package:macro_deck_client/widget/screen/device_connect.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});
  //final Box _boxLogin = Hive.box("login");
  @override
  _DeviceList createState() => _DeviceList();
}

class _DeviceList extends State<DeviceList> {
  List<SavedDevices> deviceSaves = [];

  @override
  void initState() {
    //adding item to list, you can add using json from network
    deviceSaves.add(SavedDevices(
        id: "1", idConnection: "Mac house", host: "192.69.1.1", port: "3344"));
    deviceSaves.add(SavedDevices(
        id: "2", idConnection: "Mac house2", host: "192.69.1.2", port: "111"));
    deviceSaves.add(SavedDevices(
        id: "3", idConnection: "Mac house3", host: "192.69.1.14", port: "222"));
    deviceSaves.add(SavedDevices(
        id: "4", idConnection: "Mac house4", host: "92.9.1.14", port: "333"));
    deviceSaves.add(SavedDevices(
        id: "5", idConnection: "Mac house34", host: "92.69.1.55", port: "33"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login App"),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
                child: IconButton(
                  onPressed: () {
                    //_boxLogin.clear();
                    //_boxLogin.put("loginStatus", false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const DeviceConnect();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout_rounded),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: deviceSaves.map((sDeviceOne) {
                return Card(
                  child: ListTile(
                    title: Text(sDeviceOne.idConnection),
                    subtitle: Text(sDeviceOne.host + " : " + sDeviceOne.port),
                    leading: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                      onPressed: () {},
                      child: const Icon(Icons.devices),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                      child: const Icon(Icons.delete),
                      onPressed: () {
                        //delete action for this button
                        deviceSaves.removeWhere((element) {
                          return element.id == sDeviceOne.id;
                        }); //go through the loop and match content to delete from list
                        setState(() {
                          //refresh UI after deleting element from list
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
