import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStyleMode } from '@kit.ArkUI';

@Builder
function indexBuilder() {
  Index()
}

@Entry({ routeName: 'Index' })
@Component
struct Index {
  pageInfos: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageInfos) {
      Column(){
        Text($r('app.string.HuaweiGolfApp')).fontColor(Color.White).fontSize(15).fontWeight(900)
        Blank().height(10)
        Image($r('app.media.golfPitch')).width(130)
        Blank().height(10)
        ArcButton({
          options: new ArcButtonOptions({
            label: $r('app.string.Trails'),
            position: ArcButtonPosition.BOTTOM_EDGE,
            styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
            onClick: () => {
              this.pageInfos.pushPath({ name:'Trails' })
            }
          })
        })
      }
      .backgroundColor(Color.Black)
      .width('100%')
      .height('100%')
      .padding(30)
    }.hideToolBar(true)
  }
}