import { App, window } from '@kit.ArkUI'

class FullScreen{
  async enable(){
    const baseContext = AppStorage.get<Context>('context');
    if(!baseContext) return;

    const win = await window.getLastWindow(baseContext)
    await win.setWindowLayoutFullScreen(true)

    const topArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
    const bottomArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
    AppStorage.setOrCreate('topHeight',px2vp(topArea.topRect.height))
    AppStorage.setOrCreate('bottomHeight',px2vp(bottomArea.bottomRect.height))

  }
  async disable(){
    const baseContext = AppStorage.get<Context>('context');
    if(!baseContext) return;

    const win = await window.getLastWindow(baseContext)
    await win.setWindowLayoutFullScreen(false)

    AppStorage.setOrCreate('topHeight',0)
    AppStorage.setOrCreate('bottomHeight',0)
  }
}
export const fullScreen = new FullScreen();