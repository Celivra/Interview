@Component
export struct TagComp {
  @Prop tag: string = ''

  build() {
    Text(this.tag)
      .fontSize(10)
      .fontColor($r('app.color.common_green'))
      .backgroundColor($r('app.color.common_blue_bg'))
      .padding({ top: 2, bottom: 2, left: 6, right: 6 })
      .borderRadius(2)
  }
}