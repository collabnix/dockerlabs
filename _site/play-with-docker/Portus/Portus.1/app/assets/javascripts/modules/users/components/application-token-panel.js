import BaseComponent from '~/base/component';

const TOGGLE_LINK = '#add_application_token_btn';
const TOGGLE_LINK_ICON = `${TOGGLE_LINK} i`;
const APP_TOKEN_FORM = '#add_application_token_form';
const APP_TOKEN_FIELD = '#application_token_application';

// ApplicationTokenPanel component that handles application
// token interactions.
class ApplicationTokenPanel extends BaseComponent {
  elements() {
    this.$toggle = this.$el.find(TOGGLE_LINK);
    this.$toggleIcon = this.$el.find(TOGGLE_LINK_ICON);
    this.$form = this.$el.find(APP_TOKEN_FORM);
    this.$token = this.$el.find(APP_TOKEN_FIELD);
  }

  events() {
    this.$el.on('click', TOGGLE_LINK, e => this.onClick(e));
  }

  onClick() {
    this.$form.toggle(400, 'swing', () => {
      const visible = this.$form.is(':visible');

      if (visible) {
        this.clearFields();
      }

      this.$toggleIcon.toggleClass('fa-minus-circle', visible);
      this.$toggleIcon.toggleClass('fa-plus-circle', !visible);

      layout_resizer();
    });
  }

  clearFields() {
    this.$token.val('');
    this.$token.focus();
  }
}

export default ApplicationTokenPanel;
