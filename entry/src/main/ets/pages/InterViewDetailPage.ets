import { ParticleModifier, promptAction, router } from '@kit.ArkUI';
import { StartupConfigEntry } from '@kit.AbilityKit';
import { httpClient, HttpClient } from '../utils/HttpClient';
import { http } from '@kit.NetworkKit';

@Entry
@Component
struct InterViewDetailPage {
  @State message: string = '面经详情页';
  @State stem:string = ''
  @State myId:string = ''
  aboutToAppear(): void {
    const params = router.getParams() as Record<string, string> ||{}
    if(params.stem) {
      this.stem = params.stem.toString()
    }
    if(params.id){
      this.myId = params.id
    }
    httpClient.request<Object>(`question/${this.myId}`, http.RequestMethod.GET)
      .then(()=>{
        promptAction.showToast({message:'success'})
      })
      .catch(()=>{
        promptAction.showToast({message:'fail'})
      })
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