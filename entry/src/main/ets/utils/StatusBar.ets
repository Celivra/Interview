import { window } from '@kit.ArkUI';

class StatusBar{
  async setBar(config:window.SystemBarProperties){
    const baseContext = AppStorage.get<Context>('context');
    if(!baseContext) return;
    const win = await window.getLastWindow(baseContext);
    await win.setWindowSystemBarProperties(config);
  }

  async setLightBar(){
    this.setBar({statusBarContentColor:'#ffffff'})
  }
  async setDarkBar(){
    this.setBar({statusBarContentColor:'#000000'})
  }
}
export const statusBar = new StatusBar();