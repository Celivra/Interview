import { User } from "../models/Index"

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
}
export const auth = new Auth()