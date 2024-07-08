import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CardType {
  visa,
  mastercard,
  amex,
  discover,
  dinersClub,
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({Key? key}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage>
    with SingleTickerProviderStateMixin {
  CardType _currentCardType = CardType.visa;

  final _cardNumberController =
      TextEditingController(text: '4111 1111 1111 1111');
  final _cardholderNameController = TextEditingController(text: 'John Doe');
  final _expiryDateController = TextEditingController(text: '12/24');
  final _cvvController = TextEditingController(text: '123');

  bool _isFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchCard() {
    setState(() {
      _currentCardType = CardType
          .values[(_currentCardType.index + 1) % CardType.values.length];
    });
  }

  Map<String, dynamic> _getCardDetails(CardType cardType) {
    switch (cardType) {
      case CardType.visa:
        return {
          'cardLabel': 'VISA',
          'colors': [Colors.blue, Colors.lightBlueAccent],
        };
      case CardType.mastercard:
        return {
          'cardLabel': 'MasterCard',
          'colors': [Colors.red, Colors.orange],
        };
      case CardType.amex:
        return {
          'cardLabel': 'American Express',
          'colors': [Colors.green, Colors.teal],
        };
      case CardType.discover:
        return {
          'cardLabel': 'Discover',
          'colors': [Colors.purple, Colors.deepPurpleAccent],
        };
      case CardType.dinersClub:
        return {
          'cardLabel': 'Diners Club',
          'colors': [Colors.brown, Colors.orangeAccent],
        };
      default:
        return {};
    }
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  String? _validateInput(String value, String fieldType) {
    switch (fieldType) {
      case 'cardNumber':
        return validateInput(value, r'^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}$',
            'Card number must be in the format XXXX XXXX XXXX XXXX');
      case 'cardholderName':
        return validateInput(value, r'^[a-zA-Z ]+$',
            'Cardholder name can only contain letters and spaces');
      case 'expiryDate':
        return validateInput(value, r'^(0[1-9]|1[0-2])\/[0-9]{2}$',
            'Expiry date must be in the format MM/YY');
      case 'cvv':
        return validateInput(
            value, r'^[0-9]{3,4}$', 'CVV must be 3 or 4 digits');
      default:
        return null;
    }
  }

  String? validateInput(String value, String pattern, String errorMessage) {
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cardDetails = _getCardDetails(_currentCardType);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card Design'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _flipCard,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final isFront = _animation.value < 0.5;
                  final displayAnimationValue =
                      isFront ? _animation.value : 1 - _animation.value;
                  final rotationY = displayAnimationValue * 3.1415926535897932;

                  return Transform(
                    transform: Matrix4.rotationY(rotationY),
                    alignment: Alignment.center,
                    child: isFront
                        ? _buildFront(cardDetails)
                        : _buildBack(cardDetails['colors']),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _switchCard,
              child: const Text('Switch Card'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFront(Map<String, dynamic> cardDetails) {
    return CreditCardWidget(
      cardNumberController: _cardNumberController,
      cardholderNameController: _cardholderNameController,
      expiryDateController: _expiryDateController,
      cardLabel: cardDetails['cardLabel']!,
      colors: cardDetails['colors']!,
      validateInput: _validateInput,
    );
  }

  Widget _buildBack(List<Color> color) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: color,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Container(
            height: 48,
            width: double.infinity,
            color: Colors.black,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            height: 30,
            width: MediaQuery.of(context).size.width * 0.40,
            color: Colors.grey[300],
            child: const Text("123", textAlign: TextAlign.end),
          )
        ],
      ),
    );
  }
}

class CreditCardWidget extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardholderNameController;
  final TextEditingController expiryDateController;
  final String cardLabel;
  final List<Color> colors;

  final String? Function(String, String) validateInput;

  const CreditCardWidget({
    Key? key,
    required this.cardNumberController,
    required this.cardholderNameController,
    required this.expiryDateController,
    required this.cardLabel,
    required this.colors,
    required this.validateInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Card",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.credit_card,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
            TextFormField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                counterText: "",
                // Counter text removed
                border: InputBorder.none,
                hintText: 'Card Number',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{0,4} ?\d{0,4} ?\d{0,4} ?\d{0,4}$')),
                // Allow digits and optional spaces after every four digits
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CARDHOLDER NAME',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      TextFormField(
                        controller: cardholderNameController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        // Added validation for cardholder name
                        validator: (value) => validateInput(
                          value!,
                          'cardholderName',
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EXPIRY DATE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      TextFormField(
                        controller: expiryDateController,
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          counterText: "",
                          border: InputBorder.none,
                          hintText: 'MM/YY',
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                        // Added validation for expiry date
                        validator: (value) =>
                            validateInput(value!, 'expiryDate'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
