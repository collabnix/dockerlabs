import BaseComponent from '~/base/component';

import { fadeIn } from '~/utils/effects';

// UsersSignInPage component responsible to instantiate
// the user's sign in page components and handle interactions.
class UsersSignInPage extends BaseComponent {
  mount() {
    fadeIn(this.$el);
  }
}

export default UsersSignInPage;
