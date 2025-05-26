import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String result = '';

  void calculateBMI() {
    final heightText = heightController.text;
    final weightText = weightController.text;

    final double? height = double.tryParse(heightText);
    final double? weight = double.tryParse(weightText);

    if (height != null && height > 0 && weight != null && weight > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        result = 'Your BMI is ${bmi.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        result = 'Please enter valid height and weight!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'BMI Calculator',
                  applicationVersion: '1.0',
                  children: [Text('This is a simple BMI calculator app.')],
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRywF0ZoJwhTDwiVmGjgxwuW7zb6tuOBrmSZQ&s',
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 30),

            // ListView Example
            Text(
              'Health Tips (ListView)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 150, // Must set height inside Column
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.check),
                    title: Text('Drink water regularly'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check),
                    title: Text('Exercise daily'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check),
                    title: Text('Sleep 7-8 hours'),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // GridView Example
            Text(
              'BMI Categories (GridView)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.green[100],
                    child: Center(child: Text('Underweight < 18.5')),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.blue[100],
                    child: Center(child: Text('Normal 18.5–24.9')),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.orange[100],
                    child: Center(child: Text('Overweight 25–29.9')),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.red[100],
                    child: Center(child: Text('Obese ≥ 30')),
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