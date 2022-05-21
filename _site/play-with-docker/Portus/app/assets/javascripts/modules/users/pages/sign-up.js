import BaseComponent from '~/base/component';

import { fadeIn } from '~/utils/effects';

// UsersSignUpPage component responsible to instantiate
// the user's sign up page components and handle interactions.
class UsersSignUpPage extends BaseComponent {
  mount() {
    fadeIn(this.$el);
  }
}

export default UsersSignUpPage;
