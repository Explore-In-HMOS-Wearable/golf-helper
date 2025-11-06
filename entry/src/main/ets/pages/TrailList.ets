import { TrailListComponent } from '../components/TrailListComponent';
import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStyleMode,
  ArcList,
  LengthMetrics,
  ArcListItem, ArcListAttribute, ArcListItemAttribute,} from '@kit.ArkUI';
import { HoleModel, mockHoleData } from '../models/HoleModel';


@Builder
function TrailListBuilder() {
  TrailList()
}


@Entry({ routeName: 'TrailList' })
@Component
struct TrailList {
  pathStack: NavPathStack = new NavPathStack();


  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Top }){
        ArcButton({
          options: new ArcButtonOptions({
            label: $r('app.string.goBack'),
            position: ArcButtonPosition.TOP_EDGE,
            styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
            onClick: () => {
              this.pathStack.pop()
            }
          })
        }).zIndex(10)
        ArcList({ initialIndex: 0 }) {
          ForEach(mockHoleData, (it: HoleModel) => {
            TrailListComponent({ item: it }).onClick(()=>{
              this.pathStack.pushPath({ name:'HoleDetail', param:it })
            })
          })
        }
        .width('100%')
        .height('100%')
        .space(LengthMetrics.px(10))
        .backgroundColor(Color.Black)
      }
      .backgroundColor(Color.Black)
      .width('100%')
      .height('100%')
    }.onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
    .hideTitleBar(true)

  }
}