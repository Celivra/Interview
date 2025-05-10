import { fullScreen } from '../utils/FullScreen';
@Entry
@Component
struct Index {
  @StorageProp('topHeight') topHeight:number = 0;
  @StorageProp('bottomHeight') bottomHeight:number = 0;

  build() {
    Column({space:20}){
      Text("Top")
      Button("开启沉浸式").onClick((event: ClickEvent) => {
        fullScreen.enable();
      })
      Button("关闭沉浸式").onClick((event: ClickEvent) => {
        fullScreen.disable();
      })
      Blank()
      Text("bottom")
    }
    .padding({top:this.topHeight, bottom:this.bottomHeight})
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Orange)
  }
}