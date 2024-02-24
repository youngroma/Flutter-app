import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Ticket App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(availableCities: [
        'Milano',
        'Warsaw',
        'Wroclaw',
        'Krakow',
        'Berlin',
      ]),

    );
  }
}

class LoginPage extends StatefulWidget {
  final List<String> availableCities;

  LoginPage({required this.availableCities});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButtonFormField<String>(
                  value: selectedCity,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCity = newValue;
                    });
                  },
                  items: widget.availableCities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Departure City',
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedCity != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrainListPage(initialCity: selectedCity!, availableCities: widget.availableCities,),
                      ),
                    );
                  } else {
                    // Предупреждение, если город не выбран
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Warning'),
                          content: Text('Please select a departure city.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class TrainListPage extends StatefulWidget {
  final String initialCity;
  final List<String> availableCities;

  TrainListPage({required this.initialCity, required this.availableCities});

  @override
  _TrainListPageState createState() => _TrainListPageState();
}

class _TrainListPageState extends State<TrainListPage> {
  late String selectedCity;
  List<TrainCard> trainCards = [];

  @override
  void initState() {
    super.initState();
    selectedCity = widget.initialCity;

    trainCards = [
      TrainCard(
        startCity: 'Milano',
        endCity: 'Paris',
        price: '110 Euro',
        trainClass: '1nd Class',
        travelTime: '7h 11m',
        departureTime: '6:22',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Milano',
        endCity: 'Roma',
        price: '66 Euro',
        trainClass: '1nd Class',
        travelTime: '6h 02m',
        departureTime: '9:17',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Warsaw',
        endCity: 'Vienna',
        price: '99 zl',
        trainClass: '2nd Class',
        travelTime: '6h 47m',
        departureTime: '11:22',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Warsaw',
        endCity: 'Praha',
        price: '129 zl',
        trainClass: '1nd Class',
        travelTime: '5h 00m',
        departureTime: '12:33',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Wroclaw',
        endCity: 'Krakow',
        price: '71 zł',
        trainClass: '2nd Class',
        travelTime: '4h 02m',
        departureTime: '14:15',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Wroclaw',
        endCity: 'Gdansk',
        price: '120 zł',
        trainClass: '1nd Class',
        travelTime: '5h 41m',
        departureTime: '18:05',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Krakow',
        endCity: 'Bratislava',
        price: '34 Euro',
        trainClass: '1nd Class',
        travelTime: '5h 55m',
        departureTime: '16:19',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Krakow',
        endCity: 'Warsaw',
        price: '49 zł',
        trainClass: '2nd Class',
        travelTime: '3h 32m',
        departureTime: '6:09',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Berlin',
        endCity: 'Warsaw',
        price: '63 Euro',
        trainClass: '1nd Class',
        travelTime: '4h 39m',
        departureTime: '18:59',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Berlin',
        endCity: 'Paris',
        price: '35 Euro',
        trainClass: '2nd Class',
        travelTime: '3h 22m',
        departureTime: '15:55',
        selectedCity: selectedCity,
      ),
      TrainCard(
        startCity: 'Berlin',
        endCity: 'Dresden',
        price: '20 Euro',
        trainClass: '2nd Class',
        travelTime: '2h 50m',
        departureTime: '14:14',
        selectedCity: selectedCity,
      ),
    ].where((route) => route.startCity == selectedCity).toList();


    trainCards.sort((a, b) {
      bool isHighlightedA = a.selectedCity == a.startCity; //|| a.selectedCity == a.endCity;
      bool isHighlightedB = b.selectedCity == b.startCity; //|| b.selectedCity == b.endCity;

      if (isHighlightedA && !isHighlightedB) {
        return -1;
      } else if (!isHighlightedA && isHighlightedB) {
        return 1;
      } else {
        return 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trains'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Selected City: $selectedCity',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DateWidget(),
            // Используйте отсортированный список маршрутов напрямую
            ...trainCards,
          ],
        ),
      ),
    );
  }
}

class TrainCard extends StatelessWidget {
  final String startCity;
  final String endCity;
  final String price;
  final String trainClass;
  final String travelTime;
  final String departureTime; // Новая переменная
  final String selectedCity;

  TrainCard({
    required this.startCity,
    required this.endCity,
    required this.price,
    required this.trainClass,
    required this.travelTime,
    required this.departureTime,
    required this.selectedCity,
  });

  @override
  Widget build(BuildContext context) {
    bool isHighlighted = selectedCity == startCity;
    bool isFirstClass = trainClass == '1nd Class';

    return Card(
      margin: EdgeInsets.all(10),
      color: isFirstClass ? (isHighlighted ? Colors.yellow : null) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Закругление рамки
        side: BorderSide(color: Colors.blue), // Добавление синей рамки
      ),
      child: ListTile(
        leading: Icon(Icons.train),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$startCity - $endCity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Departure Time: $departureTime'),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price: ',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              price,
              style: TextStyle(color: Colors.green),
            ),
            Text('Class: $trainClass'),
            Text('Travel Time: $travelTime'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuyTicketPage(startCity: startCity, endCity: endCity, selectedCity: selectedCity),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          child: Text(
            'Buy',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}




class BuyTicketPage extends StatefulWidget {
  final String startCity;
  final String endCity;
  final String selectedCity;

  BuyTicketPage({required this.startCity, required this.endCity, required this.selectedCity});

  @override
  _BuyTicketPageState createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> surnameControllers = [];
  List<TextEditingController> passportControllers = [];
  List<TextEditingController> emailControllers = [];
  TextEditingController ticketsController = TextEditingController();

  int numberOfTickets = 1;

  bool isFormFilled() {
    return List.generate(numberOfTickets, (index) {
      return nameControllers[index].text.isNotEmpty &&
          surnameControllers[index].text.isNotEmpty &&
          passportControllers[index].text.isNotEmpty &&
          emailControllers[index].text.isNotEmpty;
    }).every((element) => element);
  }

  void updateControllers() {
    nameControllers = List.generate(numberOfTickets, (index) => TextEditingController());
    surnameControllers = List.generate(numberOfTickets, (index) => TextEditingController());
    passportControllers = List.generate(numberOfTickets, (index) => TextEditingController());
    emailControllers = List.generate(numberOfTickets, (index) => TextEditingController());
  }

  @override
  void initState() {
    super.initState();
    updateControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Ticket'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter ticket information:'),
              Row(
                children: [
                  Text('Number of Tickets:'),
                  SizedBox(width: 10),
                  DropdownButton<int>(
                    value: numberOfTickets,
                    onChanged: (value) {
                      setState(() {
                        numberOfTickets = value!;
                        updateControllers();
                      });
                    },
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text((index + 1).toString()),
                      );
                    }),
                  ),
                ],
              ),
              ...List.generate(numberOfTickets, (index) {
                return Column(
                  children: [
                    Text('Passenger ${index + 1}:'),
                    TextField(
                      controller: nameControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Name',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    TextField(
                      controller: surnameControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    TextField(
                      controller: passportControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Passport Number',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    TextField(
                      controller: emailControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Email',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }),
              ElevatedButton(
                onPressed: () {
                  if (isFormFilled()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Ticket purchased!'),
                          content: Text('Thank you for your booked! Check your email, the ticket is waiting for you there '),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));

                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TrainListPage(initialCity: widget.selectedCity, availableCities: [],),
                                  );
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content:
                          Text('Please fill in all the required fields for each passenger.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Buy Ticket',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class DateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Today is $formattedDate',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}