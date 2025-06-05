import { User } from "../models/index"
import { router } from "@kit.ArkUI"

export const UserStoreKey = 'my-user'
class Auth {
  initUser() {
    PersistentStorage.persistProp<User>(UserStoreKey, {} as User)
  }
  getUser () {
    return AppStorage.get<User>(UserStoreKey) || {} as User
  }
  setUser(user: User) {
    AppStorage.setOrCreate<User>(UserStoreKey, user)
  }

  checkAuth(options:router.RouterOptions | Function){
    const user = this.getUser()
    if(typeof options === 'function'){
      if(user.token) options()
      else router.pushUrl({url:'pages/LoginPage'})
    }
    else if(user.token) router.pushUrl(options)
    else{
      const params = options.params as Record<string, string> || {}
      params.returnUrl = options.url
      router.pushUrl({url:"pages/LoginPage", params:params})
    }

  }

}
export const auth = new Auth()