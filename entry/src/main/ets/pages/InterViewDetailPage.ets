import { ParticleModifier, promptAction, router } from '@kit.ArkUI';
import { StartupConfigEntry } from '@kit.AbilityKit';
import { httpClient, HttpClient } from '../utils/HttpClient';
import { http } from '@kit.NetworkKit';
import { InterviewItem } from '../models';
import { NavComp } from '../component/NavComp';
import { TagComp } from '../component/TagComp';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct InterviewDetailPage {
  @State detail: InterviewItem = {} as InterviewItem

  aboutToAppear(): void {
    const params = router.getParams() as InterviewItem
    this.detail = params
  }

  @Builder
  HeaderBuilder() {
    Column({ space: 15 }) {
      Text(this.detail.stem)
        .fontWeight(600)
        .fontSize(18)
        .padding({ left: 15, right: 15 })
        .width('100%')

      Row({ space: 4 }) {
        Image(this.detail.creatorAvatar)
          .width(36)
          .aspectRatio(1)
        Column({ space: 4 }) {
          Text(this.detail.creatorName)
            .fontSize(14)
          Text() {
            Span('浏览 ' + this.detail.views)
            Span(' · ')
            Span('点赞 ' + this.detail.likeCount)
            Span(' · ')
            Span(this.detail.createdAt)
          }
          .width('100%')
          .fontSize(12)
          .fontColor('#bdbdbd')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .padding({ left: 15, right: 15 })

      Row({ space: 4 }) {
        ForEach(['大厂', '面经'], (tag: string) => {
          TagComp({ tag })
        })
      }
      .width('100%')
      .padding({ left: 15, right: 15 })
    }
  }

  webViewController = new webview.WebviewController
  build() {
    Column() {
      NavComp()
      List() {
        ListItem() {
          this.HeaderBuilder()
        }
        ListItem(){
          Web({src:$rawfile('test.html'),controller:this.webViewController})
        }
      }
      .layoutWeight(1)
      .height('100%')
      .width('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
    }
    .height('100%')
    .width('100%')
  }
}