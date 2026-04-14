import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_saathi/Containt/Stateimage.dart';
import 'package:travel_saathi/statestravel/Allinone.dart';

import '../Containt/image/imagesall.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> jammuPlaces = [
    "A River View from Gurez–Tulail Valley",
    "Aru Village",
    "Bangus Valley, Kashmir",
    "Doodhpathri, Southwest Jammu & Kashmir",
    "Houseboat, Dal Lake, Srinagar, Kashmir",
    "Nishat Bagh (Mughal Gardens), Srinagar, India",
    "Lavender Park",
    "Lidder River & Jhelum River",
    "Lidder River at Betaab Valley",
    "Sarband, Kashmir",
    "Shankaracharya Temple (Summer View)",
    "Sonmarg Valley",
    "Srinagar Panorama",
    "St. Mary's Church, Gulmarg",
    "Yousmarg"
  ];
  List<int> jammuPrices = [
    500,  // Gurez–Tulail Valley
    450,  // Aru Village
    600,  // Bangus Valley
    500,  // Doodhpathri
    1200, // Houseboat Dal Lake (Premium)
    400,  // Nishat Bagh
    350,  // Lavender Park
    400,  // Lidder & Jhelum River
    500,  // Betaab Valley
    350,  // Sarband
    450,  // Shankaracharya Temple
    700,  // Sonmarg Valley (Premium)
    600,  // Srinagar Panorama
    400,  // St. Mary's Church
    550   // Yousmarg
  ];
  List<String> jammuimage=[
    Jammu_kashmir.image.img1,
    Jammu_kashmir.image.img2,
    Jammu_kashmir.image.img3,
    Jammu_kashmir.image.img4,
    Jammu_kashmir.image.img5,
    Jammu_kashmir.image.img6,
    Jammu_kashmir.image.img7,
    Jammu_kashmir.image.img8,
    Jammu_kashmir.image.img9,
    Jammu_kashmir.image.img10,
    Jammu_kashmir.image.img11,
    Jammu_kashmir.image.img12,
    Jammu_kashmir.image.img13,
    Jammu_kashmir.image.img14,
    Jammu_kashmir.image.img15,
  ];
  // haryana
  List<String> haryanaPlaces = [
    "Bala Ji Temple, Raghunathpura",
    "Chhatta Rai Bal Mukand Dass ",
    "Jal Mahal, Narnaul",
    "Modawala (Shiv) Temple, Narnaul",
    "Pinjore Garden, Panchkula",
    "Sahukar Gumbad (Chor Gumbad)",
    "Sheikh Chilli Tomb, Kurukshetra, Haryana",
    "Suraj Kund",
    "Kalpana Chawla Planetarium",
    "Kingdom of Dreams",
    "Nada Sahib Gurudwara, Panchkula",
    "Nahar Singh Mahal, Faridabad",
    "Panjokhra Sahib Gurudwara, Ambala",
    "Star Monument, Hisar"
  ];
  List<int> haryanaPrices = [
    300,  // Bala Ji Temple
    350,  // Birbal Ka Chhatta
    400,  // Jal Mahal, Narnaul
    300,  // Shiv Temple
    450,  // Pinjore Garden
    350,  // Chor Gumbad
    500,  // Sheikh Chilli Tomb
    600,  // Suraj Kund (Festival/Popular)
    400,  // Kalpana Chawla Planetarium
    800,  // Kingdom of Dreams (Premium)
    350,  // Nada Sahib Gurudwara
    450,  // Nahar Singh Mahal
    350,  // Panjokhra Sahib Gurudwara
    300   // Star Monument
  ];
