import BaseComponent from '~/base/component';

const CURRENT_PASSWORD_FIELD = '#user_current_password';
const NEW_PASSWORD_FIELD = '#user_password';
const NEW_CONFIRMATION_PASSWORD_FIELD = '#user_password_confirmation';
const SUBMIT_BUTTON = 'input[type=submit]';

// UsersPasswordForm component that handles user password form
// interactions.
class UsersPasswordForm extends BaseComponent {
  elements() {
    this.$currentPassword = this.$el.find(CURRENT_PASSWORD_FIELD);
    this.$newPassword = this.$el.find(NEW_PASSWORD_FIELD);
    this.$newPasswordConfirmation = this.$el.find(NEW_CONFIRMATION_PASSWORD_FIELD);
    this.$submit = this.$el.find(SUBMIT_BUTTON);
  }

  events() {
    this.$el.on('keyup', CURRENT_PASSWORD_FIELD, e => this.onKeyup(e));
    this.$el.on('keyup', NEW_PASSWORD_FIELD, e => this.onKeyup(e));
    this.$el.on('keyup', NEW_CONFIRMATION_PASSWORD_FIELD, e => this.onKeyup(e));
  }

  onKeyup() {
    const currentPassword = this.$currentPassword.val();
    const newPassword = this.$newPassword.val();
    const newPasswordConfirmation = this.$newPasswordConfirmation.val();

    const currentPasswordInvalid = !currentPassword;
    const newPasswordInvalid = !newPassword;
    const newPasswordConfirmationInvalid = !newPasswordConfirmation ||
      newPassword !== newPasswordConfirmation;

    if (currentPasswordInvalid || newPasswordInvalid || newPasswordConfirmationInvalid) {
      this.$submit.attr('disabled', 'disabled');
    } else {
      this.$submit.removeAttr('disabled');
    }
  }
}

export default UsersPasswordForm;
