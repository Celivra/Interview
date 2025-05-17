import { ParticleModifier, router } from '@kit.ArkUI';
import { StartupConfigEntry } from '@kit.AbilityKit';

@Entry
@Component
struct InterViewDetailPage {
  @State message: string = '面经详情页';
  @State stem:string = ''
  aboutToAppear(): void {
    const params = router.getParams() as Record<string, string> ||{}
    if(params.stem) {
      this.stem = params.stem.toString()
    }
  }
  build() {
    RelativeContainer() {
      Text(this.stem)
        .id('InterViewDetailPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .height('100%')
    .width('100%')
  }
}