List<String> haryanaImage=[
  HaryanaImage.image.img1,
  HaryanaImage.image.img2,
  HaryanaImage.image.img3,
  HaryanaImage.image.img4,
  HaryanaImage.image.img5,
  HaryanaImage.image.img6,
  HaryanaImage.image.img7,
  HaryanaImage.image.img8,
  HaryanaImage.image.img9,
  HaryanaImage.image.img10,
  HaryanaImage.image.img11,
  HaryanaImage.image.img12,
  HaryanaImage.image.img13,
  HaryanaImage.image.img14,
];

  List<String> himachalPlaces = [
    "Landscape View of Banikhet",
    "River Valley View",
    "Jibhi Waterfall",
    "Kalpa",
    "Key Monastery, Spiti Valley",
    "Khajjiar Lake",
    "Kibber Village, Spiti Valley",
    "Manali City",
    "Mountains of Manali, Himachal Pradesh",
    "Nako Lake and Nako Village, Himachal Pradesh",
    "Nako Village",
    "Nature of Khajjiar",
    "Ancient Structure at Kalpa Temple Premises",
    "Parvati Valley, Kasol",
    "Raghupur Fort, Jibhi",
    "Reflection of Himalayan Peaks at Nako Lake",
    "Serolsar Lake, Jibhi",
    "Spiti River, Kaza",
    "Temple at Chitkul",
    "Tirthan Valley, Jibhi",
    "Tosh Glacier",
    "Triund Trek",
    "View from Tosh",
    "Barot Valley View",
    "Wooden Hut in Chitkul"
  ];
  List<int> himachalPrices = [
    300,  // Banikhet View
    250,  // River Valley View
    400,  // Jibhi Waterfall
    500,  // Kalpa
    700,  // Key Monastery (Spiti - Premium)
    450,  // Khajjiar Lake
    600,  // Kibber Village
    550,  // Manali City
    500,  // Manali Mountains
    600,  // Nako Lake & Village
    450,  // Nako Village
    400,  // Khajjiar Nature
    350,  // Kalpa Temple Structure
    650,  // Parvati Valley (Kasol)
    450,  // Raghupur Fort
    500,  // Nako Lake Reflection
    400,  // Serolsar Lake
    600,  // Spiti River (Kaza)
    300,  // Chitkul Temple
    500,  // Tirthan Valley
    700,  // Tosh Glacier (Premium Trek)
    650,  // Triund Trek
    450,  // View from Tosh
    400,  // Barot Valley
    350   // Wooden Hut (Chitkul)
  ];

  List<String> himachalImage = [
    HimachalImage.image.img1,
    HimachalImage.image.img2,
    HimachalImage.image.img3,
    HimachalImage.image.img4,
    HimachalImage.image.img5,
    HimachalImage.image.img6,
    HimachalImage.image.img7,
    HimachalImage.image.img8,
    HimachalImage.image.img9,
    HimachalImage.image.img10,
    HimachalImage.image.img11,
    HimachalImage.image.img12,
    HimachalImage.image.img13,
    HimachalImage.image.img14,
    HimachalImage.image.img15,
    HimachalImage.image.img16,
    HimachalImage.image.img17,
    HimachalImage.image.img18,
    HimachalImage.image.img19,
    HimachalImage.image.img20,
    HimachalImage.image.img21,
    HimachalImage.image.img22,
    HimachalImage.image.img23,
    HimachalImage.image.img24,
    HimachalImage.image.img25,
  ];

