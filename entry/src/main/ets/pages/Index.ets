import { fullScreen } from '../utils/FullScreen';
import { statusBar } from '../utils/StatusBar';

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
      Button("白色状态栏").onClick((event: ClickEvent) => {
        statusBar.setLightBar();
      })
      Button("黑色状态栏").onClick((event: ClickEvent) => {
        statusBar.setDarkBar();
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