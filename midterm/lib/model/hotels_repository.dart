import 'model_hotel.dart';

class HotelRepository {
  static List<Hotel> loadHotels(Star star) {
    const allHotel = <Hotel> [
      Hotel(
        star: Star.three,
        stars: 3,
        like: false,
        id: 1,
        name: 'Aventree Hotel Busan',
        phone: '054-123-1111',
        location: '12-1, Changseon-dong 1-ga, Jung-gu, Busan 600-051, South Korea',
        desc: 'With a stay at Aventree Hotel Busan in Busan (Jung-gu), you will be steps from Gukje Market and Nampodong Street. Featured amenities include complimentary wired Internet access, a 24-hour business center, and complimentary newspapers in the lobby. Limited parking is available onsite.',
      ),
      Hotel(
        star: Star.three,
        stars: 3,
        like: false,
        id: 2,
        name: 'ibis Ambassador Busan City Centre',
        phone: '054-123-1112',
        location: '777, Jungang-Daero, Busanjin-gu, Busan 614-030, South Korea',
        desc: 'Located in the central business district of Busan, the ibis Ambassador Busan City Centre is a gateway to the bustling business, financial and shopping precincts of Busan. The hotel is 30 minutes from Gimhae International Airport and next to the central railway station of Bujeon. The hotel features 207 rooms, a restaurant, bar and free Broadband WIFI internet access. ibis Ambassador Busan City Centre also offers excellent meeting facilities for up to 120 guests.',
      ),
      Hotel(
        star: Star.four,
        stars: 4,
        like: false,
        id: 3,
        name: 'Sunset Business Hotel',
        phone: '054-123-1113',
        location: '46, Gunam-ro, Haeundae-gu, Busan 612-010, South Korea',
        desc: 'With a stay at Sunset Business Hotel in Busan (Haeundae), you will be steps from Haeundae Beach and 3 minutes by foot from Busan Aquarium. Featured amenities include complimentary wired Internet access, a 24-hour business center, and express check-in. Free self parking is available onsite.',
      ),
      Hotel(
        star: Star.three,
        stars: 3,
        like: false,
        id: 4,
        name: 'Ibis Budget Ambassador Busan Haeundae',
        phone: '054-123-1114',
        location: '8, Haeundaehaebyeon-ro 209Beon-Gil, Busan 612821, South Korea',
        desc: 'A scenic view of the ocean on one side and Busan city\'s skyline on the other, ibis budget Ambassador Busan Haeundae offers excellent accommodation and services at great value. This non-smoking hotel offers 177 rooms with multiple options suited to needs of solo business travelers to families on a leisure holiday. The La Matinee restaurant at the hotel offers buffet as a breakfast with a professional multi-lingual staff at your service round the clock.',
      ),
      Hotel(
        star: Star.five,
        stars: 5,
        like: false,
        id: 5,
        name: 'Lotte Hotel Busan',
        phone: '054-123-1115',
        location: '772, Gaya-Daero, Busanjin-gu, Busan 614-030, South Korea',
        desc: 'A stay at Lotte Hotel Busan places you in the heart of Busan, within a 10-minute drive of Gukje Market and Gwangalli Beach. Featured amenities include complimentary wired Internet access, a business center, and complimentary newspapers in the lobby. This hotel has 2 meeting rooms available for events. For a surcharge, guests may use a roundtrip airport shuttle (available 24 hours) and a train station pick-up service.',
      ),
      Hotel(
        star: Star.one,
        stars: 1,
        like: false,
        id: 6,
        name: 'Park Hyatt Busan',
        phone: '054-123-1116',
        location: '51, Marine City 1-ro, Haeundae-Gu, Busan 612-824, South Korea',
        desc: 'Situated at the heart of the city’s premier shopping and beach destination Haeundae, Park Hyatt Busan is the ideal residence for the sophisticated luxury traveller visiting Korea’s second largest city for business or leisure. Occupying a dramatic oceanfront location offering scenic views of Gwangan Bridge, Park Hyatt Busan provides 269 luxuriously appointed rooms and suites equipped with latest in technology and all the luxury amenities a modern traveller could desire.',
      ),
      Hotel(
        star: Star.three,
        stars: 3,
        like: false,
        id: 7,
        name: 'Paradise Hotel Busan',
        phone: '054-123-1117',
        location: '296, Haeundaehaebyeon-ro, Haeundae-gu, Busan 612-010, South Korea',
        desc: 'Located in Busan (Haeundae), Paradise Hotel Busan is steps from Haeundae Beach and a 5-minute drive from Gwangalli Beach. Featured amenities include complimentary wired Internet access, a business center, and limo/town car service. A roundtrip airport shuttle is available for a surcharge.',
      ),
      Hotel(
        star: Star.three,
        stars: 3,
        like: false,
        id: 8,
        name: 'Tower Hill Hotel',
        phone: '054-123-1118',
        location: '20, Baeksan-gil, Jung-gu, Busan 600-023, South Korea',
        desc: 'Located in Busan (Jung-gu), Tower Hill Hotel is within a 5-minute walk of Yongdusan Park and Busan Tower. Featured amenities include a 24-hour business center, express check-in, and express check-out. Free self parking is available onsite.',
      ),
    ];
    if (star == Star.all) {
      return allHotel;
    } else {
      return allHotel.where((Hotel h) {
        return h.star == star;
      }).toList();
    }
  }
}