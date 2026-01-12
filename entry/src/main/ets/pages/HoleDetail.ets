import { HoleModel } from '../models/HoleModel';
import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStyleMode } from '@kit.ArkUI';

@Builder
function holeDetailBuilder() {
  HoleDetail()
}


@Entry({ routeName: 'HoleDetail' })
@Component
struct HoleDetail {
  pathStack: NavPathStack = new NavPathStack();
  pageParam?: HoleModel;

  build() {
    NavDestination() {
      Scroll() {
        Column() {
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
          Text($r('app.string.hole', this.pageParam?.holeName)).fontColor(Color.White).fontSize(15).fontWeight(FontWeight.Bold)
          Blank().height(10)
          Row() {
            Text(this.pageParam?.desc).fontColor(Color.White).fontSize(11).width('50%').textAlign(TextAlign.Start)
            Blank().width(15)
            Column(){
              Image(this.pageParam?.img).width(80)
              Blank().height(5)
              Button($r('app.string.mapButton')).height(30).onClick(()=>{
                this.pathStack.pushPath({ name:'MapPage', param: this.pageParam })
              })
            }
          }.width('100%')
          Blank().height(15)
        }.width('100%')
      }
      .padding({left:30, right:30, bottom:30})
      .width('100%')
      .height('100%')
      .scrollable(ScrollDirection.Vertical)
      .scrollBarWidth(0)
    }.onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
      this.pageParam = context.pathInfo.param as HoleModel;
    })
    .hideTitleBar(true)

  }
}