import { promptAction, router } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit'
import { NavComp } from '../component/NavComp'
import { Res, User } from '../models/Index'
import { auth } from '../utils/Auth'

@Entry
@Component
struct LoginPage {
  @StorageProp('topHeight')
  topHeight: number = 0
  @State
  username: string = 'hmheima'
  @State
  password: string = 'Hmheima%123'
  @State
  loading: boolean = false


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

    try {
      this.loading = true
      const req = http.createHttp()
      const res = await req.request('https://api-harmony-teach.itheima.net/hm/login', {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json'
        },
        extraData: {
          username: this.username,
          password: this.password
        },
        expectDataType: http.HttpDataType.OBJECT
      })
      const result = res.result as Res<User>
      if (result.code === 10000) {
        // success, save information
        const result = res.result as Res<User>
        auth.setUser(result.data)
        router.back()
      } else {
        // fail, prompt error information
        promptAction.showToast({ message: result.message })
      }
      this.loading = false
    } catch (e) {
      this.loading = false
      promptAction.showToast({ message: '登录失败' })
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