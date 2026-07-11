import BaseComponent from '~/base/component';

import ProfileForm from '../components/profile-form';
import PasswordForm from '../components/password-form';
import ApplicationTokenPanel from '../components/application-token-panel';

const PROFILE_FORM = 'form.profile';
const PASSWORD_FORM = 'form.password';
const APP_TOKEN_PANEL = '.app-token-wrapper';

// UsersEditPage component responsible to instantiate
// the user's edit page components and handle interactions.
class UsersEditPage extends BaseComponent {
  elements() {
    this.$profileForm = this.$el.find(PROFILE_FORM);
    this.$passwordForm = this.$el.find(PASSWORD_FORM);
    this.$appTokenPanel = this.$el.find(APP_TOKEN_PANEL);
  }

  mount() {
    this.profileForm = new ProfileForm(this.$profileForm);
    this.passwordForm = new PasswordForm(this.$passwordForm);
    this.appTokenPanel = new ApplicationTokenPanel(this.$appTokenPanel);
  }
}

export default UsersEditPage;
