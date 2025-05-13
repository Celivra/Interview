import { NavComp } from '../component/NavComp';

@Entry
@Component
struct LoginPage {
  @State loading:boolean=true;

  build() {
    Column(){
      NavComp()
      Column({space:5}){
        Image($r('app.media.ic_mine_logo'))
          .width(120)
          .aspectRatio(1)
        Text('面试通')
          .fontSize(24)
        Text('搞定企业面试真题，就用面试通')
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
      }

      Column(){
        TextInput({placeholder:'请输入用户名'})
          .inputStyle()
          .border({width:{bottom:0.5}, color:$r('app.color.common_gray_border')})
        TextInput({placeholder:'请输入密码'})
          .inputStyle()
          .type(InputType.Password)
          .showPasswordIcon(false)

        Button({type:ButtonType.Normal}){
          Row(){
            if(this.loading){
              LoadingProgress()
                .width(24)
                .aspectRatio(1)
                .color(Color.White)
                .margin({right:10})
            }
            Text('立即登入')
              .fontColor(Color.White)
          }
        }
        .width('100%')
        .backgroundColor($r('app.color.common_main_color'))
        .borderRadius(4)
        .height(44)
        .margin({top:15})
      }
      .padding(35)
    }
    .width('100%')
    .height('100%')
  }
}
@Extend(TextInput)
function inputStyle(){
  .caretColor($r('app.color.common_main_color'))
  .height(44)
  .backgroundColor(Color.White)
  .borderRadius(0)
  .placeholderColor($r('app.color.common_gray_01'))

}