List<String> gujaratImage=[
  GujratImage.image.img1,
  GujratImage.image.img2,
  GujratImage.image.img3,
  GujratImage.image.img4,
  GujratImage.image.img5,
  GujratImage.image.img6,
  GujratImage.image.img7,
  GujratImage.image.img8,
  GujratImage.image.img9,
  GujratImage.image.img10,
  GujratImage.image.img11,
  GujratImage.image.img12,
  GujratImage.image.img13,
  GujratImage.image.img14,
  GujratImage.image.img15,
];
  List<String> gujaratPlaces = [
    "Swaminarayan Temple, Mandvi",
    "Bonter Jinalaya, Koday, Kachchh",
    "Dwarkadhish Temple",
    "Dwarka Lighthouse",
    "Greater Flamingos, Rann of Kutch",
    "Polo Forest History",
    "Nageshwar Temple",
    "Nageshwar",
    "Polo Monument and Vijaynagar Forest Jain Temple",
    "Saputara Nageshwar Temple",
    "Somnath Temple",
    "Statue of Unity",
    "Varma Memorial",
    "Vijay Vilas Palace",
    "Vijay Vilas"
  ];
  List<int> gujaratPrices = [
    400,  // Swaminarayan Temple
    300,  // Bonter Jinalaya
    600,  // Dwarkadhish Temple
    350,  // Dwarka Lighthouse
    700,  // Rann of Kutch (Flamingos)
    450,  // Polo Forest
    500,  // Nageshwar Temple
    450,  // Nageshwar Area
    400,  // Polo Monument
    350,  // Saputara Temple
    650,  // Somnath Temple
    1000, // Statue of Unity (Premium)
    300,  // Varma Memorial
    550,  // Vijay Vilas Palace
    500   // Vijay Vilas
  ];
  List<String> utterPradeshImage=[
    UtterPradeshImage.image.img1,
    UtterPradeshImage.image.img3,
    UtterPradeshImage.image.img5,
    UtterPradeshImage.image.img6,
    UtterPradeshImage.image.img7,
    UtterPradeshImage.image.img11,
    UtterPradeshImage.image.img12,
    UtterPradeshImage.image.img15,
    UtterPradeshImage.image.img16,
    UtterPradeshImage.image.img17,
    UtterPradeshImage.image.img18,
    UtterPradeshImage.image.img19,
    UtterPradeshImage.image.img20,
    UtterPradeshImage.image.img21,
    UtterPradeshImage.image.img22,
    UtterPradeshImage.image.img23,
    UtterPradeshImage.image.img25,
    UtterPradeshImage.image.img26,
    UtterPradeshImage.image.img28,
    UtterPradeshImage.image.img29,
    UtterPradeshImage.image.img30,
    UtterPradeshImage.image.img32,
    UtterPradeshImage.image.img33,
    UtterPradeshImage.image.img34,
    UtterPradeshImage.image.img35,
    UtterPradeshImage.image.img36,
    UtterPradeshImage.image.img37,
    UtterPradeshImage.image.img38,
    UtterPradeshImage.image.img39,
    UtterPradeshImage.image.img40,
    UtterPradeshImage.image.img42,

  ];
  List<String> uttarPradeshPlaces = [
    "Sarnath Temple (Mulagandhakuti Vihara)",
    "Agra Fort",
    "Ayodhya Ram Mandir",
    "Bhelupur Shwetambar Jain Temple",
    "Dashashwamedh Ghat, Varanasi",
    "Fatehpur Sikri",
    "Buland Darwaza, Fatehpur Sikri",
    "Hanuman Garhi, Ayodhya",
    "Itimad-ud-Daulah, Agra",
    "ISKON Temple, Vrindavan",
    "Jahangiri Mahal, Agra Fort",
    "Jama Masjid, Fatehpur Sikri",
    "Jaswant Singh Ki Chhatri",
    "Kushinagar Museum",
    "Mariam’s Tomb, Sikandra, Agra",
    "Monuments of Fatehpur Sikri",
    "Pagal Baba Mandir",
    "Panch Mahal, Fatehpur Sikri",
    "Prem Mandir, Vrindavan",
    "Jodha Bai Palace, Fatehpur Sikri",
    "Saryu River, Guptar Ghat",
    "Saryu River Night View, Ayodhya",
    "Sarnath Jain Temple",
    "Sarnath Tibetan Temple",
    "Sikandra (Akbar’s Tomb Area)",
    "Taj Mahal, Agra",
    "Govind Dev Temple",
    "Tomb of Akbar the Great",
    "Tomb of Itimad-ud-Daulah",
    "Tomb of Nisar Begum, Khusro Bagh",
    "Vijayraghav Mandir, Ayodhya"
  ];
  List<int> uttarPradeshPrices = [
    400,  // Sarnath Temple
    600,  // Agra Fort
    800,  // Ayodhya Ram Mandir (High Demand)
    300,  // Jain Temple
    500,  // Dashashwamedh Ghat
    550,  // Fatehpur Sikri
    500,  // Buland Darwaza
    400,  // Hanuman Garhi
    450,  // Itimad-ud-Daulah
    500,  // ISKON Vrindavan
    500,  // Jahangiri Mahal
    400,  // Jama Masjid
    300,  // Jaswant Singh Chhatri
    350,  // Kushinagar Museum
    350,  // Mariam Tomb
    550,  // Fatehpur Monuments
    300,  // Pagal Baba Mandir
    450,  // Panch Mahal
    600,  // Prem Mandir
    500,  // Jodha Bai Palace
    300,  // Saryu River
    350,  // Saryu Night View
    300,  // Sarnath Jain Temple
    350,  // Tibetan Temple
    450,  // Sikandra
    1000, // Taj Mahal (Premium)
    400,  // Govind Dev Temple
    500,  // Akbar Tomb
    450,  // Itimad-ud-Daulah Tomb
    300,  // Nisar Begum Tomb
    400   // Vijayraghav Mandir
  ];

  List<String> uttarakhandImage=[
    UttrakhandImage.image.img1,
    UttrakhandImage.image.img2,
    UttrakhandImage.image.img3,
    UttrakhandImage.image.img4,
    UttrakhandImage.image.img5,
    UttrakhandImage.image.img6,
    UttrakhandImage.image.img7,
    UttrakhandImage.image.img8,
    UttrakhandImage.image.img9,
    UttrakhandImage.image.img10,
    UttrakhandImage.image.img11,
    UttrakhandImage.image.img12,
  ];
  List<String> uttarakhandPlaces = [
    "Valley of Flowers, Garhwal",
    "Auli, Himalayas",
    "Jama Masjid, Nainital",
    "Lansdowne",
    "Munsiyari",
    "Mussoorie",
    "Nanda Devi Temple, Munsiyari",
    "Nainital Town and Lake",
    "Temples on the Banks of River Ganges",
    "Thalisain",
    "Trayambakeshwar Temple",
    "Tungnath Temple",

  ];
  List<int> uttarakhandPrices = [
    700,  // Valley of Flowers (Premium Trek)
    800,  // Auli (Hill + Ski Destination)
    250,  // Jama Masjid
    400,  // Lansdowne
    550,  // Munsiyari
    600,  // Mussoorie (Popular Hill Station)
    300,  // Nanda Devi Temple
    500,  // Nainital Lake & Town
    450,  // Ganga Temples
    300,  // Thalisain
    350,  // Trayambakeshwar Temple
    650   // Tungnath Temple (High Altitude Trek)
  ];
  List<String> goaImage = [
    GoaImage.image.img1,
    GoaImage.image.img2,
    GoaImage.image.img3,
    GoaImage.image.img4,
    GoaImage.image.img5,
    GoaImage.image.img6,
    GoaImage.image.img7,
    GoaImage.image.img8,
    GoaImage.image.img9,
    GoaImage.image.img10,
    GoaImage.image.img11,
    GoaImage.image.img12,
    GoaImage.image.img13,
  ];

  List<String> goaPlaces = [
    "Anjuna Beach",
    "Arambol Beach",
    "Basilica of Bom Jesus",
    "Calangute Beach",
    "Chapora Fort",
    "Dudhsagar Waterfalls",
    "Basilica of Bom Jesus (Front View)",
    "Basilica of Bom Jesus (Interior)",
    "Baga Beach",
    "Reis Magos Church",
    "Basilica of Bom Jesus (Side View)",
    "Vagator Beach",
    "Goa Beach View"
  ];
  List<int> goaPrices = [
    500,  // Anjuna Beach
    450,  // Arambol Beach
    400,  // Basilica of Bom Jesus
    600,  // Calangute Beach (Most Popular)
    500,  // Chapora Fort
    800,  // Dudhsagar Waterfalls (Premium)
    400,  // Basilica Front View
    400,  // Basilica Interior
    650,  // Baga Beach (High Demand)
    350,  // Reis Magos Church
    400,  // Basilica Side View
    550,  // Vagator Beach
    500   // Goa Beach View
  ];
  List<String> keralaPlaces = [
    "Alappuzha Backwaters",
    "Alappuzha Houseboats",
    "Athirappilly Waterfalls",
    "Bekal Fort Beach",
    "Edava Lake",
    "Jain Temple, Alappuzha",
    "Kallar–Meenmutty Waterfalls",
    "Karapuzha Dam",
    "Kovalam 01 by Tanweer",
    "Kovalam Beach",
    "Kumarakom",
    "Munnar",
    "Our Lady of Mount Carmel Cathedral, Alappuzha",
    "Ponmudi Hills",
    "Poovar Island",
    "SAN BIRDS 48",
    "Marari Beach",
    "Silent Valley",
    "Sultan Bathery",
    "Athirappilly Waterfalls View"
  ];
  List<int> keralaPrices = [
    600,  // Alappuzha Backwaters
    1200, // Houseboats (Premium Experience)
    500,  // Athirappilly Waterfalls
    450,  // Bekal Fort Beach
    300,  // Edava Lake
    250,  // Jain Temple
    400,  // Kallar–Meenmutty Falls
    350,  // Karapuzha Dam
    300,  // Kovalam (Photo Spot)
    500,  // Kovalam Beach
    550,  // Kumarakom
    700,  // Munnar (Hill Station)
    300,  // Cathedral
    450,  // Ponmudi Hills
    650,  // Poovar Island
    200,  // SAN BIRDS
    500,  // Marari Beach
    600,  // Silent Valley
    400,  // Sultan Bathery
    500   // Athirappilly View
  ];

  List<String> keralaImage = [
    KeralaImage.image.img1,
    KeralaImage.image.img2,
    KeralaImage.image.img3,
    KeralaImage.image.img4,
    KeralaImage.image.img5,
    KeralaImage.image.img6,
    KeralaImage.image.img7,
    KeralaImage.image.img8,
    KeralaImage.image.img9,
    KeralaImage.image.img10,
    KeralaImage.image.img11,
    KeralaImage.image.img12,
    KeralaImage.image.img13,
    KeralaImage.image.img14,
    KeralaImage.image.img15,
    KeralaImage.image.img16,
    KeralaImage.image.img17,
    KeralaImage.image.img18,
    KeralaImage.image.img19,
    KeralaImage.image.img20,
  ];

  List<String> tamilNaduPlaces = [
    "Kumariamman Temple, Kanyakumari",
    "Madurai City",
    "Kodaikanal Lake",
    "Brihadisvara Temple, Thanjavur",
    "Brihadisvara Temple (Maha Shivaratri)",
    "Chennai City",
    "Vivekananda Rock Memorial",
    "Gandhi Memorial, Kanyakumari",
    "Gandhipuram Tea Estate, Coonoor",
    "Government Botanical Garden, Ooty",
    "Hogenakkal Waterfalls",
    "Meenakshi Amman Temple, Madurai",
    "Kanyakumari View Point",
    "Chidambaram Nataraja Temple",
    "Mahabalipuram",
    "Shore Temple, Mahabalipuram",
    "Meenakshi Amman Temple West Tower",
    "Nandi Mandapam, Thanjavur",
    "Ooty Hills",
    "Pancha Rathas, Mahabalipuram",
    "Pillar Rocks, Kodaikanal",
    "Silver Cascade Waterfalls, Kodaikanal",
    "Terraced Farming, Kodaikanal",
    "Thousand Pillared Hall, Meenakshi Temple",
    "Tiruvalluvar Statue, Kanyakumari",
    "Velankanni Basilica",
    "Golden Lotus Tank, Madurai",
    "Yercaud Lake"
  ];
  List<int> tamilNaduPrices = [
    400,  // Kumariamman Temple
    500,  // Madurai City
    450,  // Kodaikanal Lake
    600,  // Brihadisvara Temple
    650,  // Brihadisvara (Festival)
    550,  // Chennai City
    700,  // Vivekananda Rock Memorial
    300,  // Gandhi Memorial
    350,  // Tea Estate
    400,  // Botanical Garden
    500,  // Hogenakkal Falls
    650,  // Meenakshi Temple
    300,  // Kanyakumari View Point
    550,  // Chidambaram Temple
    600,  // Mahabalipuram
    650,  // Shore Temple
    500,  // Meenakshi West Tower
    400,  // Nandi Mandapam
    450,  // Ooty Hills
    550,  // Pancha Rathas
    350,  // Pillar Rocks
    300,  // Silver Cascade Falls
    250,  // Terraced Farming
    500,  // Thousand Pillared Hall
    700,  // Tiruvalluvar Statue
    450,  // Velankanni Basilica
    300,  // Golden Lotus Tank
    400   // Yercaud Lake
  ];
  List<String> tamilNaduImage = [
    TamilNaduImage.image.img1,
    TamilNaduImage.image.img2,
    TamilNaduImage.image.img3,
    TamilNaduImage.image.img4,
    TamilNaduImage.image.img5,
    TamilNaduImage.image.img6,
    TamilNaduImage.image.img7,
    TamilNaduImage.image.img8,
    TamilNaduImage.image.img9,
    TamilNaduImage.image.img10,
    TamilNaduImage.image.img11,
    TamilNaduImage.image.img12,
    TamilNaduImage.image.img13,
    TamilNaduImage.image.img14,
    TamilNaduImage.image.img15,
    TamilNaduImage.image.img16,
    TamilNaduImage.image.img17,
    TamilNaduImage.image.img18,
  ];

  List<String> rajasthanImages = [
    RajasthanImage.image.img1,
    RajasthanImage.image.img2,
    RajasthanImage.image.img3,
    RajasthanImage.image.img4,
    RajasthanImage.image.img5,
    RajasthanImage.image.img6,
    RajasthanImage.image.img7,
    RajasthanImage.image.img8,
    RajasthanImage.image.img9,
    RajasthanImage.image.img10,
    RajasthanImage.image.img11,
    RajasthanImage.image.img12,
    RajasthanImage.image.img13,
    RajasthanImage.image.img14,
    RajasthanImage.image.img15,
    RajasthanImage.image.img16,
    RajasthanImage.image.img17,
    RajasthanImage.image.img18,
    RajasthanImage.image.img19,
    RajasthanImage.image.img20,
    RajasthanImage.image.img21,
    RajasthanImage.image.img22,
    RajasthanImage.image.img23,
    RajasthanImage.image.img24,
    RajasthanImage.image.img25,
    RajasthanImage.image.img26,
    RajasthanImage.image.img27,
    RajasthanImage.image.img28,
    RajasthanImage.image.img29,
    RajasthanImage.image.img30,
    RajasthanImage.image.img31,
    RajasthanImage.image.img32,
    RajasthanImage.image.img33,
    RajasthanImage.image.img34,
    RajasthanImage.image.img35,
    RajasthanImage.image.img36,
    RajasthanImage.image.img37,
    RajasthanImage.image.img38,
    RajasthanImage.image.img39,
    RajasthanImage.image.img40,
    RajasthanImage.image.img41,
    RajasthanImage.image.img42,
    RajasthanImage.image.img43,
    RajasthanImage.image.img44,
    RajasthanImage.image.img45,
    RajasthanImage.image.img46,
    RajasthanImage.image.img47,
    RajasthanImage.image.img48,
    RajasthanImage.image.img49,
    RajasthanImage.image.img50,
    RajasthanImage.image.img51,
    RajasthanImage.image.img52,
    RajasthanImage.image.img53,
    RajasthanImage.image.img54,
    RajasthanImage.image.img55,
    RajasthanImage.image.img56,
    RajasthanImage.image.img57,
    RajasthanImage.image.img58,
    RajasthanImage.image.img59,
    RajasthanImage.image.img60,
    RajasthanImage.image.img61,
    RajasthanImage.image.img62,
    RajasthanImage.image.img63,
    RajasthanImage.image.img64,
    RajasthanImage.image.img65,
    RajasthanImage.image.img66,
    RajasthanImage.image.img67,
    RajasthanImage.image.img68,
    RajasthanImage.image.img69,
    RajasthanImage.image.img70,
    RajasthanImage.image.img71,
    RajasthanImage.image.img72,
    RajasthanImage.image.img73,
    RajasthanImage.image.img74,
  ];
  List<String> rajasthanPlaces=[
    "Adhai Din Ka Jhonpra",
    "Ajmer Sharif Dargah",
    "Akbar’s Fort & Ajmer Museum",
    "Ana Sagar Lake",
    "Foy Sagar Lake",
    "Nareli Jain Temple",
    "Pushkar Lake",
    "Soniji Ki Nasiyan (Jain Temple)",
    "Taragarh Fort",
    "Bala Quila (Alwar Fort)",
    "City Palace (Vinay Vilas Mahal)",
    "Moosi Maharani Ki Chhatri",
    "Sariska Tiger Reserve",
    "Siliserh Lake & Palace",
    "Bhangarh Fort",
    "Vijay Mandir Palace",
    "Neelkanth Mahadev Temple",
    "Karni Mata Temple",
    "Albert Hall Museum",
    "Amer Fort",
    "Birla Mandir",
    "City Palace",
    "Jaigarh Fort",
    "Jal Mahal",
    "Jantar Mantar",
    "Nahargarh Fort",
    "Hawa Mahal",
    "Ahar Museum",
    "Badi Lake",
    "Bagore Ki Haveli",
    "Bharatiya Lok Kala Mandal",
    "Bird Park Gulab Bagh",
    "City Palace",
    "Doodh Talai Lake",
    "Fateh Sagar Lake",
    "Jag Mandir",
    "Jagdish Temple",
    "Jaisamand Lake",
    "Lake Palace",
    "Lake Pichola",
    "Monsoon Palace",
    "Nagda",
    "Navalakha Mahal(Gulab Bagh)",
    "Pratap Gaurav Kendra",
    "Sahastar Bahu Temple",
    "Saheliyon Ki Bari",
    "Sajjangarh Biological Park",
    "Shilpgram",
    "Sukhadia Circle",
    "The Crystal Gallery",
    "Udaipur Fish Aquarium",
    "Vintage Car Collection",
    "Balsamand Lake",
    "Chamunda Mataji Temple",
    "Chokhelao Bagh And Interpretation Center",
    "Ghanta Ghar",
    "Guda Village",
    "Jaswant Thada",
    "Kailana Lake",
    "Machiya Blological Park",
    "Mahamandir Temple",
    "Mandaleshwar Mahadev",
    "Mandore",
    "Masuria Hills",
    "Mehrangarh Fort",
    "Mehrangarh Fort And Museum",
    "Moti Mahal",
    "Phool Mahal",
    "Ranisar Padamsar",
    "Sarder Goverment Museum",
    "Sarder Samand Lake And Palace",
    "Shastri",
    "Sheesh Mahal",
    "Umaid Bhawan Palace"
  ];
  List<int> rajasthanPrices = [
    300, 500, 450, 250, 200, 350, 400, 300, 500,
    550, 500, 300, 800, 400, 600, 450, 350, 300,
    300, 700, 250, 600, 650, 500, 550, 600, 500,
    250, 200, 350, 300, 250, 600, 200, 400, 500,
    450, 550, 700, 600, 500, 300, 250, 400, 350,
    300, 350, 300, 250, 400, 200, 350, 500, 300,
    250, 200, 300, 250, 450, 350, 300, 400, 450,
    350, 300, 400, 350, 300, 450, 500, 550, 600,
    650, 300, 250, 600
  ];
  List<String> punjabImage = [
    PunjabImage.image.img1,
    PunjabImage.image.img2,
    PunjabImage.image.img3,
    PunjabImage.image.img4,
    PunjabImage.image.img5,
    PunjabImage.image.img6,
    PunjabImage.image.img7,
    PunjabImage.image.img8,
    PunjabImage.image.img9,
    PunjabImage.image.img10,
    PunjabImage.image.img11,
    PunjabImage.image.img12,
    PunjabImage.image.img13,
    PunjabImage.image.img14,
    PunjabImage.image.img15,
  ];
  List<String> punjabPlaces = [
    "Sri Kesgarh Takhat, Anandpur Sahib",
    "Akal Takht, Harmandir Sahib Complex, Amritsar",
    "Atta Mandi Deori, Amritsar",
    "Dukh Bhanjani Ber Tree, Golden Temple",
    "Durgiana Temple, Amritsar",
    "Gurdwara Fatehgarh Sahib",
    "Harike Wetland",
    "Jallianwala Bagh, Amritsar",
    "Qila Mubarak (2015)",
    "Qila Mubarak, Patiala",
    "Rock Garden, Chandigarh",
    "Sukhna Lake, Chandigarh",
    "The Golden Temple, Amritsar",
    "Virasat-e-Khalsa, Roxy",
    "Wagah Border Ceremony",
  ];
  List<int> punjabPrices = [
    500,  // Sri Kesgarh Takhat
    700,  // Akal Takht (Golden Temple Complex)
    300,  // Atta Mandi Deori
    200,  // Dukh Bhanjani Ber Tree
    400,  // Durgiana Temple
    450,  // Fatehgarh Sahib
    350,  // Harike Wetland
    600,  // Jallianwala Bagh
    500,  // Qila Mubarak (2015)
    550,  // Qila Mubarak, Patiala
    400,  // Rock Garden
    300,  // Sukhna Lake
    800,  // Golden Temple (Main Attraction)
    450,  // Virasat-e-Khalsa
    650,  // Wagah Border Ceremony
  ];

  List<String> andhraPradeshImage = [
    AndhraPradeshImage.image.img1,
    AndhraPradeshImage.image.img2,
    AndhraPradeshImage.image.img3,
    AndhraPradeshImage.image.img4,
    AndhraPradeshImage.image.img5,
    AndhraPradeshImage.image.img6,
    AndhraPradeshImage.image.img7,
    AndhraPradeshImage.image.img8,
    AndhraPradeshImage.image.img9,
    AndhraPradeshImage.image.img10,
    AndhraPradeshImage.image.img11,
    AndhraPradeshImage.image.img12,
    AndhraPradeshImage.image.img13,
    AndhraPradeshImage.image.img14,
  ];
  List<String> andhraPradeshPlaces = [
    "Araku Valley Tribal Museum",
    "Cargo Ship and Breakwaters",
    "Grand Canyon of India (Gandikota)",
    "Juma Masjid",
    "Kondapalli Killa",
    "Mahastupa, Thotlakonda (Visakhapatnam)",
    "Shiva and Parvati Statues, Kailasagiri",
    "Simhachalam Temple",
    "Sri Vari Swarana Radhana",
    "Srisailam",
    "Thotlakonda Buddhist Complex, Visakhapatnam",
    "Tirumala",
    "Undavalli Caves, Munis",
    "Undavalli Caves, Vijayawada (Guntur)",
  ];
  List<int> andhraPradeshPrices = [
    300,  // Araku Valley Tribal Museum
    250,  // Cargo Ship and Breakwaters
    500,  // Gandikota (Grand Canyon of India)
    200,  // Juma Masjid
    350,  // Kondapalli Killa
    400,  // Mahastupa, Thotlakonda
    300,  // Kailasagiri Statues
    450,  // Simhachalam Temple
    600,  // Sri Vari Swarana Radhana
    550,  // Srisailam
    400,  // Thotlakonda Buddhist Complex
    800,  // Tirumala (High Demand)
    300,  // Undavalli Caves (Munis)
    300,  // Undavalli Caves (Vijayawada)
  ];

  List<String> delhiImage = [
    DelhiImage.image.img1,
    DelhiImage.image.img2,
    DelhiImage.image.img3,
    DelhiImage.image.img4,
    DelhiImage.image.img5,
    // DelhiImage.image.img6,
    DelhiImage.image.img7,
    DelhiImage.image.img8,
    DelhiImage.image.img9,
    DelhiImage.image.img10,
    DelhiImage.image.img11,
    DelhiImage.image.img12,
    DelhiImage.image.img13,
    DelhiImage.image.img14,
  ];
  List<String> delhiPlaces = [
    "Delhi Fort",
    "India Gate, New Delhi",
    "Isha Khan Niyazi’s Tomb",
    "Jama Masjid",
    "Lotus Temple",
    // "New Delhi Temple",
    "Qila Kuhna Masjid, Purana Qila",
    "Qutub Minar",
    "Shisha Gumbad, Lodhi Garden",
    "Swaminarayan Akshardham, Delhi",
    "Tomb of Humayun",
    "Tomb of Mohammad Shah",
    "Tomb of Sikandar Lodi",
    "View of Rashtrapati Bhawan",
  ];
  List<int> delhiPrices = [
    500,   // Delhi Fort
    300,   // India Gate
    200,   // Isha Khan Tomb
    400,   // Jama Masjid
    350,   // Lotus Temple
    450,   // Qila Kuhna Masjid
    600,   // Qutub Minar
    250,   // Shisha Gumbad
    700,   // Akshardham
    550,   // Humayun Tomb
    300,   // Mohammad Shah Tomb
    300,   // Sikandar Lodi Tomb
    800,   // Rashtrapati Bhawan View
  ];

  late List<Widget> wstate=[
    Allinone(TitleName: "Dehli", TitleColor:Color(0xFFB55239), PlaceImage: delhiImage, PlaceName: delhiPlaces,PlacePrice:delhiPrices,),
    Allinone(TitleName: "Haryana", TitleColor:Colors.green.shade500, PlaceImage:haryanaImage, PlaceName:haryanaPlaces,PlacePrice:haryanaPrices,),
    Allinone(TitleName: "पधारो म्हारो देश Rajasthan", TitleColor: Color(0xFFC8A46A), PlaceImage:rajasthanImages, PlaceName:rajasthanPlaces,PlacePrice:rajasthanPrices,),
    Allinone(TitleName: "AndhraPradesh", TitleColor:Colors.indigo.shade500, PlaceImage:andhraPradeshImage, PlaceName:andhraPradeshPlaces,PlacePrice:andhraPradeshPrices,),
    Allinone(TitleName: "Panjab", TitleColor:Color(0xFFC9A24D), PlaceImage:punjabImage, PlaceName:punjabPlaces,PlacePrice:punjabPrices,),
    Allinone(TitleName:"Uttar Pradesh", TitleColor:Colors.orange, PlaceImage:utterPradeshImage, PlaceName:uttarPradeshPlaces,PlacePrice:uttarPradeshPrices,),
    Allinone(TitleName: "Jammu Kashmir", TitleColor:Colors.lightBlue.shade500, PlaceImage:jammuimage, PlaceName:jammuPlaces,PlacePrice:jammuPrices,),
    Allinone(TitleName: "Himachal Pradesh", TitleColor:Colors.cyan, PlaceImage:himachalImage, PlaceName:himachalPlaces,PlacePrice:himachalPrices,),
    Allinone(TitleName: "Gujarat", TitleColor:Colors.cyan, PlaceImage: gujaratImage, PlaceName:gujaratPlaces,PlacePrice:gujaratPrices,),
    Allinone(TitleName:"Uttarakhand", TitleColor:Colors.yellow.shade500, PlaceImage:uttarakhandImage, PlaceName:uttarakhandPlaces,PlacePrice:uttarakhandPrices,),
    Allinone(TitleName: "Goa", TitleColor:Colors.pinkAccent.shade700, PlaceImage: goaImage, PlaceName: goaPlaces,PlacePrice:goaPrices,),
    Allinone(TitleName: "Kerala", TitleColor:Colors.grey, PlaceImage: keralaImage, PlaceName:keralaPlaces,PlacePrice:keralaPrices,),
    Allinone(TitleName: "Tamil Nadu", TitleColor:Colors.greenAccent.shade400, PlaceImage: tamilNaduImage, PlaceName: tamilNaduPlaces,PlacePrice:tamilNaduPrices,),

  ];
  List<String> indianStates = [
    "Dehli",
    "Haryana",
    "Rajasthan",
    "AndhraPradesh",
    "Punjab",
    "Uttar Pradesh",
    "Jammu Kashmir",
    "Himachal Pradesh",
    "Gujarat",
    "Uttarakhand",
    "Goa",
    "Kerala",
    "Tamil Nadu"
  ];
