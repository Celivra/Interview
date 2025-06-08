import { promptAction, router } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit'
import { NavComp } from '../component/NavComp'
import { User } from '../models/index'
import { auth } from '../utils/Auth'
import { httpClient } from '../utils/HttpClient'

@Entry
@Component
struct LoginPage {
  @StorageProp('topHeight') topHeight: number = 0
  @State username: string = 'hmheima'
  @State password: string = 'Hmheima%123'
  @State loading: boolean = false


  async login() {
    if (this.loading) {
      return
    }
    if (!this.username) {
      return promptAction.showToast({ message: '请输入用户名' })
    }
    if (!this.password) {
      return promptAction.showToast({ message: '请输入密码' })
    }

    this.loading = true
    try{
      const data = await httpClient.request<User>('login', http.RequestMethod.POST, new Object({
        username:this.username,
        password:this.password
      }))
      auth.setUser(data)

      const params = router.getParams() as Record<string, string> || {}
      if(params.returnUrl){
        router.replaceUrl({url:params.returnUrl, params:params})
      }else{
        router.back()
      }
      this.loading = false
    }catch (e){
      this.loading = false
      promptAction.showToast({message:'登入失败'})
    }
  }

  build() {
    Column() {
      NavComp()
      Column() {
        Image($r('app.media.icon'))
          .width(120)
          .aspectRatio(1)
        Text('面试通')
          .fontSize(28)
          .margin({ bottom: 15 })
        Text('搞定企业面试真题，就用面试通')
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
      }
      .padding(16)

      Column({ space: 15 }) {
        TextInput({ placeholder: '请输入用户名', text: $$this.username })
          .border({ width: { bottom: 0.5 }, color: $r('app.color.common_gray_border') })
          .customStyle()
        TextInput({ placeholder: '请输入密码', text: $$this.password })
          .type(InputType.Password)
          .showPasswordIcon(false)
          .customStyle()

        Button({ type: ButtonType.Normal }) {
          Row() {
            if (this.loading) {
              LoadingProgress()
                .color($r('app.color.white'))
                .width(24)
                .height(24)
                .margin({ right: 10 })
            }
            Text('立即登录')
              .fontColor($r('app.color.white'))
          }
        }
        .width('100%')
        .backgroundColor($r('app.color.common_main_color'))
        .borderRadius(4)
        .height(44)
        .onClick(() => {
          this.login()
        })
      }
      .padding(36)
    }
    .width('100%')
    .height('100%')
  }
}

@Extend(TextInput)
function customStyle() {
  .placeholderColor('#C3C3C5')
  .caretColor('#fa711d')
  .height(44)
  .borderRadius(0)
  .backgroundColor($r('app.color.white'))
}