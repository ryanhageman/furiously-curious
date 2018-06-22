/* eslint no-unused-vars: [2, { 'varsIgnorePattern': 'autocomplete' }] */
/* global Awesomplete */

function autocomplete(input, list) {
  new Awesomplete(input, {
    list,

    filter(text, input) {
      return Awesomplete.FILTER_CONTAINS(text, input.match(/[^,]*$/)[0])
    },

    item(text, input) {
      return Awesomplete.ITEM(text, input.match(/[^,]*$/)[0])
    },

    replace(text) {
      let before = this.input.value.match(/^.+,\s*|/)[0]
      this.input.value = before + text + ', '
    }
  })
}
