import { ArcListItem, ArcListItemAttribute } from '@kit.ArkUI';
import { HoleModel } from '../models/HoleModel';


@Entry
@Component
export struct TrailListComponent {
  @Prop item: HoleModel;

  build() {
    ArcListItem() {
      Row() {
        Image(this.item.img)
          .width('99px')
          .height('99px')
          .borderRadius('30px')
          .padding(5)

        Column() {
          Text(this.item.holeName).fontSize('38px').fontColor('#FFFFFFFF')
          if (this.item.par) {
            Text(`PAR ${this.item.par.toString()}`).fontSize('20px').fontColor('#FFFFFFFF')
          }
        }.width('190px')

        Image($r('app.media.chevron_right'))
          .width('50px')
          .height('50px')
          .borderRadius('50px')
      }
    }
    .borderRadius('65px')
    .width('414px')
    .height('129px')
    .backgroundColor('#26FFFFFF')
  }
}

