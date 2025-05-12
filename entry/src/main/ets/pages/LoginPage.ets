import { NavComp } from '../component/NavComp';

@Entry
@Component
struct LoginPage {
  @State message: string = 'Hello World';

  build() {
    Column(){
      NavComp()
    }
    .width('100%')
    .height('100%')
  }
}