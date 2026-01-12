import { mapCommon } from '@kit.MapKit'

export interface HoleModel {
  holeName: string
  par: number
  desc: string,
  img: Resource,
  lat: string,
  lan: string,
  mapFrame: mapCommon.LatLng[],
  holeLat: mapCommon.LatLng,
  startLat: mapCommon.LatLng
}

export const mockHoleData: HoleModel[] = [
  {
    holeName: 'Hole 1',
    par: 3,
    desc: 'The hole sloping gently from east to west.The green measures 23 by 17 meters (391 m²). With the right iron and wind consideration, reaching the green from the tee is quite achievable—setting you up for a confident start.',
    img: $r('app.media.cukur1'),
    lat:'38.316249',
    lan:'26.718988',
    mapFrame: [
      { latitude: 38.315815, longitude: 26.720250 },
      { latitude: 38.315935, longitude: 26.720189 },
      { latitude: 38.315993, longitude: 26.719791 },
      { latitude: 38.315935, longitude: 26.719111 },
      { latitude: 38.315832, longitude: 26.718662 },
      { latitude: 38.315715, longitude: 26.718620 },
      { latitude: 38.315597, longitude: 26.718764 },
      { latitude: 38.315625, longitude: 26.719012 },
      { latitude: 38.315657, longitude: 26.719634 },
      { latitude: 38.315697, longitude: 26.720205 }
    ],
    holeLat: {latitude:38.315765, longitude:26.718843},
    startLat: {latitude:38.315840, longitude:26.720135}
  },
  {
    holeName: 'Hole 2',
    par: 3,
    desc: 'This hole runs parallel to the first and rises from west to east. Olive trees line the right side, with pine and olive trees near the green. The green is elevated and visible from the tee but quite narrow, with an out-of-bounds area behind it, making club selection crucial. A pleasant uphill walk rewards you with a beautiful view from the green.',
    img: $r('app.media.cukur2'),
    lat:'38.316249',
    lan:'26.718988',
    mapFrame: [
      { latitude: 38.316145, longitude: 26.720330 },
      { latitude: 38.316318, longitude: 26.720285 },
      { latitude: 38.316308, longitude: 26.719886 },
      { latitude: 38.316308, longitude: 26.719615 },
      { latitude: 38.316328, longitude: 26.719051 },
      { latitude: 38.316213, longitude: 26.718831 },
      { latitude: 38.316055, longitude: 26.718952 },
      { latitude: 38.316055, longitude: 26.719319 },
      { latitude: 38.316058, longitude: 26.719736 },
      { latitude: 38.316008, longitude: 26.720177 }
    ],
    holeLat: {latitude:38.316228, longitude:26.720269},
    startLat: {latitude:38.316086, longitude:26.719098}
  },
  {
    holeName: 'Hole 3',
    par: 3,
    desc: 'A gentle downhill hole with a wide fairway and a bunker protecting the left side of the green. The green is slightly sloped and requires a precise approach. A smooth start for players who enjoy controlled shots.',
    img: $r('app.media.cukur3'),
    lat:'38.316249',
    lan:'26.718988',
    mapFrame: [
      { latitude: 38.316483, longitude: 26.720317 },
      { latitude: 38.316571, longitude: 26.720534 },
      { latitude: 38.316626, longitude: 26.720799 },
      { latitude: 38.316671, longitude: 26.721073 },
      { latitude: 38.316718, longitude: 26.721322 },
      { latitude: 38.316651, longitude: 26.721462 },
      { latitude: 38.316528, longitude: 26.721405 },
      { latitude: 38.316466, longitude: 26.721213 },
      { latitude: 38.316458, longitude: 26.720891 },
      { latitude: 38.316436, longitude: 26.720547 }
    ],
    holeLat: {latitude:38.316581, longitude:26.721319},
    startLat: {latitude:38.316485, longitude:26.720446
    }
  },
  {
    holeName: 'Hole 4',
    par: 4,
    desc: 'A long fairway stretches ahead, narrowing near the green. A stream guards the front, while the back offers a safe landing area. Choose your club wisely to avoid the water and aim for an easy two-putt finish.',
    img: $r('app.media.cukur4'),
    lat: '38.316249',
    lan: '26.718988',
    mapFrame: [
      { latitude: 38.316834, longitude: 26.721421 },
      { latitude: 38.317249, longitude: 26.721277 },
      { latitude: 38.317101, longitude: 26.720234 },
      { latitude: 38.316944, longitude: 26.719312 },
      { latitude: 38.316856, longitude: 26.719229 },
      { latitude: 38.316803, longitude: 26.718636 },
      { latitude: 38.316623, longitude: 26.718524 },
      { latitude: 38.316438, longitude: 26.718719 },
      { latitude: 38.316416, longitude: 26.719354 },
      { latitude: 38.316486, longitude: 26.720043 },
      { latitude: 38.316593, longitude: 26.720862 }
    ],
    holeLat: { latitude: 38.316636, longitude: 26.718840 },
    startLat: { latitude: 38.317219, longitude: 26.721360 }
  },
  {
    holeName: 'Hole 5',
    par: 3,
    desc: 'This short par 3 plays slightly uphill, with trees framing both sides. The green is wide but shallow, demanding accurate distance control. A rewarding hole for those who trust their irons.',
    img: $r('app.media.cukur5'),
    lat:'38.316249',
    lan:'26.718988',
    mapFrame: [
      { latitude: 38.316871, longitude: 26.718429 },
      { latitude: 38.316854, longitude: 26.718094 },
      { latitude: 38.316513, longitude: 26.718122 },
      { latitude: 38.315852, longitude: 26.718221 },
      { latitude: 38.315852, longitude: 26.718410 },
      { latitude: 38.315923, longitude: 26.718534 },
      { latitude: 38.316088, longitude: 26.718438 },
      { latitude: 38.316546, longitude: 26.718272 },
      { latitude: 38.316768, longitude: 26.718320 }
    ],
    holeLat: {latitude:38.315958, longitude:26.718349 },
    startLat: { latitude: 38.316750, longitude: 26.718229 }
  },
  {
    holeName: 'Hole 6',
    par: 3,
    desc: 'A downhill hole with a clear view of the flag. Bunkers on both sides challenge your accuracy, while the breeze can affect your shot. A scenic and enjoyable hole that tests both skill and focus.',
    img: $r('app.media.cukur6'),
    lat:'38.316249',
    lan:'26.718988',
    mapFrame: [
      { latitude: 38.315725, longitude: 26.718327 },
      { latitude: 38.315660, longitude: 26.718244 },
      { latitude: 38.315364, longitude: 26.718288 },
      { latitude: 38.315357, longitude: 26.718563 },
      { latitude: 38.315407, longitude: 26.719201 },
      { latitude: 38.315415, longitude: 26.720097 },
      { latitude: 38.315567, longitude: 26.720231 },
      { latitude: 38.315640, longitude: 26.720260 },
      { latitude: 38.315587, longitude: 26.719070 },
      { latitude: 38.315487, longitude: 26.718655 },
      { latitude: 38.315547, longitude: 26.718454 },
      { latitude: 38.315650, longitude: 26.718320 }
    ],
    holeLat: {latitude:38.315567, longitude:26.720119 },
    startLat: { latitude: 38.315368, longitude: 26.718371 }
  }

]