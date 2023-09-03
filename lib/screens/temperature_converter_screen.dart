import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/dark_theme.dart';

class TemperatureConverterApp extends StatefulWidget {
  const TemperatureConverterApp({super.key});

  @override
  State<TemperatureConverterApp> createState() =>
      _TemperatureConverterAppState();
}

class _TemperatureConverterAppState extends State<TemperatureConverterApp> {
  double inputTemperature = 0.0;
  double outputTemperature = 0.0;

  String inputUnit = 'Celsius'; // Default input unit
  String outputUnit = 'Fahrenheit'; // Default output unit

  bool showResult = false;

  @override
  void initState() {
    super.initState();
  }

  void convertTemperature() {
    if (inputUnit == 'Celsius' && outputUnit == 'Fahrenheit') {
      outputTemperature = (inputTemperature * 9 / 5) + 32;
    } else if (inputUnit == 'Celsius' && outputUnit == 'Kelvin') {
      outputTemperature = inputTemperature + 273.15;
    } else if (inputUnit == 'Fahrenheit' && outputUnit == 'Celsius') {
      outputTemperature = (inputTemperature - 32) * 5 / 9;
    } else if (inputUnit == 'Fahrenheit' && outputUnit == 'Kelvin') {
      outputTemperature = (inputTemperature - 32) * 5 / 9 + 273.15;
    } else if (inputUnit == 'Kelvin' && outputUnit == 'Celsius') {
      outputTemperature = inputTemperature - 273.15;
    } else if (inputUnit == 'Kelvin' && outputUnit == 'Fahrenheit') {
      outputTemperature = (inputTemperature - 273.15) * 9 / 5 + 32;
    }

    setState(() {
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    themeChanger.themeMode == ThemeMode.dark ? Colors.black45 : Colors.white;
    Color appBarTitleColor =
        themeChanger.themeMode == ThemeMode.dark ? Colors.white : Colors.black;
    Color iconColor =
        themeChanger.themeMode == ThemeMode.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            80), // Adjust the preferred height of the app bar
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Card(
            elevation: 4.0, // Add shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Make the card rounded
            ),
            margin: const EdgeInsets.symmetric(
                horizontal: 8.0), // Add margin for spacing
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Increase the padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    child: IconButton(
                      icon: themeChanger.themeMode == ThemeMode.dark
                          ? const Icon(Icons.wb_sunny)
                          : const Icon(Icons.nightlight_round),
                      color: iconColor,
                      onPressed: () {
                        themeChanger.toggleTheme();
                        setState(() {
                          appBarTitleColor =
                              themeChanger.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black;
                          iconColor = themeChanger.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Temperature Converter',
                      style: GoogleFonts.phudu(
                        letterSpacing: 2,
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: appBarTitleColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 20), // Add some spacing between the icon and title
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Column(
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green], // Change these colors as needed
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      style: GoogleFonts.robotoSlab(
                        letterSpacing: 1,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: appBarTitleColor,
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.red, // Change the cursor color here
                      decoration: InputDecoration(
                        labelText: 'Enter Temperature',
                        labelStyle: TextStyle(
                          color: appBarTitleColor, // Change the color of the label text here
                        ),
                        border: InputBorder.none, // Remove the default border
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                      onChanged: (value) {
                        inputTemperature = double.tryParse(value) ?? 0.0;
                      },
                    ),
                  ),

                  const SizedBox(height: 40),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.green], // Change these colors as needed
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Select input unit',
                                style: GoogleFonts.robotoSlab(
                                  letterSpacing: 0.5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: appBarTitleColor,
                                ),
                              ),
                              DropdownButton<String>(
                                value: inputUnit,
                                onChanged: (value) {
                                  setState(() {
                                    inputUnit = value!;
                                  });
                                },
                                items: <String>[
                                  'Celsius',
                                  'Fahrenheit',
                                  'Kelvin'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.robotoSlab(
                                        letterSpacing: 1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: appBarTitleColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.green], // Change these colors as needed
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Select output unit',
                                style: GoogleFonts.robotoSlab(
                                  letterSpacing: 0.5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: appBarTitleColor,
                                ),
                              ),
                              DropdownButton<String>(
                                value: outputUnit,
                                onChanged: (value) {
                                  setState(() {
                                    outputUnit = value!;
                                  });
                                },
                                items: <String>[
                                  'Celsius',
                                  'Fahrenheit',
                                  'Kelvin'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.robotoSlab(
                                        letterSpacing: 1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: appBarTitleColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 45,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.blueAccent,
                            Colors.redAccent,
                            Colors.purpleAccent,
                            //add more colors
                          ]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.57), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            convertTemperature();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor:
                                  Colors.transparent.withOpacity(0.38),
                              disabledBackgroundColor:
                                  Colors.transparent.withOpacity(0.12),
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text(
                            'Convert Temperature',
                            style: GoogleFonts.robotoSlab(
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (showResult)
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // You can adjust the radius as needed
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.blue, Colors.red], // Replace with your desired gradient colors
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              'Result: $outputTemperature $outputUnit',
                              style: GoogleFonts.robotoSlab(
                                letterSpacing: 1,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: appBarTitleColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
