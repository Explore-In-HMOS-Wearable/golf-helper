import { MapComponent, mapCommon, map } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { HoleModel } from '../models/HoleModel';
import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStyleMode } from '@kit.ArkUI';
import PermissionsUtil from '../utils/PermissionsUtil';
import { geoLocationManager } from '@kit.LocationKit';
import { sensor } from '@kit.SensorServiceKit';

@Builder
function mapPageBuilder() {
  MapPage()
}

@Entry({ routeName: 'MapPage' })
@Component
struct MapPage {
  pathStack: NavPathStack | undefined = undefined;
  private TAG = 'HuaweiMapDemo';
  private mapOptions?: mapCommon.MapOptions;
  private callback?: AsyncCallback<map.MapComponentController>;
  private mapController?: map.MapComponentController;
  private mapEventManager?: map.MapEventManager;
  private mapPolygon?: map.MapPolygon;
  private mapCircle?: map.MapCircle;
  pageParam?: HoleModel;

  @Prop holeLat: string
  @Prop holeLon: string
  @Prop userLocation: mapCommon.LatLng
  @State distanceMeters: number = 0
  @State azimuth: number = 0

  aboutToAppear(): void {
    PermissionsUtil.requestPermissions([
      'ohos.permission.LOCATION',
      'ohos.permission.APPROXIMATELY_LOCATION',])

    sensor.on(sensor.SensorId.ROTATION_VECTOR, (data: sensor.RotationVectorResponse) => {
      console.info(`Succeeded in invoking on. X-coordinate component: ${data.x}`);
      const x = data.x;
      const y = data.y;
      const z = data.z;
      const w = data.w;
      const sinyCosp = 2 * (w * z + x * y)
      const cosyCosp = 1 - 2 * (y * y + z * z)
      const azimuthRad = Math.atan2(sinyCosp, cosyCosp)
      const azimuthDeg = (azimuthRad * 180 / Math.PI + 360) % 360
      this.azimuth = Math.round(azimuthDeg)
    }, { interval: 100_000_000 }) // every 100ms

    // Initialize callback for map
    this.callback = async (err, mapController) => {
      if (!err) {
        this.mapController = mapController;
        this.mapEventManager = this.mapController.getEventManager();

        this.mapController.setMyLocationEnabled(true);
        this.mapController.setMyLocationControlsEnabled(true);
        this.userLocation = await geoLocationManager.getCurrentLocation();

        // Calculate distance to pageParam location
        if (this.pageParam) {
          let targetLatLng: mapCommon.LatLng = {
            latitude: parseFloat(this.pageParam.lat),
            longitude: parseFloat(this.pageParam.lan)
          };

          this.distanceMeters = map.calculateDistance(this.userLocation, targetLatLng);
        }

        // When the map is loaded, draw the polygon
        this.mapEventManager.on('mapLoad', async () => {
          console.info(this.TAG, `on-mapLoad`);
          await this.addPolygonOnMap();
        });
      } else {
        console.error(`Failed to initialize the map. Code: ${err.code}; message: ${err.message}`);
      }
    };
  }

  async addPolygonOnMap() {
    if (!this.mapController){
      return
    };

    // Explicitly type the array
    const polygonPoints: mapCommon.LatLng[] = this.pageParam?.mapFrame!

    // Define polygon options
    let polygonOptions: mapCommon.MapPolygonOptions = {
      points: polygonPoints,
      clickable: true,
      fillColor: 0x5500DE00,
      geodesic: false,
      strokeColor: 0xff000000,
      jointType: mapCommon.JointType.DEFAULT,
      strokeWidth: 8,
      visible: true,
      zIndex: 5
    };

    let mapCircleOptions: mapCommon.MapCircleOptions = {
      center: this.pageParam?.holeLat!,
      radius: 5,
      clickable: true,
      fillColor: 0xFF2196F3, // Blue fill
      strokeColor: 0xFF0D47A1, // Dark blue border
      strokeWidth: 1,
      visible: true,
      zIndex: 15
    }

    let mapCircleOptionsStart: mapCommon.MapCircleOptions = {
      center: this.pageParam?.startLat!,
      radius: 5,
      clickable: true,
      fillColor: 0xFFFFA500, // Orange fill
      strokeColor: 0xFFBF360C, // Dark orange border
      strokeWidth: 1,
      visible: true,
      zIndex: 15
    }

    // Add the polygon
    this.mapPolygon = await this.mapController.addPolygon(polygonOptions);
    this.mapCircle = await this.mapController.addCircle(mapCircleOptions);
    this.mapCircle = await this.mapController.addCircle(mapCircleOptionsStart);
    console.info(this.TAG, 'Polygon added successfully.');
  }

  onPageShow(): void {
    if (this.mapController) {
      this.mapController.show();
    }
  }

  onPageHide(): void {
    if (this.mapController) {
      this.mapController.hide();
    }
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Top }) {
        ArcButton({
          options: new ArcButtonOptions({
            label: $r('app.string.goBack'),
            position: ArcButtonPosition.TOP_EDGE,
            styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
            onClick: () => {
              this.pathStack!.pop()
            }
          })
        }).zIndex(10)
        Text($r('app.string.distance', this.distanceMeters.toFixed(2))).fontColor(Color.Black).fontSize(13).fontWeight(FontWeight.Bold).margin({top:70}).zIndex(10)

        Image($r('app.media.compass_icon'))
          .width(65)
          .height(65)
          .rotate({ angle: -this.azimuth })
          .position({ x: 35, y: 140 })
          .zIndex(20)

        MapComponent({
          mapOptions: this.mapOptions,
          mapCallback: this.callback
        })
          .width('100%')
          .height('100%');
      }.height('100%')
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
      this.pageParam = context.pathInfo.param as HoleModel;
      this.holeLat = this.pageParam.lat;
      this.holeLon = this.pageParam.lan;

      // Center the map on the provided coordinates
      this.mapOptions = {
        position: {
          target: {
            latitude: parseFloat(this.holeLat),
            longitude: parseFloat(this.holeLon)
          },
          zoom: 17
        }
      };
    })
    .hideTitleBar(true);
  }
}
