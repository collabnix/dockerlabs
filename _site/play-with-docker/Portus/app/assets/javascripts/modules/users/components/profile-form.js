import BaseComponent from '~/base/component';

const EMAIL_FIELD = '#user_email';
const DISPLAY_NAME_FIELD = '#user_display_name';
const SUBMIT_BUTTON = 'input[type=submit]';

// UsersProfileForm component handles user profile form
// interactions.
class UsersProfileForm extends BaseComponent {
  elements() {
    this.$email = this.$el.find(EMAIL_FIELD);
    this.$displayName = this.$el.find(DISPLAY_NAME_FIELD);
    this.$submit = this.$el.find(SUBMIT_BUTTON);
  }

  events() {
    this.$el.on('keyup', EMAIL_FIELD, e => this.onKeyup(e));
    this.$el.on('keyup', DISPLAY_NAME_FIELD, e => this.onKeyup(e));
  }

  onKeyup() {
    const email = this.$email.val();
    const displayName = this.$displayName.val();

    const emailInvalid = !email || email === this.originalEmail;
    const displayNameInvalid = this.$displayName[0] &&
      (!displayName || displayName === this.originalDisplayName);

    if (emailInvalid || displayNameInvalid) {
      this.$submit.attr('disabled', 'disabled');
    } else {
      this.$submit.removeAttr('disabled');
    }
  }

  mounted() {
    this.originalEmail = this.$email.val();
    this.originalDisplayName = this.$displayName.val();
  }
}

export default UsersProfileForm;
