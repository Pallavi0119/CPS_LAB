import 'package:flutter/material.dart';
import 'package:login/pages/product_description.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
 
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        return Container(
          color: isDarkMode ? Colors.grey.shade900 : const Color.fromARGB(255, 247, 248, 248),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Heading
                Text(
                  "Our Products",
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 24 : 34,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.yellow.shade200 : Colors.deepPurple,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 30),

                GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: getResponsiveCrossAxisCount(screenWidth),
    crossAxisSpacing: 20,
    mainAxisSpacing: 30,
    mainAxisExtent: 350,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return SensorCard(
      imageAsset: item["image"]!,
      title: item["title"]!,
      description: item["desc"]!,
      onReadMore: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDescriptionPage(sensorIndex: index),
          ),
        );
      },
    );
  },
),

              ],
            ),
          ),
        );
      },
    );
  }

  static final items = [

      {
      "image": "assets/images/dataloggerrender.png",
      "title": "Data Logger",
      "desc": "Reliable data logging & seamless connectivity.",
    
    },
    {
      "image": "assets/images/blegateway.png",
      "title": "BLE Gateway",
      "desc": "For industrial IoT applications and connectivity.",
    
    },
    {
      "image": "assets/images/stts751.png",
      "title": "Temperature Sensor(STTS751)",
      "desc":  " Programmable resolution and low power consumption",
    
    },  {
      "image": "assets/images/lis3dh.png",
      "title": "Motion Sensor(LIS3DH)",
      "desc": "For industrial IoT applications and connectivity.",
    
    }, {
      "image": "assets/images/memory.png",
      "title": "Memory Board(W25Q16/W25Q32)",
      "desc": "Compact, low-power, high-speed storage solution.",
  
    }, {
      "image": "assets/images/buzzer.png",
      "title": "Buzzer",
      "desc": "Compact audio signaling component.",
  
    }, {
      "image": "assets/images/relay.png",
      "title": "Relay",
      "desc": "Electromagnetically operated switch for automation and control",
 
    }, {
      "image": "assets/images/ble dev kit.jpg",
      "title": "Bluetooth Low Energy Development Kit",
      "desc": "Multi-protocol wireless prototyping kit.",
 
    }, {
      "image": "assets/images/ble node.png",
      "title": "BLE Node",
      "desc":"Advanced Bluetooth LE solution for IoT and wearable applications",

    }, {
      "image": "assets/images/programmer.png",
      "title": "Flash Tool",
      "desc": "Designed for nRF series SoCs ",
  
    }, {
      "image": "assets/images/bme680.png",
      "title": "Temperature, Humidity, Pressure and Gas Sensor (BME680)",
      "desc": "Compact 4-in-1 environmental sensor.",
  
    }, {
      "image": "assets/images/Actitvity monitoring sensor.png",
      "title": "Activity/Vibration Monitor Kit",
      "desc": "Real-time motion and environmental data tracker for STEM and IoT projects",
 
    }, {
      "image": "assets/images/lux.png",
      "title": "Lux Sensor",
      "desc":  "16-bit resolution sensor for consumer and industrial applications",
  
    }, {
      "image": "assets/images/groove shield.png",
      "title": "Groove Shield",
      "desc": "Easy integration of sensors, actuators, and inputs for rapid IoT prototyping",
  
    }, {
      "image": "assets/images/tlv.png",
      "title": "3D Magnetic Sensor(TLV493D)",
      "desc": "High precision Hall-effect sensor for accurate 3D magnetic field measurement",
  
    }, {
      "image": "assets/images/vl5.png",
      "title": "Laser Distance Sensor(TOF VL53L0X)",
      "desc":"Millimeter-level accuracy for precise distance measurement",
  
    }, {
      "image": "assets/images/ltr390.png",
      "title": "Light Sensor(UV LTR-390 )",
      "desc": "For industrial IoT applications and connectivity.",
    
    }, {
      "image": "assets/images/halleffect.png",
      "title": "Linear Magnetic Hall Sensor",
      "desc": "Detects magnetic fields with digital and analog outputs",
  
    }, {
      "image": "assets/images/ir sensor.png",
      "title": "InfraRed Sensor",
      "desc": "Detects infrared radiation emitted by objects, supporting motion detection, temperature measurement, and control systems",
 
    }, 
  ];
}

class SensorCard extends StatefulWidget {
  final String imageAsset;
  final String title;
  final String description;
  final VoidCallback onReadMore;

  const SensorCard({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.onReadMore,
  });

  @override
  State<SensorCard> createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color cardColor = isDarkMode
        ? (isHovered ? Colors.grey.shade700 : Colors.grey.shade800)
        : (isHovered ? Colors.blueGrey.shade200 : const Color.fromARGB(255, 220, 222, 223));

    Color titleColor = isDarkMode
        ? (isHovered ? Colors.yellow.shade300 : Colors.yellow.shade200)
        : Colors.black87;

    Color descColor = isDarkMode ? Colors.grey.shade400 : const Color.fromARGB(255, 47, 56, 58);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        transform: isHovered ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: isHovered ? Colors.blueAccent.withOpacity(0.3) : Colors.black.withOpacity(0.08),
              blurRadius: isHovered ? 15 : 6,
              spreadRadius: isHovered ? 2 : 0,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: widget.onReadMore,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: widget.title,
                    child: Image.asset(widget.imageAsset, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: descColor,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isHovered
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: widget.onReadMore,
                  child: const Text("Read More"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int getResponsiveCrossAxisCount(double screenWidth) {
  if (screenWidth < 500) return 1;
  if (screenWidth < 900) return 2;
  if (screenWidth < 1200) return 3;
  return 4;
}
