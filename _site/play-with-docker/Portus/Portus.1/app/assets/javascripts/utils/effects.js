// after jquery was upgraded this effect was conflicting
// with lifeitup functions (probably layout_resizer)
// so setTimeout was the workaround I found to solve the error
export const fadeIn = function ($el) {
  setTimeout(() => {
    $el.hide().fadeIn(1000);
  }, 0);
};

export default {
  fadeIn,
};