List<String> stateimage=[
  Stateimage.img.img1,
  Stateimage.img.img2,
  Stateimage.img.img3,
  Stateimage.img.img4,
  Stateimage.img.img5,
  Stateimage.img.img6,
  Stateimage.img.img7,
  Stateimage.img.img8,
  Stateimage.img.img9,
  Stateimage.img.img10,
  Stateimage.img.img11,
  Stateimage.img.img12,
  Stateimage.img.img13,

];
  @override
  void didChangeDependencies() {
    for (var img in stateimage) {
      precacheImage(NetworkImage(img), context);
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          top:true,
          child:Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                        Text("Travel Saathi",style:TextStyle(fontSize:25,fontWeight:FontWeight.bold,),),
                      SizedBox(height: 10,),
                      Expanded(
                        child: ListView.builder(

                            itemBuilder:(context,index){
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap:(){
                                Navigator.push(context,MaterialPageRoute(builder:(context) => wstate[index]));
                              },
                              child: Stack(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl:stateimage[index],
                                      width: double.infinity,
                                      height: 400,
                                      fit: BoxFit.cover,

                                      /// Loading UI
                                      placeholder: (context, url) => Container(
                                        height: 400,
                                        color: Colors.grey.shade300,
                                        child: const Center(
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      ),

                                      /// Error UI
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child:Container(
                                        padding:EdgeInsets.all(12),
                                        decoration:BoxDecoration(
                                          borderRadius:BorderRadius.only(bottomLeft:Radius.circular(20),
                                          bottomRight:Radius.circular(20)
                                          ),
                                          gradient:LinearGradient(
                                              begin:Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors:[
                                                Colors.black.withOpacity(0.6),
                                                Colors.transparent,
                                              ])
                                        ),
                                        child:Row(
                                          children: [
                                            Icon(Icons.location_on_rounded,color:Colors.white,),
                                            SizedBox(width:10,),
                                            Text(indianStates[index],style:TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.white),),
                                          ],
                                        ),
                                      )
                                  )
                                ]
                              ),
                            ),
                          );
                            },
                          itemCount:stateimage.length,

                        ),
                      )
                    ],
                  ),
          )),
    );
  }
}