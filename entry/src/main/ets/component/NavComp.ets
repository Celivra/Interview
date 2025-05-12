import { router } from '@kit.ArkUI'
@Component
export struct NavComp {
  @StorageProp('topHeight')
  topHeight: number = 0
  // 标题文字
  @Prop
  title: string = ''
  build() {
    Row({ space: 15 }) {
      Image($r('app.media.ic_common_back'))
        .size({ width: 24, height: 24 })
        .fillColor($r('app.color.black'))
        .onClick(() => router.back())
      Row() {
        if (this.title) {
          Text(this.title)
            .fontWeight(600)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
      }
      .height(56)
      .layoutWeight(1)
      Blank()
        .width(24)
    }
    .padding({ left: 15, right: 15, top: this.topHeight })
    .height(56 + this.topHeight)
    .width('100%')
  }
}