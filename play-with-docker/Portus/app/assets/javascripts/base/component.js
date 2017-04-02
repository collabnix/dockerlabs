/* eslint-disable class-methods-use-this */

// BaseComponent class to avoid boilerplate code
// into component classes and add some convention.
//
// The subclasses are not obligated to implement all
// of these methods but if they need to perform an action
// that fits one of the descriptions below, it's highly
// recommended to use the proper method.
class BaseComponent {
  // Calls in order 'elements()', 'events()', 'beforeMount()',
  // 'mount()' and 'mounted()'.
  constructor(el) {
    this.$el = el;

    this.elements();
    this.events();
    this.beforeMount();
    this.mount();
    this.mounted();
  }

  // Caches HTML elements for further use.
  elements() { }

  // Attaches listeners to events triggered by HTML elements.
  events() { }

  // Before mount hook.
  beforeMount() { }

  // Renders the component.
  mount() { }

  // After mount hook.
  mounted() { }
}

export default BaseComponent;
